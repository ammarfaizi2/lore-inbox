Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRJNDTy>; Sat, 13 Oct 2001 23:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273888AbRJNDTq>; Sat, 13 Oct 2001 23:19:46 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:26658 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S273881AbRJNDTc>; Sat, 13 Oct 2001 23:19:32 -0400
Message-ID: <71714C04806CD51193520090272892178BD710@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: kaih@khms.westfalen.de, linux-kernel@vger.kernel.org
Subject: RE: crc32 cleanups
Date: Sat, 13 Oct 2001 22:19:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think this does what was intended. Should that perhaps be
> 
> > 		for (i = 0; i < 1; i++)
> 

Good catch.  linux@horizon.com sent me a cleaned up version.

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!

That'll teach me to clean up code by hand and not test it afterwards.
That's supposed to be "i < 8" in that for() loop, but there are a couple
of other glitches, too.  In particular, I got bits of the
table-initialization
code transposed when I generalized it for less than 8 bits.

Here's a *tested* version, with test harness (if compiled with -DUNITTEST).

#include <stddef.h>	/* For size_t */
typedef unsigned _u32;

#if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
#define attribute(x) __attribute__(x)
#else
#define attribute(x)
#endif

/*
 * This code is in the public domain; copyright abandoned.
 * Liability for non-performance of this code is limited to the amount
 * you paid for it.  Since it is distributed for free, your refund will
 * be very very small.  If it breaks, you get to keep both pieces.
 */

/*
 * There are multiple 16-bit CRC polynomials in common use, but this is
 * *the* standard CRC-32 polynomial, first popularized by Ethernet.
 * x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x^1+x^0
 */
#define CRCPOLY_LE 0xedb88320
#define CRCPOLY_BE 0x04c11db7

/* How many bits at a time to use.  Requires a table of 4<<CRC_xx_BITS
bytes. */
#define CRC_LE_BITS 8
#define CRC_BE_BITS 4	/* Less performance-sensitive */

/*
 * Little-endian CRC computation.  Used with serial bit streams sent
 * lsbit-first.  Be sure to use cpu_to_le32() to append the computed CRC.
 */
#if CRC_LE_BITS > 8 || CRC_LE_BITS < 1 || CRC_LE_BITS & CRC_LE_BITS-1
# error CRC_LE_BITS must be a power of 2 between 1 and 8
#endif

#if CRC_LE_BITS == 1
/*
 * In fact, the table-based code will work in this case, but it can be
 * simplified by inlining the table in ?: form.
 */
void
crc32init_le(void)
{/* no-op */;}

_u32 attribute((pure))
crc32_le(_u32 crc, unsigned char const *p, size_t len)
{
	int i;
	while (len--) {
		crc ^= *p++;
		for (i = 0; i < 8; i++)
			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
	}
	return crc;
}
#else	/* Table-based approach */

_u32 crc32table_le[1<<CRC_LE_BITS];

/*
 * crc is the crc of the byte i; other entries are filled in based on the
 * fact that crctable[i^j] = crctable[i] ^ crctable[j].
 *
 * Note that the _init functions never write anything but the final correct
 * value to each table entry, so they're safe to call repeatedly, even if
 * someone else is currently using the table.
 */
void
crc32init_le(void)
{
	unsigned i, j;
	_u32 crc = 1;

	crc32table_le[0] = 0;

	for (i = 1<<(CRC_LE_BITS-1); i; i >>= 1) {
		crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
		for (j = 0; j < 1<<CRC_LE_BITS; j += 2*i)
			crc32table_le[i+j] = crc ^ crc32table_le[j];
	}
}

_u32 attribute((pure))
crc32_le(_u32 crc, unsigned char const *p, size_t len)
{
	while (len--) {
# if CRC_LE_BITS == 8
		crc = (crc >> 8) ^ crc32table_le[(crc ^ *p++) & 255];
# elif CRC_LE_BITS == 4
		crc ^= *p++;
		crc = (crc >> 4) ^ crc32table_le[crc & 15];
		crc = (crc >> 4) ^ crc32table_le[crc & 15];
# elif CRC_LE_BITS == 2
		crc ^= *p++;
		crc = (crc >> 2) ^ crc32table_le[crc & 3];
		crc = (crc >> 2) ^ crc32table_le[crc & 3];
		crc = (crc >> 2) ^ crc32table_le[crc & 3];
		crc = (crc >> 2) ^ crc32table_le[crc & 3];
# endif
	}
	return crc;
}
#endif

