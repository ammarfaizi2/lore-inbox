Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVKXQDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVKXQDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 11:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVKXQDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 11:03:19 -0500
Received: from waste.org ([64.81.244.121]:27610 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750705AbVKXQDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 11:03:18 -0500
Date: Thu, 24 Nov 2005 08:00:12 -0800
From: Matt Mackall <mpm@selenic.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Russell King <rmk@arm.linux.org.uk>, akpm@osdl.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: + shut-up-warnings-in-ipc-shmc.patch added to -mm tree
Message-ID: <20051124160012.GQ31287@waste.org>
References: <200511230413.jAN4DboR013036@shell0.pdx.osdl.net> <Pine.LNX.4.61.0511241235450.3504@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511241235450.3504@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[thanks for the cc]

On Thu, Nov 24, 2005 at 12:47:15PM +0000, Hugh Dickins wrote:
> On Tue, 22 Nov 2005 akpm@osdl.org wrote:
> > 
> > The patch titled
> > 
> >      Shut up warnings in ipc/shm.c
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      shut-up-warnings-in-ipc-shmc.patch
> > 
> > 
> > From: Russell King <rmk@arm.linux.org.uk>
> > 
> > Fix two warnings in ipc/shm.c
> > 
> > ipc/shm.c:122: warning: statement with no effect
> > ipc/shm.c:560: warning: statement with no effect
> > 
> > by converting the macros to empty inline functions.  For safety, let's do
> > all three.  This also has the advantage that typechecking gets performed
> > even without CONFIG_SHMEM enabled.
> 
> Sorry to be a nuisance, but I'm a little resistant to this patch.
> Which version(s) of the compiler gives that warning?
> Aren't there 5000 other such stub #defines which should also be changed?
> Or is the problem the rather complex "({0;})" - should that be "0"?
> It seems such clutter to use 6 lines of inline function for each of these.
> Nice try, but I don't buy the typechecking advantage in this case!

Unfortunately Russell didn't tell us which function caused the error
and I can't seem to find a tree that matches his line numbering.
But it looks like it's shm_unlock.

The current ({0;}) seems wrong to me. I'd expect that expression to be
void. Hmm, looks like I'm wrong. It's quite ugly, not to mention confusing.

Andrew introduced it in a patch called "[PATCH] Fix shmem.c
stubs" that did this:

-#define shmem_lock(a, b) /* always in memory, no need to lock */
+#define shmem_lock(a, b, c) ({0;}) /* always in memory, no need to lock */

(shmem_lock changed from void to int a few days before this with
"rlimit-based mlocks for unprivileged users")

I didn't get compile warnings when I introduced tiny-shmem in 2004
(or, for that matter, when I wrote it in 2003) but I do seem to be
getting them now with gcc 4 -W.

So apparently gcc has gotten more picky about such things.

If we're going to start converting such things, I'd almost rather do
something like:

kernel.h:
static inline void empty_void(void) {}
static inline void empty_int(void) { return 0; }
...

mm.h:
#define shm_lock(a, b) empty_int()

The typechecking is nice in theory, but in practice I don't think it
really makes a difference for stubbing things out.

-- 
Mathematics is the supreme nostalgia of our time.
