Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTIGGWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTIGGWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:22:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:475 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263230AbTIGGWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:22:49 -0400
Date: Sun, 7 Sep 2003 07:22:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030907062248.GX18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clearly it's too late to change the ioctl definitions, but we can at
least stop people from copying them and making the same mistake.

Index: Documentation/ioctl-number.txt
===================================================================
RCS file: /var/cvs/linux-2.6/Documentation/ioctl-number.txt,v
retrieving revision 1.1
diff -u -p -r1.1 ioctl-number.txt
--- Documentation/ioctl-number.txt	29 Jul 2003 17:00:10 -0000	1.1
+++ Documentation/ioctl-number.txt	7 Sep 2003 06:21:24 -0000
@@ -30,7 +30,9 @@ I'll register one for you.
 The second argument to _IO, _IOW, _IOR, or _IOWR is a sequence number
 to distinguish ioctls from each other.  The third argument to _IOW,
 _IOR, or _IOWR is the type of the data going into the kernel or coming
-out of the kernel (e.g.  'int' or 'struct foo').
+out of the kernel (e.g.  'int' or 'struct foo').  NOTE!  Do NOT use
+sizeof(arg) as the third argument as this results in your ioctl thinking
+it passes an argument of type size_t.
 
 Some devices use their major number as the identifier; this is OK, as
 long as it is unique.  Some devices are irregular and don't follow any
