Return-Path: <linux-kernel-owner+w=401wt.eu-S1750965AbXAQGdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbXAQGdV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbXAQGdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:33:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35929 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbXAQGdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:33:19 -0500
Date: Wed, 17 Jan 2007 07:31:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Two 2.6.20-rc5-rt2 issues
Message-ID: <20070117063144.GB14027@elte.hu>
References: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org> <20070116115638.GA6809@elte.hu> <47345.192.168.1.8.1168994713.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47345.192.168.1.8.1168994713.squirrel@www.rncbc.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Building this already with -rt5, still gives:
> ...
>   LD      arch/i386/boot/compressed/vmlinux
>   OBJCOPY arch/i386/boot/vmlinux.bin
>   BUILD   arch/i386/boot/bzImage
> Root device is (3, 2)
> Boot sector 512 bytes.
> Setup is 7407 bytes.
> System is 1427 kB
> Kernel: arch/i386/boot/bzImage is ready  (#1)
> WARNING: "profile_hits" [drivers/kvm/kvm-intel.ko] undefined!
> WARNING: "profile_hits" [drivers/kvm/kvm-amd.ko] undefined!

ok - in my test-config i didnt have KVM modular - the patch below should 
fix this problem.

	Ingo

Index: linux/kernel/profile.c
===================================================================
--- linux.orig/kernel/profile.c
+++ linux/kernel/profile.c
@@ -332,7 +332,6 @@ out:
 	local_irq_restore(flags);
 	put_cpu();
 }
-EXPORT_SYMBOL_GPL(profile_hits);
 
 static int __devinit profile_cpu_callback(struct notifier_block *info,
 					unsigned long action, void *__cpu)
@@ -402,6 +401,8 @@ void profile_hits(int type, void *__pc, 
 }
 #endif /* !CONFIG_SMP */
 
+EXPORT_SYMBOL_GPL(profile_hits);
+
 void __profile_tick(int type, struct pt_regs *regs)
 {
 	if (type == CPU_PROFILING && timer_hook)
