Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWJPP0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWJPP0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbWJPP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:26:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:57018 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422630AbWJPP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:26:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=hpBZBlkM5wPlwAj/L72YWco3HUYJU8BSLMlocj9quzqBBEix3Sndu/HpMR2jtc6eOVUNtaMC6QqOUhDmzd5fJD7xWysqH/y8yCjhO29ztJpEAN7h9zvftU+z9Qt4cqiBjZgg45i9j3H0wN7tnK+S/+w8sIknOUTHT8NXCrmXfU0=
Message-ID: <86802c440610160826g6b918d9bh65948d49f668e892@mail.gmail.com>
Date: Mon, 16 Oct 2006 08:26:08 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@muc.de>
Subject: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com, yinghai.lu@amd.com
In-Reply-To: <86802c440610151221v2217cb67t354e1ccbcee54b6a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_81061_22519800.1161012368568"
References: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com>
	 <86802c440610151221v2217cb67t354e1ccbcee54b6a@mail.gmail.com>
X-Google-Sender-Auth: 3a4802805e0b510e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_81061_22519800.1161012368568
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please check the patch.

Also I have a question about TARGET_CPUS in io_apic.c.

for a 16 sockets system with 32 non coherent ht chain. and if every
chain have 8 irq for devices, the genapic will use physflat. and it
should use you new added "different cpu can have same vector for
different irq".  --- in the i8259.c

but the setup_IOAPIC_irqs and arch_setup_ht_irq and arch_setup_msi_irq
is still using TARGET_CPUS ( it is cpumask_of_cpu(0) for physflat), so
the assign_irq_vector will not get vector for them, becase cpu 0 does
not have that much vector to be alllocated. and later
setup_affinity_xxx_irq can not be used because before irq is not there
and show on /proc/interrupts.

So I want to
1. for arch_setup_ht_irq and arch_setup_msi_irq, we can use the dev it
takes to get bus and use bus->sysdata to get bus->node mapping that is
created in fillin_cpumask_to_bus, to get real target_cpus instead of
cpu0.
2. for ioapics, may need to add another array,
ioapic_node[MAX_IOAPICS], and use ioapic address to get the numa node
for it. So later can use it to get real targets cpus when need to use
TARGET_CPUS.

Please comments.

Thanks

Yinghai Lu





---------- Forwarded message ----------
From: yhlu <yhlu.kernel@gmail.com>
Date: Oct 15, 2006 12:21 PM
Subject: re: [PATCH] x86_64: typo in __assign_irq_vector when update
pos for vector and offset
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@muc.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
yhlu.kernel@gmail.com


Please use this one

typo with cpu instead of new_cpu

Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 44b55f8..756d097 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -651,12 +651,12 @@ next:
               if (vector == IA32_SYSCALL_VECTOR)
                       goto next;
               for_each_cpu_mask(new_cpu, domain)
-                       if (per_cpu(vector_irq, cpu)[vector] != -1)
+                       if (per_cpu(vector_irq, new_cpu)[vector] != -1)
                               goto next;
               /* Found one! */
               for_each_cpu_mask(new_cpu, domain) {
-                       pos[cpu].vector = vector;
-                       pos[cpu].offset = offset;
+                       pos[new_cpu].vector = vector;
+                       pos[new_cpu].offset = offset;
               }
               if (old_vector >= 0) {
                       int old_cpu;

------=_Part_81061_22519800.1161012368568
Content-Type: text/x-patch; name=io_apic_x.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etbtnnos
Content-Disposition: attachment; filename="io_apic_x.diff"

ZGlmZiAtLWdpdCBhL2FyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCmluZGV4IDQ0YjU1ZjguLjc1NmQwOTcgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9pb19hcGljLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMu
YwpAQCAtNjUxLDEyICs2NTEsMTIgQEAgbmV4dDoKIAkJaWYgKHZlY3RvciA9PSBJQTMyX1NZU0NB
TExfVkVDVE9SKQogCQkJZ290byBuZXh0OwogCQlmb3JfZWFjaF9jcHVfbWFzayhuZXdfY3B1LCBk
b21haW4pCi0JCQlpZiAocGVyX2NwdSh2ZWN0b3JfaXJxLCBjcHUpW3ZlY3Rvcl0gIT0gLTEpCisJ
CQlpZiAocGVyX2NwdSh2ZWN0b3JfaXJxLCBuZXdfY3B1KVt2ZWN0b3JdICE9IC0xKQogCQkJCWdv
dG8gbmV4dDsKIAkJLyogRm91bmQgb25lISAqLwogCQlmb3JfZWFjaF9jcHVfbWFzayhuZXdfY3B1
LCBkb21haW4pIHsKLQkJCXBvc1tjcHVdLnZlY3RvciA9IHZlY3RvcjsKLQkJCXBvc1tjcHVdLm9m
ZnNldCA9IG9mZnNldDsKKwkJCXBvc1tuZXdfY3B1XS52ZWN0b3IgPSB2ZWN0b3I7CisJCQlwb3Nb
bmV3X2NwdV0ub2Zmc2V0ID0gb2Zmc2V0OwogCQl9CiAJCWlmIChvbGRfdmVjdG9yID49IDApIHsK
IAkJCWludCBvbGRfY3B1Owo=
------=_Part_81061_22519800.1161012368568--
