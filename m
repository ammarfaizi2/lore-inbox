Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUDOTyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUDOTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:54:54 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:5769 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262850AbUDOTym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:54:42 -0400
Date: Thu, 15 Apr 2004 20:53:15 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Subject: Re: problems with quad Xeon SuperServer came back 4 years later
In-Reply-To: <Pine.LNX.4.44.0404151930120.949-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0404152044390.949-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I fixed it again, only now the solution is a bit more involved:

a) set external cache to writethru (as opposed to writeback it was set 
before)

b) disable both cxxx/dxxx range caching.

Failing to do either a) or b) causes MOST HORRIBLE performance one can 
imagine.

Btw, the /proc/mtrr now looks a bit strange:

# cat /proc/mtrr 
reg00: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg01: base=0x100000000 (4096MB), size=2048MB: write-back, count=1
reg02: base=0xf8000000 (3968MB), size= 128MB: uncachable, count=1

But, the performance is back to normal, i.e. gzip -9 of a 10M file no 
longer takes 6 minutes but only 4 seconds it should. I am a bit worried 
about this 128M uncachable gap, since /proc/iomem says that the address 
falls within the range of System RAM:

# grep RAM /proc/iomem 
00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
00100000-fbdeffff : System RAM

Does this mean that if I access the uncachable memory range (e.g. some 
program happens to be loaded there) it is going to be extremely slow 
again?

I think these sort of "workarounds" should be in an SMP FAQ for the 
ServerWorks chipset (or do people no longer use PIII Xeons and only use 
the modern P4 and the 64bit ones? :)

I am surprized that nobody encountered this problem before.

Kind regards
Tigran

On Thu, 15 Apr 2004, Tigran Aivazian wrote:

> Hello guys,
> 
> Those of you old enough will remember the problem I reported in 2000 (and
> at the time fixed) with quad Xeon SuperServer8050 machine, here is the
> message from 12 October 2000:
> 
>  http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.1/0789.html
> 
> Now, something must have changed between 2000 and 2004 because exactly the
> same problem came back now when running 2.4.21-4EL kernel from Red Hat
> Advanced Server 3 distribution. Only now, disabling the caching of CXXX
> areas in the BIOS doesn't fix the problem, unfortunately.  I haven't tried
> 2.6 on that machine, because I need to get it working urgently with AS3
> kernels.
> 
> Did anyone else run into this? Maybe I should upgrade the BIOS which will
> tune the caching in the chipset appropriately? It is an S2QR6 motherboard
> with 4x PIII Xeon 700MHz and 6G RAM, AMI BIOS v1.2 (not upgraded since
> 1999). The problem is that "everything" is about 40-50 times slower than
> normal. E.g. gzip -9 of a 10M random file takes 6 minutes instead of 5
> seconds etc. It used to compile the kernel in 50 seconds (as the message
> above says). Now it is taking ages, so slow not even worth mentioning the
> exact numbers (i.e. unacceptably slow!)
> 
> Kind regards
> Tigran
> 
> 

