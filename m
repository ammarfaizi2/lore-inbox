Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbUCTJgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbUCTJgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:36:51 -0500
Received: from holomorphy.com ([207.189.100.168]:45191 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263268AbUCTJgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:36:48 -0500
Date: Sat, 20 Mar 2004 01:36:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040320093614.GZ2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040319220907.1e07d36f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319220907.1e07d36f.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The stack footprint of cpumasks is a concern in general. I don't have a
>> good answer to this. The half-answer I anticipate is that the truly
>> larger systems will configure themselves with deeper stacks.

On Fri, Mar 19, 2004 at 10:09:07PM -0800, Paul Jackson wrote:
> Sounds like a good enough answer to me.
> That is, a richer API can help - more 

I know that a richer repertoire of operations will reduce the stack
footprint and mentioned it. There is one issue and one issue only: the
larger the "instruction set" grows, the more intrusive and complex-
looking the thing appears, the more of quagmire merging it becomes. The
bits about deeper stacks not really a "good enough" answer. It's an
answer that trades off code impact for overhead on the systems that
demand the mechanism. In industrial/corporate kernels, this wouldn't
fly as votes are dollars, but here votes are users, and the smaller
systems' performance concerns and broader userbase's maintenance
concerns took precedence over the technically superior solution, at
least for the initial merge.


At some point in the past, I wrote:
>> This is one of the areas where I believe I carried out some innovation.
>> cpumask_const_t allows more aggressive conversion to call-by-reference

On Fri, Mar 19, 2004 at 10:09:07PM -0800, Paul Jackson wrote:
> True, you did do some substantial work there, and for const objects,
> calls by value and reference can be used interchangeably, for best
> performance, without semantic impact.
> However, something about the current cpus_*_const() macros doesn't seem
> to be having the desired impact.  I see five uses in files matching
> include/asm-i386/mach-*/mach_apic.h, and one in include/asm-x86_64/smp.h
> That's all.  None, for example, in any ia64 code.

Yes, spreading the cpumask_const_t use is needed. I pretty much ran out
of steam before getting its use propagated around, and it was also a late
addition that the arch maintainers who sent in their own updates didn't
get a very wide window to adapt to. I think it's vaguely fair to ask
those who need it to propagate its use around themselves.


On Fri, Mar 19, 2004 at 10:09:07PM -0800, Paul Jackson wrote:
> That's it.  And why should one have to code explicitly the choice of
> the cpus_*_const() variant?  Shouldn't each macro know which of routines
> it calls change things, and which don't, letting it pass a pointer to
> the read-only routines if that helps?  It knows the sizes as well, so
> it can even pick and choose which variation of code to generate.

This explicitly forces an unnecessary indirection on smaller systems
where the thing may fit into one machine word anyway, meaning it doesn't
make sense to pass it by reference.

Or in a second possible interpretation, this may already be the current
state of affairs, and you're suggesting a different way to implement it
I don't see how to do offhand which would be equivalent but using
fewer #ifdefs. That would be completely innocuous, and in combination
with a more general set of wrappers, easy to endorse.


On Fri, Mar 19, 2004 at 10:09:07PM -0800, Paul Jackson wrote:
> If one needs an explicit call by reference to avoid passing a multi-word
> object, one should ask the user to pass an explicit pointer, to a
> routine or macro that expects a pointer to a non-const, not an apparent
> value.  Shouldn't try to hide the reference semantics behind quasi-const
> labels.

It's not quasi-const, it is const. If you need a caller to do destructive
updates on your behalf, you use a pointer in both large and small cases.
You may use explicit unwrapped const call by reference, but this forces
the overhead of indirection on smaller systems.

The advantage the type wrapper has is that when NR_CPUS is small and
things fit in one or few machine words, it can be automatically
switched back to call by value with zero source changes by just picking
a threshold in a #ifdef, avoiding the indirection for smaller systems.

Of course, if the second of the two possibilities from the previously
replied-to paragraph holds, you're keeping all the operational semantics
that small systems need anyway so it may not have been necessary to
reiterate all that.


-- wli
