Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUJ3PdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUJ3PdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJ3PdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:33:14 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:23699 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261198AbUJ3OjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:39:13 -0400
Message-ID: <4183A77A.2090601@kolivas.org>
Date: Sun, 31 Oct 2004 00:38:50 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 11/28] Make the family public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig60C117A70E1CCF3F74E7EA77"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60C117A70E1CCF3F74E7EA77
Content-Type: multipart/mixed;
 boundary="------------050503070103030309030700"

This is a multi-part message in MIME format.
--------------050503070103030309030700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

   Make the family public


--------------050503070103030309030700
Content-Type: text/x-patch;
 name="publicise_family.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_family.diff"

Take all the relatives, siblings etc and make them public in scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:05.009044066 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:08.882439571 +1000
@@ -3228,104 +3228,6 @@ out_unlock:
 	return retval;
 }
 
-static inline struct task_struct *eldest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.next,struct task_struct,sibling);
-}
-
-static inline struct task_struct *older_sibling(struct task_struct *p)
-{
-	if (p->sibling.prev==&p->parent->children) return NULL;
-	return list_entry(p->sibling.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *younger_sibling(struct task_struct *p)
-{
-	if (p->sibling.next==&p->parent->children) return NULL;
-	return list_entry(p->sibling.next,struct task_struct,sibling);
-}
-
-static void show_task(task_t * p)
-{
-	task_t *relative;
-	unsigned state;
-	unsigned long free = 0;
-	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
-
-	printk("%-13.13s ", p->comm);
-	state = p->state ? __ffs(p->state) + 1 : 0;
-	if (state < ARRAY_SIZE(stat_nam))
-		printk(stat_nam[state]);
-	else
-		printk("?");
-#if (BITS_PER_LONG == 32)
-	if (state == TASK_RUNNING)
-		printk(" running ");
-	else
-		printk(" %08lX ", thread_saved_pc(p));
-#else
-	if (state == TASK_RUNNING)
-		printk("  running task   ");
-	else
-		printk(" %016lx ", thread_saved_pc(p));
-#endif
-#ifdef CONFIG_DEBUG_STACK_USAGE
-	{
-		unsigned long * n = (unsigned long *) (p->thread_info+1);
-		while (!*n)
-			n++;
-		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
-	}
-#endif
-	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
-	if ((relative = eldest_child(p)))
-		printk("%5d ", relative->pid);
-	else
-		printk("      ");
-	if ((relative = younger_sibling(p)))
-		printk("%7d", relative->pid);
-	else
-		printk("       ");
-	if ((relative = older_sibling(p)))
-		printk(" %5d", relative->pid);
-	else
-		printk("      ");
-	if (!p->mm)
-		printk(" (L-TLB)\n");
-	else
-		printk(" (NOTLB)\n");
-
-	if (state != TASK_RUNNING)
-		show_stack(p, NULL);
-}
-
-void show_state(void)
-{
-	task_t *g, *p;
-
-#if (BITS_PER_LONG == 32)
-	printk("\n"
-	       "                                               sibling\n");
-	printk("  task             PC      pid father child younger older\n");
-#else
-	printk("\n"
-	       "                                                       sibling\n");
-	printk("  task                 PC          pid father child younger older\n");
-#endif
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		/*
-		 * reset the NMI-timeout, listing all files on a slow
-		 * console might take alot of time:
-		 */
-		touch_nmi_watchdog();
-		show_task(p);
-	} while_each_thread(g, p);
-
-	read_unlock(&tasklist_lock);
-}
-
 static void __devinit ingo_init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *rq = cpu_rq(cpu);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:05.010043910 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:08.883439414 +1000
@@ -635,6 +635,104 @@ void __sched yield(void)
 
 EXPORT_SYMBOL(yield);
 
+static inline struct task_struct *eldest_child(struct task_struct *p)
+{
+	if (list_empty(&p->children)) return NULL;
+	return list_entry(p->children.next,struct task_struct,sibling);
+}
+
+static inline struct task_struct *older_sibling(struct task_struct *p)
+{
+	if (p->sibling.prev==&p->parent->children) return NULL;
+	return list_entry(p->sibling.prev,struct task_struct,sibling);
+}
+
+static inline struct task_struct *younger_sibling(struct task_struct *p)
+{
+	if (p->sibling.next==&p->parent->children) return NULL;
+	return list_entry(p->sibling.next,struct task_struct,sibling);
+}
+
+static void show_task(task_t * p)
+{
+	task_t *relative;
+	unsigned state;
+	unsigned long free = 0;
+	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
+
+	printk("%-13.13s ", p->comm);
+	state = p->state ? __ffs(p->state) + 1 : 0;
+	if (state < ARRAY_SIZE(stat_nam))
+		printk(stat_nam[state]);
+	else
+		printk("?");
+#if (BITS_PER_LONG == 32)
+	if (state == TASK_RUNNING)
+		printk(" running ");
+	else
+		printk(" %08lX ", thread_saved_pc(p));
+#else
+	if (state == TASK_RUNNING)
+		printk("  running task   ");
+	else
+		printk(" %016lx ", thread_saved_pc(p));
+#endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	{
+		unsigned long * n = (unsigned long *) (p->thread_info+1);
+		while (!*n)
+			n++;
+		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
+	}
+#endif
+	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
+	if ((relative = eldest_child(p)))
+		printk("%5d ", relative->pid);
+	else
+		printk("      ");
+	if ((relative = younger_sibling(p)))
+		printk("%7d", relative->pid);
+	else
+		printk("       ");
+	if ((relative = older_sibling(p)))
+		printk(" %5d", relative->pid);
+	else
+		printk("      ");
+	if (!p->mm)
+		printk(" (L-TLB)\n");
+	else
+		printk(" (NOTLB)\n");
+
+	if (state != TASK_RUNNING)
+		show_stack(p, NULL);
+}
+
+void show_state(void)
+{
+	task_t *g, *p;
+
+#if (BITS_PER_LONG == 32)
+	printk("\n"
+	       "                                               sibling\n");
+	printk("  task             PC      pid father child younger older\n");
+#else
+	printk("\n"
+	       "                                                       sibling\n");
+	printk("  task                 PC          pid father child younger older\n");
+#endif
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		/*
+		 * reset the NMI-timeout, listing all files on a slow
+		 * console might take alot of time:
+		 */
+		touch_nmi_watchdog();
+		show_task(p);
+	} while_each_thread(g, p);
+
+	read_unlock(&tasklist_lock);
+}
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------050503070103030309030700--

--------------enig60C117A70E1CCF3F74E7EA77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6d6ZUg7+tp6mRURAnjvAJ9T3JI/XjhIkWVS8DcX9qYjqJdD6gCdE/gb
QpdPZ6kcFCoM/zSP04oCj/U=
=XLDH
-----END PGP SIGNATURE-----

--------------enig60C117A70E1CCF3F74E7EA77--
