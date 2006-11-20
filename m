Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933832AbWKTBK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933832AbWKTBK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 20:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933831AbWKTBK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 20:10:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38824 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933829AbWKTBK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 20:10:56 -0500
Date: Mon, 20 Nov 2006 01:15:34 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jeff@garzik.org, shemminger@osdl.org, romieu@fr.zoreil.com,
       csnook@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
Message-ID: <20061120011534.54b1e010@localhost.localdomain>
In-Reply-To: <20061119202817.GA29736@osprey.hogchain.net>
References: <20061119202817.GA29736@osprey.hogchain.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would be nice if it used atl_ not at_ so its less likely to cause
namespace clashes.

You have various macros for swaps that are pretty ugly - we have
cpu_to and le/be_to_cpu functions for most swapping cases and these are
generally optimised assembler (eg bswap on x86)

AT_DESC_USED/UNUSED would be better as inline functions but thats not a
serious concern.

Be careful with :1 bitfields when working with hardware - the compiler
has more than one choice about how to pack them.

The irq enable/disable use for locking on vlan appears unsafe. PCI
interrupt delivery is asynchronous which means you can get this happen


	card sends PCI interrupt
	We call irq_disable
	We take lock
	We poke bits
	We drop lock

	PCI interrupt arrives


This really does happen, typically its nasty to debug as well because you
usually only get it on PIII boards on the one in n-zillion times a
message collides and is retransmitted on the APIC bus.

skb->len is unsigned so <= 0 can be == 0. More importantly the subtraction
before the test will wrap and is completely unsafe (see at_xmit_frame)


Alan
