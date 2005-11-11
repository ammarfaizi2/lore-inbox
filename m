Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVKKTEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVKKTEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVKKTEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:04:49 -0500
Received: from everest.sosdg.org ([66.93.203.161]:21431 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S1751043AbVKKTEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:04:49 -0500
Date: Fri, 11 Nov 2005 14:04:47 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       ak@suse.de, akpm@osdl.org
Subject: [patch] mark text section read-only
Message-ID: <20051111190447.GA14481@everest.sosdg.org>
Reply-To: coywolf@sosdg.org
References: <20051107105624.GA6531@infradead.org> <20051107105807.GB6531@infradead.org> <1131372374.23658.1.camel@windu.rchland.ibm.com> <1131373248.2858.17.camel@laptopd505.fenrus.org> <2cd57c900511110139v221ed3f3m@mail.gmail.com> <1131702428.2833.8.camel@laptopd505.fenrus.org> <2cd57c900511111057n3a7741ddw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900511111057n3a7741ddw@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 02:57:02AM +0800, Coywolf Qi Hunt wrote:
> And we could also mark text section read-only and data/stack section
> noexec if NX is supported. But I doubt the whole thing would really
> help much. Kill the kernel thread? We can't. We only run into a panic.
> Anyway I'd attach a quick patch to mark text section read only in the
> next mail.
> 
> If it's ok, I'd add Kconfig support. Comments?


Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff -pruN 2.6.14-mm2/init/main.c 2.6.14-mm2-cy/init/main.c
--- 2.6.14-mm2/init/main.c	2005-11-11 22:34:21.000000000 +0800
+++ 2.6.14-mm2-cy/init/main.c	2005-11-12 02:50:45.000000000 +0800
@@ -660,6 +660,18 @@ static inline void fixup_cpu_present_map
 #endif
 }
 
+void mark_text_ro(void)
+{
+	unsigned long addr = (unsigned long)&_text;
+
+	for (; addr < (unsigned long)&_etext; addr += PAGE_SIZE)
+		change_page_attr(virt_to_page(addr), 1, PAGE_KERNEL_RO);
+	
+	printk ("Write protecting the kernel text data: %luk\n",
+			(unsigned long)(_etext - _text) >> 10);
+	global_flush_tlb();
+}
+
 static int init(void * unused)
 {
 	lock_kernel();
@@ -716,6 +728,7 @@ static int init(void * unused)
 	 */
 	free_initmem();
 	unlock_kernel();
+	mark_text_ro();
 	mark_rodata_ro();
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
