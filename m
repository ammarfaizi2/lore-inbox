Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154424-9301>; Sun, 6 Sep 1998 18:08:15 -0400
Received: from dm.cobaltmicro.com ([209.133.34.35]:1443 "EHLO dm.cobaltmicro.com" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <154373-9301>; Sun, 6 Sep 1998 17:55:39 -0400
Date: Sun, 6 Sep 1998 17:16:30 -0700
Message-Id: <199809070016.RAA09205@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: linux-kernel@vger.rutgers.edu
In-reply-to: <Pine.LNX.4.03.9809070109140.24976-100000@mercator.cs.kuleuven.ac.be> (message from Geert Uytterhoeven on Mon, 7 Sep 1998 01:12:16 +0200 (CEST))
Subject: Re: IPv4 kernel messages
References: <Pine.LNX.4.03.9809070109140.24976-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: 	Mon, 7 Sep 1998 01:12:16 +0200 (CEST)
   From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>

   They're still there:

   | Socket destroy delayed (r=0 w=160)
   | TCPv4 bad checksum from 10.0.24.8:0071 to 10.0.24.4:040c, len=20/20/40

   Are these just warnings to be disabled in 2.2, or is there something wrong?

   10.0.24.4 runs Linux/m68k 2.1.119. 10.0.24.8 is a PPC running vger-19980903.

I see them only rarely on my main workstation which talks a lot to the
rest of the world.  On my internal Linux-2.1.x machines I never see
it.

I would check out the csum routines on m68k and PPC to make sure they
are sane in all cases.

Here is the lifesaver development utility I have been using for a long
time to verify all major changes made to Sparc and MIPS checksumming
routines.  It won't work for you as-is, but you can figure out what it
is supposed to do and link the PPC and M68k csum routines into it to
perform verifications.  Note there is an ugly piece of MIPS inline asm
in here which you'll need to remove too as the last thing I used this
for was the Cobalt kernels :-)  Note it also performs performance
metrics on your code too, so it's useful for speed tuning as well as
verification.

/* cksum_helper.c: Lifesaver development utility.
 *
 * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>

extern	int	gettimeofday();
extern	int	fprintf();

static struct timeval start_tv, stop_tv;

void
tvsub(tdiff, t1, t0)
	struct timeval *tdiff, *t1, *t0;
{
	tdiff->tv_sec = t1->tv_sec - t0->tv_sec;
	tdiff->tv_usec = t1->tv_usec - t0->tv_usec;
	if (tdiff->tv_usec < 0)
		tdiff->tv_sec--, tdiff->tv_usec += 1000000;
}

/*
 * Start timing now.
 */
void
start()
{
	(void) gettimeofday(&start_tv, (struct timezone *) 0);
}

/*
 * Stop timing and return real time in microseconds.
 */
unsigned long
stop()
{
	struct timeval tdiff;

	(void) gettimeofday(&stop_tv, (struct timezone *) 0);

	tvsub(&tdiff, &stop_tv, &start_tv);
	return (tdiff.tv_sec * 1000000 + tdiff.tv_usec);
}

void
micro(s, n)
	char	*s;
	int	n;
{
	struct timeval td;
	int	micro;

	tvsub(&td, &stop_tv, &start_tv);
	fprintf(stderr, "%s: %d secs\n", s, td.tv_sec);
	micro = td.tv_sec * 1000000 + td.tv_usec;
	fprintf(stderr, "%s: %d microseconds\n", s, micro / n);
}

void
milli(s, n)
	char	*s;
	int	n;
{
	struct timeval td;
	int	milli;

	tvsub(&td, &stop_tv, &start_tv);
	milli = td.tv_sec * 1000 + td.tv_usec / 1000;
	fprintf(stderr, "%s: %d milliseconds\n", s, milli / n);
}

/* Basically, we create buffers of varying sizes, feed them into
 * a known working checksum routine and the one to be tested,
 * if the test succeeds we just go on to the next buffer full of
 * random data and try again.  If it fails, the random data block
 * is written into files with unique names for each failure buffer,
 * and the two differing results go to stdout.
 */

/* What we test... */
extern unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum);
extern unsigned int csum_partial_copy(const char *src, char *dst, int len, int sum);
extern unsigned short ip_fast_csum(const unsigned char * iph, unsigned int ihl);
extern unsigned short int csum_tcpudp_magic(unsigned long saddr, unsigned long daddr,
					    unsigned short len, unsigned short proto,
					    unsigned int sum);
extern unsigned short ip_compute_csum(unsigned char * buff, int len);

