Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758083AbWK0MMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083AbWK0MMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758085AbWK0MMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:12:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:6866 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758083AbWK0MMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:12:38 -0500
Subject: [PATCH 2/38] KVM: Make /dev/registration happen when the arch
	specific module is loaded
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:12:36 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121236.EA67025015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids exposing the driver capabilities before they are loaded.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -244,7 +244,7 @@ extern struct kvm_arch_ops *kvm_arch_ops
 #define kvm_printf(kvm, fmt ...) printk(KERN_DEBUG fmt)
 #define vcpu_printf(vcpu, fmt...) kvm_printf(vcpu->kvm, fmt)
 
-void kvm_init_arch(struct kvm_arch_ops *ops);
+int kvm_init_arch(struct kvm_arch_ops *ops, struct module *module);
 void kvm_exit_arch(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -3558,7 +3558,6 @@ static int kvm_dev_mmap(struct file *fil
 }
 
 static struct file_operations kvm_chardev_ops = {
-	.owner		= THIS_MODULE,
 	.open		= kvm_dev_open,
 	.release        = kvm_dev_release,
 	.unlocked_ioctl = kvm_dev_ioctl,
@@ -3612,13 +3611,26 @@ static void kvm_exit_debug(void)
 
 hpa_t bad_page_address;
 
-void kvm_init_arch(struct kvm_arch_ops *ops)
+int kvm_init_arch(struct kvm_arch_ops *ops, struct module *module)
 {
+	int r;
+
 	kvm_arch_ops = ops;
+	kvm_chardev_ops.owner = module;
+
+	r = misc_register(&kvm_dev);
+	if (r) {
+		printk (KERN_ERR "kvm: misc device register failed\n");
+		goto out_free;
+	}
+
+out_free:
+	return r;
 }
 
 void kvm_exit_arch(void)
 {
+	misc_deregister(&kvm_dev);
 }
 
 static __init int kvm_init(void)
@@ -3644,13 +3656,6 @@ static __init int kvm_init(void)
 	on_each_cpu(kvm_enable, 0, 0, 1);
 	register_reboot_notifier(&kvm_reboot_notifier);
 
-	r = misc_register(&kvm_dev);
-	if (r) {
-		printk (KERN_ERR "kvm: misc device register failed\n");
-		goto out_free;
-	}
-
-
 	if ((bad_page = alloc_page(GFP_KERNEL)) == NULL) {
 		r = -ENOMEM;
 		goto out_free;
@@ -3671,7 +3676,6 @@ out:
 static __exit void kvm_exit(void)
 {
 	kvm_exit_debug();
-	misc_deregister(&kvm_dev);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	on_each_cpu(kvm_disable, 0, 0, 1);
 	free_kvm_area();
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -26,7 +26,7 @@ static struct kvm_arch_ops vmx_arch_ops 
 
 static int __init vmx_init(void)
 {
-	kvm_init_arch(&vmx_arch_ops);
+	kvm_init_arch(&vmx_arch_ops, THIS_MODULE);
 	return 0;
 }
 
