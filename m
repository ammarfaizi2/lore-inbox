Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131303AbRAaIwn>; Wed, 31 Jan 2001 03:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131490AbRAaIwd>; Wed, 31 Jan 2001 03:52:33 -0500
Received: from fedro.ugr.es ([150.214.20.19]:49026 "EHLO fedro.ugr.es")
	by vger.kernel.org with ESMTP id <S131341AbRAaIw3>;
	Wed, 31 Jan 2001 03:52:29 -0500
Date: Wed, 31 Jan 2001 09:52:11 +0100 (MET)
From: RUBEN JESUS GARCIA HERNANDEZ <rgarcia@fedro.ugr.es>
Message-Id: <200101310852.JAA15139@fedro.ugr.es>
To: tytso@mit.edu
Reply-To: rgarcia@fedro.ugr.es
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
Subject: [PATCH] The loop device will not dealloc loop devices which create a closed chain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
        Creating a loop with the loop devices (a->b && b->a) makes the
devices a & b no longer usable.

[2.] Full description of the problem/report:
        When you make a mistake and write
                        losetup <options> /dev/loop<n> /dev/loop<n>
and loop<n> is not in use, losetup activates the loop device with the
same
device as the base file. Later, you cannot destroy the loop device,
because
it is being used by the device. You have to reboot.
        This also happens if you create a loop, because loop.c does
not check 
if the device is an unconfigured loop device.
        I think the semantics should be that you cannot use a loop
over an
unconfigured loop device. That is what I added in this patch. This is
for
kernel 2.4.0

[3.] Keywords 
        loop.c, loop device
        
[4.] Kernel version 
        Linux kernel version 2.4.0 

[6.] A small shell script or example program which triggers the
problem
        losetup /dev/loop4 /dev/loop4
        losetup -d /dev/loop4   

[7.] Patch section

        This patch adds a check when configuring a loop device, to see
if the 
underlying device is an unconfigured loop device, and prevents from
configuring 
the loop device in that case.
------------------------------------------------------------
--- drivers/block/loop.c.orig   Tue Jan 30 20:59:25 2001
+++ drivers/block/loop.c        Tue Jan 30 21:00:59 2001
@@ -31,6 +31,11 @@
  * max_loop=<1-255> to the kernel on boot.
  * Erik I. Bolsø, <eriki@himolde.no>, Oct 31, 1999
  *
+ * Added code to check that the underlying device is not an
unconfigured loop
+ * device. This could lead to deadlock when both devices were the
same, or when
+ * each one pointed to the other - Rubén García Hernández,
+ * rgarcia@fedro.ugr.es, November 5, 2000
+ * 
  * Still To Fix:
  * - Advisory locking is ignored here. 
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN 
@@ -85,6 +90,11 @@
 #define FALSE 0
 #define TRUE (!FALSE)
 
+/* Forward declaration of function to get status of loop device
(needed by
+ * loop_set_fd () )
+ */
+static int loop_get_status(struct loop_device *lo, struct loop_info
*arg);
+
 /*
  * Transfer functions
  */
@@ -420,6 +430,24 @@
                lo->lo_device = inode->i_rdev;
                lo->lo_flags = 0;
 
+               if (MAJOR(inode->i_rdev)==MAJOR_NR) {
+                       int dev;
+
+                       dev=MINOR(inode->i_rdev);
+                       if (dev<max_loop) {
+                               struct loop_device * lo2;
+                               struct loop_info li;
+               
+                               lo2=&loop_dev[dev];
+                               if (loop_get_status (lo2, &li)<0) {
+                                       printk(KERN_ERR "loop_set_fd:
device is"
+                                               "an unconfigured loop
device");
+                                       error=-EINVAL;
+                                       goto out;
+                               }
+                       }
+               }
+               
                /* Backed by a block device - don't need to hold onto
                   a file structure */
                lo->lo_backing_file = NULL;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
