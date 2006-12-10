Return-Path: <linux-kernel-owner+w=401wt.eu-S1760219AbWLJE0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760219AbWLJE0O (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 23:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760223AbWLJE0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 23:26:14 -0500
Received: from science.horizon.com ([192.35.100.1]:18345 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760219AbWLJE0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 23:26:13 -0500
Date: 9 Dec 2006 23:26:10 -0500
Message-ID: <20061210042610.30658.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have not had yet any problems with VMSPLIT_3G_OPT ever since I
> used it -- which dates back to when it was a feature of Con
> Kolivas's patchset (known as LOWMEM1G), [even] before it got
> merged in mainline.
>
> (Excluding the cases Adrian Bunk listed: WINE, which I don't use, and 
> also 'some Java programs' which I have not seen.)

Seconded.  I have several servers with 1G of memory, and appreciate the
option very much; I maintained it as a custom patch long before it
became a CONFIG option.

Turning on CONFIG_EMBEDDED makes it a bit annoying to be sure not to
play with any of the other far more dangerous options that enables.
(I suppose I could just maintain a local patch to remove that from Kconfig.)

The last I remember hearing, the vm system wasn't very happy with highem
much smaller than lowmem (128M/896M = 1/7) anyway.

There's nothing wrong with a stern warning, but I'd think that disabling
CONFIG_NET would break a lot more user-space programs, and that's not
protected.


How about the following (which also fixes a bug if you select VMSPLIT_2G
and HIGHEM; with 64-bit page tables, the split must be on a 1G boundary):

choice
	depends on EXPERIMENTAL
	prompt "Memory split"
	default VMSPLIT_3G
	help
	  Select the desired split between kernel and user memory.
	  If you are not absolutely sure what you are doing, leave this
	  option alone!

	  There are important efficiency reasons why the user address
	  space and the kernel address space must both fit into the 4G
	  linear virtual address space provided by the x86 architecture.

	  Normally, Linux divides this into 3G for user virtual memory
	  and 1G for kernel memory, which holds up to 896M of RAM plus all
	  memory-mapped peripheral (e.g. PCI) devices.	Excess RAM is ignored.

	  If the "High memory support" options are enabled, the excess memory
	  is available as "high memory", which can be used for user data,
	  including file system caches, but not kernel data structures.
	  However, accessing high memory from the kernel is slightly more
	  costly than low memory, as it has to be mapped into the kernel
	  address range first.

	  This option lets systems choose to have a larger "low memory" space,
	  either to avoid the need for high memory support entirely, or for
	  workloads which require particularly large kernel data structures.

	  The downside is that the available user address space is reduced.
	  While most programs do not care, this is an incompatible change
	  to the kernel binary interface, and must be made with caution.
	  Some programs that process a lot of data will work more slowly or
	  fail, and some programs that do clever things with virtual memory
	  will crash immediately.

	  In particular, changing this option from the default breaks valgrind
	  version 3.1.0, VMware, and some Java virtual machines.

	config VMSPLIT_3G
		bool "Default 896MB lowmem (3G/1G user/kernel split)"
	config VMSPLIT_3G_OPT
		depends on !HIGHMEM
		bool "1G lowmem (2.75G/1.25G user/kernel split)   CAUTION"
	config VMSPLIT_2G
		bool "1.875G lowmem (2G/2G user/kernel split)     CAUTION"
	config VMSPLIT_2G_OPT
		depends on !HIGHMEM
		bool "2G lowmem (1.875G/2.125G user/kernel split) CAUTION"
	config VMSPLIT_1G
		bool "2.875G lowmem (1G/3G user/kernel split)     CAUTION"
	config VMSPLIT_1G_OPT
		depends on !HIGHMEM
		bool "3G lowmem (896M/3.125G user/kernel split)   CAUTION"
endchoice

config PAGE_OFFSET
        hex
        default 0xB0000000 if VMSPLIT_3G_OPT
        default 0x80000000 if VMSPLIT_2G
        default 0x78000000 if VMSPLIT_2G_OPT
        default 0x40000000 if VMSPLIT_1G
        default 0x38000000 if VMSPLIT_1G_OPT
        default 0xC0000000

(Copyright on the above abandoned to the public domain.)
