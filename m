Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286386AbRLJVEu>; Mon, 10 Dec 2001 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286385AbRLJVEk>; Mon, 10 Dec 2001 16:04:40 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56594 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S286383AbRLJVET>; Mon, 10 Dec 2001 16:04:19 -0500
Date: Mon, 10 Dec 2001 16:04:28 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@marabou.research.att.com>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@redhat.com>
Subject: [PATCH] 2.4.17-pre7: fdomain_16x0_release undeclared
Message-ID: <Pine.LNX.4.33.0112101546260.1647-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan and all!

File drivers/scsi/fdomain.h declares a data structure FDOMAIN_16X0 using
an undeclared function fdomain_16x0_release() in Linux 2.4.17-pre7.

This is not a problem for the kernel itself, but it breaks compilation of
pcmcia-cs-3.1.30 because the later uses structure FDOMAIN_16X0.

The fix is trivial - declare fdomain_16x0_release() the same way as other
non-static functions from fdomain.c.

Another partly related problem is a warning in fdomain.c:

fdomain.c: In function `fdomain_16x0_release':
fdomain.c:2045: warning: control reaches end of non-void function

I wonder if the patches that introduce warnings should be allowed in the 
stable branch?  Anyway, comparing with other SCSI drivers I see that 0 
should be returned and scsi_unregister(shpnt) should be called before 
that.

Here's the patch.  The part for fdomain.h is 100% safe and should be
applied ASAP.  The part for fdomain.c should be safe too but I'll
appreciate if somebody tests it on a real Future Domain controller.

------------------------------
--- linux.orig/drivers/scsi/fdomain.c
+++ linux/drivers/scsi/fdomain.c
@@ -2042,6 +2042,8 @@ int fdomain_16x0_release(struct Scsi_Hos
 	if (shpnt->io_port && shpnt->n_io_port)
 		release_region(shpnt->io_port, shpnt->n_io_port);
 
+	scsi_unregister(shpnt);
+	return 0;
 }
 
 MODULE_LICENSE("GPL");
--- linux.orig/drivers/scsi/fdomain.h
+++ linux/drivers/scsi/fdomain.h
@@ -34,6 +34,7 @@
 int        fdomain_16x0_biosparam( Disk *, kdev_t, int * );
 int        fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
 				   int length, int hostno, int inout );
+int        fdomain_16x0_release(struct Scsi_Host *shpnt);
 
 #define FDOMAIN_16X0 { proc_info:      fdomain_16x0_proc_info,           \
 		       detect:         fdomain_16x0_detect,              \
------------------------------

-- 
Regards,
Pavel Roskin