/*
 * Big-endian CRC computation.  Used with serial bit streams sent
 * msbit-first.  Be sure to use cpu_to_be32() to append the computed CRC.
 */
#if CRC_BE_BITS > 8 || CRC_BE_BITS < 1 || CRC_BE_BITS & CRC_BE_BITS-1
# error CRC_BE_BITS must be a power of 2 between 1 and 8
#endif

#if CRC_BE_BITS == 1
/*
 * In fact, the table-based code will work in this case, but it can be
 * simplified by inlining the table in ?: form.
 */
void
crc32init_be(void)
{/*no-op*/;}

_u32 attribute((pure))
crc32_be(_u32 crc, unsigned char const *p, size_t len)
{
	int i;
	while (len--) {
		crc ^= *p++ << 24;
		for (i = 0; i < 8; i++)
			crc = (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE
: 0);
	}
	return crc;
}

#else	/* Table-based approach */
_u32 crc32table_be[256];

void
crc32init_be(void)
{
	unsigned i, j;
	_u32 crc = 0x80000000;

	crc32table_be[0] = 0;

	for (i = 1 ; i < 1<<CRC_BE_BITS; i <<= 1) {
		crc = (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE : 0);
		for (j = 0; j < i; j++)
			crc32table_be[i+j] = crc ^ crc32table_be[j];
	}
}

_u32 attribute((pure))
crc32_be(_u32 crc, unsigned char const *p, size_t len)
{
	while (len--) {
# if CRC_BE_BITS == 8
		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
# elif CRC_BE_BITS == 4
		crc ^= *p++ << 24;
		crc = (crc << 4) ^ crc32table_be[crc >> 28];
		crc = (crc << 4) ^ crc32table_be[crc >> 28];
# elif CRC_BE_BITS == 2
		crc ^= *p++ << 24;
		crc = (crc << 2) ^ crc32table_be[crc >> 30];
		crc = (crc << 2) ^ crc32table_be[crc >> 30];
		crc = (crc << 2) ^ crc32table_be[crc >> 30];
		crc = (crc << 2) ^ crc32table_be[crc >> 30];
# endif
	}
	return crc;
}
#endif

