Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315537AbSEMDYM>; Sun, 12 May 2002 23:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSEMDYL>; Sun, 12 May 2002 23:24:11 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:55048 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315529AbSEMDYB>; Sun, 12 May 2002 23:24:01 -0400
Date: Mon, 13 May 2002 13:26:05 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, engebret@vnet.ibm.com, justincarlson@cmu.edu,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        anton@samba.org, ak@suse.de, paulus@samba.org
Subject: Re: Memory Barrier Definitions
Message-Id: <20020513132605.06b44d85.rusty@rustcorp.com.au>
In-Reply-To: <15578.36627.478751.622066@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002 08:00:35 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:
> The latter: loads can have "acquire" semantics and stores can have
> "release" semantics.  For example, at the assembly level, ld8.acq
> would be an 8-byte load with acquire semantics, st8.rel an 8-byte
> store with release semantics.  At the C level, acquire/release
> semantics is used for all accesses to "volatile" variables.

OK.  So ignoring the fact that you somehow have to attach your barriers
to a load or store for the moment, we have before vs. after (ia64),
read vs. write (most archs), io vs mem (ppc, ppc64), data dependency
vs non-data dependency (alpha), and smp vs up.

{read|write|readwrite} \
	_{before|after|bidir} \
		_{io|mem|iomem} \
			_{dd|nondd} \
				_{smp|nonsmp}

Now, I think the non-data-depends case is so common that it doesn't
belong in the name at all, but as a separate macro:

#ifndef __alpha__
	#define data_depends(barrier) (barrier)
#else
	#define data_depends(barrier) (ddep_##barrier)
#endif

Also, assuming that no data dependency on normal memory where it doesn't
matter on UP is the default, we can elide those.  Also, any barrier mentioning
IO can be assumed to be in force even if UP, so those combinations are invalid.
Note that UP with CONFIG_PREEMPT counts as SMP here:

	/* Complete all reads from normal memory before any normal
	   memory reads ;which follow this instruction, on SMP or PREEMPT */
	read_before();

	/* Do not begin any reads from normal memory which follow,
	   before any normal reads which preceed this instruction are
	   complete, on SMP or PREEMPT */
	read_after();

	/* read_before(); read_after(); */
	read_bidir();

	/* Complete all reads from IO before any IO reads which follow
	   this instruction. */
	read_before_io();

	/* Complete all reads (IO or memory) before any reads which follow
	   this instruction. */
	read_before_iomem();

	/* Do not begin any IO reads which follow, before any IO reads
	   which preceed this instruction are complete. */
	read_after_io();

	/* Do not begin any reads (IO or memory) which follow, before any
	   reads which preceed this instruction are complete. */
	read_after_iomem();

	/* read_before_io(); read_after_io(); */
	read_bidir_io();

	/* read_before_iomem(); read_after_iomem(); */
	read_bidir_iomem();

	/* read_before(), even if we are non-PREEMPT, non-SMP. */
	read_before_nonsmp();

	/* read_after(), even if we are non-PREEMPT, non-SMP. */
	read_after_nonsmp();

	/* read_before_nonsmp(); read_after_nonsmp(); */
	read_bidir_nonsmp();

Complete for write_* and readwrite_*.

Suggested semantics spin_lock():
	readwrite_after();
	readwrite_after_io();
ie. no interlock between io and memory: if you're doing both (eg acenic)
you need to put in your own iomem barrier (this is for the PPC folk).

Questions:
1) Can we elide any others?  In particular, can we remove ths _bidir_
   ones?
2) Should we prepend a "barr_" prefix?
3) Any variations I missed?

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
