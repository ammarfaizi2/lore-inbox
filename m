Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUK1Qoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUK1Qoh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUK1Qoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:44:37 -0500
Received: from [220.248.27.114] ([220.248.27.114]:2016 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261512AbUK1Q1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:27:37 -0500
Date: Mon, 29 Nov 2004 00:25:39 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [5/6]
Message-ID: <20041128162539.GE28881@hugang.soulinfo.com>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162320.GA28881@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:23:20AM +0800, hugang@soulinfo.com wrote:
> Hi Pavel Machek, Nigel Cunningham:
> 
>  device-tree.diff 
>    base from suspend2 with a little changed.
> 
>  core.diff
>   1: redefine struct pbe for using _no_ continuous as pagedir.
>   2: make shrink memory as little as possible.
>   3: using a bitmap speed up collide check in page relocating.
>   4: pagecache saving ready.
> 
>  i386.diff
>  ppc.diff
>   i386 and powerpc suspend update.
> 
>  pagecachs_addon.diff
>   if enable page caches saving, must using it, it making saving
>   pagecaches safe. idea from suspend2.
> 
>   ppcfix.diff
>   fix compile error. 
>   $ gcc -v
>    .... 
>    gcc version 2.95.4 20011002 (Debian prerelease)
> 
> I'm using 2.6.9-ck3 With above patch, swsusp1 works prefect in my 
> PowerPC and x86 PC with Highmem and prepempt option enabled.
> 
> I hope the core.diff@1,@2,@3 i386.diff ppc.diff will merge into 
> mainline kernel ASAP, :). from I view point device-tree.diff is 
> very usefuly when using pagecache saving and pagecachs_addon.diff
> that's really hack for making pagecache saving safe.
> 

--- 2.6.9-lzf/kernel/sched.c	2004-11-28 23:17:11.000000000 +0800
+++ 2.6.9/kernel/sched.c	2004-11-28 23:16:54.000000000 +0800
@@ -2656,6 +2656,12 @@ asmlinkage void __sched schedule(void)
 	 * Otherwise, whine if we are scheduling when we should not be.
 	 */
 	if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
+#ifdef CONFIG_PM
+		extern int swsusp_pagecache;
+		if (unlikely(swsusp_pagecache == 2)) /* slient warning message when 
+												writing pagecache */
+#endif
+
 		if (unlikely(in_atomic())) {
 			printk(KERN_ERR "bad: scheduling while atomic!\n");
 			dump_stack();
--- 2.6.9-lzf/mm/page-writeback.c	2004-11-25 14:06:02.000000000 +0800
+++ 2.6.9/mm/page-writeback.c	2004-11-29 00:07:13.000000000 +0800
@@ -359,6 +359,9 @@ static void wb_kupdate(unsigned long arg
 	unsigned long start_jif;
 	unsigned long next_jif;
 	long nr_to_write;
+#ifdef CONFIG_PM
+	extern int swsusp_pagecache;
+#endif
 	struct writeback_state wbs;
 	struct writeback_control wbc = {
 		.bdi		= NULL,
@@ -369,6 +372,14 @@ static void wb_kupdate(unsigned long arg
 		.for_kupdate	= 1,
 	};
 
+#ifdef CONFIG_PM
+	if (unlikely(swsusp_pagecache == 2)) {
+		start_jif = jiffies;
+		next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+		goto out;
+	}
+#endif
+
 	sync_supers();
 
 	get_writeback_state(&wbs);
@@ -389,6 +400,7 @@ static void wb_kupdate(unsigned long arg
 		}
 		nr_to_write -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
 	}
+out:
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
 	if (dirty_writeback_centisecs)
-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
