Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264554AbUE0OWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbUE0OWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUE0OWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:22:14 -0400
Received: from news.ti.com ([192.94.94.33]:60614 "EHLO dragon.ti.com")
	by vger.kernel.org with ESMTP id S264554AbUE0OWI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:22:08 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6510.0
Subject: dev.c -- dev_queue_xmit-- Is the comment misleading or is it a bug??
Date: Thu, 27 May 2004 19:51:58 +0530
Message-ID: <F6B01C6242515443BB6E5DDD63AE935F05F068@dbde2k01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: dev.c -- dev_queue_xmit-- Is the comment misleading or is it a bug??
Thread-Index: AcRD9fh41e+EOAP5RZuPLw1fJjftIg==
From: "Kumar, Sharath" <krs@ti.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (Please mark a cc to my id  in your reply as I am not subscribed to this list Thanks in advance :-))

I am attaching the snippet for dev_queue_xmit code in net/core/dev.c 

The issue I am trying to point out here is about calling this function from  an interrupt context.
(The comment clearly says that I am right in doing so)

So this function has to be re-entrant if it can be called from an interrupt which means 
q->enqueue() also needs to be re-entrant.

The enqueue function by default is mapped to  pfifo_fast_enqueue  (net/sched/sch_generic.c)
unfortunately the code in this function updates the transmit queue and qdisc->q.qlen
without disabling interrupts. 

So If I call dev_queue_xmit from a non-interrupt context and if I  have an interrupt which again makes
a call to dev_queue_xmit(on the same device), then my transmit queue may be left in inconsistent state  :-(

Either the comment is misleading or I am missing something here.

/**
 *	dev_queue_xmit - transmit a buffer
 *	@skb: buffer to transmit
 *
 *	Queue a buffer for transmission to a network device. The caller must
 *	have set the device and priority and built the buffer before calling
 *	this function. The function can be called from an interrupt.
 *
 *	A negative errno code is returned on a failure. A success does not
 *	guarantee the frame will be transmitted as it may be dropped due
 *	to congestion or traffic shaping.
 */

int dev_queue_xmit(struct sk_buff *skb)
{
		..
	..
	/* Grab device queue */
	spin_lock_bh(&dev->queue_lock);
	q = dev->qdisc;
	if (q->enqueue) {
		rc = q->enqueue(skb, q);


Regards.
-Sharath.

