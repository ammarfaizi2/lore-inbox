Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752171AbWJNTuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbWJNTuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 15:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWJNTuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 15:50:19 -0400
Received: from 1wt.eu ([62.212.114.60]:38660 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1752171AbWJNTuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 15:50:17 -0400
Date: Sat, 14 Oct 2006 21:50:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.4.x: i386/x86_64 bitops clobberings
Message-ID: <20061014195005.GA2900@1wt.eu>
References: <452970AF.8020605@web.de> <20061008224440.GA30172@1wt.eu> <45298184.1050006@web.de> <20061008233617.GA30255@1wt.eu> <4529EBEA.4070602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4529EBEA.4070602@web.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, Oct 09, 2006 at 08:27:54AM +0200, Jan Kiszka wrote:
> Willy Tarreau wrote:
> > I've done it too, but unfortunately, I discovered that it does not build
> > with gcc-2.95 anymore, while 3.3 is fine :
> > 
> > cyclades.c: In function `cyy_interrupt':
> > /usr/src/git/linux-2.4/include/asm/bitops.h:130: inconsistent operand constraints in an `asm'
> > cyclades.c: In function `cyz_handle_rx':
> > /usr/src/git/linux-2.4/include/asm/bitops.h:130: inconsistent operand constraints in an `asm'
> > 
> > 127        __asm__ __volatile__( LOCK_PREFIX
> > 128                "btsl %2,%1\n\tsbbl %0,%0"
> > 129                :"=r" (oldbit),"+m" (ADDR)
> > 130                :"Ir" (nr) : "memory");
> > 
> > 
> > I don't know what the right solution should be. I'm not fond of #ifdefs,
> > and I'm embarrassed to know that gcc can do all sorts of nasty things due
> > to a wrong clobbering :-/
> > 
> > If you have any idea on the subject, I'm willing to try.
> 
> What about
> 
> #if __GNUC__ < 3
> #define ADDR_DEPS "=m"
> #else
> #define ADDR_DEPS "+m"
> #endif
> 
> 	__asm__ __volatile__( LOCK_PREFIX
> 		"btsl %2,%1\n\tsbbl %0,%0"
> 		:"=r" (oldbit),ADDR_DEPS (ADDR)
> 		:"Ir" (nr) : "memory");
> 
> or something similar? Would keep the number of #ifs low.

I don't like it for two reasons :

  - I don't know how gcc-3.0 to 3.2 behave on such code, so may be this
    would implicitly categorize them in the wrong group

  - it makes the asm code very hard to read. Operand dependencies are
    very sensible tricks which need to be extremely clear.

I have searched the archives for previous occurrences of this recurring
problem, and found another alternative which is said to work on all gcc
versions. So here's the patch for both x86 and x86_64. I checked that it
produces identical code as I obtain with the patch from 2.6. It also
fixes your testcase for gcc-2.95 to 4.1.1.

Could you please give it a try ?

Andi, Linus, I'd be very interested in your comments on this patch, since
you're more used to deal with this problem than me.

Thanks in advance,
Willy

>From 695f7e0b3806ff44def385856cda60d7f1c2df1c Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sat, 14 Oct 2006 21:39:06 +0200
Subject: [PATCH] 2.4.x: i386/x86_64 bitops clobberings

Problem reported by Jan Kiszka <jan.kiszka@web.de> :
 "After going through debugging hell with some out-of-tree code,
  I realised that this patch :

  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=92934bcbf96bc9dc931c40ca5f1a57685b7b813b

  makes a difference: current 2.6 works with the following code
  sequence as expected (printk is executed), 2.4 fails. I used
  gcc 3.3.6-13 (Debian).

  unsigned long a = 1;

  int module_init(void)
  {
        unsigned long b = 0;
        int x;

        x = __test_and_set_bit(0, &b);
        if (__test_and_set_bit(0, &a))
                printk("x = %d\n", x);

        return -1;
  }

  I ported the x86 part back to 2.4.33 and my problem disappeared. "

The problem with this patch is that the use of "+m" in asm statements
triggers bugs in gcc 2.95 which is supported by kernel 2.4. For
instance, cyclades.c does not build anymore :

$ gcc -O2 -pipe -c cyclades-c.c
cyclades.c: In function `cyy_interrupt':
/usr/src/git/linux-2.4/include/asm/bitops.h:134: inconsistent operand constraints in an `asm'
cyclades.c: In function `cyz_handle_rx':
/usr/src/git/linux-2.4/include/asm/bitops.h:134: inconsistent operand constraints in an `asm'

As explained by Richard Henderson here, the equivalent construct
"=m"(x) : "m"(x) works on any version of gcc :

  http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107475162200773&w=3D2

I successfully verified on the example code above and on cyclades.c
that the exact same code is produced on x86 with this construct with
gcc 2.95.3, 3.3.6, 3.4.4, and 4.1.1, so it looks fine.

Just like in the former patch for 2.6, this one was applied to both
i386 and x86_64.

Signed-Off-By: Willy Tarreau <w@1wt.eu>
---
 include/asm-i386/bitops.h   |   22 +++++++++++-----------
 include/asm-x86_64/bitops.h |   22 +++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/asm-i386/bitops.h b/include/asm-i386/bitops.h
index 9b6b55e..bb63c10 100644
--- a/include/asm-i386/bitops.h
+++ b/include/asm-i386/bitops.h
@@ -38,7 +38,7 @@ static __inline__ void set_bit(int nr, v
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %1,%0"
 		:"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 }
 
 /**
@@ -55,7 +55,7 @@ static __inline__ void __set_bit(int nr,
 	__asm__(
 		"btsl %1,%0"
 		:"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 }
 
 /**
@@ -73,7 +73,7 @@ static __inline__ void clear_bit(int nr,
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %1,%0"
 		:"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 }
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
@@ -92,7 +92,7 @@ static __inline__ void __change_bit(int 
 	__asm__ __volatile__(
 		"btcl %1,%0"
 		:"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 }
 
 /**
@@ -109,7 +109,7 @@ static __inline__ void change_bit(int nr
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %1,%0"
 		:"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 }
 
 /**
@@ -127,7 +127,7 @@ static __inline__ int test_and_set_bit(i
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
@@ -147,7 +147,7 @@ static __inline__ int __test_and_set_bit
 	__asm__(
 		"btsl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 	return oldbit;
 }
 
@@ -166,7 +166,7 @@ static __inline__ int test_and_clear_bit
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
@@ -186,7 +186,7 @@ static __inline__ int __test_and_clear_b
 	__asm__(
 		"btrl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"Ir" (nr));
+		:"Ir" (nr), "m" (ADDR));
 	return oldbit;
 }
 
@@ -198,7 +198,7 @@ static __inline__ int __test_and_change_
 	__asm__ __volatile__(
 		"btcl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
@@ -217,7 +217,7 @@ static __inline__ int test_and_change_bi
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"Ir" (nr) : "memory");
+		:"Ir" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
diff --git a/include/asm-x86_64/bitops.h b/include/asm-x86_64/bitops.h
index c8a4749..f6a2a4f 100644
--- a/include/asm-x86_64/bitops.h
+++ b/include/asm-x86_64/bitops.h
@@ -38,7 +38,7 @@ static __inline__ void set_bit(long nr, 
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsq %1,%0"
 		:"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 }
 
 /**
@@ -55,7 +55,7 @@ static __inline__ void __set_bit(long nr
 	__asm__(
 		"btsq %1,%0"
 		:"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 }
 
 /**
@@ -73,7 +73,7 @@ static __inline__ void clear_bit(long nr
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrq %1,%0"
 		:"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 }
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
@@ -92,7 +92,7 @@ static __inline__ void __change_bit(long
 	__asm__ __volatile__(
 		"btcq %1,%0"
 		:"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 }
 
 /**
@@ -109,7 +109,7 @@ static __inline__ void change_bit(long n
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcq %1,%0"
 		:"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 }
 
 /**
@@ -127,7 +127,7 @@ static __inline__ int test_and_set_bit(l
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsq %2,%1\n\tsbbq %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"dIr" (nr) : "memory");
+		:"dIr" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
@@ -147,7 +147,7 @@ static __inline__ int __test_and_set_bit
 	__asm__(
 		"btsq %2,%1\n\tsbbq %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 	return oldbit;
 }
 
@@ -166,7 +166,7 @@ static __inline__ int test_and_clear_bit
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrq %2,%1\n\tsbbq %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"dIr" (nr) : "memory");
+		:"dIr" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
@@ -186,7 +186,7 @@ static __inline__ int __test_and_clear_b
 	__asm__(
 		"btrq %2,%1\n\tsbbq %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"dIr" (nr));
+		:"dIr" (nr), "m" (ADDR));
 	return oldbit;
 }
 
@@ -198,7 +198,7 @@ static __inline__ int __test_and_change_
 	__asm__ __volatile__(
 		"btcq %2,%1\n\tsbbq %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"dIr" (nr) : "memory");
+		:"dIr" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
@@ -217,7 +217,7 @@ static __inline__ int test_and_change_bi
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcq %2,%1\n\tsbbq %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
-		:"dIr" (nr) : "memory");
+		:"dIr" (nr), "m" (ADDR) : "memory");
 	return oldbit;
 }
 
-- 
1.4.1

