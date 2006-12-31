Return-Path: <linux-kernel-owner+w=401wt.eu-S933168AbWLaNVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbWLaNVy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933169AbWLaNVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:21:54 -0500
Received: from il.qumranet.com ([62.219.232.206]:41774 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933168AbWLaNVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:21:53 -0500
Subject: [PATCH 3/3] KVM: Recover after an arch module load failure
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 31 Dec 2006 13:21:52 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
References: <4597B8AB.6040504@qumranet.com>
In-Reply-To: <4597B8AB.6040504@qumranet.com>
Message-Id: <20061231132152.229352500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>

If we load the wrong arch module, it leaves behind kvm_arch_ops set, which
prevents loading of the correct arch module later.

Fix be not setting kvm_arch_ops until we're sure it's good.

Signed-off-by: Yoshimi Ichiyanagi <ichiyanagi.yoshimi@lab.ntt.co.jp>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1944,17 +1944,17 @@ int kvm_init_arch(struct kvm_arch_ops *o
 		return -EEXIST;
 	}
 
-	kvm_arch_ops = ops;
-
-	if (!kvm_arch_ops->cpu_has_kvm_support()) {
+	if (!ops->cpu_has_kvm_support()) {
 		printk(KERN_ERR "kvm: no hardware support\n");
 		return -EOPNOTSUPP;
 	}
-	if (kvm_arch_ops->disabled_by_bios()) {
+	if (ops->disabled_by_bios()) {
 		printk(KERN_ERR "kvm: disabled by bios\n");
 		return -EOPNOTSUPP;
 	}
 
+	kvm_arch_ops = ops;
+
 	r = kvm_arch_ops->hardware_setup();
 	if (r < 0)
 	    return r;
