Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUGHWQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUGHWQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUGHWQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:16:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57086 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265082AbUGHWQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:16:45 -0400
Date: Fri, 9 Jul 2004 00:16:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] Re: GCC 3.4 and broken inlining.
Message-ID: <20040708221635.GK28324@fs.tum.de>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de> <20040708210925.GA13908@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708210925.GA13908@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 11:09:26PM +0200, Arjan van de Ven wrote:
> On Thu, Jul 08, 2004 at 10:52:25PM +0200, Adrian Bunk wrote:
> > > marked as inline, but there are still cases when it decides not to inline
> > > for various reasons.  E.g. in C++ world, lots of things are inline, yet
> > > honoring that everywhere would mean very inefficient huge programs.
> > > If a function relies for correctness on being inlined, then it should use
> > > inline __attribute__((always_inline)).
> > 
> > include/linux/compiler-gcc3.h says:
> > 
> > <--  snip  -->
> > 
> > #if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
> > # define inline         __inline__ __attribute__((always_inline))
> > # define __inline__     __inline__ __attribute__((always_inline))
> > # define __inline       __inline__ __attribute__((always_inline))
> > #endif
> > 
> > <--  snip  -->
> > 
> > 
> > @Arjan:
> > This was added as part of your
> >   [PATCH] ia32: 4Kb stacks (and irqstacks) patch
> > What's the recommended solution for Nigel's problem?
> 
> the problem I've seen is that when gcc doesn't honor normal inline, it will
> often error out if you always inline....
> I'm open to removing the < 4 but as jakub said, 3.4 is quit good at honoring
> normal inline, and when it doesn't there often is a strong reason.....


I'm suggesting the following patch to remove the < 4 :


#define inline as __attribute__((always_inline)) also for gcc >= 3.4

Rationale:
- if gcc 3.4 can't inline a function marked as "inline" that's a
  strong hint that further investigation is required
- I strongly prefer a compile error over a potential runtime problem


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/include/linux/compiler-gcc3.h.old	2004-07-08 23:40:27.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/include/linux/compiler-gcc3.h	2004-07-08 23:40:37.000000000 +0200
@@ -3,7 +3,7 @@
 /* These definitions are for GCC v3.x.  */
 #include <linux/compiler-gcc.h>
 
-#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
+#if __GNUC_MINOR__ >= 1
 # define inline		__inline__ __attribute__((always_inline))
 # define __inline__	__inline__ __attribute__((always_inline))
 # define __inline	__inline__ __attribute__((always_inline))

