Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUBUDen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUBUDen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:34:43 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:42438 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261502AbUBUDeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:34:36 -0500
Date: Fri, 20 Feb 2004 22:34:16 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.3rc4 floppy oops.
In-Reply-To: <20040217233120.GA8117@redhat.com>
Message-ID: <Pine.LNX.4.58.0402202117260.7734@montezuma.fsmlabs.com>
References: <20040217233120.GA8117@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Dave Jones wrote:

> Another fun one on module unload..

I got delegated this bug by the acting floppy.c maintainer ( Cc'd )

It looks like a block request snuck through before we had initialised the
motor_off_timer timers. So i pushed the timer init earlier.

Tested here with a floppy in the driver on module load and without a
floppy. Could you verify it fixes your bug too?

Thanks

> kernel: Floppy drive(s): fd0 is 1.44M
> kernel: FDC 0 is a post-1991 82077
> kernel: Uninitialised timer!
> kernel: This is just a warning.  Your computer is OK
> kernel: function=0x00000000, data=0x0
> kernel: Call Trace:
> modprobe: FATAL: Module ide_probe not found.
> kernel:  [<c012d2f4>] check_timer_failed+0x3c/0x58
> kernel:  [<c012d72c>] del_timer+0x15/0xca
> kernel:  [<c7c714d2>] floppy_ready+0x0/0x1f9 [floppy]
> kernel:  [<c7c7149a>] start_motor+0x9e/0xd6 [floppy]
> kernel:  [<c7c714fb>] floppy_ready+0x29/0x1f9 [floppy]
> kernel:  [<c0135496>] worker_thread+0x1b4/0x250
> kernel:  [<c7c714d2>] floppy_ready+0x0/0x1f9 [floppy]
> kernel:  [<c01217e4>] default_wake_function+0x0/0xc
> kernel:  [<c010b586>] ret_from_fork+0x6/0x20
> kernel:  [<c01217e4>] default_wake_function+0x0/0xc
> kernel:  [<c01352e2>] worker_thread+0x0/0x250
> kernel:  [<c01091ed>] kernel_thread_helper+0x5/0xb

Index: linux-2.6.3-mm2/drivers/block/floppy.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-mm2/drivers/block/floppy.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 floppy.c
--- linux-2.6.3-mm2/drivers/block/floppy.c	20 Feb 2004 23:58:43 -0000	1.1.1.1
+++ linux-2.6.3-mm2/drivers/block/floppy.c	21 Feb 2004 03:29:57 -0000
@@ -4242,6 +4242,15 @@ int __init floppy_init(void)
 		disks[i] = alloc_disk(1);
 		if (!disks[i])
 			goto Enomem;
+
+		disks[i]->major = FLOPPY_MAJOR;
+		disks[i]->first_minor = TOMINOR(i);
+		disks[i]->fops = &floppy_fops;
+		sprintf(disks[i]->disk_name, "fd%d", i);
+
+		init_timer(&motor_off_timer[i]);
+		motor_off_timer[i].data = i;
+		motor_off_timer[i].function = motor_off_callback;
 	}

 	devfs_mk_dir ("floppy");
@@ -4255,13 +4264,6 @@ int __init floppy_init(void)
 		goto fail_queue;
 	}

-	for (i=0; i<N_DRIVE; i++) {
-		disks[i]->major = FLOPPY_MAJOR;
-		disks[i]->first_minor = TOMINOR(i);
-		disks[i]->fops = &floppy_fops;
-		sprintf(disks[i]->disk_name, "fd%d", i);
-	}
-
 	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 				floppy_find, NULL, NULL);

@@ -4366,9 +4368,6 @@ int __init floppy_init(void)
 	}

 	for (drive = 0; drive < N_DRIVE; drive++) {
-		init_timer(&motor_off_timer[drive]);
-		motor_off_timer[drive].data = drive;
-		motor_off_timer[drive].function = motor_off_callback;
 		if (!(allowed_drive_mask & (1 << drive)))
 			continue;
 		if (fdc_state[FDC(drive)].version == FDC_NONE)
