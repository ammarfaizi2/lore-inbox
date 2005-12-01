Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbVLADcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbVLADcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 22:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbVLADcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 22:32:12 -0500
Received: from fmr18.intel.com ([134.134.136.17]:15314 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751633AbVLADcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 22:32:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [BUG][PATCH] Kprobes: Reference count the modules when probed on it
Date: Thu, 1 Dec 2005 11:32:00 +0800
Message-ID: <9FBCE015AF479F46B3B410499F3AE05B0897F1@pdsmsx405>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][PATCH] Kprobes: Reference count the modules when probed on it
Thread-Index: AcX2J8ozRx0zjEmSQcSoCPfYz/68ZQ==
From: "Mao, Bibo" <bibo.mao@intel.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Cc: <systemtap@sources.redhat.com>
X-OriginalArrivalTime: 01 Dec 2005 03:32:01.0265 (UTC) FILETIME=[CA91FE10:01C5F627]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a Kprobes are inserted/removed on a modules,
the modules must be ref counted so as
not to allow to unload while probes are registered
on that module.

Without this patch, the probed module is free to unload,
and when the probing module unregister the probe, the
kpobes code while trying to replace the original instruction
might crash.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Mao Bibo <bibo.mao@intel.com>


 kernel/kprobes.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc3/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc3.orig/kernel/kprobes.c
+++ linux-2.6.15-rc3/kernel/kprobes.c
@@ -462,9 +462,16 @@ int __kprobes register_kprobe(struct kpr
 	int ret = 0;
 	unsigned long flags = 0;
 	struct kprobe *old_p;
+	struct module *mod;
+
+	if ((!kernel_text_address((unsigned long) p->addr)) ||
+		in_kprobes_functions((unsigned long) p->addr))
+		return -EINVAL;
+
+	if ((mod = module_text_address((unsigned long) p->addr)) &&
+			(unlikely(!try_module_get(mod)))) 
+		return -EINVAL;
 
-	if ((ret = in_kprobes_functions((unsigned long) p->addr)) != 0)
-		return ret;
 	if ((ret = arch_prepare_kprobe(p)) != 0)
 		goto rm_kprobe;
 
@@ -488,6 +495,8 @@ out:
 rm_kprobe:
 	if (ret == -EEXIST)
 		arch_remove_kprobe(p);
+	if (ret && mod)
+		module_put(mod);
 	return ret;
 }
 
@@ -495,6 +504,7 @@ void __kprobes unregister_kprobe(struct 
 {
 	unsigned long flags;
 	struct kprobe *old_p;
+	struct module *mod;
 
 	spin_lock_irqsave(&kprobe_lock, flags);
 	old_p = get_kprobe(p->addr);
@@ -506,6 +516,10 @@ void __kprobes unregister_kprobe(struct 
 			cleanup_kprobe(p, flags);
 
 		synchronize_sched();
+
+		if ((mod = module_text_address((unsigned long)
p->addr)))
+			module_put(mod);
+
 		if (old_p->pre_handler == aggr_pre_handler &&
 				list_empty(&old_p->list))
 			kfree(old_p);

