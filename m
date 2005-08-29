Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVH2RZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVH2RZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVH2RZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:25:23 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:30842 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751148AbVH2RZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:25:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=hbNYE6pvoskZZfjmosF4MgJl6xez6JAWeB+2mLfcirulKY11ls/cEC7pTru2fHlgLESnw0DLaoEiLu0dceCRgKuut17FGhmlcO+fp3M+JKvHSrbW4Q8edG73pEW3cZ46XrGH6DvJMVidAMnnJmJuW297toxvXmWjuK+qyZDqMBk=
Message-ID: <4313321A.9010508@gmail.com>
Date: Mon, 29 Aug 2005 16:04:42 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Real-Time Preemption, fixed kexec kernel relocation oops
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, built against kernel version 2.6.13-rc7 (and not against -RT tree
patch, sorry), fixes a few local_irq_disable() calls which leads to an oops
during kernel relocation in kexec subsystem. Currently, only i386 implementation
of kexec is fixed.

Anyway, this patch does not fix a strange behaviour when using kexec with a -RT
kernel. Here is dmesg output:

Uncompressing Linux... OK, booting the kernel.
Unknown interrupt or fault at EIP 00000203 00000060 c011dfe3
Linux version 2.6.13-rc7-rt1 (root@sauron) (gcc version 3.3.4 (Debian
1:3.3.4-13)) #2 Fri Aug 26 16:55:12 UTC 2005
[...]
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
[...]

System is very slow and there are tons of "lost interrupt" messages.



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- ./arch/i386/kernel/machine_kexec.c.orig	2005-08-28 22:03:52.000000000 +0000
+++ ./arch/i386/kernel/machine_kexec.c	2005-08-28 22:05:28.000000000 +0000
@@ -187,7 +187,7 @@ NORET_TYPE void machine_kexec(struct kim
 	relocate_new_kernel_t rnk;

 	/* Interrupts aren't acceptable while we reboot */
-	local_irq_disable();
+	raw_local_irq_disable();

 	/* Compute some offsets */
 	reboot_code_buffer = page_to_pfn(image->control_code_page)
--- ./arch/i386/kernel/crash.c.orig	2005-08-28 22:04:08.000000000 +0000
+++ ./arch/i386/kernel/crash.c	2005-08-28 22:04:55.000000000 +0000
@@ -143,7 +143,7 @@ static int crash_nmi_callback(struct pt_
 	 */
 	if (cpu == crashing_cpu)
 		return 1;
-	local_irq_disable();
+	raw_local_irq_disable();

 	if (!user_mode(regs)) {
 		crash_setup_regs(&fixed_regs, regs);
@@ -210,7 +210,7 @@ void machine_crash_shutdown(struct pt_re
 	 * an SMP system.
 	 */
 	/* The kernel is broken so disable interrupts */
-	local_irq_disable();
+	raw_local_irq_disable();

 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = smp_processor_id();




Regards,
-- 
					Luca


