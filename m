Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbTB1JDG>; Fri, 28 Feb 2003 04:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTB1JDG>; Fri, 28 Feb 2003 04:03:06 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:17624 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267679AbTB1JDE>; Fri, 28 Feb 2003 04:03:04 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: don't race the tasklets
Date: Fri, 28 Feb 2003 10:12:52 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281012.52627.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtouch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtouch.c b/drivers/usb/misc/speedtouch.c
--- a/drivers/usb/misc/speedtouch.c	Fri Feb 28 10:08:32 2003
+++ b/drivers/usb/misc/speedtouch.c	Fri Feb 28 10:08:32 2003
@@ -326,10 +326,10 @@
 
 	dbg ("udsl_complete_receive entered (urb 0x%p, status %d)", urb, urb->status);
 
-	tasklet_schedule (&instance->receive_tasklet);
 	/* may not be in_interrupt() */
 	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
 	list_add_tail (&rcv->list, &instance->completed_receivers);
+	tasklet_schedule (&instance->receive_tasklet);
 	spin_unlock_irqrestore (&instance->completed_receivers_lock, flags);
 }
 
@@ -489,11 +489,11 @@
 
 	dbg ("udsl_complete_send entered (urb 0x%p, status %d)", urb, urb->status);
 
-	tasklet_schedule (&instance->send_tasklet);
 	/* may not be in_interrupt() */
 	spin_lock_irqsave (&instance->send_lock, flags);
 	list_add (&snd->list, &instance->spare_senders);
 	list_add (&snd->buffer->list, &instance->spare_buffers);
+	tasklet_schedule (&instance->send_tasklet);
 	spin_unlock_irqrestore (&instance->send_lock, flags);
 }
 

