Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbULXBTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbULXBTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULXBTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 20:19:18 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:11735 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261357AbULXBTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 20:19:12 -0500
Date: Fri, 24 Dec 2004 02:18:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041224011833.GE2143@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041210163247.GM2714@holomorphy.com> <1102697553.3306.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102697553.3306.91.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 05:52:33PM +0100, Thomas Gleixner wrote:
> +			if ((p->flags & PF_MEMDIE) ||
> +			    ((p->flags & PF_EXITING) && !(p->flags & PF_DEAD)))

this had to be:

			if (((p->flags & PF_MEMDIE) || (p->flags & PF_EXITING)) &&
			    !(p->flags & PF_DEAD))

I didn't take zombies into account. A task may be in memdie state and zombie at
the same time. We must not wait a PF_MEMDIE to go away completely, we must wait
only until PF_DEAD is not set. After PF_DEAD is set we know all ram we
were waiting for is already in the free list.

I noticed some deadlocks during an oom-torture-test before applying the stuff
into the suse kernel. The above change fixed all my deadlocks. Everything else
was working fine already.

Actually before finding the above bug I fixed PF_MEMDIE too and I converted it
to p->memdie, an unsigned char. All archs should support 1 byte granularity
for per-process atomic instructions, it's near used_math that I also converted
to a char to signal it cannot be a bitflag sharing the same char with globals.

Struct layout looks like this.

	/*
	 * All archs should support atomic ops with
	 * 1 byte granularity.
	 */
	unsigned char memdie;
	/*
	 * Must be changed atomically so it shouldn't be
	 * be a shareable bitflag.
	 */
	unsigned char used_math;
	/*
	 * OOM kill score adjustment (bit shift).
	 * Cannot live together with used_math since
	 * used_math and oomkilladj can be changed at the
	 * same time, so they would race if they're in the
	 * same atomic block.
	 */
	short oomkilladj;

As for the |= PF_MEMALLOC in oom_kill_task that was a gratuitous smp breakage,
I didn't need to do anything in PF_MEMALLOC since alloc_pages checks _both_
PF_MEMALLOC and p->memdie already.

I also added a !chosen in the below code to make that logic more self
contained and less dependent on the badness implementation (should never
be necessary though):

			if (points > maxpoints || !chosen) {
				chosen = p;
				maxpoints = points;
			}

I can port the final patch (including fixage of PF_MEMDIE races) to 2.6.10-rc
after I finished.
