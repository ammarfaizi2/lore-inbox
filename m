Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSKRT06>; Mon, 18 Nov 2002 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSKRT0b>; Mon, 18 Nov 2002 14:26:31 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:62373 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264697AbSKRTYw> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (10/16): flushtlb bug.
Date: Mon, 18 Nov 2002 20:21:12 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182021.12385.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't set cpu_vm_mask if the mm isn't exclusive to the cpu.

diff -urN linux-2.5.48/include/asm-s390/tlbflush.h linux-2.5.48-s390/include/asm-s390/tlbflush.h
--- linux-2.5.48/include/asm-s390/tlbflush.h	Mon Nov 18 05:29:57 2002
+++ linux-2.5.48-s390/include/asm-s390/tlbflush.h	Mon Nov 18 20:11:48 2002
@@ -91,13 +91,15 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if (((atomic_read(&mm->mm_count) != 1) ||
-	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
-		mm->cpu_vm_mask = (1UL << smp_processor_id());
+	if (mm->cpu_vm_mask != (1UL << smp_processor_id())) {
+		/* mm was active on more than one cpu. */
+		if (mm == current->active_mm &&
+		    atomic_read(&mm->mm_count) == 1)
+			/* this cpu is the only one using the mm. */
+			mm->cpu_vm_mask = 1UL << smp_processor_id();
 		global_flush_tlb();
-	} else {                 
+	} else
 		local_flush_tlb();
-	}
 }
 
 static inline void flush_tlb(void)
diff -urN linux-2.5.48/include/asm-s390x/tlbflush.h linux-2.5.48-s390/include/asm-s390x/tlbflush.h
--- linux-2.5.48/include/asm-s390x/tlbflush.h	Mon Nov 18 05:29:50 2002
+++ linux-2.5.48-s390/include/asm-s390x/tlbflush.h	Mon Nov 18 20:11:48 2002
@@ -88,13 +88,15 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if (((atomic_read(&mm->mm_count) != 1) ||
-	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
-		mm->cpu_vm_mask = (1UL << smp_processor_id());
+	if (mm->cpu_vm_mask != (1UL << smp_processor_id())) {
+		/* mm was active on more than one cpu. */
+		if (mm == current->active_mm &&
+		    atomic_read(&mm->mm_count) == 1)
+			/* this cpu is the only one using the mm. */
+			mm->cpu_vm_mask = 1UL << smp_processor_id();
 		global_flush_tlb();
-	} else {                 
+	} else
 		local_flush_tlb();
-	}
 }
 
 static inline void flush_tlb(void)

