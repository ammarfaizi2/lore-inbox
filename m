Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWARHqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWARHqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWARHqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:46:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58304 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932128AbWARHqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:46:54 -0500
Date: Wed, 18 Jan 2006 08:47:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: [patch] fix cpucontrol <-> cache_chain_mutex lock inversion bug
Message-ID: <20060118074715.GA31736@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix cpucontrol/cache_chain_mutex lock ordering in the SLAB code.

kmem_cache_create() was doing lock_cpu_hotplug() after taking 
cache_chain_mutex. This can lead to deadlocks if a hotplug CPU is being 
brought up or down via cpuup_callback(), which takes cache_chain_mutex 
after lock_cpu_hotplug() is done.

Since the SLAB code has no choice about the cpucontrol already being 
taken at cpuup_callback(), the cache_chain_mutex has to nest inside 
lock_cpu_hotplug() - not the other way around. So the fix is to change 
kmem_cache_create() to take the cpu hotplug lock first.

the interesting thing about this bug is that i found it via a new 
CONFIG_DEBUG_MUTEXES feature i'm working on, which validates locking 
rules by mapping lock dependencies runtime, and "auto-learns" the 
locking rules - and thus detects any later violations of the locking 
rules. This code is able to detect complex lock inversion bugs (such as 
this one) even when they do not cause an actual deadlock yet. The system 
where i ran the debugger is not hotplug-cpu capable, it purely ran the 
two codepaths, at which point the detector warned about the lockup 
potential.

to reproduce the real lockup i'd need to simulate a hotplug CPU setup, 
and i'd also need to run kmem_cache_create() in parallel [which is a 
rarely called function], while also running the CPU hotplug add/remove 
code. Even knowing the precise bug it would be quite complex to set up 
the proper circumstances and reproduce the lockup.

the debug output was:

 =====================================
 [ BUG: lock inversion bug detected! ]
 -------------------------------------
 swapper/1 is trying to acquire lock {cache_chain_mutex} at:
 - cpuup_callback+0x42/0x2de
 and task is already holding lock {cpucontrol},
 which would create the following lock dependency:
  {cpucontrol} -> {cache_chain_mutex}
 but we recorded an inverse lock dependency between them in the past:
  {cache_chain_mutex} -> {cpucontrol}
 at:
 - __lock_cpu_hotplug+0x38/0x52
 which could lead to deadlocks!
 [...]

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 mm/slab.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -635,7 +635,12 @@ static kmem_cache_t cache_cache = {
 #endif
 };
 
-/* Guard access to the cache-chain. */
+/*
+ * Guard access to the cache-chain.
+ *
+ * Lock ordering: if lock_cpu_hotplug() is done, it must be
+ * called before cache_chain_mutex is acquired.
+ */
 static DEFINE_MUTEX(cache_chain_mutex);
 static struct list_head cache_chain;
 
@@ -1596,6 +1601,10 @@ kmem_cache_create (const char *name, siz
 		BUG();
 	}
 
+	/*
+	 * Don't let CPUs to come and go.
+	 */
+	lock_cpu_hotplug();
 	mutex_lock(&cache_chain_mutex);
 
 	list_for_each(p, &cache_chain) {
@@ -1797,9 +1806,6 @@ kmem_cache_create (const char *name, siz
 	cachep->dtor = dtor;
 	cachep->name = name;
 
-	/* Don't let CPUs to come and go */
-	lock_cpu_hotplug();
-
 	if (g_cpucache_up == FULL) {
 		enable_cpucache(cachep);
 	} else {
@@ -1857,12 +1863,13 @@ kmem_cache_create (const char *name, siz
 
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
-	unlock_cpu_hotplug();
       oops:
 	if (!cachep && (flags & SLAB_PANIC))
 		panic("kmem_cache_create(): failed to create slab `%s'\n",
 		      name);
 	mutex_unlock(&cache_chain_mutex);
+	unlock_cpu_hotplug();
+
 	return cachep;
 }
 EXPORT_SYMBOL(kmem_cache_create);