typedef signed char s8;
typedef unsigned char u8;

typedef signed short s16;
typedef unsigned short u16;

typedef signed int s32;
typedef unsigned int u32;

typedef signed long long s64;
typedef unsigned long long u64;

/* Now the portable checksum routine we assume works on all machines. */
#define ADDCARRY(x)  (x > 65535 ? x -= 65535 : x)
#define REDUCE {l_util.l = sum; sum = l_util.s[0] + l_util.s[1]; ADDCARRY(sum);}

int reference_cksum(u16 *w, int len)
{
	int sum = 0;
	int mlen = 0;
	int byte_swapped = 0;

	union {
		u8  c[2];
		u16 s;
	} s_util;
	union {
		u16 s[2];
		u32 l;
	} l_util;

	/* Force to even boundary. */
	if ((1 & (long) w) && (len > 0)) {
		REDUCE;
		sum <<= 8;
		s_util.c[0] = *(u8 *)w;
		w = (u16 *)((s8 *)w + 1);
		len--;
		byte_swapped = 1;
	}
	/* Unroll the loop to make overhead from
	 * branches &c small.
	 */
	while ((len -= 32) >= 0) {
		sum += w[0]; sum += w[1]; sum += w[2]; sum += w[3];
		sum += w[4]; sum += w[5]; sum += w[6]; sum += w[7];
		sum += w[8]; sum += w[9]; sum += w[10]; sum += w[11];
		sum += w[12]; sum += w[13]; sum += w[14]; sum += w[15];
		w += 16;
	}
	len += 32;
	while ((len -= 8) >= 0) {
		sum += w[0]; sum += w[1]; sum += w[2]; sum += w[3];
		w += 4;
	}
	len += 8;
	if (len == 0 && byte_swapped == 0)
		goto fini;
	REDUCE;
	while ((len -= 2) >= 0) {
		sum += *w++;
	}
	if (byte_swapped) {
		REDUCE;
		sum <<= 8;
		byte_swapped = 0;
		if (len == -1) {
			s_util.c[1] = *(u8 *)w;
			sum += s_util.s;
			len = 0;
		} else
			len = -1;
	} else if (len == -1)
		s_util.c[0] = *(u8 *)w;
fini:
	if (len == -1) {
		/* Follow the standard (the odd byte may be shifted left
		 * by 8 bits or not as determined by endian-ness of the
		 * machine).
		 */
		s_util.c[1] = 0;
		sum += s_util.s;
	}
	REDUCE;
	return (~sum & 0xffff);
}

/* XXX */
static __inline__ unsigned short int csum_fold(unsigned int sum)
{
	__asm__("
	.set	noat            
	sll	$1,%0,16
	addu	%0,$1
	sltu	$1,%0,$1
	srl	%0,%0,16
	addu	%0,$1
	xori	%0,0xffff
	.set	at"
	: "=r" (sum)
	: "0" (sum)
	: "$1");

 	return sum;
}

static int filenum = 0;

struct iphdr {
	unsigned char	version:4,
  		        ihl:4;
	unsigned char	tos;
	unsigned short	tot_len;
	unsigned short	id;
	unsigned short	frag_off;
	unsigned char	ttl;
	unsigned char	protocol;
	unsigned short	check;
	unsigned int	saddr;
	unsigned int	daddr;
	/*The options start here. */
};

struct timeval random_seed;

