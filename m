Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbUBDURM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUBDURF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:17:05 -0500
Received: from hermes.domdv.de ([193.102.202.1]:42252 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S265709AbUBDUOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:14:22 -0500
Message-ID: <4021529A.506@domdv.de>
Date: Wed, 04 Feb 2004 21:14:18 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ioapic+shared interrupt+concurrent access=ide lockup on 2.4 and 2.6
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
--------

The ide subsystem locks up on a dual Opteron system when io-apic is 
enabled and there are concurrent disk accesses on a pci ide controller 
card. The lockup occurs on different pci ide controller cards and there 
are boot parameters that can be used as workarounds. The lockup can be 
reproduced easily when a software raid5 array is used.

Details are given below. If additional information is required please 
contact me. I can currently run any tests required to fix this problem. 
Though the problem is in 2.4 and 2.6 I would prefer to find out what is 
happening based on 2.6.2 as the system doesn't lock up completely as 
opposed to 2.4.

Symptoms:
---------

Executing "dd if=/dev/md1 of=/dev/null bs=65536" on 2.6.2 (64 bit) 
results after a few seconds in:

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

When dd-ing concurrently from all disks (/dev/hdc, /dev/hde, /dev/hdg) 
from userspace on 2.6.2 the MIS count increases and finally the lockup 
happens though it takes considerably longer than using the raid5 array.

On 2.4 (either 32 bit or 64 bit) with the dd command on /dev/md1 it 
takes a few minutes to result in:

hde: dma_timer_expiry: dma status == 0x24

The 2.4 systems lock up completely then (nmi watchdog triggers, no SysRq 
on 64 bit).

In all cases the MIS count of /proc/interrupts steadily increases prior 
to the lockup. It always has the same value as the ide2/ide3 interrupt 
count on cpu1. Note that no irq balancing is active so there should be 
no interrupts on cpu1.

During the tests causing the lockup the system is otherwise idle.

Workarounds:
------------

In the cases listed below the lockup does not happen and the MIS count 
of /proc/interrupts stays at zero.

1. Boot with "noapic"
2. Boot with "ide2=serialize" (tested on 2.6.2 only)
3. Boot with "ide3=serialize" (tested on 2.6.2 only)

System:
-------

Tyan S2885 dual Opteron 246

IDE config:
-----------

ide0/hda DVD-RW
ide1/hdc WD2500JB
ide2/hde WD2500JB
ide3/hdg WD2500JB

ide2/ide3 are connected either to a HPT302 or a CMD680 card (same 
behaviour with both cards), so ide2 and ide3 share the same interrupt.

Raid5 config:
-------------

raiddev /dev/md1
	raid-level		5
	nr-raid-disks		3
	nr-spare-disks		0
	persistent-superblock	1
	chunk-size		32
	device			/dev/hdc6
	raid-disk		0
	device			/dev/hde6
	raid-disk		1
	device			/dev/hdg6
	raid-disk		2

-- 
Andreas Steinmetz

