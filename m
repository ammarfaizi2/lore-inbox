Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUJGGfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUJGGfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 02:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269726AbUJGGfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 02:35:53 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:44922
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S269725AbUJGGfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 02:35:50 -0400
Message-Id: <s164f1d5.069@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 07 Oct 2004 08:35:58 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Pavel Machek" <pavel@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [kernel] Fix random crashes in x86-64 swsusp
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe not really a final version: The __init should remain there if
suspend/resume isn't enabled in the configuration. I'd guess you want
something for this paralleling the __cpuinit/__devinit/module_init stuff
(if these occur very rarely, then doing this inline may of course also
be an acceptable choice). Jan

>>> pavel@suse.cz 07.10.04 00:06:00 >>>
Hi!

fix_processor_context was calling functions marked __init on x86-64;
bad idea. Maybe we should memset freed memory to zero so such bugs are
prevented?

Thanks to Rafael for keeping notifying me about this bug, and someone
get me yet another brown paper bag.

Anyway, this should fix it, please apply,
								Pavel

--- clean-suse/arch/x86_64/ia32/syscall32.c	2004-06-22
12:36:00.000000000 +0200
+++ linux-suse/arch/x86_64/ia32/syscall32.c	2004-10-06
23:58:27.000000000 +0200
@@ -76,7 +76,8 @@
 	
 __initcall(init_syscall32); 
 
-void __init syscall32_cpu_init(void)
+/* May not be __init: called during resume */
+void syscall32_cpu_init(void)
 {
 	if (use_sysenter < 0)
  		use_sysenter = (boot_cpu_data.x86_vendor ==
X86_VENDOR_INTEL);
--- clean-suse/arch/x86_64/kernel/setup64.c	2004-10-05
11:36:21.000000000 +0200
+++ linux-suse/arch/x86_64/kernel/setup64.c	2004-10-06
23:59:08.000000000 +0200
@@ -195,7 +195,8 @@
 char boot_exception_stacks[N_EXCEPTION_STACKS * EXCEPTION_STKSZ] 
 __attribute__((section(".bss.page_aligned")));
 
-void __init syscall_init(void)
+/* May not be marked __init: used by software suspend */
+void syscall_init(void)
 {
 	/* 
 	 * LSTAR and STAR live in a bit strange symbiosis.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
