Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271940AbRIIKDK>; Sun, 9 Sep 2001 06:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRIIKCv>; Sun, 9 Sep 2001 06:02:51 -0400
Received: from [144.137.83.84] ([144.137.83.84]:251 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S271940AbRIIKCo>;
	Sun, 9 Sep 2001 06:02:44 -0400
Message-ID: <3B9B3AA3.2BFC2995@eyal.emu.id.au>
Date: Sun, 09 Sep 2001 19:47:15 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre6: necessary patches
In-Reply-To: <Pine.LNX.4.33.0109081949510.1097-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------426B0FAA695BB69FD3C49435"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------426B0FAA695BB69FD3C49435
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Most are old ones, from way back 2.4.9 to latest -pre5.

drivers/block/genhd.c needs a few EXPORT_SYMBOLs. A peek at the -ac
series shows an added lock:

static rwlock_t gendisk_lock;

which is used by all the functions. It may be necessary now
that these functions are used from so many places.
--------------426B0FAA695BB69FD3C49435
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre6-genhd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre6-genhd.patch"

--- linux/drivers/block/genhd.c.orig	Sun Sep  9 18:54:21 2001
+++ linux/drivers/block/genhd.c	Sun Sep  9 19:39:45 2001
@@ -11,6 +11,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
 #include <linux/kernel.h>
@@ -27,6 +28,8 @@
 	gendisk_head = gp;
 }
 
+EXPORT_SYMBOL(add_gendisk);
+
 void
 del_gendisk(struct gendisk *gp)
 {
@@ -39,6 +42,8 @@
 		*gpp = (*gpp)->next;
 }
 
+EXPORT_SYMBOL(del_gendisk);
+
 struct gendisk *
 get_gendisk(kdev_t dev)
 {
@@ -50,6 +55,8 @@
 			return gp;
 	return NULL;
 }
+
+EXPORT_SYMBOL(get_gendisk);
 
 #ifdef CONFIG_PROC_FS
 int

--------------426B0FAA695BB69FD3C49435
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre6-ixj.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre6-ixj.patch"

--- linux/drivers/telephony/ixj.c-orig	Sat Sep  8 11:49:14 2001
+++ linux/drivers/telephony/ixj.c	Sat Sep  8 12:01:53 2001
@@ -2895,15 +2895,15 @@
 	set_current_state(TASK_RUNNING);
 	/* Don't ever copy more than the user asks */
 	if(j->rec_codec == ALAW)
-		ulaw2alaw(j->read_buffer, min(length, j->read_buffer_size));
-	i = copy_to_user(buf, j->read_buffer, min(length, j->read_buffer_size));
+		ulaw2alaw(j->read_buffer, min(unsigned int, length, j->read_buffer_size));
+	i = copy_to_user(buf, j->read_buffer, min(unsigned int, length, j->read_buffer_size));
 	j->read_buffer_ready = 0;
 	if (i) {
 		j->flags.inread = 0;
 		return -EFAULT;
 	} else {
 		j->flags.inread = 0;
-		return min(length, j->read_buffer_size);
+		return min(unsigned int, length, j->read_buffer_size);
 	}
 }
 
@@ -2975,15 +2975,15 @@
 	remove_wait_queue(&j->write_q, &wait);
 	if (j->write_buffer_wp + count >= j->write_buffer_end)
 		j->write_buffer_wp = j->write_buffer;
-	i = copy_from_user(j->write_buffer_wp, buf, min(count, j->write_buffer_size));
+	i = copy_from_user(j->write_buffer_wp, buf, min(unsigned int, count, j->write_buffer_size));
 	if (i) {
 		j->flags.inwrite = 0;
 		return -EFAULT;
 	}
        if(j->play_codec == ALAW)
-               alaw2ulaw(j->write_buffer_wp, min(count, j->write_buffer_size));
+               alaw2ulaw(j->write_buffer_wp, min(unsigned int, count, j->write_buffer_size));
 	j->flags.inwrite = 0;
-	return min(count, j->write_buffer_size);
+	return min(unsigned int, count, j->write_buffer_size);
 }
 
 static ssize_t ixj_enhanced_write(struct file * file_p, const char *buf, size_t count, loff_t * ppos)
@@ -6693,7 +6693,10 @@
 		retval = ixj_init_filter_raw(j, &jfr);
 		break;
 	case IXJCTL_GET_FILTER_HIST:
