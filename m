Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272395AbTHNPhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272397AbTHNPhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:37:45 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:37029 "EHLO
	quadxeon.emperorlinux.com") by vger.kernel.org with ESMTP
	id S272395AbTHNPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:37:43 -0400
Subject: 2GB laptop has pcmcia_cs looking for _insane_ sockets
From: Lincoln Durey <lincoln@EmperorLinux.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: EmperorLinux Research <research@EmperorLinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 14 Aug 2003 11:37:07 -0400
Message-Id: <1060875427.15508.2438.camel@tori>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There can't be that many laptops with 2GB RAM, but surely this report
indicates an error somewhere in the pcmcia_cs code (it is looking for
socket number e9b91000 !!)  This bug is a feature of having 2GB ram in
the system and has nothing to do with specific PC cards drop back to 1GB
and all is well (linux 2.4.[19,20,21] and pcmcia_cs 3.2.[3,4]..):

	booting with 2GB ram:

kernel: Linux Kernel Card Services 3.1.22
kernel:   options:  [pci] [cardbus] [pm]
kernel: Yenta IRQ list 0000, PCI irq9
kernel: Socket status: 080c2420
kernel: Yenta IRQ list 0000, PCI irq11
kernel: Socket status: 000dd9e2
kernel: cs: socket e9b91000 timed out during reset.

at a guess, I might say "socket->cap.irq_mask" is wrong, and
I've never seen those Socket status numbers either.
is socket_info_t getting filled incorrectly when there is 2GB ram? 

	The "socket" number varies wildly from boot to boot:

kernel: cs: socket f68d0000 timed out during reset.  Try increasing
setup_delay.
kernel: cs: socket f626c800 timed out during reset.  Try increasing
setup_delay.

	revert that laptop to 1GB ram, and you get a happy PCMCIA slot:

kernel: Linux Kernel Card Services 3.1.22
kernel:   options:  [pci] [cardbus] [pm]
kernel: Yenta IRQ list 04f8, PCI irq9
kernel: Socket status: 30000006
kernel: Yenta IRQ list 04f8, PCI irq11
kernel: Socket status: 30000006

cardmgr[1374]: watching 2 sockets
cardmgr[1375]: starting, version is 3.2.4
cardmgr[1375]: socket 1: 3Com 589 Ethernet
cardmgr[1375]: socket 0: Serial or Modem

lspci: IBM T40
02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus
Controller (rev 01)
02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus
Controller (rev 01) 

	Full logs are available: http://www.emperorlinux.com/research/lkml/


 -- Lincoln @ EmperorLinux     http://www.EmperorLinux.com