static void verify_ip_fast_csum(void)
{
	struct iphdr **buffers;
	struct iphdr *this;
	int i, b, iters=512;
	u16 ctr=52;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * 512);
	if(!buffers)
		goto outofmem;
	for(i = 0; i < 512; i++) {
		this = (struct iphdr *) malloc((sizeof(struct iphdr)));
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
	printf("verify_ip_fast_csum");
again:
	putchar('.');
	fflush(stdout);
	for(i = 0; i < 512; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < (sizeof(struct iphdr)); b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	for(i = 0; i < 512; i++) {
		unsigned short csum, csum2;

		this = buffers[i];
		csum = ip_fast_csum((const unsigned char *)this, 5);
		csum2 = reference_cksum((u16 *)this, 20);
		if(csum != csum2) {
			printf("buffer %d gets bogus csum %04x (ref=<%04x>)!\n",
			       i, csum, csum2);
			exit(1);
		}
		this->check = csum;
		if((csum = ip_fast_csum((const unsigned char *)this, 5))) {
			printf("verify_ip_fast_csum: buffer %d gets bogus csum %04x!\n",
			       i, csum);
			exit(1);
		}
		if((csum2 = reference_cksum((u16 *)this, 20))) {
			printf("verify_ip_fast_csum: buffer %d gets bogus csum2 %04x!\n",
			       i, csum2);
			exit(1);
		}
	}
	if(--iters > 0)
		goto again;
	printf("done\n");
	fflush(stdout);
	for(i = 0; i < 512; i++)
		free(buffers[i]);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in verify_ip_fast_csum!\n");
	exit(1);
}

static char compare_buffer[2048];

static void verify_csum_partial(void)
{
	int *sizes;
	struct iphdr **buffers;
	struct iphdr *this;
	int i, b, iters=512;
	u16 ctr=62;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * 512);
	sizes = (int *) malloc(sizeof(int) * 512);
	if(!buffers)
		goto outofmem;
	printf("verify_csum_partial");
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
again:
	for(i = 0; i < 512; i++) {
		int sz;

		sz = random() & 0x7ff;
		if(sz > 1500) sz=1500;
		if(sz < sizeof(struct iphdr)) sz=sizeof(struct iphdr);

		sizes[i] = sz;
		this = (struct iphdr *) malloc(sz);
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	putchar('.');
	fflush(stdout);
	for(i = 0; i < 512; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < sizes[i]; b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	for(i = 0; i < 512; i++) {
		u32 lcsum;
		unsigned short csum, csum2;

		this = buffers[i];
		lcsum = csum_partial(((const unsigned char *)this)+2, sizes[i], 0);
		csum2 = reference_cksum(((u16 *)this)+1, sizes[i]);
		csum = csum_fold(lcsum);
		if(csum != csum2) {
			u16 *ptr = (u16 *) this;

			printf("csum_partial: buffer %d gets bogus "
			       "csum %04x (ref=<%04x>)!\n",
			       i, csum, csum2);
			printf("csum_partial: buffer dump lngth=%d\n", sizes[i]);
			for(b = 0; b < sizes[i]/2; b++) {
				printf("[%04x]\n", ((u16 *)this)[b]);
			}
			printf("\n");
			exit(1);
		}

		this->check = csum;
		if((csum = csum_fold(csum_partial(((const unsigned char *)this)+2,
						  sizes[i], 0)))) {
			printf("verify_csum_partial: buffer %d gets bogus csum %04x!\n",
			       i, csum);
			exit(1);
		}
		if((csum2 = reference_cksum(((u16 *)this)+1, sizes[i]))) {
			printf("verify_csum_partial: buffer %d gets bogus csum2 %04x!\n",
			       i, csum2);
			exit(1);
		}
	}
	for(i=0; i<512; i++)
		free(buffers[i]);
	if(--iters > 0)
		goto again;
	printf("done\n");
	fflush(stdout);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in verify_csum_partial!\n");
	exit(1);
}

static void verify_csum_partial_cunaligned(void)
{
	int *sizes;
	struct iphdr **buffers;
	struct iphdr *this;
	int i, b, iters=512;
	u16 ctr=62;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * 512);
	sizes = (int *) malloc(sizeof(int) * 512);
	if(!buffers)
		goto outofmem;
	printf("verify_csum_partial");
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
again:
	for(i = 0; i < 512; i++) {
		int sz;

#if 0
		sz = random() & 0x7ff;
		if(sz > 1500) sz=1500;
		if(sz < sizeof(struct iphdr)) sz=sizeof(struct iphdr);
#else
		sz = 11;
#endif
		sizes[i] = sz;
		this = (struct iphdr *) malloc(sz);
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	putchar('.');
	fflush(stdout);
	for(i = 0; i < 512; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < sizes[i]; b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	for(i = 0; i < 512; i++) {
		u32 lcsum;
		unsigned short csum, csum2;

		this = buffers[i];
		lcsum = csum_partial_copy(((const unsigned char *)this) + 2,
					  compare_buffer, sizes[i], 0);
		csum2 = reference_cksum((((u16 *)this)+1), sizes[i]);
		csum = csum_fold(lcsum);
		if(csum != csum2) {
			u16 *ptr = (u16 *) this;

			printf("csum_partial: buffer %d gets bogus "
			       "csum %04x (ref=<%04x>)!\n",
			       i, csum, csum2);
			printf("csum_partial: buffer dump lngth=%d\n", sizes[i]);
			for(b = 0; b < sizes[i]/2; b++) {
				printf("[%04x]\n", ((u16 *)this)[b]);
			}
			printf("\n");
			exit(1);
		}
		this->check = csum;
		if((csum = csum_fold(csum_partial_copy(((const unsigned char *)this) + 2,
						  compare_buffer, sizes[i], 0)))) {
			printf("verify_csum_partial: buffer %d gets bogus csum %04x!\n",
			       i, csum);
			exit(1);
		}
		if((csum2 = reference_cksum((((u16 *)this)+1), sizes[i]))) {
			printf("verify_csum_partial: buffer %d gets bogus csum2 %04x!\n",
			       i, csum2);
			exit(1);
		}
	}
	for(i=0; i<512; i++)
		free(buffers[i]);
	if(--iters > 0)
		goto again;
	printf("done\n");
	fflush(stdout);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in verify_csum_partial!\n");
	exit(1);
}

static void verify_csum_partial_copy(void)
{
	int *sizes;
	struct iphdr **buffers;
	struct iphdr *this;
	char *dst = compare_buffer;
	int i, b, iters=512;
	u16 ctr=62;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * 512);
	sizes = (int *) malloc(sizeof(int) * 512);
	if(!buffers)
		goto outofmem;
	printf("verify_csum_partial_copy");
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
again:
	for(i = 0; i < 512; i++) {
		int sz;

		sz = random() & 0x7ff;
		if(sz > 1500) sz=1500;
		if(sz < sizeof(struct iphdr)) sz=sizeof(struct iphdr);
		sizes[i] = sz;
		this = (struct iphdr *) malloc(sz);
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	putchar('.');
	fflush(stdout);
	for(i = 0; i < 512; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < sizes[i]; b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	for(i = 0; i < 512; i++) {
		u32 lcsum;
		unsigned short csum, csum2;

		this = buffers[i];
		lcsum = csum_partial_copy((const unsigned char *)this, dst, sizes[i], 0);
		csum2 = reference_cksum((u16 *)this, sizes[i]);
		if(memcmp(this, dst, sizes[i])) {
			printf("csum_partial_copy: buffer %d mismatch after copy!\n", i);
		}
		csum = csum_fold(lcsum);
		if(csum != csum2) {
			u16 *ptr = (u16 *) this;

			printf("csum_partial_copy: buffer %d gets bogus "
			       "csum %04x (ref=<%04x>)!\n",
			       i, csum, csum2);
			printf("csum_partial_copy: buffer dump lngth=%d\n", sizes[i]);
#if 0
			for(b = 0; b < sizes[i]/2; b++) {
				printf("[%04x]\n", ((u16 *)this)[b]);
			}
			printf("\n");
#endif
			exit(1);
		}
		this->check = csum;
		if((csum = csum_fold(csum_partial_copy((const unsigned char *)this,
						       dst, sizes[i], 0)))) {
			printf("verify_csum_partial_copy: buffer %d gets bogus "
			       "csum %04x!\n",
			       i, csum);
			exit(1);
		}
		if((csum2 = reference_cksum((u16 *)this, sizes[i]))) {
			printf("verify_csum_partial_copy: buffer %d gets bogus "
			       "csum2 %04x!\n",
			       i, csum2);
			exit(1);
		}
	}
	for(i=0; i<512; i++)
		free(buffers[i]);
	if(--iters > 0)
		goto again;
	printf("done\n");
	fflush(stdout);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in verify_csum_partial_copy!\n");
	exit(1);
}

#define N 10000

static void measure_ip_fast_csum(void)
{
	struct iphdr **buffers;
	struct iphdr *this;
	int i, b, iters=512;
	int clock;
	u16 ctr=52;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * 512);
	if(!buffers)
		goto outofmem;
	for(i = 0; i < 512; i++) {
		this = (struct iphdr *) malloc((sizeof(struct iphdr)));
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
	printf("measure_ip_fast_csum...");
	fflush(stdout);
	for(i = 0; i < 512; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < (sizeof(struct iphdr)); b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	start();
	for(b = 0; b < N; b++) {
		for(i = 0; i < 512; i++) {
			this = buffers[i];
			ip_fast_csum((const unsigned char *)this, 5);
		}
	}
	clock = stop();
	printf("done\n");
	fflush(stdout);
	printf("ip_fast_csum: %d iterations takes %ld microseconds\n", N, clock);
	clock = clock/N;
	printf("ip_fast_csum: 1 iteration takes <%ld microseconds>==", clock);
	clock = (int)((double)(((double)clock) / ((double)512.00)) * (double)100.00);
	printf("<%ld nanoseconds>\n", clock);
	for(i = 0; i < 512; i++)
		free(buffers[i]);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in measure_ip_fast_csum!\n");
	exit(1);
}

#define NBUFS 256

static void measure_csum_partial(void)
{
	int *sizes;
	struct iphdr **buffers;
	struct iphdr *this;
	int i, b, iter;
	u16 ctr=62;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * NBUFS);
	sizes = (int *) malloc(sizeof(int) * NBUFS);
	if(!buffers)
		goto outofmem;
	printf("measure_csum_partial\n");
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
	for(i = 0; i < NBUFS; i++) {
		int sz;

		/* sz = (i + sizeof(struct iphdr)); */
		sz = ((i+1) * 1024);
		/* sz = ((i+32)); */
		sizes[i] = sz;
		this = (struct iphdr *) malloc(sz);
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	for(i = 0; i < NBUFS; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < sizes[i]; b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	for(b = 0; b < NBUFS; b++) {
		int clock, sz;
		const unsigned char *thing;

		sz = sizes[b];
		thing = (const unsigned char *) buffers[b];
		start();
		for(iter=0; iter < N; iter++) {
			for(i = 0; i < 512; i++) {
				csum_partial(thing, sz, 0);
			}
		}
		clock = stop();
		printf("csum_partial: sz[%d] %d iterations takes %ld microseconds\n",
		       sz, N, clock);
		clock = clock/N;
		printf("csum_partial: sz[%d] 1 iteration takes <%ld microseconds>==",
		       sz, clock);
		clock = (int)((double)(((double)clock) /
				       ((double)512.00)) * (double)100.00);
		printf("<%ld nanoseconds>\n", clock);
		fflush(stdout);
	}
	for(i=0; i<NBUFS; i++)
		free(buffers[i]);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in measure_csum_partial!\n");
	exit(1);
}

static void measure_csum_partial_copy(void)
{
	int *sizes;
	struct iphdr **buffers;
	struct iphdr *this;
	char *dst;
	int i, b, iter;
	int sz;
	u16 ctr=62;

	buffers = (struct iphdr **) malloc((sizeof(struct iphdr *)) * NBUFS);
	sizes = (int *) malloc(sizeof(int) * NBUFS);
	if(!buffers)
		goto outofmem;
	printf("measure_csum_partial_copy\n");
	gettimeofday(&random_seed, (struct timezone *) 0);
	srandom(random_seed.tv_usec);
	for(i = 0; i < NBUFS; i++) {
		/* sz = (i + sizeof(struct iphdr)); */
	        /* sz = ((i+1) * 0x80); */
		/* sz = ((i+32)); */
		sz = (1024 * 1024);
		sizes[i] = sz;
		this = (struct iphdr *) malloc(sz);
		if(!this)
			goto outofmem;
		buffers[i] = this;
	}
	dst = (char *) malloc(sz + 1024);
	for(i = 0; i < NBUFS; i++) {
		/* Fill with random bytes and zero csum field. */
		this = buffers[i];
		for(b = 0; b < sizes[i]; b++)
			((u8 *)this)[b] = (random() >> 14) & 0xff;
		this->check = 0;
	}
	for(b = 0; b < NBUFS; b++) {
		int clock, sz;
		const unsigned char *thing;

		sz = sizes[b];
		thing = (const unsigned char *) buffers[b];
		start();
		for(iter=0; iter < N; iter++) {
			for(i = 0; i < 512; i++) {
				csum_partial_copy(thing, dst, sz, 0);
			}
		}
		clock = stop();
		printf("csum_partial_copy: sz[%d] %d iterations takes %ld "
		       "microseconds\n",
		       sz, N, clock);
		clock = clock/N;
		printf("csum_partial_copy: sz[%d] 1 iteration takes <%ld "
		       "microseconds>==",
		       sz, clock);
		clock = (int)((double)(((double)clock) /
				       ((double)512.00)) * (double)100.00);
		printf("<%ld nanoseconds>\n", clock);
		fflush(stdout);
	}
	for(i=0; i<NBUFS; i++)
		free(buffers[i]);
	free(buffers);
	return;

outofmem:
	printf("Out of memory in measure_csum_partial_copy!\n");
	exit(1);
}

void main(int argc, char **argv)
{
	verify_csum_partial();
#if 0
	verify_csum_partial_copy();
	verify_csum_partial_cunaligned();
	verify_ip_fast_csum();
	measure_csum_partial();
	measure_csum_partial_copy();
	/* measure_ip_fast_csum(); */
#endif
	exit(0);
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
