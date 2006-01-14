Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWANRHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWANRHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWANRHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:07:12 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:3848 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751779AbWANRHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:07:11 -0500
Subject: Re: Regression in Autofs, 2.6.15-git
From: Ian Kent <raven@themaw.net>
To: "P. Christeas" <p_christ@hol.gr>
Cc: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-kernel@vger.kernel.org
In-Reply-To: <200601141725.28347.p_christ@hol.gr>
References: <200601140217.56724.p_christ@hol.gr>
	 <20060114051737.6e49dffe.akpm@osdl.org>
	 <200601141711.06598.p_christ@hol.gr>  <200601141725.28347.p_christ@hol.gr>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 01:06:14 +0800
Message-Id: <1137258375.2847.19.camel@eagle.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 17:25 +0200, P. Christeas wrote:
> On Saturday 14 January 2006 5:11 pm, P. Christeas wrote:
> > Doesn't that mean that mnt==0x0004 ? Clearly wrong. I can also see from
> > Christian's patch that mnt wasn't previously used, so it makes perfect
> > sense for that commit to introduce the oops.
> >
> > I guess the problem lies in autofs4_revalidate (fs/autofs4/root.c:420), the
> > nd->mnt value..
> >
> > I will add a silly validator (mnt>0xff) instead of (mnt) and see..
> Confirmed: ((u32)mnt>0xff) discards the invalid 'mnt' value and the oops 
> disappears.
> That is, the autofs4 code needs some debugging :( .

Yes. It's me again.

Could you try this patch please.

--- linux-2.6.15/fs/autofs4/root.c.dumb-nameidata	2006-01-15 01:01:26.000000000 +0800
+++ linux-2.6.15/fs/autofs4/root.c	2006-01-15 01:02:12.000000000 +0800
@@ -193,6 +193,8 @@ static int autofs4_dir_open(struct inode
 		if (!empty)
 			d_invalidate(dentry);
 
+		nd.dentry = dentry;
+		nd.mnt = mnt;
 		nd.flags = LOOKUP_DIRECTORY;
 		status = (dentry->d_op->d_revalidate)(dentry, &nd);
 


