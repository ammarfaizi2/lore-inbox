Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSBIASt>; Fri, 8 Feb 2002 19:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBIASd>; Fri, 8 Feb 2002 19:18:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39131 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287882AbSBIASR>;
	Fri, 8 Feb 2002 19:18:17 -0500
Date: Fri, 8 Feb 2002 19:18:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Robert Love <rml@tech9.net>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        mingo@elte.hu, haveblue@us.ibm.com
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <1013196987.805.153.camel@phantasy>
Message-ID: <Pine.GSO.4.21.0202081859370.28514-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Feb 2002, Robert Love wrote:

> On Fri, 2002-02-08 at 14:21, Alexander Viro wrote:
> 
> > Had anyone actually seen lseek() vs. lseek() contention prior to the
> > switch to ->i_sem-based variant?
> 
> Yes, I did, even on my 2-way.
> 
> Additionally, when I posted the remove-bkl-llseek patch, someone from
> SGI noted that on a 24-processor NUMA IA-64 machine, _50%_ of machine
> time was spent spinning on the BKL in llseek-intense operations.

That doesn't say _anything_ about the source of contention.
 
> The bkl is not held for a long time, but it is acquired often, and there
> are definitely workloads that show a big hit with the BKL in there.

Sigh...  OK, here's an exercise:

You have a spinlock and two functions - hog() and light().  Both grab that
spinlock.  light() releases it and returns fast.  hog() spends quite a
while in critical area and then releases the lock.

a) show that if lock gets contended then most of the time it will be
held by hog()

b) show that time spent spinning in light() depends mostly on the amount
of time spent in hog()

c) replace light() with light1(), ..., lightN().  Compare the effect
of removing lock from one of them with that of removing it from hog().

d) characterize the dependence of light()/light() contention upon the
amount of time spent in hog().  (hint: attempts to call light()
while hog() is running will lead to accumulation of contenders and when
hog() is done they _will_ figth each other).

General rules:
	* go for hogs first, don't try to pick the light ones.
	* one spinning most is not necessary the cause of contention.
	* even when you see real light/light contention - check the
history immediately before; you may find the hog that had had held them
back.

