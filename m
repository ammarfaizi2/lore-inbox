Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSFRU1j>; Tue, 18 Jun 2002 16:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSFRU1i>; Tue, 18 Jun 2002 16:27:38 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:9236 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317604AbSFRU1h>; Tue, 18 Jun 2002 16:27:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-reply-to: Your message of "Tue, 18 Jun 2002 13:05:51 MST."
             <Pine.LNX.4.44.0206181302300.872-100000@home.transmeta.com> 
Date: Wed, 19 Jun 2002 06:31:46 +1000
Message-Id: <E17KPdj-0004EP-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206181302300.872-100000@home.transmeta.com> you writ
e:
> On Wed, 19 Jun 2002, Rusty Russell wrote:
> >
> > NO.  They want to be node-affine.  They don't want to specify what
> > CPUs they attach to.
> 
> So you're going to have separate interfaces for that? Gag me with a volvo,
> but that's idiotic.

No, you have accepted a non-portable userspace interface and put it in
generic code.  THAT is idiotic.

So any program that doesn't use the following is broken:

	#include <limits.h>

	#define BITS_PER_LONG (sizeof(long)*CHAR_BIT)

	int set_cpu(int cpu)
	{
		size_t size = sizeof(unsigned long);
		unsigned long *bitmask = NULL;
		int ret;

		do {
			size *= 2;
			bitmask = realloc(bitmask, size);
			memset(bitmask, 0, size);
			bitmask[cpu / BITS_PER_LONG] = (1 << (cpu % BITS_PER_LONG);
			ret = sched_setaffinity(getpid(), size, bitmask);
		} while (ret < 0 && errno = -EINVAL);

		return ret;
	}

> Besides, even that would be broken. You want bitmaps, because bitmaps is
> really what it is all about. It's NOT about "I must run on this CPU", it
> can equally well be "I mustn't run on those two CPU's that are hosting the
> RT part of this thing" or something like that.

Just bind to a cpu != those two CPUs.  I could come up with contrived
examples too, but I'm trying to save userspace programmers and those
who have to port to new architectures.

If you don't know how to do it well, do it simply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
