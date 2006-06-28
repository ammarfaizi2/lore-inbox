Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWF1Rfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWF1Rfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWF1Rfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:35:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25538 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751427AbWF1Rfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:35:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: [2.6 patch] i386: KEXEC must depend on (!SMP && X86_LOCAL_APIC)
References: <20060628165533.GJ13915@stusta.de>
Date: Wed, 28 Jun 2006 11:35:15 -0600
In-Reply-To: <20060628165533.GJ13915@stusta.de> (Adrian Bunk's message of
	"Wed, 28 Jun 2006 18:55:33 +0200")
Message-ID: <m14py5fajw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Bunk <bunk@stusta.de> writes:
> This patch fixes the following issue with CONFIG_SMP=y and 
> CONFIG_X86_VOYAGER=y:
>
> <--  snip  -->
>
> ...
>   CC      arch/i386/kernel/crash.o
> arch/i386/kernel/crash.c: In function ‘crash_nmi_callback’:
> arch/i386/kernel/crash.c:113: error: implicit declaration of function
> ‘disable_local_APIC’
>
> <--  snip  -->

I think the patch below more correctly captures the dependency.

In truth that call to disable_local_APIC() is a bug but the kernel
isn't ready yet to boot in apic only mode, so it remains until
the apic initialization can be moved into init_IRQ.

Does this sound good?

Eric


diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
index 48f0f62..5b96f03 100644
--- a/arch/i386/kernel/crash.c
+++ b/arch/i386/kernel/crash.c
@@ -90,7 +90,7 @@ static void crash_save_self(struct pt_re
        crash_save_this_cpu(regs, cpu);
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
 static atomic_t waiting_for_crash_ipi;
 
 static int crash_nmi_callback(struct pt_regs *regs, int cpu)

