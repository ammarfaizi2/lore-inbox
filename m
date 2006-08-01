Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWHAJLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWHAJLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWHAJLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:11:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3036 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932379AbWHAJLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:11:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Kratochvil <lace@jankratochvil.net>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>
	<20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060731202520.GB11790@in.ibm.com>
	<20060731210050.GC11790@in.ibm.com>
	<m18xm9425s.fsf@ebiederm.dsl.xmission.com>
	<20060801042528.GA19157@host0.dyn.jankratochvil.net>
Date: Tue, 01 Aug 2006 03:09:28 -0600
In-Reply-To: <20060801042528.GA19157@host0.dyn.jankratochvil.net> (Jan
	Kratochvil's message of "Tue, 1 Aug 2006 06:25:28 +0200")
Message-ID: <m1bqr43jqv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kratochvil <lace@jankratochvil.net> writes:

> On Tue, 01 Aug 2006 04:31:43 +0200, Eric W. Biederman wrote:
> ...
>> 4MB is a little harsh, but I haven't worked through what the exact rules
>> are, I know 4MB is the worst case alignment for arch/i386.
>> 
>> The rule is that we have to be at the same offset from 4MB as we
>> were built to run at.  So in this case address where (address %4MB) == 1MB.
>
> In such case your patch is not optimal.  The original VA Linux Japan patch 2.0
> 	http://mkdump.sourceforge.net/cvs.html
> 	cvs -q -z3
> -d:pserver:anonymous:@mkdump.cvs.sourceforge.net:/cvsroot/mkdump rdiff -u -r
> bp_linux-2_6-minik -r linux-2_6-minik linux
> had lower alignment requirements and these were really tested that time.
>
> i386 had alignment requirement:
> 	/* current_thread_info()&co. are 8192-alignment fixed (for the initial
> stack). */
> 	#if CONFIG_PHYSICAL_START & 0x1FFF
> 	#error "CONFIG_PHYSICAL_START must be 2*PAGE_SIZE (0x2000) aligned!"
> 	#endif
> as IIRC those i386 2MB/4MB pages must be (apparently) 2MB/4MB aligned in the
> virtual address space but their physical target address can be arbitrary.

I know you can't use huge pages if your physical address is not
properly aligned.   Which can be a performance impact if nothing else.
Not something I want to encourage in a general purpose kernel. 

If it is actually a problem once we get past the user confusion
aspect of this I will happily revisit it.  The big confusion in all of
this is that with a 4MB alignment and a 1MB offset the useable cases
are: 1MB, 5MB, 9MB, 13MB, 17MB, 21MB... 


What I did that is rather unique is I actually enforce this in misc.c
so there is no way we can slip by our alignment requirements.

I'm not terribly comfortable with the 8K alignment number as we only
tell the linker we need 4K alignment.  So there might be other
implicit things out there as well.  Although I admit head.S may be
the only place we can get away with that kind of thing, as the linker
can move everything else around.  Groan yet another kernel audit if
we go this route.

> and x86_64 alignment requirement was:
> 	#if (CONFIG_PHYSICAL_START - 0x100000) & 0x1FFFFF
> 	#error "CONFIG_PHYSICAL_START must be '2MB * x + 1MB' aligned!"
> 	#endif
> while IIRC those x86_64 2MB pages need to have even the physical target address
> 2MB aligned.  Lower alignment would require suboptimal execution by not using
> the 2MB pages (and the patch would have to handle it appropriately).

Yes. I have that check.  Except now the check really is
(CONFIG_PHYSICAL_START & 0x1FFFFF) == 0 because the x86_64 kernel lives at
2MB by default now, so it can really get the benefit of huge pages.

> ( I did not check your patches as they are locked in that useless GIT anyway. )
( As opposed to the unuseable CVS I presume :)

I guess I should just post them so we can have a sane conversation :)

Eric

