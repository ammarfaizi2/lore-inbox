Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLOK2D>; Fri, 15 Dec 2000 05:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOK1y>; Fri, 15 Dec 2000 05:27:54 -0500
Received: from fedro.ugr.es ([150.214.20.19]:8160 "EHLO fedro.ugr.es")
	by vger.kernel.org with ESMTP id <S129324AbQLOK1k>;
	Fri, 15 Dec 2000 05:27:40 -0500
Date: Fri, 15 Dec 2000 10:57:08 +0100 (MET)
From: RUBEN JESUS GARCIA HERNANDEZ <x6039854@fedro.ugr.es>
Message-Id: <200012150957.KAA17552@fedro.ugr.es>
To: linux-kernel@vger.kernel.org
Reply-To: x6039854@fedro.ugr.es
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
Subject: Problem: LinuxKernel drivers/block/loop.c (with patch)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
        1. Creating a loop with the loop devices (a->b && b->a) makes
the
device no longer usable.

[2.] Full description of the problem/report:
        2. When you make a mistake and write
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
kernel 2.2.17, international patch 10. 
        I have checked 2.4.0 test 11, and it has the same problem. I
sent the
patch to Theodore Ts'o (tytso@mit.edu), who wrote the original loop.c,
but he
did not respond, and the patch is not in 2.2.18. I could not find who
is 
maintaining loop.c now.
        To use this patch with 2.4.?, the remark has to be placed by
hand, 
and MAX_LOOP has to change into max_loop

[3.] Keywords 
        3. loop.c, loop device
        
[4.] Kernel version 
        4. Linux version 2.2.17int10 

[5.] Output of Oops.. message (if applicable)
        5. N/A
        
[6.] A small shell script or example program which triggers the
problem
        6. losetup /dev/loop4 /dev/loop4
        
[7.] Environment
        7. N/A
[X.] Other notes, patches, fixes, workarounds:
        X. Please send a note so that I see the mail did not get lost.

                Rubén J. García Hernández
                x6039854@fedro.ugr.es

Here is the patch, just adding a check to see the underlying device is
not an
unconfigured loop device.

----------------------------------------------
--- loop.c      Sun Nov  5 16:41:41 2000
+++ /usr/src/linux-2.2.17int10/drivers/block/loop.c     Sun Nov  5
16:28:14 2000
@@ -22,6 +22,11 @@
  * CBC (and relatives) mode encryption requiring unique IVs per data
block. 
  * Reed H. Petty, rhp@draper.net
  * 
+ * Added code to check that the underlying device is not an
unconfigured loop
+ * device. This could lead to deadlock when both devices were the
same, or when
+ * each one pointed to the other - Rubén García Hernández,
+ * x6039854@fedro.ugr.es, November 5, 2000
+ * 
  * Still To Fix:
  * - Advisory locking is ignored here. 
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN 
@@ -76,7 +81,11 @@
 /* Forward declaration of function to create missing blocks in the 
    backing file (can happen if the backing file is sparse) */
 static int create_missing_block(struct loop_device *lo, int block,
int blksize);
-
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
@@ -381,6 +390,28 @@
                lo->lo_device = inode->i_rdev;
                lo->lo_flags = 0;
 
+               if (MAJOR(inode->i_rdev)==MAJOR_NR) {
+                       int dev;
+
+                       dev=MINOR(inode->i_rdev);
+                       if (dev<MAX_LOOP) {
+                               struct loop_device * lo2;
+                               struct loop_info li;
+
+                               lo2=&loop_dev[dev];
+                               if (loop_get_status (lo2, &li)<0) {
+                                       printk(KERN_ERR "loop_set_fd:
device is"
+                                               " an unconfigured loop
device");
+                                       error=-EINVAL;
+                                       goto out;
+                               }
+                       }
+               }
                /* Backed by a block device - don't need to hold onto
                   a file structure */
                lo->lo_backing_file = NULL;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
