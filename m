Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUC3HiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUC3HiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:38:09 -0500
Received: from holomorphy.com ([207.189.100.168]:4000 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263322AbUC3HgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:36:07 -0500
Date: Mon, 29 Mar 2004 23:36:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-ID: <20040330073604.GK791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040330065152.GJ791@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Ivd6Nf4GAZ12BQqh"
Content-Disposition: inline
In-Reply-To: <20040330065152.GJ791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ivd6Nf4GAZ12BQqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2004 at 10:51:52PM -0800, William Lee Irwin III wrote:
> Given zeroed tail preconditions these implementations satisfy zeroed
> tail postconditions, which makes them compatible with whatever changes
> from Paul Jackson one may want to merge in the future. No particular
> effort was required to ensure this.
> A small (but hopefully forgiveable) cleanup is a spelling correction:
> s/bitmap_shift_write/bitmap_shift_right/ in one of the kerneldoc comments.
> The primary effect of the patch is to remove the MAX_BITMAP_BITS
> limitation, so restoring the NR_CPUS to be limited only by stackspace
> and slab allocator maximums. They also look vaguely more efficient than
> the current code, though as this was not done for performance reasons,
> no performance testing was done.

An updated userspace test harness properly more demonstrating the
zeroed tail preconditions/postconditions properties is included as a
MIME attachment. The bitmap code requires no changes. This is merely a
more adequate testcase.


-- wli

--Ivd6Nf4GAZ12BQqh
Content-Type: text/x-csrc; charset=us-ascii
Content-Description: bitmap_test.c
Content-Disposition: attachment; filename="bitmap.c"

#include <limits.h>
#include <stdio.h>
#include <assert.h>
#include <sys/time.h>
#include <time.h>

struct ref {
	void *p;
};

#define EXPORT_SYMBOL(x)	static struct ref __ref__##x = { .p = (x) }
#define BITS_TO_LONGS(bits) \
        (((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
#define DECLARE_BITMAP(name,bits) \
        unsigned long name[BITS_TO_LONGS(bits)]
#define CLEAR_BITMAP(name,bits) \
        memset(name, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
#define TYPEBITS(t)	(CHAR_BIT*sizeof(t))
#define BITS_PER_LONG	TYPEBITS(unsigned long)

#define MAX_BITMAP_BITS	512

#define BUG_ON(p)	assert(!(p))

static inline void bitmap_clear(unsigned long *bitmap, int bits)
{
        CLEAR_BITMAP((unsigned long *)bitmap, bits);
}

static inline void bitmap_fill(unsigned long *bitmap, int bits)
{
        memset(bitmap, 0xff, BITS_TO_LONGS(bits)*sizeof(unsigned long));
}

static inline void bitmap_copy(unsigned long *dst,
                        const unsigned long *src, int bits)
{
        memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
}

static inline int set_bit(int nr, unsigned long *addr)
{
	unsigned long mask = 1UL << (nr % BITS_PER_LONG);
	int retval = !!(addr[nr/BITS_PER_LONG] & mask);
	addr[nr/BITS_PER_LONG] |= mask;
	return retval;
}

static inline int clear_bit(int nr, unsigned long *addr)
{
	unsigned long mask = 1UL << (nr % BITS_PER_LONG);
	int retval = !!(addr[nr/BITS_PER_LONG] & mask);
	addr[nr/BITS_PER_LONG] &= ~mask;
	return retval;
}

static inline int test_bit(int nr, const unsigned long *addr)
{
	return !!(addr[nr/BITS_PER_LONG] & (1UL << (nr % BITS_PER_LONG)));
}

int bitmap_empty(const unsigned long *bitmap, int bits)
{
	int k, lim = bits/BITS_PER_LONG;
	for (k = 0; k < lim; ++k)
		if (bitmap[k])
			return 0;

	if (bits % BITS_PER_LONG)
		if (bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
			return 0;

	return 1;
}
EXPORT_SYMBOL(bitmap_empty);

int bitmap_full(const unsigned long *bitmap, int bits)
{
	int k, lim = bits/BITS_PER_LONG;
	for (k = 0; k < lim; ++k)
		if (~bitmap[k])
			return 0;

	if (bits % BITS_PER_LONG)
		if (~bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1))
			return 0;

	return 1;
}
EXPORT_SYMBOL(bitmap_full);

int bitmap_equal(const unsigned long *bitmap1,
		unsigned long *bitmap2, int bits)
{
	int k, lim = bits/BITS_PER_LONG;;
	for (k = 0; k < lim; ++k)
		if (bitmap1[k] != bitmap2[k])
			return 0;

	if (bits % BITS_PER_LONG)
		if ((bitmap1[k] ^ bitmap2[k]) &
				((1UL << (bits % BITS_PER_LONG)) - 1))
			return 0;

	return 1;
}
EXPORT_SYMBOL(bitmap_equal);

void bitmap_complement(unsigned long *bitmap, int bits)
{
	int k;
	int nr = BITS_TO_LONGS(bits);

	for (k = 0; k < nr; ++k)
		bitmap[k] = ~bitmap[k];
}
EXPORT_SYMBOL(bitmap_complement);

/*
 * bitmap_shift_right - logical right shift of the bits in a bitmap
 *   @dst - destination bitmap
 *   @src - source bitmap
 *   @nbits - shift by this many bits
 *   @bits - bitmap size, in bits
 *
 * Shifting right (dividing) means moving bits in the MS -> LS bit
 * direction.  Zeros are fed into the vacated MS positions and the
 * LS bits shifted off the bottom are lost.
 */
void bitmap_shift_right(unsigned long *dst,
			const unsigned long *src, int shift, int bits)
{
	int k, lim = BITS_TO_LONGS(bits);
	int off = shift/BITS_PER_LONG, rem = shift % BITS_PER_LONG;
	unsigned long mask = (1UL << rem) - 1;
	for (k = 0; off + k < lim; ++k) {
		unsigned long upper;

		/*
		 * If shift is not word aligned, take lower rem bits of
		 * word above and make them the top rem bits of result.
		 */
		if (rem && off + k + 1 < lim)
			upper = src[off + k + 1] & mask;
		else
			upper = 0;
		dst[k] = upper << (BITS_PER_LONG - rem) | src[off + k] >> rem;
	}
	if (off)
		memset(&dst[lim - off], 0, off*sizeof(unsigned long));
}
EXPORT_SYMBOL(bitmap_shift_right);

/*
 * bitmap_shift_left - logical left shift of the bits in a bitmap
 *   @dst - destination bitmap
 *   @src - source bitmap
 *   @nbits - shift by this many bits
 *   @bits - bitmap size, in bits
 *
 * Shifting left (multiplying) means moving bits in the LS -> MS
 * direction.  Zeros are fed into the vacated LS bit positions
 * and those MS bits shifted off the top are lost.
 */
void bitmap_shift_left(unsigned long *dst,
			const unsigned long *src, int shift, int bits)
{
	int k, lim = BITS_TO_LONGS(bits);
	int off = shift/BITS_PER_LONG, rem = shift % BITS_PER_LONG;
	for (k = lim - off - 1; k >= 0; --k) {
		unsigned long lower;

		/*
		 * If shift is not word aligned, take upper rem bits of
		 * word below and make them the bottom rem bits of result.
		 */
		if (rem && k > 0)
			lower = src[k - 1] >> (BITS_PER_LONG - rem);
		else
			lower = 0;
		dst[k + off] = lower | src[k] << rem;
	}
	if (off)
		memset(dst, 0, off*sizeof(unsigned long));
}
EXPORT_SYMBOL(bitmap_shift_left);

void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
				const unsigned long *bitmap2, int bits)
{
	int k;
	int nr = BITS_TO_LONGS(bits);

	for (k = 0; k < nr; k++)
		dst[k] = bitmap1[k] & bitmap2[k];
}
EXPORT_SYMBOL(bitmap_and);

void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
				const unsigned long *bitmap2, int bits)
{
	int k;
	int nr = BITS_TO_LONGS(bits);

	for (k = 0; k < nr; k++)
		dst[k] = bitmap1[k] | bitmap2[k];
}
EXPORT_SYMBOL(bitmap_or);


/*
 * bitmap_shift_right - logical right shift of the bits in a bitmap
 *   @dst - destination bitmap
 *   @src - source bitmap
 *   @nbits - shift by this many bits
 *   @bits - bitmap size, in bits
 *
 * Shifting right (dividing) means moving bits in the MS -> LS bit
 * direction.  Zeros are fed into the vacated MS positions and the
 * LS bits shifted off the bottom are lost.
 */
void old_bitmap_shift_right(unsigned long *dst,
			const unsigned long *src, int shift, int bits)
{
	int k;
	DECLARE_BITMAP(__shr_tmp, MAX_BITMAP_BITS);

	BUG_ON(bits > MAX_BITMAP_BITS);
	bitmap_clear(__shr_tmp, bits);
	for (k = 0; k < bits - shift; ++k)
		if (test_bit(k + shift, src))
			set_bit(k, __shr_tmp);
	bitmap_copy(dst, __shr_tmp, bits);
}
EXPORT_SYMBOL(old_bitmap_shift_right);

/*
 * bitmap_shift_left - logical left shift of the bits in a bitmap
 *   @dst - destination bitmap
 *   @src - source bitmap
 *   @nbits - shift by this many bits
 *   @bits - bitmap size, in bits
 *
 * Shifting left (multiplying) means moving bits in the LS -> MS
 * direction.  Zeros are fed into the vacated LS bit positions
 * and those MS bits shifted off the top are lost.
 */
void old_bitmap_shift_left(unsigned long *dst,
			const unsigned long *src, int shift, int bits)
{
	int k;
	DECLARE_BITMAP(__shl_tmp, MAX_BITMAP_BITS);

	BUG_ON(bits > MAX_BITMAP_BITS);
	bitmap_clear(__shl_tmp, bits);
	for (k = bits; k >= shift; --k)
		if (test_bit(k - shift, src))
			set_bit(k, __shl_tmp);
	bitmap_copy(dst, __shl_tmp, bits);
}
EXPORT_SYMBOL(old_bitmap_shift_left);

#define ALIGN(x,y)	(((x) + (y) - 1) & ~((y) - 1))
#define BITALIGN(x)	ALIGN(x, 1)

int main(void)
{
	int n;
	struct timeval tv;
	unsigned short seed[3];
	unsigned long bitmap1[BITS_TO_LONGS(MAX_BITMAP_BITS)],
			bitmap2[BITS_TO_LONGS(MAX_BITMAP_BITS)],
			bitmap3[BITS_TO_LONGS(MAX_BITMAP_BITS)];

	gettimeofday(&tv, NULL);
	seed[0] = (unsigned short)tv.tv_usec;
	seed[1] = (unsigned short)getpid();
	seed[2] = (unsigned short)0;

	while (1) {
		int k, shift, bits = 1;
		++n;
		memset(bitmap1, 0, sizeof(bitmap1));
		memset(bitmap2, 0, sizeof(bitmap2));
		memset(bitmap3, 0, sizeof(bitmap3));
		while (bits <= 1)
			bits = (unsigned long)nrand48(seed) % (MAX_BITMAP_BITS+1);
		bits = BITALIGN(bits);
		for (k = 0; k < BITS_TO_LONGS(bits); ++k) {
			bitmap1[k] = (unsigned long)nrand48(seed);
			if (k == BITS_TO_LONGS(bits) - 1 && bits % BITS_PER_LONG)
				bitmap1[k] &= (1UL << (bits % BITS_PER_LONG)) - 1;
		}
		shift = (unsigned long)nrand48(seed) % bits;
		shift = BITALIGN(shift);
		memcpy(bitmap2, bitmap1, sizeof(bitmap1));
		memcpy(bitmap3, bitmap1, sizeof(bitmap1));
		if (n & 1) {
			old_bitmap_shift_left(bitmap1, bitmap1, shift, bits);
			bitmap_shift_left(bitmap2, bitmap2, shift, bits);
		} else {
			old_bitmap_shift_right(bitmap1, bitmap1, shift, bits);
			bitmap_shift_right(bitmap2, bitmap2, shift, bits);
		}
		if (memcmp(bitmap1, bitmap2, sizeof(bitmap1))) {
			int mismatches = 0;
			for (k = 0; k < BITS_TO_LONGS(bits); ++k) {
				int match;
				unsigned long mask;
				mask = (1UL << (bits % BITS_PER_LONG)) - 1;
				if (k < bits/BITS_PER_LONG)
					match = !!(bitmap1[k] == bitmap2[k]);
				else {
					match = !((bitmap1[k] ^ bitmap2[k]) & mask);
				}
				if (!match)
					mismatches++;
			}
			if (!mismatches)
				continue;

			printf("problem %s/%d/%d!!!\n", (n&1) ? "left" : "right", shift, bits);
			for (k = 0; k < BITS_TO_LONGS(bits); ++k) {
				int match;
				unsigned long mask;
				mask = (1UL << (bits % BITS_PER_LONG)) - 1;
				if (k < bits/BITS_PER_LONG)
					match = !!(bitmap1[k] == bitmap2[k]);
				else {
					match = !((bitmap1[k] ^ bitmap2[k]) & mask);
				}
				printf("orig/old/new %c = 0x%0*lx/0x%0*lx/0x%0*lx\n",
					match ? ' ' : '*',
					2*sizeof(bitmap3[k]), bitmap3[k],
					2*sizeof(bitmap1[k]), bitmap1[k],
					2*sizeof(bitmap2[k]), bitmap2[k]);
			}
			exit(1);
		}
	}
	return 0;
}

--Ivd6Nf4GAZ12BQqh--