/*
 * A brief CRC tutorial.
 *
 * A CRC is a long-division remainder.  You add the CRC to the message,
 * and the whole thing (message+CRC) is a multiple of the given
 * CRC polynomial.  To check the CRC, you can either check that the
 * CRC matches the recomputed value, *or* you can check that the
 * remainder computed on the message+CRC is 0.  This latter approach
 * is used by a lot of hardware implementations, and is why so many
 * protocols put the end-of-frame flag after the CRC.
 *
 * It's actually the same long division you learned in school, except that
 * - We're working in binary, so the digits are only 0 and 1, and
 * - When dividing polynomials, there are no carries.  Rather than add and
 *   subtract, we just xor.  Thus, we tend to get a bit sloppy about
 *   the difference between adding and subtracting.
 *
 * A 32-bit CRC polynomial is actually 33 bits long.  But since it's
 * 33 bits long, bit 32 is always going to be set, so usually the CRC
 * is written in hex with the most significant bit omitted.  (If you're
 * familiar with the IEEE 754 floating-point format, it's the same idea.)
 *
 * Note that a CRC is computed over a string of *bits*, so you have
 * to decide on the endianness of the bits within each byte.  To get
 * the best error-detecting properties, this should correspond to the
 * order they're actually sent.  For example, standard RS-232 serial is
 * little-endian; the most significant bit (sometimes used for parity)
 * is sent last.  And when appending a CRC word to a message, you should
 * do it in the right order, matching the endianness.
 *
 * Just like with ordinary division, the remainder is always smaller than
 * the divisor (the CRC polynomial) you're dividing by.  Each step of the
 * division, you take one more digit (bit) of the dividend and append it
 * to the current remainder.  Then you figure out the appropriate multiple
 * of the divisor to subtract to being the remainder back into range.
 * In binary, it's easy - it has to be either 0 or 1, and to make the
 * XOR cancel, it's just a copy of bit 32 of the remainder.
 *
 * When computing a CRC, we don't care about the quotient, so we can
 * throw the quotient bit away, but subtract the appropriate multiple of
 * the polynomial from the remainder and we're back to where we started,
 * ready to process the next bit.
 *
 * A big-endian CRC written this way would be coded like:
 * for (i = 0; i < input_bits; i++) {
 * 	multiple = remainder & 0x80000000 ? CRCPOLY : 0;
 * 	remainder = (remainder << 1 | next_input_bit()) ^ multiple;
 * }
 * Notice how, to get at bit 32 of the shifted remainder, we look
 * at bit 31 of the remainder *before* shifting it.
 *
 * But also notice how the next_input_bit() bits we're shifting into
 * the remainder don't actually affect any decision-making until
 * 32 bits later.  Thus, the first 32 cycles of this are pretty boring.
 * Also, to add the CRC to a message, we need a 32-bit-long hole for it at
 * the end, so we have to add 32 extra cycles shifting in zeros at the
 * end of every message,
 *
 * So the standard trick is to rearrage merging in the next_input_bit()
 * until the moment it's needed.  Then the first 32 cycles can be
precomputed,
 * and merging in the final 32 zero bits to make room for the CRC can be
 * skipped entirely.
 * This changes the code to:
 * for (i = 0; i < input_bits; i++) {
 *      remainder ^= next_input_bit() << 31;
 * 	multiple = (remainder & 0x80000000) ? CRCPOLY : 0;
 * 	remainder = (remainder << 1) ^ multiple;
 * }
 * With this optimization, the little-endian code is simpler:
 * for (i = 0; i < input_bits; i++) {
 *      remainder ^= next_input_bit();
 * 	multiple = (remainder & 1) ? CRCPOLY : 0;
 * 	remainder = (remainder >> 1) ^ multiple;
 * }
 *
 * Note that the other details of endianness have been hidden in CRCPOLY
 * (which must be bit-reversed) and next_input_bit().
 *
 * However, as long as next_input_bit is returning the bits in a sensible
 * order, we can actually do the merging 8 or more bits at a time rather
 * than one bit at a time:
 * for (i = 0; i < input_bytes; i++) {
 * 	remainder ^= next_input_byte() << 24;
 * 	for (j = 0; j < 8; j++) {
 * 		multiple = (remainder & 0x80000000) ? CRCPOLY : 0;
 * 		remainder = (remainder << 1) ^ multiple;
 * 	}
 * }
 * Or in little-endian:
 * for (i = 0; i < input_bytes; i++) {
 * 	remainder ^= next_input_byte();
 * 	for (j = 0; j < 8; j++) {
 * 		multiple = (remainder & 1) ? CRCPOLY : 0;
 * 		remainder = (remainder << 1) ^ multiple;
 * 	}
 * }
 * If the input is a multiple of 32 bits, you can even XOR in a 32-bit
 * word at a time and increase the inner loop count to 32.
 *
 * You can also mix and match the two loop styles, for example doing the
 * bulk of a message byte-at-a-time and adding bit-at-a-time processing
 * for any fractional bytes at the end.
 *
 * The only remaining optimization is to the byte-at-a-time table method.
 * Here, rather than just shifting one bit of the remainder to decide
 * in the correct multiple to subtract, we can shift a byte at a time.
 * This produces a 40-bit (rather than a 33-bit) intermediate remainder,
 * but again the multiple of the polynomial to subtract depends only on
 * the high bits, the high 8 bits in this case.  
 *
 * The multile we need in that case is the low 32 bits of a 40-bit
 * value whose high 8 bits are given, and which is a multiple of the
 * generator polynomial.  This is simply the CRC-32 of the given
 * one-byte message.
 *
 * Two more details: normally, appending zero bits to a message which
 * is already a multiple of a polynomial produces a larger multiple of that
 * polynomial.  To enable a CRC to detect this condition, it's common to
 * invert the CRC before appending it.  This makes the remainder of the
 * message+crc come out not as zero, but some fixed non-zero value.
 *
 * The same problem applies to zero bits prepended to the message, and
 * a similar solution is used.  Instead of starting with a remainder of
 * 0, an initial remainder of all ones is used.  As long as you start
 * the same way on decoding, it doesn't make a difference.
 */

#if UNITTEST

#include <stdlib.h>
#include <stdio.h>

#if 0 /*Not used at present */
static void
buf_dump(char const *prefix, unsigned char const *buf, size_t len)
{
	fputs(prefix, stdout);
	while (len--)
		printf(" %02x", *buf++);
	putchar('\n');

}
#endif

