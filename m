Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWJYMiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWJYMiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWJYMiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:38:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:5840 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964795AbWJYMh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FXaGjMxpD3cmKG5yxLENHCeUHwkgFV9zk48aI3Fl8vKXBdSfP0eNZvRCOuI4wTF8Cm5UreQlx8NuVrWWFW4veoa5cRx86Ene9MBpYIexdFhiNCUzNkb0X/DYnuJslw8EoDphuAvZlmkqiYBWM8RO2sRt8Yjup8GI0lwnIE93BT4=
Message-ID: <4ac8254d0610250537m7ee628cbo255decde52586742@mail.gmail.com>
Date: Wed, 25 Oct 2006 14:37:57 +0200
From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
To: linux-kernel@vger.kernel.org, ak@suse.de, yinghai.lu@amd.com
Subject: IO_APIC broken by 45edfd1db02f818b3dc7e4743ee8585af6b78f78
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've bisected the non-working'ness of HD-Audio and USB Mouse on one of
my x86_64 boxes back to the following commit.

The machine is an HP xw4400 Core 2 Duo E6600 with the Intel 975X chipset.
Please let me know if you need any debug info.

45edfd1db02f818b3dc7e4743ee8585af6b78f78 is first bad commit
commit 45edfd1db02f818b3dc7e4743ee8585af6b78f78
Author: Yinghai Lu <yinghai.lu@amd.com>
Date:   Sat Oct 21 18:37:01 2006 +0200

    [PATCH] x86-64: typo in __assign_irq_vector when updating pos for
vector and offset

    typo with cpu instead of new_cpu

    Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
    Signed-off-by: Andi Kleen <ak@suse.de>

:040000 040000 1d64801d89bfb23ef4d63d1625f47122d01ded6c
03bb862d9bfdfb05fb5382d56d52ffe1c5f8aba2 M	arch

Accordingly ther revert-diff is this
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index b000017..1fa95d5 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -651,12 +651,12 @@ next:
                if (vector == IA32_SYSCALL_VECTOR)
                        goto next;
                for_each_cpu_mask(new_cpu, domain)
-                       if (per_cpu(vector_irq, new_cpu)[vector] != -1)
+                       if (per_cpu(vector_irq, cpu)[vector] != -1)
                                goto next;
                /* Found one! */
                for_each_cpu_mask(new_cpu, domain) {
-                       pos[new_cpu].vector = vector;
-                       pos[new_cpu].offset = offset;
+                       pos[cpu].vector = vector;
+                       pos[cpu].offset = offset;
                }
                if (old_vector >= 0) {
                        int old_cpu;