Index: include/linux/coda.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/coda.h,v
retrieving revision 1.1
diff -u -p -r1.1 coda.h
--- include/linux/coda.h	29 Jul 2003 17:02:11 -0000	1.1
+++ include/linux/coda.h	7 Sep 2003 06:19:03 -0000
@@ -324,7 +324,7 @@ struct coda_statfs {
 #define VC_MAXMSGSIZE      sizeof(union inputArgs)+sizeof(union outputArgs) +\
                             VC_MAXDATASIZE  
 
-#define CIOC_KERNEL_VERSION _IOWR('c', 10, sizeof (int))
+#define CIOC_KERNEL_VERSION _IOWR('c', 10, size_t)
 
 #if 0
 #define CODA_KERNEL_VERSION 0 /* don't care about kernel version number */
Index: include/linux/fs.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/fs.h,v
retrieving revision 1.3
diff -u -p -r1.3 fs.h
--- include/linux/fs.h	23 Aug 2003 02:47:23 -0000	1.3
+++ include/linux/fs.h	7 Sep 2003 06:19:03 -0000
@@ -188,15 +188,18 @@ extern int leases_enable, dir_notify_ena
 #define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
 #if 0
 #define BLKPG      _IO(0x12,105)/* See blkpg.h */
-#define BLKELVGET  _IOR(0x12,106,sizeof(blkelv_ioctl_arg_t))/* elevator get */
-#define BLKELVSET  _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))/* elevator set */
+
+/* Some people are morons.  Do not use sizeof! */
+
+#define BLKELVGET  _IOR(0x12,106,size_t)/* elevator get */
+#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
 /* A jump here: 108-111 have been used for various private purposes. */
-#define BLKBSZGET  _IOR(0x12,112,sizeof(int))
-#define BLKBSZSET  _IOW(0x12,113,sizeof(int))
-#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))	/* return device size in bytes (u64 *arg) */
+#define BLKBSZGET  _IOR(0x12,112,size_t)
+#define BLKBSZSET  _IOW(0x12,113,size_t)
+#define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
Index: include/linux/i8k.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/i8k.h,v
retrieving revision 1.1
diff -u -p -r1.1 i8k.h
--- include/linux/i8k.h	29 Jul 2003 17:02:12 -0000	1.1
+++ include/linux/i8k.h	7 Sep 2003 06:19:03 -0000
@@ -22,12 +22,12 @@
 
 #define I8K_BIOS_VERSION	_IOR ('i', 0x80, 4)
 #define I8K_MACHINE_ID		_IOR ('i', 0x81, 16)
-#define I8K_POWER_STATUS	_IOR ('i', 0x82, sizeof(int))
-#define I8K_FN_STATUS		_IOR ('i', 0x83, sizeof(int))
-#define I8K_GET_TEMP		_IOR ('i', 0x84, sizeof(int))
-#define I8K_GET_SPEED		_IOWR('i', 0x85, sizeof(int))
-#define I8K_GET_FAN		_IOWR('i', 0x86, sizeof(int))
-#define I8K_SET_FAN		_IOWR('i', 0x87, sizeof(int)*2)
+#define I8K_POWER_STATUS	_IOR ('i', 0x82, size_t)
+#define I8K_FN_STATUS		_IOR ('i', 0x83, size_t)
+#define I8K_GET_TEMP		_IOR ('i', 0x84, size_t)
+#define I8K_GET_SPEED		_IOWR('i', 0x85, size_t)
+#define I8K_GET_FAN		_IOWR('i', 0x86, size_t)
+#define I8K_SET_FAN		_IOWR('i', 0x87, size_t)
 
 #define I8K_FAN_LEFT		1
 #define I8K_FAN_RIGHT		0
Index: include/linux/if_pppox.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/if_pppox.h,v
retrieving revision 1.1
diff -u -p -r1.1 if_pppox.h
--- include/linux/if_pppox.h	29 Jul 2003 17:02:12 -0000	1.1
+++ include/linux/if_pppox.h	7 Sep 2003 06:19:03 -0000
@@ -67,9 +67,9 @@ struct sockaddr_pppox { 
  *
  ********************************************************************/
 
-#define PPPOEIOCSFWD	_IOW(0xB1 ,0, sizeof(struct sockaddr_pppox))
+#define PPPOEIOCSFWD	_IOW(0xB1 ,0, size_t)
 #define PPPOEIOCDFWD	_IO(0xB1 ,1)
-/*#define PPPOEIOCGFWD	_IOWR(0xB1,2, sizeof(struct sockaddr_pppox))*/
+/*#define PPPOEIOCGFWD	_IOWR(0xB1,2, size_t)*/
 
 /* Codes to identify message types */
 #define PADI_CODE	0x09
Index: include/linux/input.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/input.h,v
retrieving revision 1.8
diff -u -p -r1.8 input.h
--- include/linux/input.h	23 Aug 2003 02:57:02 -0000	1.8
+++ include/linux/input.h	7 Sep 2003 06:19:03 -0000
@@ -73,7 +73,7 @@ struct input_absinfo {
 #define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, struct input_absinfo)		/* get abs value/limits */
 #define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, struct input_absinfo)		/* set abs value/limits */
 
-#define EVIOCSFF		_IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))	/* send a force effect to a force feedback device */
+#define EVIOCSFF		_IOC(_IOC_WRITE, 'E', 0x80, size_t)	/* send a force effect to a force feedback device */
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */
 #define EVIOCGEFFECTS		_IOR('E', 0x84, int)			/* Report number of effects playable at the same time */
 
Index: include/linux/matroxfb.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/matroxfb.h,v
retrieving revision 1.1
diff -u -p -r1.1 matroxfb.h
--- include/linux/matroxfb.h	29 Jul 2003 17:02:13 -0000	1.1
+++ include/linux/matroxfb.h	7 Sep 2003 06:19:03 -0000
@@ -15,21 +15,21 @@ struct matroxioc_output_mode {
 #define MATROXFB_OUTPUT_MODE_NTSC	0x0002
 #define MATROXFB_OUTPUT_MODE_MONITOR	0x0080
 };
-#define MATROXFB_SET_OUTPUT_MODE	_IOW('n',0xFA,sizeof(struct matroxioc_output_mode))
-#define MATROXFB_GET_OUTPUT_MODE	_IOWR('n',0xFA,sizeof(struct matroxioc_output_mode))
+#define MATROXFB_SET_OUTPUT_MODE	_IOW('n',0xFA,size_t)
+#define MATROXFB_GET_OUTPUT_MODE	_IOWR('n',0xFA,size_t)
 
 /* bitfield */
 #define MATROXFB_OUTPUT_CONN_PRIMARY	(1 << MATROXFB_OUTPUT_PRIMARY)
 #define MATROXFB_OUTPUT_CONN_SECONDARY	(1 << MATROXFB_OUTPUT_SECONDARY)
 #define MATROXFB_OUTPUT_CONN_DFP	(1 << MATROXFB_OUTPUT_DFP)
 /* connect these outputs to this framebuffer */
-#define MATROXFB_SET_OUTPUT_CONNECTION	_IOW('n',0xF8,sizeof(__u32))
+#define MATROXFB_SET_OUTPUT_CONNECTION	_IOW('n',0xF8,size_t)
 /* which outputs are connected to this framebuffer */
-#define MATROXFB_GET_OUTPUT_CONNECTION	_IOR('n',0xF8,sizeof(__u32))
+#define MATROXFB_GET_OUTPUT_CONNECTION	_IOR('n',0xF8,size_t)
 /* which outputs are available for this framebuffer */
-#define MATROXFB_GET_AVAILABLE_OUTPUTS	_IOR('n',0xF9,sizeof(__u32))
+#define MATROXFB_GET_AVAILABLE_OUTPUTS	_IOR('n',0xF9,size_t)
 /* which outputs exist on this framebuffer */
-#define MATROXFB_GET_ALL_OUTPUTS	_IOR('n',0xFB,sizeof(__u32))
+#define MATROXFB_GET_ALL_OUTPUTS	_IOR('n',0xFB,size_t)
 
 enum matroxfb_ctrl_id {
   MATROXFB_CID_TESTOUT	 = V4L2_CID_PRIVATE_BASE,
Index: include/linux/pmu.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pmu.h,v
retrieving revision 1.1
diff -u -p -r1.1 pmu.h
--- include/linux/pmu.h	29 Jul 2003 17:02:14 -0000	1.1
+++ include/linux/pmu.h	7 Sep 2003 06:19:03 -0000
@@ -107,15 +107,15 @@ enum {
 /* no param */
 #define PMU_IOC_SLEEP		_IO('B', 0)
 /* out param: u32*	backlight value: 0 to 15 */
-#define PMU_IOC_GET_BACKLIGHT	_IOR('B', 1, sizeof(__u32*))
+#define PMU_IOC_GET_BACKLIGHT	_IOR('B', 1, size_t)
 /* in param: u32	backlight value: 0 to 15 */
-#define PMU_IOC_SET_BACKLIGHT	_IOW('B', 2, sizeof(__u32))
+#define PMU_IOC_SET_BACKLIGHT	_IOW('B', 2, size_t)
 /* out param: u32*	PMU model */
-#define PMU_IOC_GET_MODEL	_IOR('B', 3, sizeof(__u32*))
+#define PMU_IOC_GET_MODEL	_IOR('B', 3, size_t)
 /* out param: u32*	has_adb: 0 or 1 */
-#define PMU_IOC_HAS_ADB		_IOR('B', 4, sizeof(__u32*)) 
+#define PMU_IOC_HAS_ADB		_IOR('B', 4, size_t) 
 /* out param: u32*	can_sleep: 0 or 1 */
-#define PMU_IOC_CAN_SLEEP	_IOR('B', 5, sizeof(__u32*)) 
+#define PMU_IOC_CAN_SLEEP	_IOR('B', 5, size_t) 
 /* no param */
 #define PMU_IOC_GRAB_BACKLIGHT	_IOR('B', 6, 0) 
 
Index: include/linux/radeonfb.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/radeonfb.h,v
retrieving revision 1.1
diff -u -p -r1.1 radeonfb.h
--- include/linux/radeonfb.h	29 Jul 2003 17:02:14 -0000	1.1
+++ include/linux/radeonfb.h	7 Sep 2003 06:19:03 -0000
@@ -8,8 +8,8 @@
 #define ATY_RADEON_CRT_ON	0x00000002
 
 
-#define FBIO_RADEON_GET_MIRROR	_IOR('@', 3, sizeof(__u32*))
-#define FBIO_RADEON_SET_MIRROR	_IOW('@', 4, sizeof(__u32*))
+#define FBIO_RADEON_GET_MIRROR	_IOR('@', 3, size_t)
+#define FBIO_RADEON_SET_MIRROR	_IOW('@', 4, size_t)
 
 #endif
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
