Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133014AbRDKXDj>; Wed, 11 Apr 2001 19:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133024AbRDKXDa>; Wed, 11 Apr 2001 19:03:30 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:48139 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S133014AbRDKXDQ>;
	Wed, 11 Apr 2001 19:03:16 -0400
Date: Wed, 11 Apr 2001 16:00:43 -0700
From: Anton Blanchard <anton@samba.org>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3rd try: i386 rw_semaphores fix
Message-ID: <20010411160043.A4304@va.samba.org>
In-Reply-To: <16590.986993861@warthog.cambridge.redhat.com> <17213.987007030@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17213.987007030@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Wed, Apr 11, 2001 at 05:37:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Here's the RW semaphore patch #3. This time with more asm constraints added.

Personally I care about sparc and ppc64 and as such would like to see the
slow paths end up in lib/rwsem.c protected by #ifndef __HAVE_ARCH_RWSEM
or something like that. If we couldn't get rwsems to work on x86, what
hope have we on other archs? :)

I have a few questions:

In arch/i386/kernel/semaphore.c:

static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
static inline __u16 rwsem_cmpxchgw(struct rw_semaphore *sem, __u16 old, __u16 new)

Can these end up in include/asm/rwsem*? The rest could then go into
lib/rwsem.c.

/* try to grab an 'activity' marker
 * - need to make sure two copies of rwsem_wake() don't do this for two separate processes
 *   simultaneously
 * - be horribly naughty, and only deal with the LSW of the atomic counter
 */
	if (rwsem_cmpxchgw(sem,0,RWSEM_ACTIVE_BIAS)!=0)

Many archs dont have cmpxchg on 16 bit quantities. We can implement it
but it will be extra instructions. Anyway on 64 bit archs, count will be 
64 bit so we will have two 32 bit quantities to cmpxchg on.

Now that I look at it, can you just do a cmpxchg on the complete sem->count
and retry if it failed because the high order bits have changed?

Anton
