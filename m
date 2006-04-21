Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWDUSBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWDUSBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDUSBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:01:10 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:21719 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932315AbWDUSBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:01:09 -0400
Subject: Re: kfree(NULL)
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1145635403.20843.21.camel@localhost.localdomain>
References: <63XWg-1IL-5@gated-at.bofh.it> <63YfP-26I-11@gated-at.bofh.it>
	 <63ZEY-45n-27@gated-at.bofh.it>  <4448F97D.5000205@imap.cc>
	 <1145635403.20843.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 14:00:59 -0400
Message-Id: <1145642459.24962.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 09:03 -0700, Daniel Walker wrote:
> 
> After reviewing some of the callers of kfree(NULL) they appear to be
> errors by the caller .. Where there's some false assumptions going on
> during looping or repeated calls to the same function. 
> 
> I agree with Andrew , I think the calls should be investigated while
> retaining the unlikley() predictor . 
> 

Below is a quick patch to do statistics on kfree.  It records up to 1000
locations of those that use kfree(NULL). Yes I know that the
adding/searching the list is O(n), but it's only for statistics, and it
only happens on the NULL case.

Then it allows for showing what it found through the sysrq-l 

Anyway, after booting with this patch I got the following output:

SysRq : Show stats on kfree
Total number of NULL frees:      16129
Total number of non NULL frees:  18119
Callers of NULL frees:
[       27]  c0154bcd - do_tune_cpucache+0x13d/0x230
[      631]  c025b9dd - class_device_add+0xcd/0x300
[       30]  c019523c - sysfs_d_iput+0x3c/0x8e
[       44]  c0193750 - sysfs_hash_and_remove+0xd0/0x110
[        1]  c01f4787 - kobject_cleanup+0x37/0x90
[        1]  c025bf73 - class_dev_release+0x23/0x90
[       14]  c021b615 - tty_write+0x105/0x220
[       20]  c025b5ff - class_device_del+0x16f/0x190
[        6]  c021cd34 - release_mem+0x174/0x2a0
[       36]  c011e804 - do_sysctl+0x94/0x250
[     6491]  c01aafc4 - start_this_handle+0x234/0x4b0
[     8404]  c01aba66 - do_get_write_access+0x2e6/0x5a0
[      263]  c01abdf0 - journal_get_undo_access+0xd0/0x120
[       28]  c01a3c9f - ext3_clear_inode+0x2f/0x40
[        3]  c0194a0c - sysfs_dir_close+0x6c/0x90
[       59]  c0304e1d - inet_sock_destruct+0xad/0x1f0
[        1]  c030a698 - ip_rt_ioctl+0xe8/0x130
[       64]  c02e2669 - ip_push_pending_frames+0x2d9/0x400
[        6]  c02d69b0 - netlink_release+0x1c0/0x300

The numbers in the []'s is the number of times they call kfree with
NULL.

This was right after a boot, but I can play on the system and see what
else is doing a heavy kfree(NULL).  Maybe Jan Engelhardt's idea of doing
the inline unless CONFIG_CC_OPTIMIZE_FOR_SIZE is set is the way to go.

Anyway, if you want to play, or make this a better patch, here it is.

-- Steve

Index: linux-2.6.17-rc2/drivers/char/sysrq.c
===================================================================
--- linux-2.6.17-rc2.orig/drivers/char/sysrq.c	2006-04-21 13:13:28.000000000 -0400
+++ linux-2.6.17-rc2/drivers/char/sysrq.c	2006-04-21 13:39:43.000000000 -0400
@@ -271,6 +271,19 @@ static struct sysrq_key_op sysrq_unrt_op
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+extern void kfree_show_stats(void);
+static void sysrq_handle_kfree_stat(int key, struct pt_regs *pt_regs,
+                                    struct tty_struct *tty)
+{
+        kfree_show_stats();
+}
+static struct sysrq_key_op sysrq_kfree_op = {
+	.handler	= sysrq_handle_kfree_stat,
+	.help_msg	= "KfreeStats",
+	.action_msg	= "Show stats on kfree",
+	.enable_mask	= SYSRQ_ENABLE_RTNICE,
+};
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
@@ -301,7 +314,7 @@ static struct sysrq_key_op *sysrq_key_ta
 	&sysrq_kill_op,			/* i */
 	NULL,				/* j */
 	&sysrq_SAK_op,			/* k */