-		retval = j->filter_hist[arg];
+		if(arg<0||arg>3)
+			retval = -EINVAL;
+		else
+			retval = j->filter_hist[arg];
 		break;
 	case IXJCTL_INIT_TONE:
 		copy_from_user(&ti, (char *) arg, sizeof(ti));
--- linux/include/linux/ixjuser.h-orig	Sat Sep  8 11:57:55 2001
+++ linux/include/linux/ixjuser.h	Sat Sep  8 11:58:03 2001
@@ -1,11 +1,16 @@
+#ifndef __LINUX_IXJUSER_H
+#define __LINUX_IXJUSER_H
+
 /******************************************************************************
  *
  *    ixjuser.h
  *
- *    Device Driver for the Internet PhoneJACK and
- *    Internet LineJACK Telephony Cards.
+ * Device Driver for Quicknet Technologies, Inc.'s Telephony cards
+ * including the Internet PhoneJACK, Internet PhoneJACK Lite,
+ * Internet PhoneJACK PCI, Internet LineJACK, Internet PhoneCARD and
+ * SmartCABLE
  *
- *    (c) Copyright 1999 Quicknet Technologies, Inc.
+ *    (c) Copyright 1999-2001  Quicknet Technologies, Inc.
  *
  *    This program is free software; you can redistribute it and/or
  *    modify it under the terms of the GNU General Public License
@@ -37,14 +42,14 @@
  *
  *****************************************************************************/
 
-static char ixjuser_h_rcsid[] = "$Id: ixjuser.h,v 3.11 2000/03/30 22:06:48 eokerson Exp $";
+static char ixjuser_h_rcsid[] = "$Id: ixjuser.h,v 4.1 2001/08/05 00:17:37 craigs Exp $";
 
-#include "telephony.h"
+#include <linux/telephony.h>
 

 /******************************************************************************
 *
-* IOCTL's used for the Quicknet Cards
+* IOCTL's used for the Quicknet Telephony Cards
 *
 * If you use the IXJCTL_TESTRAM command, the card must be power cycled to
 * reset the SRAM values before futher use.
@@ -135,6 +140,7 @@
 } IXJ_FILTER_CADENCE;
 
 #define IXJCTL_SET_FILTER		_IOW ('q', 0xC7, IXJ_FILTER *)
+#define IXJCTL_SET_FILTER_RAW		_IOW ('q', 0xDD, IXJ_FILTER_RAW *)
 #define IXJCTL_GET_FILTER_HIST		_IOW ('q', 0xC8, int)
 #define IXJCTL_FILTER_CADENCE		_IOW ('q', 0xD6, IXJ_FILTER_CADENCE *)
 #define IXJCTL_PLAY_CID			_IO  ('q', 0xD7)
@@ -366,7 +372,7 @@
 * This group of IOCTLs deal with the Acoustic Echo Cancellation settings
 * of the DSP
 *
-* Issueing the IXJCTL_AEC_START command with a value of AEC_OFF has the
+* Issuing the IXJCTL_AEC_START command with a value of AEC_OFF has the
 * same effect as IXJCTL_AEC_STOP.  This is to simplify slider bar
 * controls.  IXJCTL_AEC_GET_LEVEL returns the current setting of the AEC.
 ******************************************************************************/
@@ -379,11 +385,12 @@
 #define AEC_MED   2
 #define AEC_HIGH  3
 #define AEC_AUTO  4
+#define AEC_AGC   5
 /******************************************************************************
 *
 * Call Progress Tones, DTMF, etc.
-* IXJCTL_DTMF_OOB determines if dtmf signaling is sent as Out-Of-Band
-* only.  If you pass a 1, dtmf is suppressed from the audio stream.
+* IXJCTL_DTMF_OOB determines if DTMF signaling is sent as Out-Of-Band
+* only.  If you pass a 1, DTMF is suppressed from the audio stream.
 * Tone on and off times are in 250 microsecond intervals so
 * ioctl(ixj1, IXJCTL_SET_TONE_ON_TIME, 360);
 * will set the tone on time of board ixj1 to 360 * 250us = 90ms
@@ -407,10 +414,10 @@
 #define IXJCTL_CPT_STOP			PHONE_CPT_STOP
 
 /******************************************************************************
-* LineJack specific IOCTLs
+* LineJACK specific IOCTLs
 *
 * The lsb 4 bits of the LED argument represent the state of each of the 4
-* LED's on the LineJack
+* LED's on the LineJACK
 ******************************************************************************/
 
 #define IXJCTL_SET_LED			_IOW ('q', 0xCE, int)
