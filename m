Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154809-31090>; Tue, 22 Dec 1998 17:34:03 -0500
Received: from noc.nyx.net ([206.124.29.3]:2862 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <155393-31090>; Tue, 22 Dec 1998 16:05:03 -0500
Date: Tue, 22 Dec 1998 15:09:22 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199812222209.PAA03112@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Tue Dec 22 15:09:22 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: sterlilize.c - fixed
Sender: owner-linux-kernel@vger.rutgers.edu

That'll teach me to try last-minute clean-ups without testing.
This will work slightly better.  I also added a version
number and cleaned up a few comments.

I'll also stop spamming linux-kernel with this; I just wanted to
make this fix equally visible.
-- 
	-Colin

/* 
 * sterilize.c - by Colin Plumb.
 * Version 1.01
 *
 * Do a secure overwrite of given files or devices, so that not even
 * very expensive hardware probing can recover the data.
 *
 * For the theory behind this, see "Secure Deletion of Data from Magnetic
 * and Solid-State Memory", on line at
 * http://www.cs.auckland.ac.nz/~pgut001/pubs/secure_del.html
 *
 * Although this processs is also known as "wiping", I prefer the longer
 * name both because I think it is more evocative of what is happening and
 * because a longer name conveys a more appropriate sense of deliberateness.
 *
 * If asked to wipe a file, this also deletes it, renaming it to in a
 * clever way to try to leave no trace of the original filename.
 *
 * Copyright 1997, 1998 Colin Plumb <colin@nyx.net>.  This program may
 * be freely distributed under the terms of the GNU, BSD or Artistic
 * licenses.  Even if you use the BSD license, which does not require it,
 * I'd really like to get improvements back.
 *
 * The ISAAC code still bears some resemblance to the code written
 * by Bob Jenkins, but he permits pretty unlimited use.
 *
 * This was inspired by a desire to improve on some code titled:
 * Wipe V1.0-- Overwrite and delete files.  S. 2/3/96
 * but I've rewritten everything here so completely that no trace of
 * the original remains.
 *
 * Things to do:
 * - Think about security implications.  Is ther any way this can be tricked
 *   into deleting the wrong file?  It will try to work on named pipes
 *   and sockets, too, which might not be a good idea.
 *
 * - Do we need autoconf for anything?
 */

#include <sys/stat.h>	/* For struct stat */
#include <sys/time.h>	/* For struct timeval */
#include <stdio.h>
#include <stdarg.h>	/* Used by pferror */
#include <stdlib.h>	/* For free() */
#include <unistd.h>	/* for open(), close(), write(), fstat() */
#include <fcntl.h>	/* for open(), close(), O_RDWR */
#include <string.h>	/* For strlen(), memcpy(), memset(), etc. */
#include <limits.h>	/* For UINT_MAX, etc. */
#include <errno.h>	/* For errno */

static char const version_string[] =
	"sterilize 0.9";
#define DEFAULT_PASSES 25	/* Default */
/* How often to update wiping display */
#define VERBOSE_UPDATE	100*1024

/*
 * --------------------------------------------------------------------
 *     Bob Jenkins' cryptographic random number generator, ISAAC.
 *     Hacked by Colin Plumb.
 *
 * We need a source of random numbers for some of the overwrite data.
 * Cryptographically secure is good, but it's not fatal if it's not,
 * so I can be a little bit experimental in the choice of RNGs here.
 *
 * This generator is based somewhat on RC4, but has analysis
 * (http://ourworld.compuserve.com/homepages/bob_jenkins/randomnu.htm)
 * pointing to it actually being better.  I like because it's nice and
 * fast, and because the author did a decent job analyzing it.
 * --------------------------------------------------------------------
 */

#if ULONG_MAX == 0xffffffff
typedef unsigned long word32;
#elif UINT_MAX == 0xffffffff
typedef unsigned word32;
#elif USHRT_MAX == 0xffffffff
typedef unsigned short word32;
#elif UCHAR_MAX == 0xffffffff
typedef unsigned char word32;
#else
#error No 32-bit type available!
#endif

/* Size of the state tables to use.  (You may change ISAAC_LOG) */
#define ISAAC_LOG 8
#define ISAAC_SIZE (1<<ISAAC_LOG)
#define ISAAC_BYTES (ISAAC_SIZE*sizeof(word32))

/* RNG state variables */
struct isaac_state {
	word32 mm[ISAAC_SIZE];	/* Main state array */
	word32 iv[8];		/* Seeding initial vector */
	word32 a, b, c;		/* Extra index variables */
};

/* This index operation is more efficient on many processors */
#define ind(mm,x)  *(unsigned *)((char *)(mm) + ( (x) & (ISAAC_SIZE-1)<<2 ))

/*
 * The central step.  This uses two temporaries, x and y.  mm is the
 * whole state array, while m is a pointer to the current word.  off is
 * the offset from m to the word ISAAC_SIZE/2 words away in the mm array,
 * i.e. +/- ISAAC_SIZE/2.
 */
#define isaac_step(mix,a,b,mm,m,off,r) \
( \
  a = (a^(mix)) + (m)[off], \
  x = *(m), \
  *(m) = y = ind(mm,x) + a + b, \
  *(r) = b = ind(mm,y>>ISAAC_LOG) + x \
)

/*
 * Refill the entire r[] array
 */
static void
isaac_refill(struct isaac_state *s, word32 r[ISAAC_SIZE])
{
	register word32 a, b;	/* Caches of a and b */
	register word32 x, y;	/* Temps needed by isaac_step() macro */
	register word32 *m = s->mm;	/* Pointer into state array */

	a = s->a;
	b = s->b + (++s->c);

	do {
		isaac_step(a << 13, a, b, s->mm, m  , ISAAC_SIZE/2, r  );
		isaac_step(a >>  6, a, b, s->mm, m+1, ISAAC_SIZE/2, r+1);
		isaac_step(a <<  2, a, b, s->mm, m+2, ISAAC_SIZE/2, r+2);
		isaac_step(a >> 16, a, b, s->mm, m+3, ISAAC_SIZE/2, r+3);
		r += 4;
	} while ((m += 4) < s->mm+ISAAC_SIZE/2);
	do {
		isaac_step(a << 13, a, b, s->mm, m  , -ISAAC_SIZE/2, r  );
		isaac_step(a >>  6, a, b, s->mm, m+1, -ISAAC_SIZE/2, r+1);
		isaac_step(a <<  2, a, b, s->mm, m+2, -ISAAC_SIZE/2, r+2);
		isaac_step(a >> 16, a, b, s->mm, m+3, -ISAAC_SIZE/2, r+3);
		r += 4;
	} while ((m += 4) < s->mm+ISAAC_SIZE);
	s->a = a;
	s->b = b;
}

/*
 * The basic seed-scrambling step for initialization, based on Bob
 * Jenkins' 256-bit hash.
 */
#define mix(a,b,c,d,e,f,g,h) \
   (       a ^= b << 11, d += a, \
   b += c, b ^= c >>  2, e += b, \
   c += d, c ^= d <<  8, f += c, \
   d += e, d ^= e >> 16, g += d, \
   e += f, e ^= f << 10, h += e, \
   f += g, f ^= g >>  4, a += f, \
   g += h, g ^= h <<  8, b += g, \
   h += a, h ^= a >>  9, c += h, \
   a += b                        )

/* The basic ISAAC initialization pass.  */
static void
isaac_mix(struct isaac_state *s, word32 const seed[ISAAC_SIZE])
{
	int i;
 	word32 a = s->iv[0];
 	word32 b = s->iv[1];
 	word32 c = s->iv[2];
 	word32 d = s->iv[3];
 	word32 e = s->iv[4];
 	word32 f = s->iv[5];
 	word32 g = s->iv[6];
 	word32 h = s->iv[7];

	for (i = 0; i < ISAAC_SIZE; i += 8) {
		a += seed[i];
		b += seed[i+1];
		c += seed[i+2];
		d += seed[i+3];
		e += seed[i+4];
		f += seed[i+5];
		g += seed[i+6];
		h += seed[i+7];

		mix(a, b, c, d, e, f, g, h);

		s->mm[i] = a;
		s->mm[i+1] = b;
		s->mm[i+2] = c;
		s->mm[i+3] = d;
		s->mm[i+4] = e;
		s->mm[i+5] = f;
		s->mm[i+6] = g;
		s->mm[i+7] = h;
	}

	s->iv[0] = a;
	s->iv[1] = b;
	s->iv[2] = c;
	s->iv[3] = d;
	s->iv[4] = e;
	s->iv[5] = f;
	s->iv[6] = g;
	s->iv[7] = h;
}

/*
 * Initialize the ISAAC RNG with the given seed material.
 * Its size MUST be a multiple of ISAAC_BYTES, and may be
 * the s->mm array.
 *
 * This is a generalization of the original ISAAC initialzation code
 * to support larger seed sizes.  For seed sizes of 0 and ISAAC_BYTES,
 * it is identical.
 */
static void
isaac_init(struct isaac_state *s, word32 const *seed, size_t seedsize)
{
	static word32 const iv[8] = {
		0x1367df5a, 0x95d90059, 0xc3163e4b, 0x0f421ad8,
		0xd92a4a78, 0xa51a3c49, 0xc4efea1b, 0x30609119 };
	int i;

#if 0
	/* Tne initialization of iv is a precomputed form of: */
	for (i = 0; i < 7; i++)
		iv[i] = 0x9e3779b9;	/* the golden ratio */ 
	for (i = 0; i < 4; ++i)		/* scramble it */
		mix(iv[0], iv[1], iv[2], iv[3], iv[4], iv[5], iv[6], iv[7]);
#endif
	s->a = s->b = s->c = 0;

	for (i = 0; i < 8; i++)
		s->iv[i] = iv[i];

	if (seedsize) {
		/* First pass */
		isaac_mix(s, seed);
		/* Second and subsequent passes (extension to ISAAC) */
		while (seedsize -= ISAAC_BYTES) {
			seed += ISAAC_SIZE;
			for (i = 0; i < ISAAC_SIZE; i++)
				s->mm[i] += seed[i];
			isaac_mix(s, s->mm);
		}
	}

	/* Final pass */
	isaac_mix(s, s->mm);
}

/*
 * Get seed material.  16 bytes (128 bits) is plenty, but if we have
 * /dev/urandom, we get 32 bytes = 256 bits for complete overkill.
 */
static void
isaac_seed(struct isaac_state *s)
{
	s->mm[0] = getpid();
	s->mm[1] = getppid();

	{
#ifdef CLOCK_REALTIME	/* POSIX ns-resolution */
		struct timespec ts;
		clock_gettime(CLOCK_REALTIME, &ts);
		s->mm[2] = ts.tv_sec;
		s->mm[3] = ts.tv_nsec;
#else
		struct timeval tv;
		gettimeofday(&tv, (struct timezone *)0);
		s->mm[2] = tv.tv_sec;
		s->mm[3] = tv.tv_usec;
#endif
	}

	{
		int fd = open("/dev/urandom", O_RDONLY);
		if (fd >= 0) {
			read(fd, (char *)(s->mm+4), 32);
			close(fd);
		} else {
			fd = open("/dev/random", O_RDONLY | O_NONBLOCK);
			if (fd >= 0) {
				/* /dev/random is more precious, so use less */
				read(fd, (char *)(s->mm+4), 16);
				close(fd);
			}
		}
	}

	isaac_init(s, s->mm, sizeof(s->mm));
}

/*
 * Read up to "size" bytes from the given FD and use them as additional
 * ISAAC seed material.  Returns the number of bytes actually read.
 */
static off_t
isaac_seedfd(struct isaac_state *s, int fd, off_t size)
{
	off_t sizeleft = size;
	size_t lim, soff;
	ssize_t ssize;
	int i;
	word32 seed[ISAAC_SIZE];

	while (sizeleft) {
		lim = sizeof(seed);
		if ((off_t)lim > sizeleft)
			lim = (size_t)sizeleft;
		soff = 0;
		do {
			ssize = read(fd, (char *)seed+soff, lim-soff);
		} while (ssize > 0 && (soff += (size_t)ssize) < lim);
		/* Mix in what was read */
		if (soff) {
			/* Garbage after the sofff position is harmless */
			for (i = 0; i < ISAAC_SIZE; i++)
				s->mm[i] += seed[i];
			isaac_mix(s, s->mm);
			sizeleft -= soff;
		}
		if (ssize <= 0)
			break;
	}
	/* Final mix, as in isaac_init */
	isaac_mix(s, s->mm);
	return size - sizeleft;
}

/* Single-value RNG built on top of isaac */
struct irand_state {
	word32 r[ISAAC_SIZE];
	unsigned numleft;
	struct isaac_state *s;
};

static void
irand_init(struct irand_state *r, struct isaac_state *s)
{
	r->numleft = 0;
	r->s = s;
}

/*
 * We take from the end of the block deliberately, so if we need
 * only a small number of values, we choose the final ones which are
 * marginally better mixed than the initial ones.
 */
static word32
irand32(struct irand_state *r)
{
	if (!r->numleft) {
		isaac_refill(r->s, r->r);
		r->numleft = ISAAC_SIZE;
	}
	return r->r[--r->numleft];
}

/*
 * Return a uniformly distributed random number between 0 and n,
 * inclusive.  Thus, the result is modulo n+1.
 */
static word32
irand_mod(struct irand_state *r, word32 n)
{
	word32 x;
	word32 lim;

	if (!++n)
		return irand32(r);

	lim = -n % n;	/* = (2**32-n) % n = 2**32 % n */
	do {
		x = irand32(r);
	} while (x < lim);
	return x % n;
}

/* Global variable for error printing purposes */
char const *argv0 = NULL;

/*
 * Like perror() but fancier.  (And fmt is not allowed to be NULL)
 */
#if __GNUC__ >= 2
static void pfstatus(char const *, ...) __attribute__((format(printf, 1, 2)));
static void pferror(char const *, ...) __attribute__((format(printf, 1, 2)));
#endif

/*
 * Update current status line on stdout.
 * This is done by using CR and overprinting the new data.
 * This takes printf args and overwrites status line with new status line.
 * Each line is padded with trailing spaces to cover up what was printed
 * before (assuming the return value of printf is an accurate width).
 */
static int status_visible = 0;	/* Number of visible characters */
static int status_pos = 0;	/* Current position, including padding */

static void
pfstatus(char const *fmt, ...)
{
	int new;
	va_list ap;

	/* If we weren't at beginning, go there. */
	if (status_pos)
		putchar('\r');
	va_start(ap, fmt);
	new = vprintf(fmt, ap);
	va_end(ap);
	if (new >= 0) {
		status_pos = new;
		while (status_pos < status_visible) {
			putchar(' ');
			status_pos++;
		}
		status_visible = new;
	}
	fflush(stdout);
}

/* Go to beginning of (possibly new) line, leaving any status visible. */
static void
flushstatus(void)
{
	if (status_visible) {
		putchar('\n');	/* Leave line visible */
		fflush(stdout);
		status_visible = status_pos = 0;
	} else if (status_pos) {
		putchar('\r');	/* Go back to beginning of line */
		fflush(stdout);
		status_pos = 0;
	}
}

static void
pferror(char const *fmt, ...)
{
	va_list ap;
	char const *err;

	err = strerror(errno);

	flushstatus();	/* Make it look pretty */

	if (argv0) {
		fputs(argv0, stderr);
		fputs(": ", stderr);
	}
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputs(": ", stderr);
	fputs(err, stderr);
	putc('\n', stderr);
}
 
/*
 * Get the size of a file that doesn't want to cooperate, (such as a
 * device) by doing a binary search for the last readable byte.  The size
 * of the file is the least offset at which it is not possible to read
 * a byte.  (We assume that if it is possible to read a byte at offset x,
 * it is also possible at all offsets <= x.)
 */
static off_t
sizefd(int fd)
{
	off_t hi, lo, mid;
	char c;

	/* Binary doubling upwards to find the right range */
	lo = 0;
	hi = 0;	/* Any number, preferably 2^x-1, is okay here. */

	/*
	 * Loop invariant: we have verified that it is possible to read
	 * a byte at all offsets < lo.	Increase hi until it is not
	 * possible to read a byte at that offset, establishing the loop
	 * invariant for the following loop.
	 */
	for (;;) {
		if (lseek(fd, hi, SEEK_SET) == (off_t)-1 ||
		    read(fd, &c, 1) < 1)
			break;
		lo = hi+1;	/* This preserves loop invariant. */
		hi += lo;	/* Exponential doubling. */
	}
	/*
	 * Loop invariant: it is not possible to read a byte at hi,
	 * but it is possible at all offsets < lo.  Thus, the
	 * offset we seek is between lo and hi inclusive.
	 */
	while (hi > lo) {
		mid = (hi+lo)/2;	/* Rounded down, so mid < hi */
		if (lseek(fd, mid, SEEK_SET) == (off_t)-1 ||
		    read(fd, &c, 1) < 1) {
			hi = mid;	/* mid < hi, so this makes progress */
			continue;
		}
		lo = mid+1;	/* Because mid < hi, lo <= hi */
	}
	/* Windows is now of zero width, so we have an exact answer */
	return hi;
}

/*
 * Fill a buffer with a specified pattern. 
 * 
 * The buffer must be at least 3 bytes long.
 */
static void
fillpattern(int type, unsigned char *r, size_t size)
{
	size_t i;
	unsigned bits = type & 0xfff;

	bits |= bits << 12;
	((unsigned char *)r)[0] = (bits >> 4) & 255;
	((unsigned char *)r)[1] = (bits >> 8) & 255;
	((unsigned char *)r)[2] = bits & 255;
	for (i = 3; i < size/2; i *= 2)
		memcpy((char *)r+i, (char *)r, i);
	if (i < size)
		memcpy((char *)r+i, (char *)r, size-i);

	/* Invert the first bit of every 512-byte sector. */
	if (type & 0x1000)
		for (i = 0; i < size; i += 512)
			r[i] ^= 0x80;
}

/*
 * Fill a buffer with random data.
 * size is rounded UP to a multiple of * ISAAC_BYTES.
 */
static void
fillrand(struct isaac_state *s, word32 *r, size_t size)
{
	size = (size+ISAAC_BYTES-1)/ISAAC_BYTES;

	while (size--) {
		isaac_refill(s, r);
		r += ISAAC_SIZE;
	}
}

static void
passname(int type, char buf[7])
{
	unsigned long bits;

	if (type < 0) {
		memcpy(buf, "random", 7);
	} else {
		bits = type & 0xfff;
		bits |= bits << 12;
		if (type & 0x1000)
			bits ^= 0x800000;
		sprintf(buf, "%0.6lX", bits);
	}
}

static int
dopass(int fd, char const *name, off_t size, int type,
	struct isaac_state *s, unsigned long k, unsigned long n)
{
	off_t cursize, thresh;
	size_t lim, soff;
	ssize_t ssize;
	word32 r[ISAAC_SIZE*12]; /* Multiple of 4K and of pattern size */
	char pass_string[7];

	if (lseek(fd, 0, SEEK_SET) < 0) {
		pferror("Error seeking \"%s\"", name);
		return -1;
	}

	thresh = 0;
	if (n) {
		passname(type, pass_string);
		pfstatus("%s: pass %lu/%lu (%s)...", name, k, n, pass_string);
		if (size > VERBOSE_UPDATE)
			thresh = size - VERBOSE_UPDATE;
	}
		
	if (type >= 0) {
		lim = sizeof(r);
		if ((off_t)lim > size) {
			lim = (size_t)size;
		}
		fillpattern(type, (unsigned char *)r, lim);
	}

	for (cursize = size; cursize; ) {
		/* How much to write this time? */
		lim = sizeof(r);
		if ((off_t)lim > cursize)
			lim = (size_t)cursize;
		if (type < 0)
			fillrand(s, r, lim);
		/* Loop to retry partial writes. */
		for (soff = 0; soff < lim; soff += ssize) {
			ssize = write(fd, (char *)r+soff, lim-soff);
			if (ssize < 0) {
				int e = errno;
				pferror("Error writing \"%s\" at %lu",
					name, size-cursize+soff);
				if (e == EBADF && fd == 0)
					fputs(
"(Did you remember to open stdin read/write with \"<>file\"?)\n", stderr);
				return -1;
			}
		}

		cursize -= lim;

		if (cursize <= thresh && n) {
			pfstatus("%s: pass %lu/%lu (%s)...%lu/%lu K",
				name, k, n, pass_string,
				(size-cursize+1023)/1024, (size+1023)/1024);
			if (thresh > VERBOSE_UPDATE)
				thresh -= VERBOSE_UPDATE;
			else
				thresh = VERBOSE_UPDATE;
		}
	}
	if (fdatasync(fd) < 0) {
		pferror("Error syncing \"%s\"", name);
		return -1;
	}
	return 0;
}

/*
 * The passes start and end with a random pass, and the passes in between
 * are done in random order.
 * First, all possible 1-bit patterns.  There are two of them.
 * Then, all possible 2-bit patterns.  There are four, but the two
 * which are also 1-bit patterns can be omitted.
 * Then, all possible 3-bit patterns.  Again, 8-2 = 6.
 * Then, all possible 4-bit patterns.  16-4 = 12.
 *
 * Another possible enhancement is to play with the first bit of each
 * disk block to adjust the encoding phase.  There is support
 * in fillpattern for this, using bit 12 of the patterns.
 *
 * 100100100100
 *    9   2   4
 * 110110110110
 *    D   B   6
 * 
 * The basic passes are:
 * 1-bit: 0x000, 0xFFF
 * 2-bit: 0x555, 0xAAA
 * 3-bit: 0x249, 0x492, 0x6DB, 0x924, 0xB6D, 0xDB6 (+ 1-bit)
 *
 * 4-bit: 0x111, 0x222, 0x333, 0x444, 0x666, 0x777,
 *        0x888, 0x999, 0xBBB, 0xCCC, 0xDDD, 0xEEE (+ 1-bit, 2-bit)
 * Adding three random passes at the beginning, middle and end
 * produces the default 25-pass structure.
 *
 * The next extension would be to 5-bit and 6-bit patterns.
 * There are 30 uncovered 5-bit patterns and 64-8-2 = 46 uncovered
 * 6-bit patterns, so they would increase the time required
 * significantly.  4-bit patterns are enough for most purposes.
 *
 * The main gotcha is that this would require a trickier encoding,
 * since lcm(2,3,4) = 12 bits is easy to fit into an int, but
 * lcm(2,3,4,5) = 60 bits is not.
 *
 * One extension that is included is to complement the first bit in each
 * 512-byte block, to alter the phase pf the encoded data in the more
 * complex encodings.  This doesn't apply to MFM, so the 1-bit patterns
 * are considered part of the 3-bit ones and the 2-bit patterns are
 * considered part of the 4-bit patterns.
 *
 *
 * How does the generalization to variable numbers of passes work?
 *
 * Here's how... 
 * Have an ordered list of groups of passes.  Each group is a set.
 * Take as many groups as will fit, plus a random subset of the
 * last partial group, and place them into the passes list.
 * Then shuffle the passes list into random order and use that.
 *
 * One extra detail: if we can't include a large enough fraction of the
 * last group to be interesting, then just substitute random passes.
 *
 * If you want more passes than the entire list of groups can
 * provide, just start repeating from the beginning of the list.
 */
static int const
patterns[] = {
	-2,
	2, 0x000, 0xFFF,	/* 1-bit */
	2, 0x555, 0xAAA,	/* 2-bit */
	-1,
	6,         0x249, 0x492, 0x6DB, 0x924, 0xB6D, 0xDB6,	/* 3-bit */
	12,        0x111, 0x222, 0x333, 0x444,        0x666, 0x777,
	    0x888, 0x999,        0xBBB, 0xCCC, 0xDDD, 0xEEE, 	/* 4-bit */
	-1,
	/* The following patterns have the frst bit per block flipped */
	8, 0x1000, 0x1249, 0x1492, 0x16DB, 0x1924, 0x1B6D, 0x1DB6, 0x1FFF,
	14,         0x1111, 0x1222, 0x1333, 0x1444, 0x1555, 0x1666, 0x1777,
	    0x1888, 0x1999, 0x1AAA, 0x1BBB, 0x1CCC, 0x1DDD, 0x1EEE,
	-1,
	0	/* End */
};


/*
 * Generate a random wiping pass pattern with num passes.
 * This is a two-stage process.  First, the passes to include
 * are chosen, and then they are shuffled into the desired
 * order.
 */


static void
genpattern(int *dest, size_t num, struct isaac_state *s)
{
	struct irand_state r;
	size_t randpasses;
	int const *p;
	int *d;
	size_t n;
	size_t accum, top, swap;
	int k;

	if (!num)
		return;

	irand_init(&r, s);

	/* Stage 1: choose the passes to use */
	p = patterns;
	randpasses = 0;
	d = dest;
	n = num;

	for (;;) {
		k = *p++;
		if (!k) {	/* Loop back to the beginning */
			p = patterns;
		} else if (k < 0) {	/* -k random passes */
			k = -k;
			if ((size_t)k >= n) {
				randpasses += n;
				n = 0;
				break;
			}
			randpasses += k;
			n -= k;
		} else if ((size_t)k <= n) {	/* Full block of patterns */
			memcpy(d, p, k*sizeof(int));
			p += k;
			d += k;
			n -= k;
		} else if (n < 2 || 2*n < (size_t)k) { /* Finish with random */
			randpasses += n;
			break;
		} else {	/* Pad out with k of the n available */
			do {
				if (n == (size_t)k-- || irand_mod(&r, k) < n) {
					*d++ = *p;
					n--;
				}
				p++;
			} while (n);
			break;
		}
	}
	top = num - randpasses;	/* Top of initialized data */

	/* assert(d = dest+top); */

	/*
	 * We now have fixed patterns in the dest buffer up to
	 * "top", and we need to scramble them, with "randpasses"
	 * random passes evenly spaced among them.
	 *
	 * We want one at the beginning, one at the end, and
	 * evenly spaced in between.  To do this, we basically
	 * use Bresenham's line draw (a.k.a DDA) algorithm
	 * to draw a line with slope (randpasses-1)/(num-1).
	 * (We use a positive accumulator and count down to
	 * do this.)
	 *
	 * So for each desired output value, we do the following:
	 * - If it should be a random pass, copy the pass type
	 *   to top++, out of the way of the other passes, and
	 *   set the current pass to -1 (random).
	 * - If it should be a normal pattern pass, choose an
	 *   entry at random between here and top-1 (inclusive)
	 *   and swap the current entry with that one.
	 */

	randpasses--;	/* To speed up later math */
	accum = randpasses;
	for (n = 0; n < num; n++) {
		if (accum <= randpasses) {
			accum += num-1;
			dest[top++] = dest[n];
			dest[n] = -1;
		} else {
			swap = n + irand_mod(&r, top-n-1);
			k = dest[n];
			dest[n] = dest[swap];
			dest[swap] = k;
		}
		accum -= randpasses;
	}
	/* assert(top == num); */

	memset(&r, 0, sizeof(r));
}


/* Flags definition.  Bit numbers here correspond to positions below! */
#define FLAG_DEVICES	1
#define FLAG_FORCE	2
#define FLAG_PRESERVE	4
#define FLAG_VERBOSE	8
#define FLAG_EXACT	16
#define FLAG_ZERO	32
static char const simpleflags[] = "dfpvxz";	/* Same order as above */

#define FLAG_EXTRAVERBOSE 256

/*
 * The core routine to actually do the work.  This overwrites the first
 * size bytes of the given fd.  Returns -1 on error, 0 on success with
 * regular files, and 1 on success with non-regular files.
 */
static int
wipefd(int fd, char const *name, struct isaac_state *s,
	size_t passes, unsigned flags)
{
	size_t i;
	struct stat st;
	off_t size;
	unsigned long n;
	int *passarray;

	if (!passes)
		passes = DEFAULT_PASSES;

	n = 0;
	if (flags & FLAG_VERBOSE)
		n = passes + ((flags & FLAG_ZERO) != 0);

	if (fstat(fd, &st)) {
		pferror("Can't fstat file \"%s\"", name);
		return -1;
	}

	/* Check for devices */
	if (!S_ISREG(st.st_mode) && !(flags & FLAG_DEVICES)) {
		fprintf(stderr,
"\"%s\" is not a regular file: use -d to enable operations on devices\n",
			name);
		return -1;
	}

	/* Allocate pass array */
	passarray = malloc(passes * sizeof(int));
	if (!passarray) {
		pferror("Can't alllocate array for %lu passes",
		        (unsigned long)passes);
		return -1;
	}

	size = st.st_size;
	if (!size) {
		/* Reluctant to talk?  Apply thumbscrews. */
		size = sizefd(fd);
	} else if (st.st_blksize && !(flags & FLAG_EXACT)) {
		/* Round up to the next st_blksize to include "slack" */
		size += st.st_blksize - 1 - (size-1) % st.st_blksize;
	}

	/* Use the file itself as seed material. */
	(void)isaac_seedfd(s, fd, size);

	/* Schedule the passes in random order. */
	genpattern(passarray, passes, s);

	/* Do the work */
	for (i = 0; i < passes; i++) {
		if (dopass(fd, name, size, passarray[i], s, i+1, n) < 0) {
			memset(passarray, 0, passes*sizeof(int));
			free(passarray);
			return -1;
		}
		if (flags & FLAG_EXTRAVERBOSE)
			flushstatus();
	}

	memset(passarray, 0, passes*sizeof(int));
	free(passarray);

	if (flags & FLAG_ZERO)
		if (dopass(fd, name, size, 0, s, passes+1, n) < 0)
			return -1;

	return !S_ISREG(st.st_mode);
}


/* Characters allowed in a file name - a safe universal set. */
static char const nameset[] =
"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_+=%@#.";

/*
 * This increments the name, considering it as a big-endian base-N number
 * with the digits taken from nameset.  Characters not in the nameset
 * are considered to come before nameset[0].
 *
 * It's not obvious, but this will explode if name[0..len-1] contains
 * any 0 bytes.
 *
 * This returns the carry (1 on overflow).
 */
static int
incname(char *name, unsigned len)
{
	char const *p;

	if (!len)
		return -1;

	p = strchr(nameset, name[--len]);
	/* If the character is not found, replace it with a 0 digit */
	if (!p) {
		name[len] = nameset[0];
		return 0;
	}
	/* If this character has a successor, use it */
	if (p[1]) {
		name[len] = p[1];
		return 0;
	}
	/* Otherwise, set this digit to 0 and increment the prefix */
	name[len] = nameset[0];
	return incname(name, len);
}

/*
 * Repeatedly rename a file with shorter and shorter names,
 * to obliterate all traces of the file name on any system that
 * adds a trailing delimiter to on-disk file names and reuses
 * the same directory slot.  Finally, delete it.
 * The passed-in filename is changed to the current filename.
 * (Which is deleted if this function succeeds, but is still present if
 * it fails for some reason.)
 *
 * The main loop is written carefully to not get stuck if all possible
 * names of a given length are occupied.  It counts down the length from
 * the original to 0.  While the length is non-zero, it tries to find an
 * unused file name of the given length.  It continues until either the
 * name is available and the rename succeeds, or it runs out of names
 * to try (incname() wraps and returns 1).  Finally, it deletes the file.
 *
 * Note that rename() and remove() are both in the ANSI C standard,
 * so this is NOT Unix-specific.
 *
 * To force the directory data out, we try to open() the directory and
 * invoke fdatasync() on it.  This is rather non-standard, so we don't
 * inisit that it works, just fall back to a global sync() in thet case.
 */
int
wipename(char *oldname, unsigned flags)
{
	char *newname, *origname = 0;
	char *base;	/* Pointer to filename component, after directories. */
	unsigned len;
	int err;
	int dirfd;	/* Try to open directory to sync *it* */

	pfstatus("%s: deleting", oldname);

	newname = strdup(oldname);	/* This is a malloc */
	if (!newname) {
		pferror("malloc failed");
		return -1;
	}
	if (flags & FLAG_VERBOSE) {
		origname = strdup(oldname);
		if (!origname) {
			pferror("malloc failed");
			free(newname);
			return -1;
		}
	}

	/* Find the file name portion */
	base = strrchr(newname, '/');
	/* Temporary hackery to get a directory fd */
	if (base) {
		*base = '\0';
		dirfd = open(newname, O_RDONLY);
		*base = '/';
	} else {
		dirfd = open(".", O_RDONLY);
	}
	base = base ? base+1 : newname;
	len = strlen(base);

	while (len) {
		memset(base, nameset[0], len);
		base[len] = 0;
		do {
			if (access(newname, F_OK) < 0
			    && !rename(oldname, newname)) {
				if (dirfd < 0 || fdatasync(dirfd) < 0)
					sync();	/* Force directory out */
				if (origname) {
					pfstatus("%s: renamed to \"%s\"",
						origname, newname);
					if (flags & FLAG_EXTRAVERBOSE)
						flushstatus();
				}
				memcpy(oldname+(base-newname), newname, len+1);
				break;
			}
		} while (!incname(base, len));
		len--;
	}
	free(newname);
	err = remove(oldname);
	if (dirfd < 0 || fdatasync(dirfd) < 0)
		sync();
	close(dirfd);
	if (origname) {
		if (!err)
			pfstatus("%s: deleted", origname);
		free(origname);
	}
	return err;
}


/*
 * Finally, the function that actually takes a filename and grinds
 * it into hamburger.  Returns 1 if it was not a regular file.
 *
 * Detail to note: since we do not restore errno to EACCES after
 * a failed chmod, we end up printing the error code from the chmod.
 * This is probably either EACCES again or EPERM, which both give
 * reasonable error messages.  But it might be better to change that.
 */
static int
wipefile(char *name, struct isaac_state *s, size_t passes, unsigned flags)
{
	int err, fd;

	fd = open(name, O_RDWR);
	if (fd < 0 && errno == EACCES && flags & FLAG_FORCE) {
		if (chmod(name, 0600) >= 0)
			fd = open(name, O_RDWR);
	}
	if (fd < 0) {
		pferror("Unable to open \"%s\"", name);
		return -1;
	}
	
	err = wipefd(fd, name, s, passes, flags);
	close(fd);

	/* Wipe the name and unlink - regular files only, no devices! */
	if (err == 0 && !(flags & FLAG_PRESERVE)) {
		err = wipename(name, flags);
		if (err < 0)
			pferror("Unable to delete file \"%s\"", name);
	}
	return err;
}

/* Command-line parsing.  Should add some help and so on. */
int
main(int argc, char **argv)
{
	struct isaac_state s;
	int err = 0;
	int no_more_opts = 0;
	unsigned flags = 0;
	char const *p;
	char *p2;	/* Actually a const ptr, but kludged... */
	unsigned long passes = 0;
	unsigned wipes = 0;	/* How many files have we actually wiped? */

	argv0 = argv[0];

	isaac_seed(&s);

	while (--argc && !err) {
		p = *++argv;
		if (no_more_opts || *p != '-') {
			/* Plain old filename */
			/* Note that this overwrites *argv! */
			if (wipefile(*argv, &s, (size_t)passes, flags) < 0)
				err = 1;
			flushstatus();
			wipes++;
			continue;
		}

		/* Parse option */
		if (p[1] == '\0') {	/* "-": stdin */
			if (wipefd(0, *argv, &s, (size_t)passes, flags) < 0)
				err = 1;
			flushstatus();
			wipes++;
			continue;
		}
		if (p[1] == '-') {	/* "--long_option" */
			if (p[2] == '\0') {
				no_more_opts = 1;
			} else if (strcmp(p+2, "help") == 0) {
				puts(
"Usage: sterilize [OPTIONS] FILE [...]\n"
"Delete a file securely, first overwriting it to hide its contents.\n"
"\n"
"  -          Sterilize standard input (but don't delete it)\n"
"             This will error unless you use <>file, a safety feature\n"
"  -NUM       Overwrite NUM times instead of the default (25)\n"
"  -d         Allow operation on devices (devices are never deleted)\n"
"  -f         Force, change permissions to allow writing if necessary\n"
"  -p         Preserve, do not delete file after overwriting\n"
"  -v         Verbose, print progress\n"
"  -x         Exact, do not round file sizes up to the next full block\n"
"  -z         Add a final overwrite with zeros to hide sterilization\n"
"  --         End of options; following filenames may begin with -\n"
"  --help     Display this help and exit\n"
"  --version  Print version information and exit");
				return 0;	/* Immediate quit */
			} else if (strcmp(p+2, "version") == 0) {
				puts(version_string);
				return 0;	/* Immediate quit */
			} else {
				fprintf(stderr, "%s: Unknown option %s\n",
					argv0, p);
				err = 1;
				break;
			}
			continue;
		}
		/* Short options */
		while (*++p) {
			if ((*p == 'v') && (flags & FLAG_VERBOSE))
				flags |= FLAG_EXTRAVERBOSE;
			p2 = strchr(simpleflags, *p);
			if (p2) {
				flags |= 1 << (p2-simpleflags);
				continue;
			}
			if (*p >= '0' && *p <= '9') {
				passes = strtoul(p, &p2, 0);

				if ((word32)passes != passes ||
				    (size_t)(passes*sizeof(int))/sizeof(int)
					!= passes)
				{
					fprintf(stderr,
						"%s: Too many passes: -%s\n",
						argv0, p);
					err = 1;
					break;
				}
				p = p2-1;
				continue;
			}
			fprintf(stderr, "%s: Unknown option -%s\n",
				argv0, p);
			err = 1;
			break;
		}
	}

	/* Just on general principles, wipe s. */
	memset(&s, 0, sizeof(s));

	if (!wipes && !err) {
		fprintf(stderr, "%s: no filename specified\n"
		                "Try \"%s --help\" for more information.\n",
			argv0, argv0);
		err = 1;
	}

	return err;
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
