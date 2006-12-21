Return-Path: <linux-kernel-owner+w=401wt.eu-S965185AbWLUJrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWLUJrI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWLUJrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:47:07 -0500
Received: from il.qumranet.com ([62.219.232.206]:50871 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965188AbWLUJrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:47:06 -0500
Subject: [PATCH 2/5] KVM: Do not export unsupported msrs to userspace
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 21 Dec 2006 09:47:04 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <458A57A4.9000807@qumranet.com>
In-Reply-To: <458A57A4.9000807@qumranet.com>
Message-Id: <20061221094704.DCB6C250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riepe <michael@mr511.de>

Some msrs, such as MSR_STAR, are not available on all processors.  Exporting
them causes qemu to try to fetch them, which will fail.

So, check all msrs for validity at module load time.

Signed-off-by: Michael Riepe <michael@mr511.de>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1417,6 +1417,9 @@ static int kvm_dev_ioctl_set_sregs(struc
 /*
  * List of msr numbers which we expose to userspace through KVM_GET_MSRS
  * and KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.
+ *
+ * This list is modified at module load time to reflect the
+ * capabilities of the host cpu.
  */
 static u32 msrs_to_save[] = {
 	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
@@ -1427,6 +1430,22 @@ static u32 msrs_to_save[] = {
 	MSR_IA32_TIME_STAMP_COUNTER,
 };
 
+static unsigned num_msrs_to_save = 0;
+
+static __init void kvm_init_msr_list(void)
+{
+	u32 dummy[2];
+	unsigned i, j;
+
+	for (i = j = 0; i < ARRAY_SIZE(msrs_to_save); i++) {
+		if (rdmsr_safe(msrs_to_save[i], &dummy[0], &dummy[1]) < 0)
+			continue;
+		if (j < i)
+			msrs_to_save[j] = msrs_to_save[i];
+		j++;
+	}
+	num_msrs_to_save = j;
+}
 
 /*
  * Adapt set_msr() to msr_io()'s calling convention
@@ -1735,15 +1754,15 @@ static long kvm_dev_ioctl(struct file *f
 		if (copy_from_user(&msr_list, user_msr_list, sizeof msr_list))
 			goto out;
 		n = msr_list.nmsrs;
-		msr_list.nmsrs = ARRAY_SIZE(msrs_to_save);
+		msr_list.nmsrs = num_msrs_to_save;
 		if (copy_to_user(user_msr_list, &msr_list, sizeof msr_list))
 			goto out;
 		r = -E2BIG;
-		if (n < ARRAY_SIZE(msrs_to_save))
+		if (n < num_msrs_to_save)
 			goto out;
 		r = -EFAULT;
 		if (copy_to_user(user_msr_list->indices, &msrs_to_save,
-				 sizeof msrs_to_save))
+				 num_msrs_to_save * sizeof(u32)))
 			goto out;
 		r = 0;
 	}
@@ -1894,6 +1913,8 @@ static __init int kvm_init(void)
 
 	kvm_init_debug();
 
+	kvm_init_msr_list();
+
 	if ((bad_page = alloc_page(GFP_KERNEL)) == NULL) {
 		r = -ENOMEM;
 		goto out;
