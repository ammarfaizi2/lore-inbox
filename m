Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUDEE41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 00:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUDEE41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 00:56:27 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:5711 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263104AbUDEE4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 00:56:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 - panic when intensive disk access on 120GB firewire disk
Date: Sun, 4 Apr 2004 23:56:19 -0500
User-Agent: KMail/1.6.1
Cc: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
References: <40706EA2.7040900@rgadsdon2.giointernet.co.uk>
In-Reply-To: <40706EA2.7040900@rgadsdon2.giointernet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404042356.21109.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 April 2004 03:22 pm, Robert Gadsdon wrote:
> Kernel panic from 2.6.5 'final' when running slocate (updatedb) 
> accessing 120GB firewire disk:
> 
> Oops: 00002 [#1]
> PREEMPT SMP
> CPU: 0
> EIP: 0060:[<f8a10a27>]  Not tainted
> EFLAGS: 00010047 (2.6.5)
> EIP is at hpsb_packet_sent+0x27/0x90 [ieee1394]

Could you please try the patch below.

Thank you.
-- 
Dmitry


===================================================================


ChangeSet@1.1784, 2004-04-04 23:52:29-05:00, dtor_core@ameritech.net
  IEEE1394: Make sure that a packet submitted into completion
            queue just once; race between hpsb_packet_sent and
            hpsb_packet_received


 ieee1394_core.c |   26 ++++++++++++++++++++++----
 ieee1394_core.h |    1 +
 2 files changed, 23 insertions(+), 4 deletions(-)


===================================================================



diff -Nru a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c	Sun Apr  4 23:53:45 2004
+++ b/drivers/ieee1394/ieee1394_core.c	Sun Apr  4 23:53:45 2004
@@ -96,7 +96,7 @@
 	WARN_ON(packet->complete_routine != NULL);
 	packet->complete_routine = routine;
 	packet->complete_data = data;
-	return;
+	atomic_set(&packet->completion_armed, 1);
 }
 
 /**
@@ -412,8 +412,26 @@
 	}
 
 	if (ackcode != ACK_PENDING || !packet->expect_response) {
+		struct hpsb_packet *p;
+		struct list_head *lh;
+		unsigned long flags;
+
 		atomic_dec(&packet->refcnt);
-		list_del(&packet->list);
+
+		/*
+		 * Remove packet from host's pending queue
+		 * (and not from any other queue)
+		 */
+		spin_lock_irqsave(&host->pending_pkt_lock, flags);
+	        list_for_each(lh, &host->pending_packets) {
+                	p = list_entry(lh, struct hpsb_packet, list);
+                	if (p == packet) {
+				list_del(&packet->list);
+				break;
+                	}
+        	}
+		spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
+
 		packet->state = hpsb_complete;
 		queue_packet_complete(packet);
 		return;
@@ -1003,7 +1021,8 @@
 
 static void queue_packet_complete(struct hpsb_packet *packet)
 {
-	if (packet->complete_routine != NULL) {
+	if (packet->complete_routine != NULL &&
+	    atomic_dec_and_test(&packet->completion_armed)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&khpsbpkt_lock, flags);
@@ -1013,7 +1032,6 @@
 		/* Signal the kernel thread to handle this */
 		up(&khpsbpkt_sig);
 	}
-	return;
 }
 
 static int hpsbpkt_thread(void *__hi)
diff -Nru a/drivers/ieee1394/ieee1394_core.h b/drivers/ieee1394/ieee1394_core.h
--- a/drivers/ieee1394/ieee1394_core.h	Sun Apr  4 23:53:45 2004
+++ b/drivers/ieee1394/ieee1394_core.h	Sun Apr  4 23:53:45 2004
@@ -66,6 +66,7 @@
 	 * packet is completed.  */
 	void (*complete_routine)(void *);
 	void *complete_data;
+	atomic_t completion_armed;
 
         /* Store jiffies for implementing bus timeouts. */
         unsigned long sendtime;
