Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWHACdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWHACdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWHACdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:33:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37052 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030363AbWHACdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:33:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com>
	<20060706081520.GB28225@host0.dyn.jankratochvil.net>
	<aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>
	<20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060731202520.GB11790@in.ibm.com>
	<20060731210050.GC11790@in.ibm.com>
Date: Mon, 31 Jul 2006 20:31:43 -0600
In-Reply-To: <20060731210050.GC11790@in.ibm.com> (Vivek Goyal's message of
	"Mon, 31 Jul 2006 17:00:50 -0400")
Message-ID: <m18xm9425s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Jul 31, 2006 at 04:25:20PM -0400, Vivek Goyal wrote:
>> On Mon, Jul 31, 2006 at 10:19:04AM -0600, Eric W. Biederman wrote:
>> > 
>> > I have spent some time and have gotten my relocatable kernel patches
>> > working against the latest kernels.  I intend to push this upstream
>> > shortly.
>> > 
>> > Could all of the people who care take a look and test this out
>> > to make certain that it doesn't just work on my test box?
>> > 
>> Hi Eric,
>> 
>> Currently I am testing your patches on i386. With CONFIG_RELOCATABLE=y
>> kernel boots fine and kexec also works.
>> 
>> But my kernel hangs on kexec on panic case. It hangs early in 
>> decompress_kernel(). Kernel hangs at following condition.
>> 
>> +       if (((u32)output - CONFIG_PHYSICAL_START) & 0x3fffff)
>> +               error("Destination address not 4M aligned");
>> 

As for the missing print.  Did you have an appropriate earlyprintk?

> Ok. I am decompressing the kernel to 16MB and after reducing 1MB of
> CONFIG_PHYSICAL_START I am left with 15MB which is not 4M aligned
> hence I seems to be running into it.
>
> I changed it to
>
> if ((u32)output) & 0x3fffff)
>
> and kdump kernel booted fine. But this will run into issues if I load
> kernel at 1MB.
>
> I got a dump question. Why do I have to load the kernel at 4MB alignment?
> Existing kernel boots loads at 1MB, which is non 4MB aligned and it works
> fine?

4MB is a little harsh, but I haven't worked through what the exact rules
are, I know 4MB is the worst case alignment for arch/i386.

The rule is that we have to be at the same offset from 4MB as we
were built to run at.  So in this case address where (address %4MB) == 1MB.

We might be able to get away with 2MB alignment.  I thought kexec-tools
did that calculation automatically for an ET_DYN image but it has been
a while since I looked.

My goal with the check was to catch problems early before something
bad happened.

Eric

