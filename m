Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUKVW6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUKVW6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUKVW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:56:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10903 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261204AbUKVWv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:51:59 -0500
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: Akinobu Mita <amgta@yacht.ocn.ne.jp>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
In-Reply-To: <41A20DB5.2050302@in.ibm.com>
References: <419CACE2.7060408@in.ibm.com>
	 <20041119153052.21b387ca.akpm@osdl.org>
	 <1100912759.4987.207.camel@dyn318077bld.beaverton.ibm.com>
	 <200411201204.37750.amgta@yacht.ocn.ne.jp>  <41A20DB5.2050302@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1101162858.4987.231.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Nov 2004 14:34:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hari,

Thanks for the patch and I tried it. 

I hacked "sysrq-b" to call panic() to test this.
So far, my success is limited.

These could be already known and being worked on ..
Out of few times I tried, I run into following.

1) When panic the system, I get
Badness in smp_call_function() in arch/i386/kernel/smp.c: 552
and the system hangs.

2) Machine boots to single user only with 1 CPU. 
I get following msgs while booting second kernel.

..

Booting processor 1/1 eip 2000
Stuck ??
Inquiring remote APIC #1...
... APIC #1 ID: 01000000
... APIC #1 VERSION: 00040011
... APIC #1 SPIV: 000000ff
CPU #1 not responding - cannot use it.
Booting processor 1/2 eip 2000
Stuck ??
Inquiring remote APIC #2...
... APIC #2 ID: 02000000
... APIC #2 VERSION: 00040011
... APIC #2 SPIV: 000000ff
CPU #2 not responding - cannot use it.
Booting processor 1/3 eip 2000
Stuck ??
Inquiring remote APIC #3...
... APIC #3 ID: 03000000
... APIC #3 VERSION: 00040011
...

3) When I tried to run gdb on the core file,
gdb gets killed since there is not enough memory.
(this is on the second kernel - so this could be okay).

#gdb vmlinux.kexec1 ../core/vmcore.1
GNU gdb 5.2.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "i586-suse-linux"...oom-killer:
gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 4, high 12, batch 2
cpu 0 cold: low 0, high 4, batch 2
HighMem per-cpu: empty
                       
Free pages:        1116kB (0kB HighMem)
Active:2222 inactive:3280 dirty:0 writeback:0 unstable:0 free:279
slab:804 mapped:2275 pagetables:23
DMA free:292kB min:292kB low:364kB high:436kB active:108kB
inactive:128kB present:16384kB pages_scanned:544 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:824kB min:588kB low:732kB high:880kB active:8780kB
inactive:12992kB present:32768kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB = 292kB
Normal: 44*4kB 7*8kB 1*16kB 0*32kB 3*64kB 1*128kB 1*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 824kB
HighMem: empty
Swap cache: add 23125, delete 19925, find 8355/9281, race 2+1
Out of Memory: Killed process 4290 (gdb).
Terminated

FYI.


Thanks,
Badari

On Mon, 2004-11-22 at 08:03, Hariprasad Nellitheertha wrote:
> Akinobu Mita wrote:
> > I've forgotten CC-ing.
> > 
> > On Saturday 20 November 2004 10:05, Badari Pulavarty wrote:
> > 
> > 
> >>4) Load the second kernel to be booted using
> >>
> >>   kexec -p <second-kernel> --args-linux --append="root=<root-dev> dump
> >>   init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"
> >>
> >>But kexec doesn't seem to like option "-p".
> >>Even when I removed "-p", its complaining about "--args-linux"
> 
> 
> There is a kexec-tools patch that is required to get the "-p" option
> working. I had sent it out only to the fastboot mailing list without
> updating kdump documentation. I will send out an updated documentation
> patch indicating this requirement (I will host the patch on some site
> and point to it in the document).
> 
> Meanwhile, I am attaching the patch with this note. Kindly try kdump
> with this. Thanks!
> 
> Regards, Hari
> 


