Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTKVXvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 18:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTKVXvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 18:51:16 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:3591 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262838AbTKVXvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 18:51:13 -0500
Date: Sun, 23 Nov 2003 10:51:01 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 7/x: Fix OSS fragments
Message-ID: <20031122235101.GA9276@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au> <20031122082227.GA27692@gondor.apana.org.au> <20031122082635.GA27752@gondor.apana.org.au> <20031122083912.GA27884@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20031122083912.GA27884@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch makes userfragsize do what it's meant to do: do not start
DAC/ADC until a full fragment is available.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p7

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.14
diff -u -r1.14 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 08:39:42 -0000	1.14
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 10:00:30 -0000
@@ -1438,6 +1438,7 @@
 	unsigned long flags;
 	unsigned int swptr;
 	int cnt;
+	int pending;
         DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
@@ -1463,6 +1464,8 @@
 		return -EFAULT;
 	ret = 0;
 
+	pending = 0;
+
         add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1556,7 +1559,7 @@
                         continue;
                 }
 		dmabuf->swptr = swptr;
-		dmabuf->count -= cnt;
+		pending = dmabuf->count -= cnt;
 		spin_unlock_irqrestore(&card->lock, flags);
 
 		count -= cnt;
@@ -1564,7 +1567,9 @@
 		ret += cnt;
 	}
  done:
-	i810_update_lvi(state,1);
+	pending = dmabuf->dmasize - pending;
+	if (dmabuf->enable || pending >= dmabuf->userfragsize)
+		i810_update_lvi(state, 1);
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 
@@ -1581,6 +1586,7 @@
 	ssize_t ret;
 	unsigned long flags;
 	unsigned int swptr = 0;
+	int pending;
 	int cnt;
         DECLARE_WAITQUEUE(waita, current);
 
@@ -1606,6 +1612,8 @@
 		return -EFAULT;
 	ret = 0;
 
+	pending = 0;
+
         add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1698,7 +1706,7 @@
                 }
 
 		dmabuf->swptr = swptr;
-		dmabuf->count += cnt;
+		pending = dmabuf->count += cnt;
 
 		count -= cnt;
 		buffer += cnt;
@@ -1706,7 +1714,8 @@
 		spin_unlock_irqrestore(&state->card->lock, flags);
 	}
 ret:
-	i810_update_lvi(state,0);
+	if (dmabuf->enable || pending >= dmabuf->userfragsize)
+		i810_update_lvi(state, 0);
         set_current_state(TASK_RUNNING);
         remove_wait_queue(&dmabuf->wait, &waita);
 

--bp/iNruPH9dso1Pn--
