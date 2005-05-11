Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVEKKLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVEKKLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVEKKLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:11:23 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:20612 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261193AbVEKKLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:11:16 -0400
Message-ID: <4281DC03.36011256@tv-sign.ru>
Date: Wed, 11 May 2005 14:18:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru> 
	 <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org>
	 <Pine.LNX.4.58.0505091449580.29090@graphe.net> <42808B84.BCC00574@tv-sign.ru> <Pine.LNX.4.58.0505101212350.20718@graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> On Tue, 10 May 2005, Oleg Nesterov wrote:
>
> > > There is no corruption around ptype_all as you can see from the log. There
> > > is a list of hex numbers which are from ptype_all -8 to ptype_all +8.
> > > Looks okay to me.
> >
> > Still ptype_all could be accessed (and corrupted) as ptype_base[16].
>
> Ok. I added padding before and after ptype_all.
> With padding the problem no longer occurs.
>
> However, if the padding is put before ptype_base and after ptype_all
> then the problem occurs.

So. ptype_base/ptype_all is corrupted before e1000_probe()->register_netdev().

Christoph, please, could you try this patch?

Make sure you are booting with 'init=/bin/sh', kernel should oops.

My kernel oops (as expected) in arp_init()->dev_add_pack(), after 2 successful
register_netdevice() calls.

Oleg.

--- 2.6.12-rc4/arch/i386/kernel/cpu/common.c~HACK	2005-05-09 16:36:52.000000000 +0400
+++ 2.6.12-rc4/arch/i386/kernel/cpu/common.c	2005-05-11 16:51:29.000000000 +0400
@@ -542,7 +542,7 @@ void __init early_cpu_init(void)
 	umc_init_cpu();
 	early_cpu_detect();
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#if	1
 	/* pse is not compatible with on-the-fly unmapping,
 	 * disable it even if the cpus claim to support it.
 	 */
--- 2.6.12-rc4/net/core/dev.c~HACK	2005-05-09 16:37:16.000000000 +0400
+++ 2.6.12-rc4/net/core/dev.c	2005-05-11 17:51:07.000000000 +0400
@@ -156,8 +156,19 @@
  */
 
 static DEFINE_SPINLOCK(ptype_lock);
-static struct list_head ptype_base[16];	/* 16 way hashed list */
-static struct list_head ptype_all;		/* Taps */
+
+static struct {
+	char pad_start[512];
+
+	struct list_head _ptype_base[16];	/* 16 way hashed list */
+	struct list_head _ptype_all;		/* Taps */
+
+	char pad_end[PAGE_SIZE - 512 - (16+1) * sizeof(struct list_head)];
+
+}	PTYPE_PAGE __attribute__((__aligned__(PAGE_SIZE)));
+
+#define	ptype_base	(PTYPE_PAGE._ptype_base)
+#define	ptype_all	(PTYPE_PAGE._ptype_all)
 
 #ifdef OFFLINE_SAMPLE
 static void sample_queue(unsigned long dummy);
@@ -2727,6 +2738,8 @@ int register_netdevice(struct net_device
 	struct hlist_node *p;
 	int ret;
 
+	printk(KERN_CRIT "%s: ENTER\n", __FUNCTION__);
+
 	BUG_ON(dev_boot_phase);
 	ASSERT_RTNL();
 
@@ -2828,6 +2841,7 @@ int register_netdevice(struct net_device
 	ret = 0;
 
 out:
+	printk(KERN_CRIT "%s: LEAVE=%d\n", __FUNCTION__, ret);
 	return ret;
 out_err:
 	free_divert_blk(dev);
@@ -3255,6 +3269,33 @@ static int dev_cpu_callback(struct notif
  *
  */
 
+#define CK(e) do { if (!(e)) {							\
+	printk(KERN_CRIT "ERR!! %d %s(%s)\n", __LINE__, __FUNCTION__, #e);	\
+	mdelay(2000);								\
+}} while (0)
+
+#include <asm/tlbflush.h>
+
+static void mk_writable(int yes)
+{
+	unsigned long addr = (unsigned long)&PTYPE_PAGE;
+	pte_t *pte;
+
+	CK(!(addr & ~PAGE_MASK));
+	CK(sizeof(PTYPE_PAGE) == PAGE_SIZE);
+
+	pte = lookup_address(addr);
+
+	CK(pte); CK(!(pte_val(*pte) & _PAGE_PSE));
+
+	if (yes)
+		set_pte_atomic(pte, pte_mkwrite(*pte));
+	else
+		set_pte_atomic(pte, pte_wrprotect(*pte));
+
+	flush_tlb_all();
+}
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -3277,6 +3318,8 @@ static int __init net_dev_init(void)
 	for (i = 0; i < 16; i++) 
 		INIT_LIST_HEAD(&ptype_base[i]);
 
+	mk_writable(0);
+
 	for (i = 0; i < ARRAY_SIZE(dev_name_head); i++)
 		INIT_HLIST_HEAD(&dev_name_head[i]);
 
-
