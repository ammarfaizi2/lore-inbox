Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933968AbWKTGgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933968AbWKTGgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933967AbWKTGgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:36:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26065 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933964AbWKTGf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:35:59 -0500
Message-ID: <45614C80.5070303@redhat.com>
Date: Mon, 20 Nov 2006 01:34:40 -0500
From: Chris Snook <csnook@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] atl1: Revised Attansic L1 ethernet driver
References: <20061119202817.GA29736@osprey.hogchain.net> <20061120011534.54b1e010@localhost.localdomain>
In-Reply-To: <20061120011534.54b1e010@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Would be nice if it used atl_ not at_ so its less likely to cause
> namespace clashes.

Some of this code looked like Attansic may have meant to share it 
between drivers for atl1/atl2/atf1/atf2, but seeing as I can't find any 
code for those, I'll convert it all to atl1_ and let Attansic generalize 
the code if they ever decide they want to submit drivers.

> You have various macros for swaps that are pretty ugly - we have
> cpu_to and le/be_to_cpu functions for most swapping cases and these are
> generally optimised assembler (eg bswap on x86)
> 
> AT_DESC_USED/UNUSED would be better as inline functions but thats not a
> serious concern.
> 
> Be careful with :1 bitfields when working with hardware - the compiler
> has more than one choice about how to pack them.

Lacking a spec, I'm not entirely sure what the original intent was, so 
we're stuck with testing.  Is there a specific disambiguation technique 
you recommend?

> The irq enable/disable use for locking on vlan appears unsafe. PCI
> interrupt delivery is asynchronous which means you can get this happen
> 
> 
> 	card sends PCI interrupt
> 	We call irq_disable
> 	We take lock
> 	We poke bits
> 	We drop lock
> 
> 	PCI interrupt arrives
> 
> 
> This really does happen, typically its nasty to debug as well because you
> usually only get it on PIII boards on the one in n-zillion times a
> message collides and is retransmitted on the APIC bus.

Nice catch.  I admit the VLAN code is not so well audited or tested. 
Fortunately, the chip only seems to be on Asus M2V motherboards, at 
least for now, but I want to audit all of the locking code at some point.

> skb->len is unsigned so <= 0 can be == 0. More importantly the subtraction
> before the test will wrap and is completely unsafe (see at_xmit_frame)

Thanks!

	-- Chris
