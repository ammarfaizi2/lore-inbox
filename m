Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbTCGG4O>; Fri, 7 Mar 2003 01:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbTCGG4O>; Fri, 7 Mar 2003 01:56:14 -0500
Received: from dp.samba.org ([66.70.73.150]:60546 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261396AbTCGG4M>;
	Fri, 7 Mar 2003 01:56:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       akpm@zip.com.au
Subject: Re: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification
In-Reply-To: <Pine.LNX.4.44.0303021457010.32518-100000@serv>
References: <20030228203039.A12990@baldur.yggdrasil.com>
	<Pine.LNX.4.44.0303021457010.32518-100000@serv>
Date: Fri, 07 Mar 2003 17:34:18 +1100
Message-Id: <20030307070646.C85322C07D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Mar 2003 15:12:37 +0100 (CET)
Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Fri, 28 Feb 2003, Adam J. Richter wrote:
> 
> > 	The following patch shrinks changes the implementation of
> > try_module_get() and friends to eliminate the special stopping of all
> > CPU's when a module is unloaded.  Instead, it uses a read/write
> > semaphore in a perhaps slightly non-intuitive way.
> 
> Hmm, I was waiting a bit for Rusty's comment, but there isn't any...

(Sorry, on holiday, skimming mail)

I like it *very* much!  There's a small race, but it's easily fixed by
turning the local_dec into a module_put (or variant) (otherwise an
rmmod --wait can sleep forever, waking up and seeing a non-zero
refcount, and going back to sleep).

Three other requests, if I may.

It'd be nice to have a comment for the two smp_mb() eg. /* Must increment
before checking state */ and vice-versa above the one in module.c.  Secondly
probably nicer to just rename the modlist_lock to module_lock and use that,
and thirdly merge with the racefix patch below if Linus hasn't already
taken it.

BTW, I'm away from the office for a couple of weeks, and even if I weren't,
my test box doesn't stay up for more than minutes under any recent kernel 8(
Can you stress test this and send to Linus?

> BTW making the module ref functions not inline saves about 5KB with the 
> standard config.

Interesting.  The "if (!module)" could theortically be dropped, but I
just looked at the sizes of try_module_get as a standalone function
for various config options (x86, gcc 3.2.3):

UNLOAD=y
SMP=y
PREEMPT=y
try_module_get() 78 bytes

UNLOAD=y
SMP=y
PREEMPT=n
try_module_get() 48 bytes

UNLOAD=y
SMP=n
PREEMPT=n
try_module_get() 28 bytes

UNLOAD=n
try_module_get() 21 bytes

These numbers are a bit exaggerated due to function prologue and
epilogues, but on x86 PREEMPT=y case at least I definitely think that
it's worth out-of-lining it (a straight function call costs about 11
bytes).  Don't know about other archs.

Thanks for the patch!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

Name: Fix two module races
Author: Bob Miller, Rusty Russell
Status: Trivial

D: Bob Miller points out that the try_module_get in use_module() can,
D: of course, fail.  Secondly, there is a race between setting the module
D: live, and a simultaneous removal of it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.62-bk6/kernel/module.c working-2.5.62-bk6-modraces/kernel/module.c
--- linux-2.5.62-bk6/kernel/module.c	2003-02-18 11:18:57.000000000 +1100
+++ working-2.5.62-bk6-modraces/kernel/module.c	2003-02-24 13:42:44.000000000 +1100
@@ -173,16 +173,19 @@ static int use_module(struct module *a, 
 	struct module_use *use;
 	if (b == NULL || already_uses(a, b)) return 1;
 
+	if (!strong_try_module_get(b))
+		return 0;
+
 	DEBUGP("Allocating new usage for %s.\n", a->name);
 	use = kmalloc(sizeof(*use), GFP_ATOMIC);
 	if (!use) {
 		printk("%s: out of memory loading\n", a->name);
+		module_put(b);
 		return 0;
 	}
 
 	use->module_which_uses = a;
 	list_add(&use->list, &b->modules_which_use_me);
-	try_module_get(b); /* Can't fail */
 	return 1;
 }
 
@@ -1456,10 +1459,12 @@ sys_init_module(void *umod,
 	}
 
 	/* Now it's a first class citizen! */
+	down(&module_mutex);
 	mod->state = MODULE_STATE_LIVE;
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
+	up(&module_mutex);
 
 	return 0;
 }

