Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUEUHjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUEUHjz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUEUHjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:39:55 -0400
Received: from lakemtai06.cox.net ([68.1.17.126]:3481 "EHLO lakemtai06.cox.net")
	by vger.kernel.org with ESMTP id S265398AbUEUHjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:39:53 -0400
Mime-Version: 1.0 (Apple Message framework v613)
In-Reply-To: <5A97B381-AAA2-11D8-BDC1-000393ACC76E@mac.com>
References: <5A97B381-AAA2-11D8-BDC1-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8307265D-AABC-11D8-BDC1-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6] Missing _raw_write_trylock for PPC/SMP
Date: Thu, 20 May 2004 20:19:23 -0400
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 20, 2004, at 17:12, Kyle Moffett wrote:
> The PPC/32 architecture is missing the SMP definition of the 
> _raw_write_trylock
> function.  I'm not strong enough on PowerPC assembly but it would be 
> nice if
> someone could write up an implementation for 
> linux/include/asm-ppc/spinlock.h

I found the time to brush up on my assembly a little, and using the 
PPC/32 and
PPC/64 implementations of _raw_write_lock and the PPC/64 implementation
of _raw_write_trylock for reference I hacked together a patch.  There 
are
probably bugs in it as I'm still a little rusty, so it needs someone 
skilled in PPC
assembly to review it, but hopefully it will work.  I'll try compiling 
it into my
kernel tomorrow to see if it works. (I won't have access to the machine 
in
question untill then, sorry).

Cheers,
Kyle Moffett


--- a/include/asm-ppc/spinlock.h	2004-05-09 22:32:28.000000000 -0400
+++ linux/include/asm-ppc/spinlock.h	2004-05-20 20:12:44.000000000 -0400
@@ -135,6 +135,28 @@
  	: "cr0", "memory");
  }

+static __inline__ int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int tmp;
+	unsigned int ret;
+	
+	__asm__ __volatile__(
+"1:     lwarx           %0,0,%2         # write_trylock\n\
+	cmpwi           0,%0,0\n\
+	li              %1,0\n\
+	bne-            2f\n"
+	PPC405_ERR77(0,%1)
+"       stwcx.          %3,0,%2\n\
+	bne-            1b\n\
+	li              %1,1\n\
+	isync\n\
+2:"     : "=&r"(tmp), "=&r"(ret)
+	: "r"(&rw->lock), "r"(-1)
+	: "cr0", "memory");
+	
+	return ret;
+}
+
  static __inline__ void _raw_write_lock(rwlock_t *rw)
  {
  	unsigned int tmp;

