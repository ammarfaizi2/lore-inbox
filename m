Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265707AbTFNS7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 14:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbTFNS7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 14:59:02 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:5642 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S265707AbTFNS66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 14:58:58 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Russel King <rmk@arm.linux.org.uk>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] fix yenta unload oops
Date: Sat, 14 Jun 2003 21:12:42 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306142112.42731.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

rmmod yenta produces the following oops:
Unable to handle kernel paging request at virtual address d084781e
 printing eip:
d08a555f
*pde = 013f1067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<d08a555f>]    Not tainted
EFLAGS: 00010212
EIP is at yenta_config_init+0x18f/0x1e0 [yenta]
eax: d084781e   ebx: cfe16d08   ecx: c030d508   edx: 00000cfe
esi: cef0d154   edi: c3236000   ebp: c3237f2c   esp: c3237f10
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 2618, threadinfo=c3236000 task=c988ae60)
Stack: d084781e d08a63b6 00000079 00000500 05800000 cef0d154 cef0d21c c3237f44
       d08a55ca cef0d154 c0134970 c988ae60 cef0d21c c3237f50 d08b3d1a cef0d21c
       c3237f68 d08b4657 cef0d21c d08b489b 00000000 cef0d21c c3237fec d08b4fe6
Call Trace:
 [<d08a63b6>] +0x0/0x6a [yenta]
 [<d08a55ca>] yenta_init+0x1a/0x50 [yenta]
 [<c0134970>] process_timeout+0x0/0x10
 [<d08b3d1a>] init_socket+0x2a/0x30 [pcmcia_core]
 [<d08b4657>] shutdown_socket+0x17/0x100 [pcmcia_core]
 [<d08b489b>] socket_shutdown+0x4b/0x60 [pcmcia_core]
 [<d08b4fe6>] pccardd+0x346/0x360 [pcmcia_core]
 [<c0122e70>] default_wake_function+0x0/0x30
 [<c010c092>] ret_from_fork+0x6/0x14
 [<c0122e70>] default_wake_function+0x0/0x30
 [<d08b4ca0>] pccardd+0x0/0x360 [pcmcia_core]

the attached patch fixes this. against 2.5.70-bk.

rgds
-daniel


===== drivers/pcmcia/yenta.c 1.23 vs edited =====
--- 1.23/drivers/pcmcia/yenta.c	Wed Jun 11 23:52:43 2003
+++ edited/drivers/pcmcia/yenta.c	Sat Jun 14 19:37:24 2003
@@ -764,6 +764,9 @@
 {
 	struct yenta_socket *sock = pci_get_drvdata(dev);
 
+	/* we don't want a dying socket registered */
+	pcmcia_unregister_socket(&sock->socket);
+	
 	/* Disable all events so we don't die in an IRQ storm */
 	cb_writel(sock, CB_SOCKET_MASK, 0x0);
 	exca_writeb(sock, I365_CSCINT, 0);
@@ -777,7 +780,6 @@
 		iounmap(sock->base);
 	yenta_free_resources(sock);
 
-	pcmcia_unregister_socket(&sock->socket);
 	pci_set_drvdata(dev, NULL);
 }
 

 [<c010937d>] kernel_thread_helper+0x5/0x18

Code: c6 00 00 c7 44 24 08 79 00 00 00 c7 44 24 04 b6 63 8a d0 8b



