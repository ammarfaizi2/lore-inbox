Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUFWBsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUFWBsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 21:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUFWBso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 21:48:44 -0400
Received: from ozlabs.org ([203.10.76.45]:13970 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266023AbUFWBsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 21:48:25 -0400
Date: Wed, 23 Jun 2004 09:16:46 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org, akpm@osdl.org
Subject: Re: [profile]: [0/23] mmap() support for /proc/profile
Message-ID: <20040622231646.GA17387@krispykreme>
References: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was trying to profile a mostly-idle workload to get an idea of what
> area of the kernel things were diving into and falling asleep in during
> an OAST run. Without these patches, kerneltop et al showed heavy /proc/
> activity along with copy_to_user() at the top of the profiles.

Interesting stuff. FYI we did some analysis of the hottest addresses in
the kernel and profile_lock featured very high up:

void profile_hook(struct pt_regs * regs)
{
        read_lock(&profile_lock);
        notifier_call_chain(&profile_listeners, 0, regs);
        read_unlock(&profile_lock);
}

Thats 2 atomic operations to the same cacheline per timer interrupt per
cpu. Considering how rarely timer based profiling is used, perhaps RCU
or even just a profiling_enabled sysctl flag would help here. Id prefer
not to compile it out in distro kernels if possible, its a very useful
feature when required.

In the mean time, how about this quick fix?

Anton

--

Cacheline align profile_lock, analysis shows it to be one of the hottest
memory locations on large SMP boxes.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== kernel/profile.c 1.5 vs edited =====
--- 1.5/kernel/profile.c	Wed Jul 16 18:09:04 2003
+++ edited/kernel/profile.c	Wed Jun 23 09:13:28 2004
@@ -8,6 +8,7 @@
 #include <linux/bootmem.h>
 #include <linux/notifier.h>
 #include <linux/mm.h>
+#include <linux/cache.h>
 #include <asm/sections.h>
 
 unsigned int * prof_buffer;
@@ -119,7 +120,7 @@
 }
 
 static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
+static rwlock_t profile_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
  
 int register_profile_notifier(struct notifier_block * nb)
 {
