Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTIKSzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTIKSzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:55:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57233 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261460AbTIKSzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:55:01 -0400
Date: Thu, 11 Sep 2003 19:55:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911185500.GN29532@mail.jlokier.co.uk>
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk> <20030911123535.GB28180@mail.jlokier.co.uk> <20030911160929.A19449@flint.arm.linux.org.uk> <20030911162510.GA29532@mail.jlokier.co.uk> <20030911175224.A20308@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911175224.A20308@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On 1st September, I wrote:
> | This looks like an old kernel on your NetWinder.  Later 2.4 kernels
> | should get this right (by marking the pages uncacheable in user space.)
> 
> So this says that there _are_ old kernels which didn't do any fixup
> _and_ I pointed out that you were receiving reports from such kernels.

I hadn't forgotten what you wrote.  What you wrote says I _might_ be
receiving reports from such kernels.  Until we get feedback, neither
of us knows for sure.

> Now, lets rewind back to the original mail.  You said:
> 
> |>    CPUs with incoherent write buffers: PA-RISC 2.0, 68040 and ARMs.
> 
> I still claim this is an inaccurate summary, and is misleading - this
> says "All ARMs have incoherent write buffers" which is many times removed
> from reality.

I agree with you, it's unhelpfully worded and I will change it.

(Though I don't think that it means what you think it does, which just goes
to show how badly worded it is).

> Continuing:
> 
> |>    SHMLBA not valid:           ARM, m68k
> |> On the ARM this is
> |> believed to be due to a chip bug, and very recent kernels may contain
> |> a workaround for it (disabling the write buffer for aliased pages).
> 
> I still claim this description is wrong.

I agree with you, the description is quite misleading.

> You are claiming that all ARMs
> contain this bug and the kernel needs to work around it for all ARMs.
> This is clearly not the case. 

I'm not claiming that at all, and never have, but I will change
the wording to be clear.  Tell me if this works for you:

	An application writer might ask if the value of SHMLBA means
	"virtual alias mappings separated by a multiple of
	SHMLBA will be coherent with each other".

	Let's examine whether that's a reliable assumption.

	To avoid any misunderstanding, because people do misunderstand
	this, let me be clear: this question has _nothing_ to do with
	whether the CPU implements coherence in hardware.

	It is possible to implement virtual alias coherence _entirely_
	in software, on any CPU with an MMU.  Conversely, it's
	possible for software to make virtual aliases non-coherent,
	even if the CPU architecture is itself coherent.  (Some
	distributed cluster kernels might do that).

	To put it starkly: virtual alias coherence is a function of
	the kernel, not the CPU.

	Returning to the question of whether SHMLBA does actually mean
	that an application will see virtual alias coherence at that
	separation.  That can depend on the kernel version, on which
	libc the application is compiled with (because they don't all
	define a good SHMLBA value), and on exactly which revision of
	the CPU is being used.  We observe these Linux platforms:

		x86:		SHMLBA ok, all separations coherent
		IA64:		SHMLBA ok, all separations coherent
		x86_64:		SHMLBA ok, all separations coherent
		PPC:		SHMLBA ok, all separations coherent
		Alpha:		SHMLBA ok, all separations coherent
		VAX:		SHMLBA ok, all separations coherent
		S390:		SHMLBA ok, all separations coherent
		Sparc:		SHMLBA ok, with suitable definition
		PA-RISC:	SHMLBA ok, if using kernel headers
		MIPS:		SHMLBA ok, if using kernel headers
		SH:		SHMLBA ok, if using kernel headers
		m68k:		SHMLBA not ok if it's a 68030 or 68040
				else SHMLBA seems ok if it's a 68020 or 68060
		ARM:		SHMLBA ok, if running kernel >= 2.6.0
				else SHMLBA not ok, if running kernel < 2.4.0
				else SHMLBA may be ok depending on chip rev

	Note that the kernel headers tend to define good values of
	SHMLBA for each architecture where it needs to be different
	from the page size.  The table above assumes the values from
	kernel headers are being used.

	Applications are compiled with libc headers, not kernel headers.
	It is not clear that Glibc defines good values of SHMLBA for the
	Sparc, MIPS or SH architectures.  Other libcs may be different
	again.  I haven't investigated this.

	Moral (pessimistic): Unfortunately, on Linux, SHMLBA is not a fully
	reliable guarantee that an application can depend on virtual alias
	coherence.  It depends on the architecture, and on some
	architectures it depends on libc, exact CPU subtype, and/or the
	kernel version.

	Moral (optimistic): Starting with Linux 2.6.0, all architectures
	offer virtual alias coherence for _some_ value of SHMLBA, except
	some subtypes of m68k.  The m68k port could be fixed with
	appropriate kernel code, but that is not implemented at this time.

Russell, feel free to correct the kernel version numbers, or anything
else in the above text.

> In addition, the fact that a previously undiscovered bug exists does
> not determine whether SHMLBA is valid or not.

No, but whether you are running a kernel with the workaround _does_
determine whether SHMLBA is valid or not.

Remember: SHMLBA is not a description of the CPU, it is a description
of the guarantees made by the kernel to userspace.

> The fact that SHMLBA _must_ be defined (it is not optional) _and_
> there exists _no_ value for SHMLBA on the buggy _StrongARM_s does
> not mean it is invalid as you are claiming.

Here I will respectfully disagree.  SHMLBA does not represent any
property of the CPU.  It has everthing to do with whatever illusions
the kernel presents to userspace.

With your fix, _all_ values of SHMLBA are valid on the buggy StrongARMs.

On a similar note, I don't see a problem that SHMLBA must be defined, as
it's always possible for the kernel to make it work.  On the ARM you've
done it through cacheability attributes.  It can be made to work on the
m68k through changes to page fault handling, if cacheability attributes
aren't available on the m68k.

> > ...until we learn what kernel versions the Netwinder folks are
> > running, or they kindly run the test on a new kernel.
> 
> Absolutely - so what _you_ need to do now is to go off to each person
> who responded (only _you_ have those details and therefore only _you_
> can do this) and _ask_ them the question.

That's what I'll do.

Please tell me if the indented earlier text is clear enough for you.

-- Jamie