@@ -423,8 +430,8 @@
 * as the parameter to the mixer command to change the mixer settings.
 * 
 ******************************************************************************/
-#define MIXER_MASTER_L		0x0100
-#define MIXER_MASTER_R		0x0200
+#define MIXER_MASTER_L		0x0000
+#define MIXER_MASTER_R		0x0100
 #define ATT00DB			0x00
 #define ATT02DB			0x01
 #define ATT04DB			0x02
@@ -535,9 +542,9 @@
 ******************************************************************************/
 #define IXJCTL_DAA_COEFF_SET		_IOW ('q', 0xD0, int)
 
-#define DAA_US 		1	//PITA 8kHz
-#define DAA_UK 		2	//ISAR34 8kHz
-#define DAA_FRANCE 	3	//
+#define DAA_US 		1	/*PITA 8kHz */
+#define DAA_UK 		2	/*ISAR34 8kHz */
+#define DAA_FRANCE 	3	/* */
 #define DAA_GERMANY	4
 #define DAA_AUSTRALIA	5
 #define DAA_JAPAN	6
@@ -575,14 +582,14 @@
 ******************************************************************************/
 #define IXJCTL_DAA_AGAIN		_IOW ('q', 0xD2, int)
 
-#define AGRR00DB	0x00	// Analog gain in receive direction 0dB
-#define AGRR3_5DB	0x10	// Analog gain in receive direction 3.5dB
-#define AGRR06DB	0x30	// Analog gain in receive direction 6dB
-
-#define AGX00DB		0x00	// Analog gain in transmit direction 0dB
-#define AGX_6DB		0x04	// Analog gain in transmit direction -6dB
-#define AGX3_5DB	0x08	// Analog gain in transmit direction 3.5dB
-#define AGX_2_5B	0x0C	// Analog gain in transmit direction -2.5dB
+#define AGRR00DB	0x00	/* Analog gain in receive direction 0dB */
+#define AGRR3_5DB	0x10	/* Analog gain in receive direction 3.5dB */
+#define AGRR06DB	0x30	/* Analog gain in receive direction 6dB */
+
+#define AGX00DB		0x00	/* Analog gain in transmit direction 0dB */
+#define AGX_6DB		0x04	/* Analog gain in transmit direction -6dB */
+#define AGX3_5DB	0x08	/* Analog gain in transmit direction 3.5dB */
+#define AGX_2_5B	0x0C	/* Analog gain in transmit direction -2.5dB */
 
 #define IXJCTL_PSTN_LINETEST		_IO  ('q', 0xD3)
 
@@ -639,6 +646,52 @@
 #define IXJCTL_WRITE_WAIT		_IOR ('q', 0xE5, unsigned long)
 #define IXJCTL_DRYBUFFER_READ		_IOR ('q', 0xE6, unsigned long)
 #define IXJCTL_DRYBUFFER_CLEAR		_IO  ('q', 0xE7)
+#define IXJCTL_DTMF_PRESCALE		_IOW ('q', 0xE8, int)
+
+/******************************************************************************
+*
+* This ioctl allows the user application to control what events the driver
+* will send signals for, and what signals it will send for which event.
+* By default, if signaling is enabled, all events will send SIGIO when
+* they occur.  To disable signals for an event set the signal to 0.
+*
+******************************************************************************/
+typedef enum {
+	SIG_DTMF_READY,
+	SIG_HOOKSTATE,
+	SIG_FLASH,
+	SIG_PSTN_RING,
+	SIG_CALLER_ID,
+	SIG_PSTN_WINK,
+	SIG_F0, SIG_F1, SIG_F2, SIG_F3,
+	SIG_FC0, SIG_FC1, SIG_FC2, SIG_FC3,
+	SIG_READ_READY = 33,
+	SIG_WRITE_READY = 34
+} IXJ_SIGEVENT;
+
+typedef struct {
+	unsigned int event;
+	int signal;
+} IXJ_SIGDEF;
+
+#define IXJCTL_SIGCTL			_IOW ('q', 0xE9, IXJ_SIGDEF *)
+
+/******************************************************************************
+*
+* These ioctls allow the user application to change the gain in the 
+* Smart Cable of the Internet Phone Card.  Sending -1 as a value will cause
+* return value to be the current setting.  Valid values to set are 0x00 - 0x1F
+*
+* 11111 = +12 dB
+* 10111 =   0 dB
+* 00000 = -34.5 dB
+*
+* IXJCTL_SC_RXG sets the Receive gain
+* IXJCTL_SC_TXG sets the Transmit gain
+*
+******************************************************************************/
+#define IXJCTL_SC_RXG			_IOW ('q', 0xEA, int)
+#define IXJCTL_SC_TXG			_IOW ('q', 0xEB, int)
 
 /******************************************************************************
 *
@@ -653,3 +706,17 @@
 
 #define IXJCTL_INTERCOM_START 		_IOW ('q', 0xFD, int)
 #define IXJCTL_INTERCOM_STOP  		_IOW ('q', 0xFE, int)
+
+/******************************************************************************
+ *
+ * new structure for accessing raw filter information
+ *
+ ******************************************************************************/
+
+typedef struct {
+	unsigned int filter;
+	char enable;
+	unsigned int coeff[19];
+} IXJ_FILTER_RAW;
+
+#endif

