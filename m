Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSHGXEp>; Wed, 7 Aug 2002 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSHGXEp>; Wed, 7 Aug 2002 19:04:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314080AbSHGXEn>;
	Wed, 7 Aug 2002 19:04:43 -0400
Message-ID: <3D51A7DD.A4F7C5E4@zip.com.au>
Date: Wed, 07 Aug 2002 16:06:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, davej@suse.de, frankeh@us.ibm.com,
       andrea@suse.de
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
References: <1028757835.22405.300.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> This patch provides an improved version of get_pid() while also taking
> care of the bug that causes the machine to hang when you hit PID_MAX.

Has this been evaluated against Bill Irwin's constant-time
allocator?  Bill says it has slightly worse normal-case and
vastly improved worst-case performance over the stock allocator.
Not sure how it stacks up against this one.   Plus it's much nicer
looking code.

He's shy, so.....



#include <linux/compiler.h>
#include <linux/bitops.h>
#include <linux/spinlock.h>
#include <linux/init.h>

/*
 * pid allocator
 * (C) 2002 William Irwin, IBM
 *
 * The strategy is to maintain a tower of bitmaps where a bitmap above
 * another in each bit accounts whether any pid's are available in the
 * space tracked by BITS_PER_LONG bits of the level below. The bitmaps
 * must be marked on allocation and also release, hence some
 * infrastructure for detecting when the last user of a pid releases it
 * must be in place.
 *
 * This general strategy is simple in concept and enforces highly
 * deterministic bounds on the search time for the next pid.
 */

#define PID_MAX		0x8000
#define RESERVED_PIDS	300

#define MAP0_SIZE	(PID_MAX   >> BITS_PER_LONG_SHIFT)
#define MAP1_SIZE	(MAP0_SIZE >> BITS_PER_LONG_SHIFT)
#define MAP2_SIZE	(MAP1_SIZE >> BITS_PER_LONG_SHIFT)

#define MAP0_SHIFT	BITS_PER_LONG_SHIFT
#define MAP1_SHIFT	(2*BITS_PER_LONG_SHIFT)
#define MAP2_SHIFT	(3*BITS_PER_LONG_SHIFT)

#define PID_MAP_MASK	(BITS_PER_LONG - 1)

#define PID_MAP_DEPTH	(ARRAY_SIZE(pid_map) - 1)

static unsigned long pid_map0[MAP0_SIZE];
static unsigned long pid_map1[MAP1_SIZE];
static unsigned long pid_map2[MAP2_SIZE];

static unsigned long * pid_map[] = { pid_map0, pid_map1, pid_map2, NULL, };

unsigned long last_pid = 0;
unsigned long npids = 0;

static const int map_shifts[] =
	{	0,
		BITS_PER_LONG_SHIFT,
		BITS_PER_LONG_SHIFT*2,
		BITS_PER_LONG_SHIFT*3,
		BITS_PER_LONG_SHIFT*4,
	};

static inline int pid_map_shift(int depth)
{
	return map_shifts[depth+1];
}

static spinlock_t pid_lock = SPIN_LOCK_UNLOCKED;

void free_pid(unsigned long pid)
{
	unsigned long **map = pid_map;

	spin_lock(&pid_lock);
	while (*map) {
		int bit = pid & PID_MAP_MASK;
		pid >>= BITS_PER_LONG_SHIFT;
		__clear_bit(bit, &(*map)[pid]);
		++map;
	}
	--npids;
	spin_unlock(&pid_lock);
}

static inline int whole_block_used(int level, unsigned long pid)
{
	return pid_map[level][pid >> pid_map_shift(level)] == ~0UL;
}

static inline void mark_pid(unsigned long pid)
{
	int level;
	for (level = 0; level < PID_MAP_DEPTH; ++level) {
		int shift, bit;
		unsigned long entry;

		shift = pid_map_shift(level);
		entry = pid >> shift;
		bit   = (pid >> (shift - BITS_PER_LONG_SHIFT)) & PID_MAP_MASK;
		if (level == 0 || whole_block_used(level - 1, pid))
			__set_bit(bit, &pid_map[level][entry]);
		else
			break;
	}
	++npids;
}

static inline int pid_map_limit(int depth)
{
	return PID_MAX >> pid_map_shift(depth);
}

#ifdef PID_ALLOC_EXAMPLE
/*
 * the pid allocation traverses the bitmaps by recursively ffz'ing
 * through down the tower of maps. Some additional logic is required
 * to enforce lower limits, but the following example of how one
 * would perform this search without the lower limit may well prove
 * enlightening for those interested in the mechanics of the algorithm.
 */
