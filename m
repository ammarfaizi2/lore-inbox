Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUJBIe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUJBIe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 04:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267356AbUJBIe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 04:34:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:2454 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267354AbUJBIef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 04:34:35 -0400
Date: Sat, 2 Oct 2004 10:31:23 +0200
From: Olaf Hering <olh@suse.de>
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] khpsbpkt exists on suspend
Message-ID: <20041002083123.GB24322@suse.de>
References: <20040923221018.GA15788@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040923221018.GA15788@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben,

sw-suspend does not work with our kernel.
khpsbpkt will die because down_interruptible returns -EINTR on suspend.
As a result, hpsb packet delivery will not work anymore after resume.


knodemgrd_0   D 00000000     0  5291      1                5170 (L-TLB)
c30cbe98 00000046 00000010 00000000 ab7b5340 000f4221 c0c54ae0 c5490aa0 
       c5490bf0 c30ca000 c30cbf04 c30cbeb4 c30cbeec c03053be 00000000 c5490aa0 
       c0119c00 00000000 00000000 c0c54aec c6e08000 c89e758b 00000001 c5490aa0 
Call Trace:
 [<c03053be>] wait_for_completion+0x6e/0xa0
 [<c0119c00>] default_wake_function+0x0/0x10
 [<c89e758b>] hpsb_packet_received+0x6b/0x70 [ieee1394]
 [<c0119c00>] default_wake_function+0x0/0x10
 [<c89e6c99>] hpsb_send_packet_and_wait+0x49/0x60 [ieee1394]
 [<c89e7dad>] hpsb_make_readpacket+0x6d/0x80 [ieee1394]
 [<c89e8189>] hpsb_read+0x49/0xd0 [ieee1394]
 [<c89e81a1>] hpsb_read+0x61/0xd0 [ieee1394]
 [<c89eb953>] nodemgr_bus_read+0x53/0x90 [ieee1394]
 [<c89f05f0>] csr1212_parse_bus_info_block+0xb0/0x130 [ieee1394]
 [<c89f0d9e>] csr1212_parse_csr+0x1e/0x90 [ieee1394]
 [<c89ed353>] nodemgr_node_scan_one+0x63/0x1e0 [ieee1394]
 [<c89ed529>] nodemgr_node_scan+0x59/0x60 [ieee1394]
 [<c89edba4>] nodemgr_host_thread+0x144/0x180 [ieee1394]
 [<c89eda60>] nodemgr_host_thread+0x0/0x180 [ieee1394]
 [<c0104255>] kernel_thread_helper+0x5/0x10


diff -purN linux-2.6.9-rc3/drivers/ieee1394/ieee1394_core.c linux-2.6.9-rc3.bug45851/drivers/ieee1394/ieee1394_core.c
--- linux-2.6.9-rc3/drivers/ieee1394/ieee1394_core.c	2004-09-30 05:04:23.000000000 +0200
+++ linux-2.6.9-rc3.bug45851/drivers/ieee1394/ieee1394_core.c	2004-10-02 10:14:09.408062417 +0200
@@ -1030,15 +1030,19 @@ static int hpsbpkt_thread(void *__hi)
 
 	daemonize("khpsbpkt");
 
-	while (!down_interruptible(&khpsbpkt_sig)) {
-		if (khpsbpkt_kill)
+	while (1) {
+		if (down_interruptible(&khpsbpkt_sig)) {
+			if (current->flags & PF_FREEZE) {
+				refrigerator(0);
+				continue;
+			}
+			printk("khpsbpkt: received unexpected signal?!\n" );
 			break;
-
-		if (current->flags & PF_FREEZE) {
-			refrigerator(0);
-			continue;
 		}
 
+		if (khpsbpkt_kill)
+			break;
+
 		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
 			packet = (struct hpsb_packet *)skb->data;
 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
