Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWHAE2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWHAE2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWHAE2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:28:33 -0400
Received: from ip-160-218-152-249.eurotel.cz ([160.218.152.249]:42401 "EHLO
	host0.dyn.jankratochvil.net") by vger.kernel.org with ESMTP
	id S1161002AbWHAE2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:28:33 -0400
Date: Tue, 1 Aug 2006 06:25:28 +0200
From: Jan Kratochvil <lace@jankratochvil.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060801042528.GA19157@host0.dyn.jankratochvil.net>
References: <aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com> <20060707133518.GA15810@in.ibm.com> <20060707143519.GB13097@host0.dyn.jankratochvil.net> <20060710233219.GF16215@in.ibm.com> <20060711010815.GB1021@host0.dyn.jankratochvil.net> <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com> <20060731202520.GB11790@in.ibm.com> <20060731210050.GC11790@in.ibm.com> <m18xm9425s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xm9425s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 04:31:43 +0200, Eric W. Biederman wrote:
...
> 4MB is a little harsh, but I haven't worked through what the exact rules
> are, I know 4MB is the worst case alignment for arch/i386.
> 
> The rule is that we have to be at the same offset from 4MB as we
> were built to run at.  So in this case address where (address %4MB) == 1MB.

In such case your patch is not optimal.  The original VA Linux Japan patch 2.0
	http://mkdump.sourceforge.net/cvs.html
	cvs -q -z3 -d:pserver:anonymous:@mkdump.cvs.sourceforge.net:/cvsroot/mkdump rdiff -u -r bp_linux-2_6-minik -r linux-2_6-minik linux
had lower alignment requirements and these were really tested that time.

i386 had alignment requirement:
	/* current_thread_info()&co. are 8192-alignment fixed (for the initial stack). */
	#if CONFIG_PHYSICAL_START & 0x1FFF
	#error "CONFIG_PHYSICAL_START must be 2*PAGE_SIZE (0x2000) aligned!"
	#endif
as IIRC those i386 2MB/4MB pages must be (apparently) 2MB/4MB aligned in the
virtual address space but their physical target address can be arbitrary.

and x86_64 alignment requirement was:
	#if (CONFIG_PHYSICAL_START - 0x100000) & 0x1FFFFF
	#error "CONFIG_PHYSICAL_START must be '2MB * x + 1MB' aligned!"
	#endif
while IIRC those x86_64 2MB pages need to have even the physical target address
2MB aligned.  Lower alignment would require suboptimal execution by not using
the 2MB pages (and the patch would have to handle it appropriately).

( I did not check your patches as they are locked in that useless GIT anyway. )


Regards,
Lace
