Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbRGKMCS>; Wed, 11 Jul 2001 08:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbRGKMCJ>; Wed, 11 Jul 2001 08:02:09 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:52468 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S267288AbRGKMB4>; Wed, 11 Jul 2001 08:01:56 -0400
Date: Wed, 11 Jul 2001 13:03:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave J <davej@suse.de>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
In-Reply-To: <3B4BC5C0.BDDC12A6@home.com>
Message-ID: <Pine.LNX.4.21.0107111239460.1306-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Jordan wrote:
> While trying to figure out what happened to make my two identical
> processors show up differently in /proc/cpuinfo I noticed that they do
> not appear differently in the x86info utility.  Here is a copy of my
> /proc/cpuinfo:
> 
> processor       : 0
> ...
> cpuid level     : 2
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse
> bogomips        : 1992.29
> 
> processor       : 1
> ...
> cpuid level     : 3
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse
> bogomips        : 1998.84
> 
> Notice that the cpuid level and bogomips values are reported to be
> different ...

As others have said, cpuid level 3 corresponds to Processor Serial
Number enabled.  I think what you have here is a machine on which
the BIOS has disabled PSN on the first CPU, but left it enabled on the
second CPU, and so the kernel has then disabled it on the second CPU.

Whereas arch/i386/kernel/setup.c clears its own copy of the Processor
Serial Number feature bit 18 (a.k.a. 0x40000 or "pn") when it "squashes"
the serial number, it doesn't re-evaluate cpuid_level, so still reports
the original 3.  But if it tried cpuid 0 again, it would find that
max cpuid level has gone down to 2 - as x86info finds.  No big deal.

And the bogomips difference has no significance: a timing loop
got fractionally different results when run on the two processors,
run it another time and they'd both come out different again.

Hugh

