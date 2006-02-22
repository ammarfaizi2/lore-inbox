Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWBVPvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWBVPvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWBVPvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:51:20 -0500
Received: from mail.aknet.ru ([82.179.72.26]:15370 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751320AbWBVPvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:51:19 -0500
Message-ID: <43FC8877.4020300@aknet.ru>
Date: Wed, 22 Feb 2006 18:51:19 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: 2.6.16-rc4-mm1 (bugs and lockups)
References: <43FB5317.60501@aknet.ru> <20060221174400.4542ccbf.akpm@osdl.org>
In-Reply-To: <20060221174400.4542ccbf.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000608050406010107090103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000608050406010107090103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Andrew Morton wrote:
> umm, actually it's wrong.  i386's smp_prepare_boot_cpu() diddles with
> per-cpu memory, and that's not initialised at that stage.  See the call to
> setup_per_cpu_areas() a few lines later.
> So I'll drop that hunk.  How important is it in practice?
It was important because it used to fix both the printk and
(completely accidentally!) the boot problem itself.

> #ifdef CONFIG_SMP
> 	cpu_set(smp_processor_id(), cpu_online_map);	/* comment */
> #endif
I don't even think #ifdef is needed. Having that for the UP
case may be useless, yet looks consistent to me.

> right there in start_kernel()?
This is enough for printk but not for the boot lockup.
The attached patch is however enough. And it should be
correct, as it is consistent with an UP case.

> (That assumes that smp_processor_id() works at that stage.  Surely that's
> true).
Looking into the arch-specific code, I can see that some
arches evaluate the boot-cpu number by some other means,
not by the smp_processor_id(). Still I am pretty sure the
patch won't hurt them.

With this patch and with the hotfixes, I've got the -mm
kernel working, thanks.

----

Register the boot-cpu in the cpu maps earlier to allow the
early printk to work, and to fix an obscure deadlock at boot.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------000608050406010107090103
Content-Type: text/x-patch;
 name="smpb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpb.diff"

--- a/init/main.c	2006-02-21 10:36:04.000000000 +0300
+++ b/init/main.c	2006-02-22 11:30:01.000000000 +0300
@@ -440,6 +440,15 @@
  *	Activate the first processor.
  */
 
+static void boot_cpu_init(void)
+{
+	int cpu = smp_processor_id();
+	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
+	cpu_set(cpu, cpu_online_map);
+	cpu_set(cpu, cpu_present_map);
+	cpu_set(cpu, cpu_possible_map);
+}
+
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
@@ -449,17 +458,13 @@
  * enable them
  */
 	lock_kernel();
+	boot_cpu_init();
 	page_address_init();
 	printk(KERN_NOTICE);
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
-
-	/*
-	 * Mark the boot cpu "online" so that it can call console drivers in
-	 * printk() and can access its per-cpu storage.
-	 */
-	smp_prepare_boot_cpu();
+	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 
 	/*
 	 * Set up the scheduler prior starting any interrupts (such as the

--------------000608050406010107090103--
