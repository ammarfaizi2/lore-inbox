Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTE3Sas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTE3Sas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 14:30:48 -0400
Received: from [196.25.143.130] ([196.25.143.130]:13840 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id S263897AbTE3Saf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 14:30:35 -0400
Date: Fri, 30 May 2003 20:43:32 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: Joe Buck <jbuck@synopsys.com>
Cc: Kendrick Hamilton <hamilton@sedsystems.ca>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: Problem Installing Linux Kernel Module compiled with gcc-3.2.x
Message-ID: <20030530204332.C7564@prism.co.za>
References: <Pine.LNX.4.44.0305300919510.3613-100000@sw-55.sedsystems.ca> <20030530192240.A7564@prism.co.za> <20030530103329.A848@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20030530103329.A848@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 10:33:29AM -0700, Joe Buck wrote:
> On Fri, May 30, 2003 at 07:22:40PM +0200, Bernd Jendrissek wrote:
> 
> > If you look at linux/include/linux/spinlock.h, you'll see:
> > 
> > /*
> >  * Your basic spinlocks, allowing only a single CPU anywhere
> >  *
> >  * Most gcc versions have a nasty bug with empty initializers.
> >  */
> > #if (__GNUC__ > 2)
> >   typedef struct { } spinlock_t;
> >   #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
> > #else
> >   typedef struct { int gcc_is_buggy; } spinlock_t;
> >   #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
> > #endif
> 
> Yuk!  What is the benefit of introducing this incompatibility?  #ifdefs
> are harmful to maintainance, and it's only one word, so why not always
> put in the dummy struct member?

I dont speak for the kernel people, but...

I suppose some people just insist on squeezing every last cycle out of
their machines.  For my home PC (a 486 with 5MB RAM running linux 2.0.30),
I am quite grateful for such cycle and bit saving.  Believe me, I notice
whether I have apache running or not. :)

Hmm, yes, it does seem to be just one word.  grep -r spinlock_t . |wc -l
says 1013 here, that's across *all* architectures.  IOW 4052 bytes - that's
*one page* - on i386!

Never mind what definition tcc will give to __GNUC__

So there I thought I was going to justify the kernel.  Instead I mostly
agree with Joe!  I'm also sure there have been flamewars about this...

> > Hmm, actually I thought the kernel had a mechanism to prevent a GCC 3.x
> > module from being loaded into a GCC 2.x kernel and vice versa?
> 
> Is there any reason, other than the above-described bit of evil, for doing
> this (forbidding mixing)?  It prevents the bug-finding approach I
> described earlier (a binary search for finding miscompiled code) from
> working.

Between GCC 2.x and 3.x the *major* version changed (duh).  I would
imagine that people are/were (justifiably?) concerned that ABI's might
have changed.  From your response, I assume there are no ABI changes
for C at least?  I suppose a gratuitous ABI change would constitute a
bug, though...

BTW I said "I thought" - it appears there is in fact no such mechanism.

Okay, so here's a PR (Public Relations, not Problem Report) patch just
for you, Joe:     <with a fistful of smileys :)>

(It also gets rid of some of that crazy 2-space indentation.)

diff -u linux/include/linux/spinlock.h.borig linux/include/linux/spinlock.h
--- linux/include/linux/spinlock.h.borig        Tue May 13 17:05:57 2003
+++ linux/include/linux/spinlock.h      Fri May 30 20:29:42 2003
@@ -53,13 +53,8 @@
  *
  * Most gcc versions have a nasty bug with empty initializers.
  */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#endif
+typedef struct { int gcc_was_buggy; } spinlock_t;
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 
 #define spin_lock_init(lock)   do { } while(0)
 #define spin_lock(lock)                (void)(lock) /* Not "unused variable". */
