Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUAPHpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUAPHpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:45:23 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:37547 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265311AbUAPHpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 02:45:09 -0500
Subject: Re: Linux 2.4.25-pre5
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       sim@netnation.com, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <Pine.LNX.4.58L.0401152110020.17528@logos.cnet>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
	 <20040115145519.79beddc3.davem@redhat.com>
	 <Pine.LNX.4.58L.0401152110020.17528@logos.cnet>
Content-Type: text/plain
Message-Id: <1074239098.31120.27.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 16 Jan 2004 07:44:58 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 21:23 -0200, Marcelo Tosatti wrote:
> On Thu, 15 Jan 2004, David S. Miller wrote:
> 
> > On Thu, 15 Jan 2004 18:19:40 -0200 (BRST)
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > > Here is -pre5.
> >
> > If this is anything like the current 2.4.x BK tree, people will need this
> > in order to get a successful build:
> >
> > --- Makefile.~1~	Thu Jan 15 12:13:10 2004
> > +++ Makefile	Thu Jan 15 12:13:12 2004
> > @@ -1,6 +1,6 @@
> >  VERSION = 2
> >  PATCHLEVEL = 4
> > -UBLEVEL = 25
> > +SUBLEVEL = 25
> >  EXTRAVERSION = -pre5
> >
> >  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> 
> I forgot to "bk push" (I never forget, you know).
> 
> Sir Woodhouse,
> 
> I just managed to crash a SMP box running dbench.
> 
> I guess this is related to your deadlock fix?

Oh bugger. It's all very well observing that it's OK to leave ourselves
on the wait queue because the inode is about to be freed..... but the
wait queue doesn't get reinitialised again when the inode is allocated
again from the same slab page. Someone _else_ inherits the stale wait
queue.

I hereby declare myself to be Today's Official Mr Fuck All Good.

===== fs/inode.c 1.48 vs edited =====
--- 1.48/fs/inode.c	Wed Jan 14 20:51:18 2004
+++ edited/fs/inode.c	Fri Jan 16 07:43:14 2004
@@ -96,6 +96,7 @@
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
 
+		init_waitqueue_head(&inode->i_wait);
 		inode->i_sb = sb;
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
@@ -147,7 +148,6 @@
 
 void __inode_init_once(struct inode *inode)
 {
-	init_waitqueue_head(&inode->i_wait);
 	INIT_LIST_HEAD(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_data.clean_pages);
 	INIT_LIST_HEAD(&inode->i_data.dirty_pages);


-- 
dwmw2


