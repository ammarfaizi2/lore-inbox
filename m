Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWB1Q5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWB1Q5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWB1Q5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:57:30 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:677 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751809AbWB1Q5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:57:30 -0500
Message-Id: <200602281657.k1SGvKFk026965@laptop11.inf.utfsm.cl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] allow hard links to directories, opt-in for any filesystem 
In-Reply-To: Message from Nick Piggin <nickpiggin@yahoo.com.au> 
   of "Tue, 28 Feb 2006 22:52:19 +1100." <44043973.4070202@yahoo.com.au> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 28 Feb 2006 13:57:20 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 28 Feb 2006 13:57:20 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Joshua Hudson wrote:
> > Patch seems to work, might want more testing.
> > It probably should not be applied without a discussion, especially
> > as no filesystem in kernel tree wants this. I am working on a fs that does.

> This is backwards I think. This is not disallowed because there are
> no filesystems that want it. Linux doesn't want it so it is disallowed
> by the vfs.

Right.

> You have to put forward a case for why we want it, rather than show us
> your filesystem that "wants" it. Right?

Nope. The "why a FS might want it" part is pretty clear (we do have
symlinks to directories as a poor man's substitute, after all), the "why it
can't be allowed" part is the tricky one...

- It creates the possibility of loops ==> The garbage collection of unused
  stuff can't be done just by reference counts (as today), and gets very
  hairy... and needs a /lot/ of memory.
- Loop detection/breaking in a general graph /can't/ be done while it is
  being updated, and they thake a long time (and lots of memory)
- Can't just assume that by locking in the directory/subdirectory/... order
  no deadlocks are possible, and traversing the filesystem for surgery gets
  to be one operation at a time, not concurrent as today
- A while back (in one of the recurrent ReiserFS flamewars Re: Files as
  directories, which creates exactly the same situation when linking to a
  file-is-a-directory) somebody (Linus? Ted T'so?) showed that certain
  simple operations would potentially require exponential time or memory (I
  forget which), and thus the idea was out of the question.

Sure, the situations that give rise to the problems are rather clear-cut,
and could be disallowed, but the result for the user would have seemingly
random restrictions. IMVHO it is much better to have a restricted system
with a simple conceptual model than a more relaxed one, but with hard to
understand corner cases it doesn't allow.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