static _u32 attribute((const))
bitreverse(_u32 x)
{
	x = (x >> 16) | (x << 16);
	x = (x >> 8 & 0x00ff00ff) | (x << 8 & 0xff00ff00);
	x = (x >> 4 & 0x0f0f0f0f) | (x << 4 & 0xf0f0f0f0);
	x = (x >> 2 & 0x33333333) | (x << 2 & 0xcccccccc);
	x = (x >> 1 & 0x55555555) | (x << 1 & 0xaaaaaaaa);
	return x;
}

static void
bytereverse(unsigned char *buf, size_t len)
{
	while (len--) {
		unsigned char x = *buf;
		x = (x >> 4) | (x << 4);
		x = (x >> 2 & 0x33) | (x << 2 & 0xcc);
		x = (x >> 1 & 0x55) | (x << 1 & 0xaa);
		*buf++ = x;
	}
}

static void
random_garbage(unsigned char *buf, size_t len)
{
	while (len--)
		*buf++ = (unsigned char)random();
}

#if 0 /* Not used at present */
static void
store_le(_u32 x, unsigned char *buf)
{
	buf[0] = (unsigned char)x;
	buf[1] = (unsigned char)(x >> 8);
	buf[2] = (unsigned char)(x >> 16);
	buf[3] = (unsigned char)(x >> 24);
}
#endif

static void
store_be(_u32 x, unsigned char *buf)
{
	buf[0] = (unsigned char)(x >> 24);
	buf[1] = (unsigned char)(x >> 16);
	buf[2] = (unsigned char)(x >> 8);
	buf[3] = (unsigned char)x;
}

/*
 * This checks that CRC(buf + CRC(buf)) = 0, and that
 * CRC commutes with bit-reversal.  This has the side effect
 * of bytewise bit-reversing the input buffer, and returns
 * the CRC of the reversed buffer.
 */
static _u32
test_step(_u32 init, unsigned char *buf, size_t len)
{
	_u32 crc1, crc2;
	size_t i;

	crc1 = crc32_be(init, buf, len);
	store_be(crc1, buf+len);
	crc2 = crc32_be(init, buf, len+4);
	if (crc2)
		printf("\nCRC cancellation fail: 0x%08x should be 0\n",
crc2);

	for (i = 0; i <= len+4; i++) {
		crc2 = crc32_be(init, buf, i);
		crc2 = crc32_be(crc2, buf+i, len+4-i);
		if (crc2)
			printf("\nCRC split fail: 0x%08x\n", crc2);
	}

	/* Now swap it around for the other test */

	bytereverse(buf, len+4);
	init = bitreverse(init);
	crc2 = bitreverse(crc1);
	if (crc1 != bitreverse(crc2))
		printf("\nBit reversal fail: 0x%08x -> %0x08x -> 0x%08x\n",
				crc1, crc2, bitreverse(crc2));
	crc1 = crc32_le(init, buf, len);
	if (crc1 != crc2)
		printf("\nCRC endianness fail: 0x%08x != 0x%08x\n", crc1,
crc2);
	crc2 = crc32_le(init, buf, len+4);
	if (crc2)
		printf("\nCRC cancellation fail: 0x%08x should be 0\n",
crc2);

	for (i = 0; i <= len+4; i++) {
		crc2 = crc32_le(init, buf, i);
		crc2 = crc32_le(crc2, buf+i, len+4-i);
		if (crc2)
			printf("\nCRC split fail: 0x%08x\n", crc2);
	}

	return crc1;
}

#define SIZE 64
#define INIT1 0
#define INIT2 0

int
main(void)
{
	unsigned char buf1[SIZE+4];
	unsigned char buf2[SIZE+4];
	unsigned char buf3[SIZE+4];
	int i, j;
	_u32 crc1, crc2, crc3;

	crc32init_le();
	crc32init_be();

	for (i = 0; i <= SIZE; i++) {
		printf("\rTesting length %d...", i);
		fflush(stdout);
		random_garbage(buf1, i);
		random_garbage(buf2, i);
		for (j = 0; j < i; j++)
			buf3[j] = buf1[j] ^ buf2[j];

		crc1 = test_step(INIT1, buf1, i);
		crc2 = test_step(INIT2, buf2, i);
		/* Now check that CRC(buf1 ^ buf2) = CRC(buf1) ^ CRC(buf2)
*/
		crc3 = test_step(INIT1^INIT2, buf3, i);
		if (crc3 != (crc1 ^ crc2))
			printf("CRC XOR fail: 0x%08x != 0x%08x ^ 0x%08x\n",
					crc3, crc1, crc2);
	}
	printf("\nAll test complete.  No failures expected.\n");
	return 0;
}

#endif /* UNITTEST */
