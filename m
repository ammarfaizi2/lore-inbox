Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSHPWwF>; Fri, 16 Aug 2002 18:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSHPWwF>; Fri, 16 Aug 2002 18:52:05 -0400
Received: from 12-230-33-102.client.attbi.com ([12.230.33.102]:22780 "EHLO
	fury.localdomain") by vger.kernel.org with ESMTP id <S317616AbSHPWwE>;
	Fri, 16 Aug 2002 18:52:04 -0400
Date: Fri, 16 Aug 2002 15:51:07 -0700 (PDT)
From: Pollei <sjp@toolbuilders.com>
To: linux-kernel@vger.kernel.org
Subject: lighter weight barriers was ([patch 4/21] fix ARCH_HAS_PREFETCH)
In-Reply-To: <200208162239.PAA21541@fury.localdomain>
Message-ID: <Pine.LNX.4.21.0208161545020.21569-100000@fury.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Willy Tarreau wrote:

> On Wed, Aug 14, 2002 at 02:41:24PM -0700, Pollei wrote:
> > How about:
> > 
> > #define fake_read(fake_var) __asm__ __volatile__ ("" : : "X" (fake_var) )
> > #define fake_write(fake_var) __asm__ __volatile__ ("" : "=X" (fake_var) : )
> 
> Interestingly, it's what I wanted to do, but I always have difficulties
> with asm arguments, so I did not know how to write it.
> 
> thanks,
> Willy
> 

actually the following based loosely on what is in asm-foo/system.h and
linux/kernel.h might closer to being more generally usefull:

/* make sure a value actually gets computed runtime and doesn't get
   optimized away via use of very light weight barriers.
   make the compiler forget what it knows about the values basicly.
   not guaranteed to hit memory though.
 */
#define lite_barrier_var(fake_var) __asm__ ("" :  "+X" (fake_var):  "0" (fake_var) )
#define lite_wbarrier_var(fake_var) __asm__ ("" : : "X" (fake_var) )
#define lite_rbarrier_var(fake_var) __asm__ ("" : "+X" (fake_var) )

/* try and make sure value gets read and/or written to memory right now.
   other cpu might not see changes or see them out of order.
 */
#define barrier_var(fake_var) __asm__ __volatile__ ("" :  "+m" (fake_var):  "0" (fake_var) )
#define wbarrier_var(fake_var) __asm__ __volatile__ ("" : : "m" (fake_var) )
#define rbarrier_var(fake_var) __asm__ __volatile__ ("" : "+m" (fake_var) )

/* stronger memory barriers for variable needs cpu specific asm
   (lock sfence mfence lfence)
 */
#if 0 /* too lazy to finish */
#define mb_var(fake_var) __asm__ __volatile__ ("lock; addl $0,%0" : : : "m" (fake_var) )
#define rmb_var(fake_var) __asm__ __volatile__ ("lock; addl $0,0(%%esp)" : : "m" (fake_var) )
#if CONFIG_OOSTORE
#define wmb_var(fake_var) __asm__ __volatile__ ("lock; addl $0,0(%%esp)" : "=m" (fake_var) )
#else
#define wmb_var(fake_var) __asm__ __volatile__ ("" : "=m" (fake_var) )
#endif
#endif

int
main(void)
{
  {
  int i;
  for (i=0;i<100;i++)
   lite_wbarrier_var(i);
  }

  {
  int i;
  i=2;
  lite_wbarrier_var(i);
  i+=5;
  lite_wbarrier_var(i);
  }

  {
  int i;
  i=4;
  lite_barrier_var(i);
  i+=9;
  lite_wbarrier_var(i);
  }

  return 0;
}


need to try it out on different versions of gcc.
Right now I know older version of gcc doesn't see much difference in
lite_?barrier and ?barrier and will force the use of the stack when
without it will just use register. If done right in theory one could get
away with not useing the volatile keyword in declspecs and in some places
in the kernel replace some of the stronger blow everything away barriers
with lighter weight variants. Replacing the heavier variants with light
might not pay off though because most places would be looping on one
thing, or used in spinlocks where you need stronger invalidation of old
information. anyway just something I played around with a little.


