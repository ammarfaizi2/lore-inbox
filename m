Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276880AbSIVJKq>; Sun, 22 Sep 2002 05:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276951AbSIVJKD>; Sun, 22 Sep 2002 05:10:03 -0400
Received: from smtpout.mac.com ([204.179.120.86]:17149 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276880AbSIVJIo>;
	Sun, 22 Sep 2002 05:08:44 -0400
Date: Sat, 21 Sep 2002 22:41:03 +0200
Subject: [PATCH] 7/11 sound/oss replace cli()
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <71BA1DEC-CDA2-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/gus_midi.c	2002-04-20 18:25:20.000000000 
+0200
+++ linux-2.5-cli-oss/sound/oss/gus_midi.c	2002-08-16 
13:57:28.000000000 +0200
@@ -16,6 +16,7 @@
   */

  #include <linux/init.h>
+#include <linux/spinlock.h>
  #include "sound_config.h"

  #include "gus.h"
@@ -25,7 +26,7 @@
  static int      my_dev;
  static int      output_used = 0;
  static volatile unsigned char gus_midi_control;
-
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
  static void     (*midi_input_intr) (int dev, unsigned char data);

  static unsigned char tmp_queue[256];
@@ -75,8 +76,7 @@

  	output_used = 1;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);

  	if (GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY)
  	{
@@ -92,7 +92,7 @@
  		outb((gus_midi_control), u_MidiControl);
  	}

-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  	return ok;
  }

@@ -113,16 +113,14 @@
  	/*
  	 * Drain the local queue first
  	 */
-
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);

  	while (qlen && dump_to_midi(tmp_queue[qhead]))
  	{
  		qlen--;
  		qhead++;
  	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  	/*
  	 *	Output the byte if the local queue is empty.
@@ -142,14 +140,13 @@
  		return 0;	/*
  				 * Local queue full
  				 */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);

  	tmp_queue[qtail] = midi_byte;
  	qlen++;
  	qtail++;

-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  	return 1;
  }

@@ -174,15 +171,14 @@
  	if (!output_used)
  		return 0;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);

  	if (qlen && dump_to_midi(tmp_queue[qhead]))
  	{
  		qlen--;
  		qhead++;
  	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  	return (qlen > 0) | !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
  }

@@ -226,11 +222,9 @@
  void gus_midi_interrupt(int dummy)
  {
  	volatile unsigned char stat, data;
-	unsigned long flags;
  	int timeout = 10;

-	save_flags(flags);
-	cli();
+	spin_lock(&lock);

  	while (timeout-- > 0 && (stat = GUS_MIDI_STATUS()) & 
(MIDI_RCV_FULL | MIDI_XMIT_EMPTY))
  	{
@@ -258,5 +252,5 @@
  			}
  		}
  	}
-	restore_flags(flags);
+	spin_unlock(&lock);
  }

