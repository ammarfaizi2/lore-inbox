Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277365AbRJEM34>; Fri, 5 Oct 2001 08:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277367AbRJEM3p>; Fri, 5 Oct 2001 08:29:45 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:42253 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S277365AbRJEM3f>; Fri, 5 Oct 2001 08:29:35 -0400
Message-Id: <200110051229.f95CTvN00624@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: unnecessary retransmit from network stack
Date: Fri, 5 Oct 2001 14:29:53 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i wrote a prototype for a nic driver for my theses some time
ago. when looking at the performance of my nic driver i could 
not beleave how slow it is. i started to log tcp sequence 
numbers and saw that the network stack asks my driver to 
transmit the same tcp paket multiple times within less then 
2ms. how can that happen? below you see what the drivers sees 
when an ssh connection is set up on a PII 400MHz 2.4.7 kernel.

why does net_dev.hard_start_xmit get called multiple times 
with the same tcp packet?  


TxMit: transmit function of the nic driver
TxIrq: packet transmission reported by nic
RxIrq: packet reception reported by nic

cpu clock-tick | event | Tcp SeqNo | Tcp AckNo
---------------|-------|-----------|----------
0x186dce194bc8 | TxMit | 909902971 | 0
0x186dce1beb05 | TxIrq | 909902971 | 0
0x186dce1ef8f8 | RxIrq | 897283491 | 909902972
0x186dce1f8b03 | TxMit | 909902972 | 897283492
0x186dce220317 | TxIrq | 909902972 | 897283492
0x186dce3002e8 | RxIrq | 897283492 | 909902972
0x186dce308560 | TxMit | 909902972 | 897283515 <- dublicate
0x186dce330bab | TxIrq | 909902972 | 897283515
0x186dce3c09bf | TxMit | 909902972 | 897283515 <- dublicate
0x186dce3e9b6f | TxIrq | 909902972 | 897283515
0x186dce424310 | RxIrq | 897283515 | 909902994
0x186dce47bc44 | RxIrq | 897283515 | 909902994	 
0x186dcf094683 | TxMit | 909902994 | 897283791
0x186dcf0bcafb | TxIrq | 909902994 | 897283791


