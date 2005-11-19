Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbVKSDqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbVKSDqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbVKSDqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:46:19 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:20654 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S1161241AbVKSDqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:46:18 -0500
Date: Sat, 19 Nov 2005 03:44:56 +0000
From: Jon Masters <jonathan@jonmasters.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Cal Peake <cp@absolutedigital.net>, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Message-ID: <20051119034456.GA10526@apogee.jonmasters.org>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net> <20051116005958.25adcd4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116005958.25adcd4a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 12:59:58AM -0800, Andrew Morton wrote:
> Cal Peake <cp@absolutedigital.net> wrote:

> >  "[PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk"

> > causes an annoying side-effect. Upon first write attempt to a floppy I get 
> > this:

> > $ dd if=bootdisk.img of=/dev/fd0 bs=1440k
> > dd: writing `/dev/fd0': Operation not permitted
> > 1+0 records in
> > 0+0 records out

Yes indeed. I reproduced that behaviour.

> hmm, yes, when floppy_open() does its test we haven't yet gone and
> determined the state of FD_DISK_WRITABLE.  On later opens, we have done, so
> things work OK.

I stuck a test in for first use and had floppy_release free up policy
too. But there are a bunch of problems in the floppy driver I've noticed
in going through it tonight (and there's only so much of that I can take
at 03:43 on a Saturday morning). I'll hopefully followup again.

Jon.

diff -urN linux-2.6.14/drivers/block/floppy.c linux-2.6.14_new/drivers/block/floppy.c
--- linux-2.6.14/drivers/block/floppy.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14_new/drivers/block/floppy.c	2005-11-19 03:17:08.000000000 +0000
@@ -1610,10 +1610,11 @@
 			DPRINT("wp=%x\n", ST3 & 0x40);
 		}
 #endif
-		if (!(ST3 & 0x40))
+		if (!(ST3 & 0x40)) {
 			SETF(FD_DISK_WRITABLE);
-		else
+		} else {
 			CLEARF(FD_DISK_WRITABLE);
+		}
 	}
 }
 
@@ -3677,15 +3678,19 @@
 	int drive = (long)inode->i_bdev->bd_disk->private_data;
 
 	down(&open_lock);
+
 	if (UDRS->fd_ref < 0)
 		UDRS->fd_ref = 0;
 	else if (!UDRS->fd_ref--) {
 		DPRINT("floppy_release with fd_ref == 0");
 		UDRS->fd_ref = 0;
 	}
-	if (!UDRS->fd_ref)
+	if (!UDRS->fd_ref) {
+		opened_bdev[drive]->bd_disk->policy = 0;
 		opened_bdev[drive] = NULL;
+	}
 	floppy_release_irq_and_dma();
+
 	up(&open_lock);
 	return 0;
 }
@@ -3714,6 +3719,13 @@
 		USETF(FD_VERIFY);
 	}
 
+	/* set underlying gendisk policy to reflect device ro/rw status */
+	if (UDRS->first_read_date && !(UTESTF(FD_DISK_WRITABLE))) {
+		inode->i_bdev->bd_disk->policy = 1;
+	} else {
+		inode->i_bdev->bd_disk->policy = 0;
+	}
+	
 	if (UDRS->fd_ref == -1 || (UDRS->fd_ref && (filp->f_flags & O_EXCL)))
 		goto out2;
 
@@ -3788,6 +3800,7 @@
 		if ((filp->f_mode & 2) && !(UTESTF(FD_DISK_WRITABLE)))
 			goto out;
 	}
+
 	up(&open_lock);
 	return 0;
 out:
