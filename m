Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUJOVos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUJOVos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUJOVos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:44:48 -0400
Received: from ipx-196-245-190-80.ipxserver.de ([80.190.245.196]:36817 "EHLO
	ipx10046.ipxserver.de") by vger.kernel.org with ESMTP
	id S268463AbUJOVn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:43:28 -0400
Subject: tun.c patch to fix "smp_processor_id() in preemptible code"
From: Alain Schroeder <alain@parkautomat.net>
To: linux-kernel@vger.kernel.org
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Type: multipart/mixed; boundary="=-n3kiN/2jthBHZzaOuFzb"
Message-Id: <1097876587.4170.16.camel@marvin.home.parkautomat.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 23:43:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n3kiN/2jthBHZzaOuFzb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was getting these traces on a SMP host:

dsor-vm2 kernel: using smp_processor_id() in preemptible code: linux/480
dsor-vm2 kernel:  [smp_processor_id+108/132] smp_processor_id+0x6c/0x84
kernel:  [pg0+945156838/1070318592] tun_chr_writev+0x14e/0x174 [tun]
kernel:  [pg0+945156917/1070318592] tun_chr_write+0x29/0x30 [tun]
kernel:  [vfs_write+189/236] vfs_write+0xbd/0xec
kernel:  [sys_write+64/108] sys_write+0x40/0x6c
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

The (very) little attached patch fixes this.

Bye,
   Alain

PS: I am not subscribed to the lkml.

-- 
"My grandfather once told me that there are two kinds of people: those
who work and those who take the credit. He told me to try to be in the
first group; there was less competition there." -- Indira Gandhi

--=-n3kiN/2jthBHZzaOuFzb
Content-Disposition: attachment; filename=tun-preempt.patch
Content-Type: text/x-patch; name=tun-preempt.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.8-rc2/drivers/net/tun.c	Wed Jun 16 05:19:22 2004
+++ linux-2.6.9-rc4-mm1-skas/drivers/net/tun.c	Fri Oct 15 21:16:18 2004
@@ -207,7 +207,9 @@
 	if (tun->flags & TUN_NOCHECKSUM)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
  
+	preempt_disable();
 	netif_rx_ni(skb);
+	preempt_enable();
    
 	tun->stats.rx_packets++;
 	tun->stats.rx_bytes += len;

--=-n3kiN/2jthBHZzaOuFzb--

