Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282816AbRLGKWG>; Fri, 7 Dec 2001 05:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRLGKV4>; Fri, 7 Dec 2001 05:21:56 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:40576 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S282816AbRLGKVv>;
	Fri, 7 Dec 2001 05:21:51 -0500
Message-Id: <200112071021.fB7ALeH00823@hal.astr.lu.lv>
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: i810_audio.c v0.11 is still broken (deadlocks)
Date: Fri, 7 Dec 2001 12:21:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_44YYUVNPBHZARVSSAF64"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_44YYUVNPBHZARVSSAF64
Content-Type: text/plain;
  charset="iso-8859-13"
Content-Transfer-Encoding: 8bit

Downloaded i810_audio.c v0.11 this morning. 

After loading it I'm getting system deadlock immediatelly after first attempt 
to use sound support as i810_write() calls i810_update_lvi() without setting
PCM_ENABLE_INPUT bit. Added setting this bit in i810_write() and
also some protection against deadlocks in __i810_update_lvi() with 
corresponding error message (see attached diffs).

Results: sound seems to work as far as I have tested for not a very long time.

I'm still getting messages that __i810_update_lvi() is called without setting
PCM_ENABLE_INPUT (which would cause deadlock without protection
I added there).

Andris

--------------Boundary-00=_44YYUVNPBHZARVSSAF64
Content-Type: text/x-diff;
  charset="iso-8859-13";
  name="i810_audio.c.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="i810_audio.c.diff"

--- i810_audio.c-0.11	Fri Dec  7 08:29:51 2001
+++ i810_audio.c	Fri Dec  7 11:28:32 2001
@@ -959,7 +959,11 @@
 		} else {
 			__start_dac(state);
 		}
-		while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
+		if (dmabuf->trigger & PCM_ENABLE_INPUT) {
+    			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
+		} else {
+			printk (KERN_ERR "i810_audio: __i810_update_lvi called without setting PCM_ENABLE_INPUT\n");
+		}
 	}
 
 	/* swptr - 1 is the tail of our transfer */
@@ -1509,6 +1513,12 @@
 		x = dmabuf->fragsize - (swptr % dmabuf->fragsize);
 		memset(dmabuf->rawbuf + swptr, '\0', x);
 	}
+	// There is data waiting to be played
+	/*
+	 * Force the trigger setting since we would
+	 * deadlock with it set any other way
+	 */
+	dmabuf->trigger = PCM_ENABLE_OUTPUT;
 	i810_update_lvi(state,0);
 ret:
         set_current_state(TASK_RUNNING);

--------------Boundary-00=_44YYUVNPBHZARVSSAF64--
