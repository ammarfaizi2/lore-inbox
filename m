Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293186AbSCRWjA>; Mon, 18 Mar 2002 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSCRWit>; Mon, 18 Mar 2002 17:38:49 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:54280 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293164AbSCRWiX>;
	Mon, 18 Mar 2002 17:38:23 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 18 Mar 2002 15:36:37 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020318153637.J4783@host110.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.33.0203181146070.4783-100000@home.transmeta.com> <Pine.LNX.4.33.0203181213130.12950-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the modified for PPC version and the results.

The cycle timer in this case is about 16.6MHz.

# ./foo
  92.01: 1
   7.98: 2
# ./foo
   3.71: 0
  92.30: 1
   3.99: 2
# ./foo
  92.01: 1
   7.97: 2
# ./foo
  92.01: 1
   7.97: 2
# ./foo
   3.71: 0
  92.30: 1
   3.99: 2
# ./foo
   3.71: 0
  92.30: 1
   3.99: 2

#include <stdlib.h>

#if defined(__powerpc__)
#define rdtsc(low) \
   __asm__ __volatile__ ("mftb %0": "=r" (low))
#else
#define rdtsc(low) \
  __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
#endif

#define MAXTIMES 1000
#define BUFSIZE (128*1024*1024)
#define access(x) (*(volatile unsigned int *)&(x))

int main()
{
	unsigned int i, j;
	static int times[MAXTIMES];
	char *buffer = malloc(BUFSIZE);

	for (i = 0; i < BUFSIZE; i += 4096)
		access(buffer[i]);
	for (i = 0; i < MAXTIMES; i++)
		times[i] = 0;
	for (j = 0; j < 100; j++) {
		for (i = 0; i < BUFSIZE ; i+= 4096) {
			unsigned long start, end;

			rdtsc(start);
			access(buffer[i]);
			rdtsc(end);
			end -= start;
			if (end >= MAXTIMES)
				end = MAXTIMES-1;
			times[end]++;
		}
	}
	for (i = 0; i < MAXTIMES; i++) {
		int count = times[i];
		double percent = (double)count / (BUFSIZE/4096);
		if (percent < 1)
			continue;
		printf("%7.2f: %d\n", percent, i);
	}
	return v0;
}


} Btw, here's a program that does a simple histogram of TLB miss cost, and
} shows the interesting pattern on intel I was talking about: every 8th miss
} is most costly, apparently because Intel pre-fetches 8 TLB entries at a
} time.
} 
} So on a PII core, you'll see something like
} 
} 	  87.50: 36
} 	  12.39: 40
} 
} ie 87.5% (exactly 7/8) of the TLB misses take 36 cycles, while 12.4% (ie
} 1/8) takes 40 cycles (and I assuem that the extra 4 cycles is due to
} actually loading the thing from the data cache).
} 
} Yeah, my program might be buggy, so take the numbers with a pinch of salt.
} But it's interesting to see how on an athlon the numbers are
} 
} 	   3.17: 59
} 	  34.94: 62
} 	   4.71: 85
} 	  54.83: 88
} 
} ie roughly 60% take 85-90 cycles, and 40% take ~60 cycles. I don't know
} where that pattern would come from..
} 
} What are the ppc numbers like (after modifying the rdtsc implementation,
} of course)? I suspect you'll get a less clear distribution depending on
} whether the hash lookup ends up hitting in the primary or secondary hash,
} and where in the list it hits, but..
} 
} 			Linus
