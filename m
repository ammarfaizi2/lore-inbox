Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319393AbSH2Vwr>; Thu, 29 Aug 2002 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319387AbSH2VwR>; Thu, 29 Aug 2002 17:52:17 -0400
Received: from smtpout.mac.com ([204.179.120.85]:36574 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319368AbSH2Vus>;
	Thu, 29 Aug 2002 17:50:48 -0400
Message-Id: <200208292155.g7TLtBKN026234@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 10/41 sound/oss/midibuf.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/midibuf.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/midibuf.c	Wed Aug 14 22:41:29 2002
@@ -15,7 +15,7 @@
  */
 #include <linux/stddef.h>
 #include <linux/kmod.h>
-
+#include <linux/spinlock.h>
 #define MIDIBUF_C
 
 #include "sound_config.h"
@@ -55,6 +55,7 @@
 };
 
 static volatile int open_devs = 0;
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 #define DATA_AVAIL(q) (q->len)
 #define SPACE_AVAIL(q) (MAX_QUEUE_SIZE - q->len)
@@ -63,20 +64,20 @@
 	if (SPACE_AVAIL(q)) \
 	{ \
 	  unsigned long flags; \
-	  save_flags( flags);cli(); \
+	  spin_lock_irqsave(&lock, flags); \
 	  q->queue[q->tail] = (data); \
 	  q->len++; q->tail = (q->tail+1) % MAX_QUEUE_SIZE; \
-	  restore_flags(flags); \
+	  spin_unlock_irqrestore(&lock, flags); \
 	}
 
 #define REMOVE_BYTE(q, data) \
 	if (DATA_AVAIL(q)) \
 	{ \
 	  unsigned long flags; \
-	  save_flags( flags);cli(); \
+	  spin_lock_irqsave(&lock, flags); \
 	  data = q->queue[q->head]; \
 	  q->len--; q->head = (q->head+1) % MAX_QUEUE_SIZE; \
-	  restore_flags(flags); \
+	  spin_unlock_irqrestore(&lock, flags); \
 	}
 
 static void drain_midi_queue(int dev)
@@ -122,8 +123,7 @@
 	unsigned long   flags;
 	int             dev;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	if (open_devs)
 	{
 		for (dev = 0; dev < num_midis; dev++)
@@ -135,9 +135,9 @@
 				{
 					int c = midi_out_buf[dev]->queue[midi_out_buf[dev]->head];
 
-					restore_flags(flags);	/* Give some time to others */
+					spin_unlock_irqrestore(&lock,flags);/* Give some time to others */
 					ok = midi_devs[dev]->outputc(dev, c);
-					cli();
+					spin_lock_irqsave(&lock, flags);
 					midi_out_buf[dev]->head = (midi_out_buf[dev]->head + 1) % MAX_QUEUE_SIZE;
 					midi_out_buf[dev]->len--;
 				}
@@ -151,7 +151,7 @@
 		 * Come back later
 		 */
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 int MIDIbuf_open(int dev, struct file *file)
@@ -217,7 +217,6 @@
 void MIDIbuf_release(int dev, struct file *file)
 {
 	int mode;
-	unsigned long flags;
 
 	dev = dev >> 4;
 	mode = translate_mode(file);
@@ -225,9 +224,6 @@
 	if (dev < 0 || dev >= num_midis || midi_devs[dev] == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
-
 	/*
 	 * Wait until the queue is empty
 	 */
@@ -249,7 +245,6 @@
 					 * Ensure the output queues are empty
 					 */
 	}
-	restore_flags(flags);
 
 	midi_devs[dev]->close(dev);
 
@@ -267,7 +262,6 @@
 
 int MIDIbuf_write(int dev, struct file *file, const char *buf, int count)
 {
-	unsigned long flags;
 	int c, n, i;
 	unsigned char tmp_data;
 
@@ -276,9 +270,6 @@
 	if (!count)
 		return 0;
 
-	save_flags(flags);
-	cli();
-
 	c = 0;
 
 	while (c < count)
@@ -308,6 +299,8 @@
 		for (i = 0; i < n; i++)
 		{
 			/* BROKE BROKE BROKE - CANT DO THIS WITH CLI !! */
+			/* yes, think the same, so I removed the cli() brackets 
+				QUEUE_BYTE is protected against interrupts */
 			if (copy_from_user((char *) &tmp_data, &(buf)[c], 1)) {
 				c = -EFAULT;
 				goto out;
@@ -317,7 +310,6 @@
 		}
 	}
 out:
-	restore_flags(flags);
 	return c;
 }
 
@@ -325,14 +317,10 @@
 int MIDIbuf_read(int dev, struct file *file, char *buf, int count)
 {
 	int n, c = 0;
-	unsigned long flags;
 	unsigned char tmp_data;
 
 	dev = dev >> 4;
 
-	save_flags(flags);
-	cli();
-
 	if (!DATA_AVAIL(midi_in_buf[dev])) {	/*
 						 * No data yet, wait
 						 */
@@ -361,6 +349,8 @@
 			REMOVE_BYTE(midi_in_buf[dev], tmp_data);
 			fixit = (char *) &tmp_data;
 			/* BROKE BROKE BROKE */
+			/* yes removed the cli() brackets again
+			 should q->len,tail&head be atomic_t? */
 			if (copy_to_user(&(buf)[c], fixit, 1)) {
 				c = -EFAULT;
 				goto out;
@@ -369,7 +359,6 @@
 		}
 	}
 out:
-	restore_flags(flags);
 	return c;
 }
 
@@ -440,7 +429,7 @@
 
 int MIDIbuf_avail(int dev)
 {
-        if (midi_in_buf[dev])
+	if (midi_in_buf[dev])
 		return DATA_AVAIL (midi_in_buf[dev]);
 	return 0;
 }

