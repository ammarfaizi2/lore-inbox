Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUBZPJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbUBZPJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:09:46 -0500
Received: from hermes.domdv.de ([193.102.202.1]:41481 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S261946AbUBZPJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:09:42 -0500
Message-ID: <403E0C2B.1060309@domdv.de>
Date: Thu, 26 Feb 2004 16:09:31 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@redhat.com, discuss@x86-64.org
Subject: [resend] ioapic+shared interrupt+concurrent access=ide lockup
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did send a similar message about 3 weeks ago to lkml but there was no 
reply. The following is related to 2.6.2 (x86-64) though 2.4 shows 
similar symptoms.

Summary:
--------

The ide subsystem locks up on a dual Opteron system when io-apic is 
enabled and there are concurrent accesses to both ide channels of a pci 
ide controller card. The lockup occurs on different pci ide controller 
cards and there are boot parameters that can be used as workarounds.

Details are given below. If additional information is required please 
contact me. I can currently run any tests required to fix this problem.

Symptoms:
---------

Execute: "dd if=/dev/hde of=/dev/null & ; dd if=/dev/hdg of=/dev/null &"

This results after a short time in:

hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
...

Further accesses to hde and hdg always result then in the same messages
as stated above.

The MIS count of /proc/interrupts steadily increases prior to the 
lockup. It always has the same value as the ide2/ide3 interrupt count on 
cpu1. Note that no irq balancing is active so there should be no 
interrupts on cpu1.

During the tests causing the lockup the system is otherwise idle.

Workarounds:
------------

In the cases listed below the lockup does not happen and the MIS count
of /proc/interrupts stays at zero.

1. Boot with "noapic"
2. Boot with "ide2=serialize"
3. Boot with "ide3=serialize"

System:
-------

Tyan S2885 dual Opteron 246

IDE config:
-----------

ide0/hda WD2500JB
ide1/hdc WD2500JB
ide2/hde WD2500JB
ide3/hdg DVD-RW

ide2/ide3 are were tested with the following cards: HPT302, CMD680 and 
PDC20268 (the latter being now the one in the system). All cards show 
the same behaviour so it is probably not a driver problem.

It doesn't matter if hdg is a DVD-RW or a hard disk, the problem is the 
same.

-- 
Andreas Steinmetz