static long alloc_pid_from_zero(void)
{
	unsigned long pid = 0;
	int level;

	for (level = PID_MAP_DEPTH - 1; level >= 0; --level) {
		unsigned long entry = pid_map[level][pid];

		if (unlikely(entry == ~0UL))
			return ~0UL;

		pid = (pid << BITS_PER_LONG_SHIFT) + ffz(pid_map[level][pid]);
	}
	return pid;
}
#endif /* PID_ALLOC_EXAMPLE */


static const unsigned long pid_max_levels[] =
	{	PID_MAX >> BITS_PER_LONG_SHIFT,
		PID_MAX >> (BITS_PER_LONG_SHIFT*2),
		PID_MAX >> (BITS_PER_LONG_SHIFT*3),
		PID_MAX >> (BITS_PER_LONG_SHIFT*4),
	};

static inline unsigned long pid_map_digit(int level, unsigned long limit)
{
	return (limit >> pid_map_shift(level-1)) & PID_MAP_MASK;
}

/*
 * Scratch space for storing the digits of the limit, all accesses
 * protected by the pid_lock.
 */
static unsigned long limit_digits[4];

/*
 * This is not a high-performance implementation. alloc_pid_after()
 * can be made highly compact with some effort, but this is instead
 * meant to be clear. As the cost of fork() is dominated by much
 * more expensive operations and the cost of this is constant-bounded
 * by a very low constant, the gains from manual optimization here
 * are marginal.
 */
static long alloc_pid_after(unsigned long limit)
{
	unsigned long pid = 0;
	int level;

	/*
	 * The limit passed to us is a strict lower limit. It is more
	 * convenient to work with <= constraints.
	 */
	++limit;
	if (unlikely(limit == PID_MAX))
		return ~0UL;

	for (level = 0; level < PID_MAP_DEPTH; ++level) {
		limit_digits[level] = limit & PID_MAP_MASK;
		limit >>= BITS_PER_LONG_SHIFT;
	}

	/*
	 * Now the lowest available pid number above limit is
	 * reconstructed by ffz'ing down the bitmap and checking
	 * each digit against the digits of the limit for
	 * dictionary ordering. If the check should fail, it's
	 * fixed up by using the maximum of the two digits. The
	 * dictionary ordering on digits also means that a
	 * greater significant digit found in the bitmap
	 * invalidates all further comparisons, which requires
	 * fallback to the pure recursive ffz algorithm outlined
	 * above in order to be handled.
	 */
	for (level = PID_MAP_DEPTH - 1; level >= 0; --level) {
		unsigned long bit, digit;

		if (unlikely(pid >= pid_max_levels[level]))
			return ~0UL;

		bit = ffz(pid_map[level][pid]);
		digit = limit_digits[level];

		if (unlikely(bit < digit))
			bit = digit;

		pid = (pid << BITS_PER_LONG_SHIFT) + bit;

		/*
		 * This is not an optimization; if this check
		 * should succeed the digit comparisons above
		 * are no longer valid and (pessimistically)
		 * incorrect first available pid's are found.
		 * 
		 */
		if (likely(bit > digit)) {
			--level;
			goto finish_just_ffz;
		}
	}
out:
	if (pid < PID_MAX)
		return pid;
	else
		return ~0UL;

finish_just_ffz:
	/*
	 * Now revert to the pure recursive ffz algorithm with
	 * the slight variation of not beginning at a fixed level,
	 * because it is no longer valid to perform comparisons
	 * of the digit obtained by ffz'ing the bitmap against the
	 * digits of the limit.
	 */
	while (level >= 0) {
		unsigned long bit;

		if (unlikely(pid >= pid_max_levels[level]))
			return ~0UL;

		bit = ffz(pid_map[level][pid]);
		pid = (pid << BITS_PER_LONG_SHIFT) + bit;
		--level;
	}

	goto out;
}

int alloc_pid(void)
{
	unsigned long pid;

	spin_lock(&pid_lock);
	BUG_ON(last_pid >= PID_MAX);
	pid = alloc_pid_after(last_pid);
	if (unlikely(pid == ~0UL)) {
		pid = alloc_pid_after(RESERVED_PIDS);
		if (unlikely(pid == ~0UL))
			goto out;
		BUG_ON(pid < RESERVED_PIDS);
	} else
		BUG_ON(pid <= last_pid);
	last_pid = pid;
	mark_pid(pid);
out:
	spin_unlock(&pid_lock);
	return (int)pid;
}

void __init pid_init(void)
{
	mark_pid(0);
}
