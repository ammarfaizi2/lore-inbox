Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbSIRQdt>; Wed, 18 Sep 2002 12:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbSIRQdt>; Wed, 18 Sep 2002 12:33:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50662 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267361AbSIRQdp>;
	Wed, 18 Sep 2002 12:33:45 -0400
Date: Wed, 18 Sep 2002 18:46:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180915350.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209181843240.23619-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> Yeah. It increases memory pressure for the _complex_ and _slow_
> algorithms. Agreed.

what complex and slow algorithms? Take a look at the alloc_pid() and 
free_pid() fastpaths:

void free_pid(unsigned long pid)
{
        pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
        int offset = pid & BITS_PER_PAGE_MASK;

        atomic_inc(&map->nr_free);
        test_and_clear_bit(offset, map->page));
}

it's all bitshifts.

int alloc_pid(void)
{
        pid = last_pid + 1;
        if (pid >= pid_max)
                pid = RESERVED_PIDS;

        offset = pid & BITS_PER_PAGE_MASK;
        map = pidmap_array + pid / BITS_PER_PAGE;

        if (likely(map->page && !test_and_set_bit(offset, map->page))) {
		atomic_dec(&map->nr_free);
                last_pid = pid;
                return pid;
	[...]
}

> See my two-liner suggestion (which is admittedly not even compiled, so
> the one disadvantage it might have is that it might need to be debugged.
> But it's only two lines and doesn't actually change any fundamental part
> of any existing algorithms, so debugging shouldn't be a big problem.

it solves the PID-space-squeeze problem, but it does not solve the
fundamental problem: possibly thousands of consecutive PIDs allocated.

	Ingo

