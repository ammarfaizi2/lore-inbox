Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRAOVdY>; Mon, 15 Jan 2001 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbRAOVdO>; Mon, 15 Jan 2001 16:33:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46354 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131564AbRAOVdC>; Mon, 15 Jan 2001 16:33:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 4G SGI quad Xeon - memory-related slowdowns
Date: 15 Jan 2001 13:32:40 -0800
Organization: Transmeta Corporation
Message-ID: <93vq9o$vt$1@penguin.transmeta.com>
In-Reply-To: <3A6364AF.AC4D4081@fnal.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A6364AF.AC4D4081@fnal.gov>,
Paul Hubbard  <phubbard@fnal.gov> wrote:
>
>We're having some problems with the 2.4.0 kernel on our SGI 1450, and
>were hoping for some help.
> The box is a quad Xeon 700/2MB, with 4GB of memory, ServerSet III HE
>chipset, RH6.1 (slightly modified for local configuration) distribution.
>
>a) If we compile the kernel with no high memory support, /proc/meminfo
>shows 1G of memory and everything works fine.

Good.

>b) If we compile for 4G of memory, /proc/meminfo shows about 3G, and
>overriding the amount at the lilo prompt causes kernel panics at bootup.
>However, other than missing a quarter of the memory, it works just
>fine.

3GB is right - your last 1GB is above the 4GB mark, and it's mapped
there explicitly so that you'll have space in the low 32 bits to map PCI
devices etc (and things like the APIC, you get the idea). 

If you try to override it, you will very obviously crash, because if you
tell Linux that you have 4GB of memory, Linux will think that you have
4GB of _contiguous_ memory, which is not true.  The only way to use that
last gigabyte is to enable support for memory > 4GB, and get the proper
memory map _without_ any overrides that shows the proper holes for PCI
space. 

Check your "dmesg" output under a working kernel for details - you'll
see how the memory is laid out and reported by the e820 call..

>c) If we compile the kernel for 64G high memory (PAE mode), we see all
>of the memory but have other problems:
>  i) mkefs -m0 on a 72GB Seagate SCSI disk runs very slowly (about
>5MB/sec instead of 22-25) and the machine hangs after the format
>completes. To be exact, the command prompt returns, but
>     ls or any other command will never return, and you have to reset
>the box. This is a 
>     showstopper for us!

Sounds like a true-to-God bug. Possibly in the form of incorrect MTRR
settings. Make sure you enable MTRR support.

I do need more information on what seems to hang, and how it hangs. One
of the pre-kernels will give you a nice stack backtrace for each process
if you press control-scrolllock, and that might be useful.

>  ii) If I override the amount of memory via lilo, we still get the
>       hang, but performance actually improves!

The performance problem is _probably_ due to the kernel having to
double-buffer the IO requests, coupled with bad MTRR settings (ie memory
above the 4GB range is probably marked as non-cacheable or something,
which means that you'll get really bad performance). 

Not using the high memory will avoid the double-buffering, and will also
avoid using memory that isn't cached. If I'm right.

The hang still indicates that something is wrong in PAE-land, though.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
