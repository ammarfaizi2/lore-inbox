Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWIKXhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWIKXhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWIKXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:37:41 -0400
Received: from gw.goop.org ([64.81.55.164]:24223 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965136AbWIKXhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:37:40 -0400
Message-ID: <4505F33E.3020009@goop.org>
Date: Mon, 11 Sep 2006 16:37:34 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda: Initialize the PDA early, before any C code
 runs.
References: <4505E8C1.7010906@goop.org> <20060911160301.10789d6e.akpm@osdl.org> <4505F212.4040307@goop.org>
In-Reply-To: <4505F212.4040307@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Not sure, but I think this replicates the behaviour of the original 
> code (ie, INIT_THREAD_INFO initializes cpu to 0, so smp_processor_id 
> will return 0).  Hm, Voyager will probably need a little patch to 
> update the the PDA cpu_number properly in smp_setup_processor_id().

Something like this, perhaps:

Subject: set the boot CPU number in the boot_pda

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

diff -r 97aa2356d521 arch/i386/mach-voyager/voyager_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c	Mon Sep 11 14:52:11 2006 -0700
+++ b/arch/i386/mach-voyager/voyager_smp.c	Mon Sep 11 16:34:09 2006 -0700
@@ -28,6 +28,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
+#include <asm/pda.h>
 
 /* TLB state -- visible externally, indexed physically */
 DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned = { &init_mm, 0 };
@@ -1949,4 +1950,5 @@ smp_setup_processor_id(void)
 smp_setup_processor_id(void)
 {
 	current_thread_info()->cpu = hard_smp_processor_id();
-}
+	write_pda(cpu_number, hard_smp_processor_id());
+}


