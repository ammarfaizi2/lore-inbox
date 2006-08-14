Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWHNUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWHNUBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWHNUBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:01:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55477 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932616AbWHNUBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:01:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com>
Date: Mon, 14 Aug 2006 14:00:33 -0600
In-Reply-To: <44E0AD1D.1040408@zytor.com> (H. Peter Anvin's message of "Mon,
	14 Aug 2006 10:04:29 -0700")
Message-ID: <m1hd0ft7dq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Vivek Goyal wrote:
>> On Thu, Aug 10, 2006 at 02:09:58PM -0600, Eric W. Biederman wrote:
>>>> I just reserved memory at non 2MB aligned location 65MB@15MB so that
>>>> kernel is loaded at 16MB and other smaller segments below the compressed
>>>> image, then I can successfully booted into the kdump kernel.
>>> :)
>>>
>>>> So basically kexec on panic path seems to be clean except stomping issue.
>>>> May be bzImage program header should reflect right "MemSize" which
>>>> takes into account extra memory space calculations.
>>> Yes.  That sounds like the right thing to do.
>>>
>>> I remember trying to compute a good memsize when I created the bzImage
>>> header but it is completely possible I missed some part of the
>>> calculation or assumed that the kernels .bss section would always be
>>> larger than what I needed for decompression.
>>>
>
> Could someone please describe the intended semantics of this MemSize header,
> *and* its intended usage?

I think Vivek did a decent job.  But here is my take.

Currently the ELF header we prepend to the linux kernel have
exactly one segment.

A segment has several file offset, fields alignment, type, physical
address, virtual address, file size, and memory size.

The file size parameter describes how much data to pull off of the
disk.  The memory size describes how much room the segment will
consume in memory.  The difference between file size and memory size
is treated as bss data.  Memory size must always be bigger than
file size.

In the case of the kernel there is a certain amount of memory that
the kernel uses before it starts reserving things and using the
memory map.  The memory that the kernel unconditionally uses should
be described with the memsize parameter.

An accurate description allows your initrd and your parameter segment
to be placed right up next to your kernel without worry about them
being stomped, we already do this on a couple of other architectures,
or it allows you to detect that there is not enough room to hold your
kernel, initrd and parameters.

So since we now have the possibility of describing this accurately I
would like to.  Although the traditional x86 work around of pushing
everything up as far in memory as we can and the kernel can address
is potentially still an option.

For the kexec on panic case we have a very small reserved chunk of
memory (16MB I think is typical right now).  The smaller that we can
successfully run out of the better.  Which makes it easy to hit these
kinds of things if we don't have an accurate description of the
kernel.

Eric