-	NULL,				/* l */
+	&sysrq_kfree_op,		/* l */
 	&sysrq_showmem_op,		/* m */
 	&sysrq_unrt_op,			/* n */
 	/* This will often be registered as 'Off' at init time */
Index: linux-2.6.17-rc2/mm/slab.c
===================================================================
--- linux-2.6.17-rc2.orig/mm/slab.c	2006-04-21 10:11:41.000000000 -0400
+++ linux-2.6.17-rc2/mm/slab.c	2006-04-21 13:47:51.000000000 -0400
@@ -3366,6 +3366,69 @@ void kmem_cache_free(struct kmem_cache *
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
+#define KFREE_STAT_SZ 1000
+struct kfree_struct {
+	void *addr;
+	unsigned long counter;
+} kfree_stats[KFREE_STAT_SZ];
+int nr_kfree_stats;
+unsigned long kfree_nulls;
+atomic_t kfree_non_nulls = ATOMIC_INIT(0);
+spinlock_t kfree_stat_lock = SPIN_LOCK_UNLOCKED;
+
+void kfree_show_stats(void)
+{
+	unsigned long flags;
+	unsigned long i;
+
+	spin_lock_irqsave(&kfree_stat_lock, flags);
+	printk("Total number of NULL frees:      %ld\n",
+	       kfree_nulls);
+	printk("Total number of non NULL frees:  %d\n",
+	       atomic_read(&kfree_non_nulls));
+	printk("Callers of NULL frees:\n");
+	for (i=0; i < nr_kfree_stats; i++) {
+		void *addr = kfree_stats[i].addr;
+		unsigned long cnt = kfree_stats[i].counter;
+		printk("[%9ld]  %p - ", cnt, addr);
+		print_symbol("%s\n", (unsigned long)addr);
+	}
+	spin_unlock_irqrestore(&kfree_stat_lock, flags);
+}
+
+/*
+ * add_kfree_null - this adds the calling address to
+ *  the list of callers that called kfree with NULL.
+ *  Yes this is very inefficient, but it _should_ be the
+ *  slow path (called when NULL) and is only used for stats.
+ */
+static inline void add_kfree_null(void *addr)
+{
+	unsigned long flags;
+	unsigned long i;
+
+	spin_lock_irqsave(&kfree_stat_lock, flags);
+
+	kfree_nulls++;  /* protected by kfree_stat_lock */
+
+	if (nr_kfree_stats == KFREE_STAT_SZ)
+		goto out;
+
+	/* ARGH! linear O(n) search! */
+	for (i=0; i < nr_kfree_stats; i++)
+		if (kfree_stats[i].addr == addr) {
+			kfree_stats[i].counter++;
+			goto out;
+		}
+
+	nr_kfree_stats++;
+	kfree_stats[i].addr = addr;
+	kfree_stats[i].counter = 1;
+
+out:
+	spin_unlock_irqrestore(&kfree_stat_lock, flags);
+}
+
 /**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
@@ -3380,9 +3443,12 @@ void kfree(const void *objp)
 	struct kmem_cache *c;
 	unsigned long flags;
 
-	if (unlikely(!objp))
+	if (unlikely(!objp)) {
+		add_kfree_null(__builtin_return_address(0));
 		return;
+	}
 	local_irq_save(flags);
+	atomic_inc(&kfree_non_nulls);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
 	mutex_debug_check_no_locks_freed(objp, obj_size(c));


