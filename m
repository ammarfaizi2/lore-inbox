Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWE2WkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWE2WkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWE2WkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:40:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751443AbWE2WkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:40:01 -0400
Date: Mon, 29 May 2006 15:44:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: torvalds@osdl.org, scjody@modernduck.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc5] ieee1394_core: switch to kthread API
Message-Id: <20060529154402.cfa5143e.akpm@osdl.org>
In-Reply-To: <tkrat.cfb023075101da5c@s5r6.in-berlin.de>
References: <tkrat.cfb023075101da5c@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 18:43:52 +0200 (CEST)
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

We end up with:

:static void queue_packet_complete(struct hpsb_packet *packet)
:{
:	if (packet->no_waiter) {
:		hpsb_free_packet(packet);
:		return;
:	}
:	if (packet->complete_routine != NULL) {
:		skb_queue_tail(&hpsbpkt_queue, packet->skb);
:		wake_up_process(khpsbpkt_thread);
:	}
:	return;
:}
:
:static int hpsbpkt_thread(void *__hi)
:{
:	struct sk_buff *skb;
:	struct hpsb_packet *packet;
:	void (*complete_routine)(void*);
:	void *complete_data;
:
:	current->flags |= PF_NOFREEZE;
:
:	while (!kthread_should_stop()) {
:		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
:			packet = (struct hpsb_packet *)skb->data;
:
:			complete_routine = packet->complete_routine;
:			complete_data = packet->complete_data;
:
:			packet->complete_routine = packet->complete_data = NULL;
:
:			complete_routine(complete_data);
:		}

There's a race here.

:		set_current_state(TASK_INTERRUPTIBLE );
:		schedule();
:	}
:
:	return 0;
:}

If queue_packet_complete() is called on another CPU in that window, there
will be a new skb queued and we'll miss the wakeup.

I used skb_peek() in the below fix, but there are other ways, perhaps..


--- devel/drivers/ieee1394/ieee1394_core.c~ieee1394_core-switch-to-kthread-api-fix	2006-05-29 15:42:30.000000000 -0700
+++ devel-akpm/drivers/ieee1394/ieee1394_core.c	2006-05-29 15:42:40.000000000 -0700
@@ -1001,7 +1001,6 @@ void abort_timedouts(unsigned long __opa
 static struct task_struct *khpsbpkt_thread;
 static struct sk_buff_head hpsbpkt_queue;
 
-
 static void queue_packet_complete(struct hpsb_packet *packet)
 {
 	if (packet->no_waiter) {
@@ -1036,10 +1035,11 @@ static int hpsbpkt_thread(void *__hi)
 			complete_routine(complete_data);
 		}
 
-		set_current_state(TASK_INTERRUPTIBLE );
-		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!skb_peek(&hpsbpkt_queue))
+			schedule();
+		__set_current_state(TASK_RUNNING);
 	}
-
 	return 0;
 }
 
_

