Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTKVHJu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 02:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKVHJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 02:09:50 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:47890 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262056AbTKVHJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 02:09:48 -0500
Date: Sat, 22 Nov 2003 18:09:31 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 1/x: Fix wait queue race in drain_dac
Message-ID: <20031122070931.GA27231@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This is the first of a number of patches to fix DMA bugs in the
OSS i810_audio driver.

This particular one fixes a textbook race condition in drain_dac
that causes it to timeout when it shouldn't.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p1

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.8
diff -u -r1.8 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	3 Sep 2003 10:27:11 -0000	1.8
+++ kernel-source-2.4/drivers/sound/i810_audio.c	21 Nov 2003 11:20:48 -0000
@@ -1231,6 +1231,17 @@
 		spin_lock_irqsave(&state->card->lock, flags);
 		i810_update_ptr(state);
 		count = dmabuf->count;
+
+		/* It seems that we have to set the current state to
+		 * TASK_INTERRUPTIBLE every time to make the process
+		 * really go to sleep.  This also has to be *after* the
+		 * update_ptr() call because update_ptr is likely to
+		 * do a wake_up() which will unset this before we ever
+		 * try to sleep, resuling in a tight loop in this code
+		 * instead of actually sleeping and waiting for an
+		 * interrupt to wake us up!
+		 */
+		__set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 		if (count <= 0)
@@ -1250,16 +1261,6 @@
                         break;
                 }
 
-		/* It seems that we have to set the current state to
-		 * TASK_INTERRUPTIBLE every time to make the process
-		 * really go to sleep.  This also has to be *after* the
-		 * update_ptr() call because update_ptr is likely to
-		 * do a wake_up() which will unset this before we ever
-		 * try to sleep, resuling in a tight loop in this code
-		 * instead of actually sleeping and waiting for an
-		 * interrupt to wake us up!
-		 */
-		set_current_state(TASK_INTERRUPTIBLE);
 		/*
 		 * set the timeout to significantly longer than it *should*
 		 * take for the DAC to drain the DMA buffer

--AhhlLboLdkugWU4S--
