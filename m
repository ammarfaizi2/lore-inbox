Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWHJULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWHJULL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWHJULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:11:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19144 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751516AbWHJUKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:10:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060804234327.GF16231@redhat.com>
	<m1hd0rmaje.fsf@ebiederm.dsl.xmission.com>
	<20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
Date: Thu, 10 Aug 2006 14:09:58 -0600
In-Reply-To: <20060810181825.GD14732@in.ibm.com> (Vivek Goyal's message of
	"Thu, 10 Aug 2006 14:18:25 -0400")
Message-ID: <m1irl01hex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Thu, Aug 10, 2006 at 11:05:22AM -0600, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@in.ibm.com> writes:
>> 
>> > Apart from this I think something is still off on x86_64. I have not
>> > been able to make kdump work on x86_64. Second kernel simply hangs.
>> > Two different machines are showing different results.
>> >
>> > - On one machine, it seems to be stuck somewhere in decompress_kernel().
>> >   Serial console is not behaving properly even with earlyprintk(). Somehow
>> >   I feel it is some bss corruption even after my changes.
>> >
>> > - Other machines seems to be going till start_kernel() and even after
>> >   that (No messages on the console, all serial debugging) and then
>> >   either it hangs or jumps back to BIOS.
>> >
>> > Will look more into it.
>> 
>> Thanks.
>> 
>> I'm a little disappointed but at this point it isn't a great surprise,
>> the code is early yet and hasn't had much testing or attention.
>> I wonder if I have missed something else silly.
>> 
>> As for testing, can you use plain kexec to load the kernel at a
>> different address?  I'm curious to know if it is something related
>> to the kexec on panic path or if it is just running at a different
>> location that is the problem.
>
> Yes. This seems to be minor stuff. Parameter segment seems to be
> getting stomped while I am doing decompression. Most probably should
> be coming from extra space calculations (32K etc) being done at run
> time to find out where should we shift the compressed image.
>
> Kexec works because parameter segment is being loaded below the
> compressed image and doest not get stomped over. :-) 

Ah.  That makes sense.

> I just reserved memory at non 2MB aligned location 65MB@15MB so that
> kernel is loaded at 16MB and other smaller segments below the compressed
> image, then I can successfully booted into the kdump kernel.

:)

> So basically kexec on panic path seems to be clean except stomping issue.
> May be bzImage program header should reflect right "MemSize" which
> takes into account extra memory space calculations.

Yes.  That sounds like the right thing to do.  

I remember trying to compute a good memsize when I created the bzImage
header but it is completely possible I missed some part of the
calculation or assumed that the kernels .bss section would always be
larger than what I needed for decompression.

Eric
