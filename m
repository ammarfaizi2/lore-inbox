Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265129AbTLRNH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbTLRNH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:07:56 -0500
Received: from ns.suse.de ([195.135.220.2]:52614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265129AbTLRNHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:07:53 -0500
Date: Thu, 18 Dec 2003 14:05:04 +0100
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: x86_64-2.6.0-1 released
Message-Id: <20031218140504.5ea235c8.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The first x86-64 patchkit for the 2.6.0 linux kernel has been released. I normally don't announce
patchkits to linux-kernel, but a lot of people don't seem to know about them. The patchkit
has fixes for many serious bugs (including data corruption iossues) on x86-64 that didn't make it 
in official 2.6.0. Please don't bother reporting any x86-64 problems to me if you didn't 
apply the patchkit first. 

Hopefully now that the trees are more open again most of this can migrate into the official
tree, depending on the policy enforced by Linus/Andrew.

This version just has a few minor fixes against the last patchkit release (x86_64-2.6.0test11-3)

ftp://ftp.x86-64.org/pub/linux/v2.6/x86_64-2.6.0-1.bz2
df65fee5a0388a036d324cb9b16bd778  x86_64-2.6.0-1.bz2

ChangeLog since x86_64-2.6.0test11-3:
- Mark some more non 64bit clean drivers !64BIT
- Remove dump_sg in pci-gart.c again
- Fix inefficiency in find_next_bit

Older Changelog is available in ftp://ftp.x86-64.org/pub/linux/v2.6/RELEASE-NOTES

Some known issues:
Taskfile IO can hang SuSE hwscan. Better disable it for now.
Taskfile IO can cause disk corruption too.
NMI watchdog runs too often (HZ instead once a second) (still true?)
[I think that's fixed now, but needs verifying]
Machine Check calls printk currently, but that can deadlock when the MCE
occurs inside any of the console locks.
sysfs support for arch/ may not be complete.
32bit SYSCALL seems to still have problems with some programs (disabled currently)
Some reports of persistent segfaults after stress tests
(also seen once here, need to be reproduced). Could be IOMMU overflow.
Mysterious timer bug in some cases. Shortly in or after bootup
the timer lists gets corrupted in some configuration. Seems to depend
on how long the bootup takes.
JFS seems to corrupt file systems quickly (generic 64bit bug)
	[maintainer cannot reproduce it]
WCHAN seems to be broken
Suspend often doesn't initialize video after wakeup
	Generic problem, needs a lot of effort to fix properly. The graphic
	card has to be POSTed properly, which is quite complicated.
MPT fusion driver breaks when iommu merging is disabled (run with iommu=merge)
	A workaround for this is enabled by default now. Underlying bug
	still unfixed. This bug seems to only occur on some specific machines,
	most MPT fusion users probably don't have to worry about it. Seems
	to be a driver bug.
Realtek 8169 driver does not support >4GB (patch exists, should be merged
by network driver maintainer) 
Nvidia and VIA boards are forced to IO-APIC off to work around ACPI bugs.
	This will be a major problem once SMP boards with these chipsets 
	are out.
Some boards don't set the wall clock correctly
G400 DRM crashes machine
VIA SATA doesn't work
Some people report disk corruptions with IOMMU. Not able to reproduce it.
	It seems to happen on some block device drivers who have a very deep
	queue. Mostly these devices don't need an IOMMU (3ware is a prominent 
	exception) because they support 64bit IO. Unfortunately many people
	still run with CONFIG_IOMMU_DEBUG which will force the IOMMU support
	for every device. Changing the IOMMU flush to flush on every mapping
	seems to fix it. Currently there are workarounds active that
	check for Qlogic and 3ware and do that.  Anybody still seeing this please 
	try with iommu=fullflush and report back.
	Underlying bug still undebugged.
Scheduler does not work well with NUMA (testcase multithreaded STREAM) 
	It does not distribute threads quickly enough to all CPUs,
	which leads to memory getting allocated on the wrong nodes.
Some motherboard/cpu combinations do not reboot automatically
IPSec netlink setup code is not 32bit emulation clean
iptables is not 32bit emulation clean
gettimeofday gets non monontonous when ntpd corrects drift
valgrind does not run even with linux32 --3gb. Figure out what is different.
	[An a.out emacs also doesn't run. Probable the same difference]


-Andi
