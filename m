Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbUKRWBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUKRWBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUKRV7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:59:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263002AbUKRV60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:58:26 -0500
Date: Thu, 18 Nov 2004 13:58:09 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Fabio Coatti <cova@ferrara.linux.it>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
Message-ID: <20041118135809.3314ce41@lembas.zaitcev.lan>
In-Reply-To: <20041118133557.72f3b369.akpm@osdl.org>
References: <200411182203.02176.cova@ferrara.linux.it>
	<20041118133557.72f3b369.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 13:35:57 -0800, Andrew Morton <akpm@osdl.org> wrote:

> Fabio Coatti <cova@ferrara.linux.it> wrote:
> >
> > Just a reminder: it's possible to cause a kernel oops simply inserting and 
> > removing a usb storage (flash pen); using ub driver doesn't improve the 
> > situation; noticed in 2.6.9-rc4-mm1 and present in 2.6.10-rc2-mm2.
> > The same device works just fine with 2.6.8.1 (mdk cooker)
> 
> OK, that's something we'd like to get fixed prior to 2.6.10.

Actually Fabio told me that his oops was fixed by the patch present in
2.6.10-rc2. The problem is that his device needs special handling which
I do not know how to provide, so it does not work in the end. I hope it
will resolve itself eventually, as I get testers.

There was one last oops from Martin Schleminger ("Sahara") which I think
I fixed but I need a confirmation before pushing to Greg. Apparently, it
only happens on kernels with preempt enabled. If anyone knows of any other
problems, I'm all ears.

-- Pete

P.S. Current updates:

--- linux-2.6.10-rc2-usb/drivers/block/ub.c	2004-11-16 17:03:02.000000000 -0800
+++ linux-2.6.10-rc1-ub/drivers/block/ub.c	2004-11-07 19:01:03.000000000 -0800
@@ -36,7 +36,7 @@
 #define DRV_NAME "ub"
 #define DEVFS_NAME DRV_NAME
 
-#define UB_MAJOR 125	/* Stolen from Experimental range for a week - XXX */
+#define UB_MAJOR 180
 
 /*
  * Definitions which have to be scattered once we understand the layout better.
@@ -1535,8 +1535,11 @@
 
 	ub_revalidate(sc);
 	/* This is pretty much a long term P3 */
-	printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
-	    sc->name, sc->dev->devnum, sc->capacity.nsec, sc->capacity.bsize);
+	if (!atomic_read(&sc->poison)) {		/* Cover sc->dev */
+		printk(KERN_INFO "%s: device %u capacity nsec %ld bsize %u\n",
+		    sc->name, sc->dev->devnum,
+		    sc->capacity.nsec, sc->capacity.bsize);
+	}
 
 	/* XXX Support sector size switching like in sr.c */
 	blk_queue_hardsect_size(disk->queue, sc->capacity.bsize);
