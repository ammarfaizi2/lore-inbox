Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVBICS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVBICS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVBICS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:18:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:30652 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261751AbVBICRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:17:41 -0500
Date: Tue, 8 Feb 2005 18:17:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050208181738.S24171@build.pdx.osdl.net>
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com> <20050208184145.GD10799@logos.cnet> <20050209003746.GB9792@bougret.hpl.hp.com> <20050208175129.G469@build.pdx.osdl.net> <20050209020713.GA12770@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050209020713.GA12770@bougret.hpl.hp.com>; from jt@hpl.hp.com on Tue, Feb 08, 2005 at 06:07:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Tourrilhes (jt@hpl.hp.com) wrote:
> On Tue, Feb 08, 2005 at 05:51:29PM -0800, Chris Wright wrote:
> > Hmm, having ability to read kernel data is not so nice.
> 
> 	It's not like you can read any arbitrary address, exploiting
> such a flaw is in my mind theoritical. Let's not overblow things,
> there are some real bugs to take care of.

If the fix is simple (as it appears to be), there's no good reason to
leave the risk there.

> >  prism54 uses
> > this, and is a reasonably popular card.  Looks to me like this should be
> > plugged.  Is the patch below sufficient? (stolen from full 2.6 patch)
> 
> 	Yep, except that you have an extra chunk that should not be
> in. You probably did not use the latest version of the patch (and that
> was not in the one sent to Marcelo). I would not like to introduce a
> real bug in 2.4.X :-(

Yes, you are correct, here it is without that errouneous bit.

thanks,
-chris

===== net/core/wireless.c 1.4 vs edited =====
--- 1.4/net/core/wireless.c	2003-09-03 04:12:57 -07:00
+++ edited/net/core/wireless.c	2005-02-08 17:45:15 -08:00
@@ -310,7 +310,7 @@ static inline int call_commit_handler(st
 
 /* ---------------------------------------------------------------- */
 /*
- * Number of private arguments
+ * Calculate size of private arguments
  */
 static inline int get_priv_size(__u16	args)
 {
@@ -320,6 +320,24 @@ static inline int get_priv_size(__u16	ar
 	return num * priv_type_size[type];
 }
 
+/* ---------------------------------------------------------------- */
+/*
+ * Re-calculate the size of private arguments
+ */
+static inline int adjust_priv_size(__u16		args,
+				   union iwreq_data *	wrqu)
+{
+	int	num = wrqu->data.length;
+	int	max = args & IW_PRIV_SIZE_MASK;
+	int	type = (args & IW_PRIV_TYPE_MASK) >> 12;
+
+	/* Make sure the driver doesn't goof up */
+	if (max < num)
+		num = max;
+
+	return num * priv_type_size[type];
+}
+
 
 /******************** /proc/net/wireless SUPPORT ********************/
 /*
@@ -701,7 +719,7 @@ static inline int ioctl_private_call(str
 			   ((extra_size + offset) <= IFNAMSIZ))
 				extra_size = 0;
 		} else {
-			/* Size of set arguments */
+			/* Size of get arguments */
 			extra_size = get_priv_size(descr->get_args);
 
 			/* Does it fits in iwr ? */
@@ -771,6 +789,14 @@ static inline int ioctl_private_call(str
 
 		/* If we have something to return to the user */
 		if (!ret && IW_IS_GET(cmd)) {
+
+			/* Adjust for the actual length if it's variable,
+			 * avoid leaking kernel bits outside. */
+			if (!(descr->get_args & IW_PRIV_SIZE_FIXED)) {
+				extra_size = adjust_priv_size(descr->get_args,
+							      &(iwr->u));
+			}
+
 			err = copy_to_user(iwr->u.data.pointer, extra,
 					   extra_size);
 			if (err)