--------------426B0FAA695BB69FD3C49435
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre6-pci_ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre6-pci_ids.patch"

--- linux/include/linux/pci_ids.h-orig	Sat Sep  8 11:41:13 2001
+++ linux/include/linux/pci_ids.h	Sat Sep  8 11:41:34 2001
@@ -852,6 +852,7 @@
 #define PCI_DEVICE_ID_INTERG_2000	0x2000
 #define PCI_DEVICE_ID_INTERG_2010	0x2010
 #define PCI_DEVICE_ID_INTERG_5000	0x5000
+#define PCI_DEVICE_ID_INTERG_5050	0x5050
 
 #define PCI_VENDOR_ID_REALTEK		0x10ec
 #define PCI_DEVICE_ID_REALTEK_8029	0x8029

--------------426B0FAA695BB69FD3C49435
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre6-rd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre6-rd.patch"

--- linux/drivers/block/rd.c.orig	Sat Sep  8 11:58:19 2001
+++ linux/drivers/block/rd.c	Sat Sep  8 12:21:50 2001
@@ -259,7 +259,7 @@
 			/* special: we want to release the ramdisk memory,
 			   it's not like with the other blockdevices where
 			   this ioctl only flushes away the buffer cache. */
-			if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
+			if ((atomic_read(&rd_bdev[minor]->bd_openers) > 2))
 				return -EBUSY;
 			destroy_buffers(inode->i_rdev);
 			rd_blocksizes[minor] = 0;
@@ -372,7 +372,7 @@
 		struct block_device *bdev = rd_bdev[i];
 		rd_bdev[i] = NULL;
 		if (bdev) {
-			blkdev_put(bdev);
+			blkdev_put(bdev, BDEV_FILE);
 			bdput(bdev);
 		}
 		destroy_buffers(MKDEV(MAJOR_NR, i));

--------------426B0FAA695BB69FD3C49435
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre6-rrunner.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre6-rrunner.patch"

--- linux/drivers/net/rrunner.c.orig	Thu Jul  5 04:50:39 2001
+++ linux/drivers/net/rrunner.c	Fri Aug 17 08:12:20 2001
@@ -1238,7 +1238,7 @@
 	       index, cons);
 
 	if (rrpriv->tx_skbuff[index]){
-		len = min(0x80, rrpriv->tx_skbuff[index]->len);
+		len = min(int, 0x80, rrpriv->tx_skbuff[index]->len);
 		printk("skbuff for index %i is valid - dumping data (0x%x bytes - DMA len 0x%x)\n", index, len, rrpriv->tx_ring[index].size);
 		for (i = 0; i < len; i++){
 			if (!(i & 7))
@@ -1249,7 +1249,7 @@
 	}
 
 	if (rrpriv->tx_skbuff[cons]){
-		len = min(0x80, rrpriv->tx_skbuff[cons]->len);
+		len = min(int, 0x80, rrpriv->tx_skbuff[cons]->len);
 		printk("skbuff for cons %i is valid - dumping data (0x%x bytes - skbuff len 0x%x)\n", cons, len, rrpriv->tx_skbuff[cons]->len);
 		printk("mode 0x%x, size 0x%x,\n phys %08x (virt %08lx), skbuff-addr %08lx, truesize 0x%x\n",
 		       rrpriv->tx_ring[cons].mode,

--------------426B0FAA695BB69FD3C49435--

