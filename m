Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVAFPah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVAFPah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVAFPah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:30:37 -0500
Received: from [213.146.154.40] ([213.146.154.40]:424 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262861AbVAFPaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:30:21 -0500
Date: Thu, 6 Jan 2005 15:30:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050106153016.GA19324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, ak@suse.de, mingo@elte.hu,
	rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
	pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
	alsa-devel@lists.sourceforge.net, greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org> <20050105150310.GA19758@mellanox.co.il> <20050105133358.16ce6891.akpm@osdl.org> <20050106144116.GA25898@mellanox.co.il> <20050106145527.GB18725@infradead.org> <20050106152248.GA25955@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106152248.GA25955@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:22:48PM +0200, Michael S. Tsirkin wrote:
> > +	if (!filp->f_op || !filp->f_op->ioctl)
> > +		goto do_ioctl;
> > +
> > +	if (filp->f_op || filp->f_op->compat_ioctl) {
> >  		error = filp->f_op->compat_ioctl(filp, cmd, arg);
> >  		goto out_fput;
> >  	}
> 
> So now if I dont have ->ioctl the ioctl_compat wont be called.
> What if I only have unlocked_ioctl?

Indeed.  In my test setup I didn't have a driver using both.  So let's
think a little more what checks we want.

The original intention (pre-patch) was that without an ioctl entry
we'd skip the hash table lookup and skip right to trying the few standard
ioctls.

So with ->compat_ioctl we should try that one first, then checking
for either ->ioctl or ->unlocked_ioctl beeing there.  Like the patch
below (this time it's actually untested because all my 64bit machines
are in use):


--- linux-2.6.10-mm2.orig/fs/compat.c	2005-01-06 11:40:18.831900000 +0100
+++ linux-2.6.10-mm2/fs/compat.c	2005-01-06 16:36:17.340977664 +0100
@@ -436,14 +436,15 @@
 	if (!filp)
 		goto out;
 
-	if (!filp->f_op) {
-		if (!filp->f_op->ioctl)
-			goto do_ioctl;
-	} else if (filp->f_op->compat_ioctl) {
+	if (filp->f_op && filp->f_op->compat_ioctl) {
 		error = filp->f_op->compat_ioctl(filp, cmd, arg);
 		goto out_fput;
 	}
 
+	if (!filp->f_op ||
+	    (!filp->f_op->ioctl && !filp->f_op->unlocked_ioctl))
+		goto do_ioctl;
+
 	down_read(&ioctl32_sem);
 	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
 		if (t->cmd == cmd)

> 
> 
> MST
---end quoted text---
