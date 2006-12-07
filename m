Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032473AbWLGQ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032473AbWLGQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032475AbWLGQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:59:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47299 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032473AbWLGQ7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:59:39 -0500
Date: Thu, 7 Dec 2006 17:57:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
Message-ID: <20061207165751.GA2720@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com> <20061207121344.GA19749@elte.hu> <4578391E.40001@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4578391E.40001@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> 
> The attached patch is necessary to build 2.6.19-rt8 without KEXEC 
> enabled. Without KEXEC enabled crash.c doesn't get included. I believe 
> this is correct.

ah, indeed. I went for a slightly different approach - see the patch 
below. Sending an NMI to all CPUs is not something that is tied to 
KEXEC, it belongs into nmi.c.

	Ingo

Index: linux/arch/i386/kernel/crash.c
===================================================================
--- linux.orig/arch/i386/kernel/crash.c
+++ linux/arch/i386/kernel/crash.c
@@ -132,14 +132,6 @@ static int crash_nmi_callback(struct not
 	return 1;
 }
 
-void smp_send_nmi_allbutself(void)
-{
-	cpumask_t mask = cpu_online_map;
-	cpu_clear(safe_smp_processor_id(), mask);
-	if (!cpus_empty(mask))
-		send_IPI_mask(mask, NMI_VECTOR);
-}
-
 static struct notifier_block crash_nmi_nb = {
 	.notifier_call = crash_nmi_callback,
 };
Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -1133,6 +1133,14 @@ int proc_nmi_enabled(struct ctl_table *t
 
 #endif
 
+void smp_send_nmi_allbutself(void)
+{
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(safe_smp_processor_id(), mask);
+	if (!cpus_empty(mask))
+		send_IPI_mask(mask, NMI_VECTOR);
+}
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi);
Index: linux/arch/x86_64/kernel/crash.c
===================================================================
--- linux.orig/arch/x86_64/kernel/crash.c
+++ linux/arch/x86_64/kernel/crash.c
@@ -127,11 +127,6 @@ static int crash_nmi_callback(struct not
 	return 1;
 }
 
-void smp_send_nmi_allbutself(void)
-{
-	send_IPI_allbutself(NMI_VECTOR);
-}
-
 /*
  * This code is a best effort heuristic to get the
  * other cpus to stop executing. So races with
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -1015,6 +1015,11 @@ int proc_nmi_enabled(struct ctl_table *t
 
 #endif
 
+void smp_send_nmi_allbutself(void)
+{
+	send_IPI_allbutself(NMI_VECTOR);
+}
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(avail_to_resrv_perfctr_nmi);


