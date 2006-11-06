Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753059AbWKFNPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbWKFNPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbWKFNPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:15:06 -0500
Received: from il.qumranet.com ([62.219.232.206]:61912 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1753059AbWKFNPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:15:05 -0500
Subject: [PATCH] KVM: fix calculation of initial value of rdx register
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 06 Nov 2006 13:15:02 -0000
To: kvm-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-Id: <20061106131502.BD90D2500A7@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On bootup, the rdx register contains information about the processor.  The
function which calculates this value has the bugs:

 - missing 'cpuid' to get the value from the processor
 - missing register clobber caused a miscompilation in some circumstances
 - we shouldn't return a value that depends on the current processor in 
   case we migrate

In any case nobody looks at the value, so just return a generic P6
identifier.

Thanks to Christian Hesse <mail@earthworm.de> for debugging help.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1052,12 +1052,7 @@ static void set_cr8(struct kvm_vcpu *vcp
 
 static u32 get_rdx_init_val(void)
 {
-	u32 val;
-
-	asm ("movl $1, %%eax \n\t"
-	     "movl %%eax, %0 \n\t" : "=g"(val) );
-	return val;
-
+	return 0x600; /* P6 family */
 }
 
 static void fx_init(struct kvm_vcpu *vcpu)
