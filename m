Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTJSAMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTJSAMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 20:12:18 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:20176 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261905AbTJSAMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 20:12:15 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
	<20031018161439.484915f8.akpm@osdl.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 18 Oct 2003 17:11:28 -0700
In-Reply-To: <20031018161439.484915f8.akpm@osdl.org>
Message-ID: <87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> We already have the `system_running' flag which is
    Andrew> suitable for this.

OK, an alternate patch is below (also tested on my system).  I felt
that my first patch, which added the "init_idle_done" flag, was nice
because the flag gets set exactly when might_sleep() becomes valid,
and everything is contained in kernel/sched.c.  On the other hand, I
can see why not adding yet another flag is nice, too.  It's a matter
of taste, I guess.

    Andrew> I've been dithering over whether we should use it, mainly
    Andrew> because doing things like downing a semaphore before we've
    Andrew> even called sched_init() (cpufreq) is a
    Andrew> happens-to-be-harmless but fairly dumb thing to do.

True, but fixing some of the problems will be pretty ugly.  For
example, to fix the warning from kmem_cache_init:

    Debug: sleeping function called from invalid context at mm/slab.c:1857
    in_atomic():1, irqs_disabled():0
    Call Trace:
     [<c0105000>] _stext+0x0/0x30
     [<c011aea8>] __might_sleep+0x88/0xa0
     [<c013e708>] kmem_cache_alloc+0x1d8/0x1e0
     [<c011d531>] printk+0x121/0x150
     [<c0105000>] _stext+0x0/0x30
     [<c013d059>] kmem_cache_create+0x169/0x6a0
     [<c03019c0>] mem_init+0x1a0/0x210
     [<c0105000>] _stext+0x0/0x30
     [<c030469e>] kmem_cache_init+0x11e/0x2c0
     [<c02fa6d8>] start_kernel+0xb8/0x150
     [<c02fa4e0>] unknown_bootoption+0x0/0x110

We would probably have to change lots of stuff in mm/slab.c, including
kmem_cache_create(), since right now it unconditionally does

        /* Get cache's description obj. */
        cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);

which will trigger a might_sleep.  Maybe the least bad way to fix that
would be to do something like

        if (system_running)
                cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
        else
                cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_ATOMIC);

which strikes me as pretty ugly.  And there would be other changes in slab.c ...

Similarly, for the register_console() warning, I guess we would change
register_console to do

        if (system_running)
                acquire_console_sem();

        /* ... */

        if (system_running)
                release_console_sem();

in kernel/printk.c.  Let me know if you'd like a patch like that, I
can cook it up.

    Andrew> Yes, we should probably do something like this, but later.

I've already seen several more reports of this problem on lkml.  I
definitely think this should be fixed for -test9 and possibly even
-test8-mm1 -- otherwise you're going to continue to get reports of
this.  Nobody likes seeing tracebacks in their kernel messages.  Your
call though, obviously...

 - Roland

--- linux-2.6.0-test8/kernel/sched.c~early_might_sleep	Sat Oct 18 11:54:24 2003
+++ linux-2.6.0-test8/kernel/sched.c	Sat Oct 18 16:44:14 2003
@@ -2847,8 +2847,12 @@ void __might_sleep(char *file, int line)
 {
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
+	extern int system_running;
 
-	if (in_atomic() || irqs_disabled()) {
+	/* Don't print warnings until system_running is set.  This avoids
+	   spurious warnings during boot before local_irq_enable() and
+	   init_idle(). */
+	if (system_running && (in_atomic() || irqs_disabled())) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
