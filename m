Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTETWvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbTETWvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:51:00 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:42407 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261450AbTETWtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:49:53 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 10/14] USB speedtouch: send path micro optimizations
Date: Wed, 21 May 2003 01:02:47 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210102.47957.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 speedtch.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:55 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:55 2003
@@ -167,8 +167,8 @@
 	struct atm_skb_data atm_data;
 	unsigned int num_cells;
 	unsigned int num_entire;
-	unsigned char cell_header [ATM_CELL_HEADER];
 	unsigned int pdu_padding;
+	unsigned char cell_header [ATM_CELL_HEADER];
 	unsigned char aal5_trailer [ATM_AAL5_TRAILER];
 };
 
@@ -483,8 +483,7 @@
 		memset (target, 0, ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER);
 		target += ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER;
 
-		if (--ctrl->num_cells)
-			BUG();
+		BUG_ON (--ctrl->num_cells);
 	}
 
 	memcpy (target, ctrl->aal5_trailer, ATM_AAL5_TRAILER);
@@ -674,11 +673,11 @@
 static void udsl_process_send (unsigned long data)
 {
 	struct udsl_send_buffer *buf;
-	int err;
 	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
-	unsigned int num_written;
 	struct sk_buff *skb;
 	struct udsl_sender *snd;
+	int err;
+	unsigned int num_written;
 
 made_progress:
 	spin_lock_irq (&instance->send_lock);
@@ -712,16 +711,15 @@
 			list_add (&snd->list, &instance->spare_senders);
 			spin_unlock_irq (&instance->send_lock);
 			list_add (&buf->list, &instance->filled_send_buffers);
-			return;
+			return; /* bail out */
 		}
 
 		spin_lock_irq (&instance->send_lock);
 	} /* while */
 	spin_unlock_irq (&instance->send_lock);
 
-	if (!instance->current_skb && !(instance->current_skb = skb_dequeue (&instance->sndqueue))) {
+	if (!instance->current_skb && !(instance->current_skb = skb_dequeue (&instance->sndqueue)))
 		return; /* done - no more skbs */
-	}
 
 	skb = instance->current_skb;
 

