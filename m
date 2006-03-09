Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWCIIGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWCIIGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 03:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWCIIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 03:06:14 -0500
Received: from ns1.siteground.net ([207.218.208.2]:14830 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750786AbWCIIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 03:06:13 -0500
Date: Thu, 9 Mar 2006 00:06:51 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org, Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060309080651.GA3599@localhost.localdomain>
References: <20060307181301.4dd6aa96.akpm@osdl.org> <20060308202656.GA4493@localhost.localdomain> <20060308203642.GZ5410@kvack.org> <20060308210726.GD4493@localhost.localdomain> <20060308211733.GA5410@kvack.org> <20060308222528.GE4493@localhost.localdomain> <20060308224140.GC5410@kvack.org> <20060308154321.0e779111.akpm@osdl.org> <20060309001803.GF4493@localhost.localdomain> <20060308163258.36f3bd79.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308163258.36f3bd79.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:32:58PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > On Wed, Mar 08, 2006 at 03:43:21PM -0800, Andrew Morton wrote:
> > > Benjamin LaHaise <bcrl@kvack.org> wrote:
> > > >
> > > > I think it may make more sense to simply convert local_t into a long, given 
> > > > that most of the users will be things like stats counters.
> > > > 
> > > 
> > > Yes, I agree that making local_t signed would be better.  It's consistent
> > > with atomic_t, atomic64_t and atomic_long_t and it's a bit more flexible.
> > > 
> > > Perhaps.  A lot of applications would just be upcounters for statistics,
> > > where unsigned is desired.  But I think the consistency argument wins out.
> > 
> > It already is... for most of the arches except x86_64.
> 
> x86 uses unsigned long.

Here's a patch making x86_64 local_t to 64 bits like other 64 bit arches.
This keeps local_t unsigned long.  (We can change it to signed value 
along with other arches later in one go I guess) 

Thanks,
Kiran


Change x86_64 local_t to 64 bits like all other arches.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.16-rc5mm3/include/asm-x86_64/local.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/asm-x86_64/local.h	2006-03-08 16:51:31.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/asm-x86_64/local.h	2006-03-08 21:56:01.000000000 -0800
@@ -5,18 +5,18 @@
 
 typedef struct
 {
-	volatile unsigned int counter;
+	volatile long counter;
 } local_t;
 
 #define LOCAL_INIT(i)	{ (i) }
 
-#define local_read(v)	((v)->counter)
+#define local_read(v)	((unsigned long)(v)->counter)
 #define local_set(v,i)	(((v)->counter) = (i))
 
 static __inline__ void local_inc(local_t *v)
 {
 	__asm__ __volatile__(
-		"incl %0"
+		"incq %0"
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
@@ -24,7 +24,7 @@ static __inline__ void local_inc(local_t
 static __inline__ void local_dec(local_t *v)
 {
 	__asm__ __volatile__(
-		"decl %0"
+		"decq %0"
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
@@ -32,7 +32,7 @@ static __inline__ void local_dec(local_t
 static __inline__ void local_add(unsigned int i, local_t *v)
 {
 	__asm__ __volatile__(
-		"addl %1,%0"
+		"addq %1,%0"
 		:"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
@@ -40,7 +40,7 @@ static __inline__ void local_add(unsigne
 static __inline__ void local_sub(unsigned int i, local_t *v)
 {
 	__asm__ __volatile__(
-		"subl %1,%0"
+		"subq %1,%0"
 		:"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
@@ -71,4 +71,4 @@ static __inline__ void local_sub(unsigne
 #define __cpu_local_add(i, v)	cpu_local_add((i), (v))
 #define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
 
-#endif /* _ARCH_I386_LOCAL_H */
+#endif /* _ARCH_X8664_LOCAL_H */
