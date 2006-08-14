Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWHNVRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWHNVRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWHNVQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:16:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28572 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964935AbWHNVQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:16:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: "H. Peter Anvin" <hpa@zytor.com>, Don Zickus <dzickus@redhat.com>,
       fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com>
	<20060814181118.GB2519@in.ibm.com> <44E0CFD0.3060506@zytor.com>
	<20060814194252.GC2519@in.ibm.com> <44E0D2DB.7030003@zytor.com>
	<m18xlrt6wk.fsf@ebiederm.dsl.xmission.com>
	<20060814205921.GE2519@in.ibm.com>
Date: Mon, 14 Aug 2006 15:15:59 -0600
In-Reply-To: <20060814205921.GE2519@in.ibm.com> (Vivek Goyal's message of
	"Mon, 14 Aug 2006 16:59:21 -0400")
Message-ID: <m1ejvjrpbk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Aug 14, 2006 at 02:10:51PM -0600, Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> 
>> > Vivek Goyal wrote:
>> >>>>
>> >>> What about once the kernel is booted?
>> >> Sorry did not understand the question. Few more lines will help.
>> >>
>> >
>> > Is this field intended to protect any kind of memory during the early boot
> phase
>> > of the kernel proper, or only the decompressor?
>> 
>> Yes, the field should account for memory usage until the kernel starts
>> doing the accounting at run time.
>> 
>> I'm actually surprised that taking into account the .bss was not enough to
>> cover up anything the decompressor was doing.  Usually the kernel's .bss
>> is more than the extra 32K or so that the decompressor uses.
>>
>
> I think .bss section size will act as a buffer for decompressor only if
> .bss is not part of compressed data hence decompressor does not have to
> move beyond bss and it can run very well from kernel bss space. 

Agreed.  

> But somehow on my machine, it looks like that bss is very much part
> of raw binary image hence part of compressed data (vmlinux.bin.gz).
> memsz exported in bzImage is same as size of raw output binary.
>
> Probably that's the reason that we are stomping other segments in my
> case and if my understanding is right then it should happen irrespective
> of kernel bss size.
>
> Here I am pasting how kernel vmlinux file program headers look like.
> .bss is mapped by first program header along with .text.

Ok.  So somehow we have done the insane thing of putting .bss in the middle of
the executable.  It might even be sane if it is just the .init sections we put
after it, but no we are putting .data after the .bss.

Well that easily explains why we had a problem.

Getting the proper accounting in for handling this case is probably reasonable.
It probably also makes sense for someone to take a good hard look at the crazy
ordering of sections on x86_64.

Eric
