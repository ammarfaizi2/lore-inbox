Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUDEFDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 01:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbUDEFDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 01:03:20 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:42870 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263101AbUDEFDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 01:03:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PANIC] ohci1394 & copy large files
Date: Mon, 5 Apr 2004 00:03:10 -0500
User-Agent: KMail/1.6.1
Cc: Ben Collins <bcollins@debian.org>, Marcel Lanz <marcel.lanz@ds9.ch>
References: <20040404141600.GB10378@ds9.ch> <20040404141339.GW13168@phunnypharm.org>
In-Reply-To: <20040404141339.GW13168@phunnypharm.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404050003.13758.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 April 2004 09:13 am, Ben Collins wrote:
> On Sun, Apr 04, 2004 at 04:16:00PM +0200, Marcel Lanz wrote:
> > Since 2.6.4 and still in 2.6.5 I get regurarly a Kernel panic if I try
> > to backup large files (10-35GB) to an external attached disc (200GB/JFS) via ieee1394/sbp2.
> > 
> > Has anyone similar problems ?
> 
> Known issue, fixed in our repo. I still need to sync with Linus once I
> iron one more issue and merge some more patches.
> 

I have some concerns that it is completely fixed in your tree - there is still
a race - if hpsb_packet_received arrives before hosb_packet_sent then there is
a chance that the code will try to put the same packet in the completion queue
twice. With SVN tree it will cause kernel BUG in skb code, in BK tree kernel
will just oops.

I wonder what was the reason to convert the code to abuse skbs aside for using
skbs queues and their locking?

Anyway, below is a backport of my patch from SVN to BK tree, I would like to
know if it works for others...

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
