Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUCHGux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUCHGuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:50:52 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:20931 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262409AbUCHGuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:50:50 -0500
Date: Mon, 8 Mar 2004 01:50:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Ben Collins <bcollins@debian.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS when copying data from local to an external drive (ieee1394)
In-Reply-To: <200403070139.30268.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0403070229490.29087@montezuma.fsmlabs.com>
References: <200403070139.30268.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004, Dmitry Torokhov wrote:

> I started getting oopses when cpying data from local IDE to an external
> Firewire drive. Not always, but quite often. The kernel is a bk pull a
> day before 2.6.4-rc2 was released, I do not see any ieee1394 updates
> since.
>
> Unfortunately the oops was not saves in the logs, so here is what I managed
> to write down:

> Oops: 00002 [#1]
> PREEMPT
> CPU: 0
> EIP: 0060 [<c0243d087>] Tainted: P
> EFLAGS: 00010047
> EIP is at hpsb_packet_sent+0x86/0x90
> eax: 00100100 ebx: dfd74000 ecx: dd6edfb0 edx: 00200200

A spot of linked list corruption.

> esi: 00000001 edi: dd6cdf60 ebp: c03e3ee0 esp: c03c3edc
> ds: 007b es: 007b ss: 0068
> Process swapper (pid: 0; threadinfo=c03c2000, task=c034a800)
> ....
> Call trace:
> [<co25306e>] dma_trm_tasklet+0xae/0x1b0

Does this patch help any?

Index: linux-2.6.4-rc1-mm2/drivers/ieee1394/ieee1394_core.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.4-rc1-mm2/drivers/ieee1394/ieee1394_core.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ieee1394_core.c
--- linux-2.6.4-rc1-mm2/drivers/ieee1394/ieee1394_core.c	4 Mar 2004 04:12:44 -0000	1.1.1.1
+++ linux-2.6.4-rc1-mm2/drivers/ieee1394/ieee1394_core.c	8 Mar 2004 06:47:04 -0000
@@ -403,6 +403,8 @@ void hpsb_selfid_complete(struct hpsb_ho
 void hpsb_packet_sent(struct hpsb_host *host, struct hpsb_packet *packet,
                       int ackcode)
 {
+	unsigned long flags;
+
 	packet->ack_code = ackcode;

 	if (packet->no_waiter) {
@@ -413,7 +415,9 @@ void hpsb_packet_sent(struct hpsb_host *

 	if (ackcode != ACK_PENDING || !packet->expect_response) {
 		atomic_dec(&packet->refcnt);
+		spin_lock_irqsave(&host->pending_pkt_lock, flags);
 		list_del(&packet->list);
+		spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 		packet->state = hpsb_complete;
 		queue_packet_complete(packet);
 		return;
