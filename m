Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSEaADl>; Thu, 30 May 2002 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSEaADk>; Thu, 30 May 2002 20:03:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60143 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S312254AbSEaADi>; Thu, 30 May 2002 20:03:38 -0400
Subject: [PATCH] 2.4-ac: free_pgtable P4 TLB race fix
From: Robert Love <rml@tech9.net>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-MUNQDNwUYPafcrXlBtk0"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 17:03:32 -0700
Message-Id: <1022803412.1145.421.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MUNQDNwUYPafcrXlBtk0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

Attached is a patch to resolve the free_pgtable P4 TLB reported and
fixed by Intel and Linus.

The problem lies in freeing page tables before the TLB is flushed on
Pentium 4s.  The solution is to make certain that the page table pages
are not freed prior to flushing the TLB

More information can be had at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102208353523931&w=2

Patch is against 2.4.19-pre9-ac3, please apply.

	Robert Love


--=-MUNQDNwUYPafcrXlBtk0
Content-Disposition: attachment; filename=P4-tlb-fix-rml-2.4.19-pre9-ac3-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=P4-tlb-fix-rml-2.4.19-pre9-ac3-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre9-ac3/arch/i386/kernel/process.c linux/arch/i386/=
kernel/process.c
--- linux-2.4.19-pre9-ac3/arch/i386/kernel/process.c	Thu May 30 16:34:44 20=
02
+++ linux/arch/i386/kernel/process.c	Thu May 30 16:54:58 2002
@@ -308,7 +308,7 @@
 	/*
 	 * Use `swapper_pg_dir' as our page directory.
 	 */
-	asm volatile("movl %0,%%cr3": :"r" (__pa(swapper_pg_dir)));
+	load_cr3(swapper_pg_dir);
=20
 	/* Write 0x1234 to absolute memory location 0x472.  The BIOS reads
 	   this on booting to tell it to "Bypass memory test (also warm
diff -urN linux-2.4.19-pre9-ac3/arch/i386/kernel/smp.c linux/arch/i386/kern=
el/smp.c
--- linux-2.4.19-pre9-ac3/arch/i386/kernel/smp.c	Thu May 30 16:34:44 2002
+++ linux/arch/i386/kernel/smp.c	Thu May 30 16:55:43 2002
@@ -298,11 +298,15 @@
 /*
  * We cannot call mmdrop() because we are in interrupt context,=20
  * instead update mm->cpu_vm_mask.
+ *
+ * We need to reload %cr3 since the page tables may be going
+ * away from under us..
  */
 static void inline leave_mm (unsigned long cpu)
 {
 	BUG_ON(cpu_tlbstate[cpu].state =3D=3D TLBSTATE_OK);
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	load_cr3(swapper_pg_dir);
 }
=20
 /*
diff -urN linux-2.4.19-pre9-ac3/arch/i386/mm/init.c linux/arch/i386/mm/init=
.c
--- linux-2.4.19-pre9-ac3/arch/i386/mm/init.c	Thu May 30 16:34:43 2002
+++ linux/arch/i386/mm/init.c	Thu May 30 16:54:58 2002
@@ -331,7 +331,7 @@
 {
 	pagetable_init();
=20
-	__asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+	load_cr3(swapper_pg_dir);=09
=20
 #if CONFIG_X86_PAE
 	/*
diff -urN linux-2.4.19-pre9-ac3/include/asm-i386/mmu_context.h linux/includ=
e/asm-i386/mmu_context.h
--- linux-2.4.19-pre9-ac3/include/asm-i386/mmu_context.h	Thu May 30 16:34:0=
4 2002
+++ linux/include/asm-i386/mmu_context.h	Thu May 30 16:54:58 2002
@@ -42,7 +42,7 @@
 		set_bit(cpu, &next->cpu_vm_mask);
 		set_bit(cpu, &next->context.cpuvalid);
 		/* Re-load page tables */
-		asm volatile("movl %0,%%cr3": :"r" (__pa(next->pgd)));
+		load_cr3(next->pgd);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -51,9 +51,9 @@
 			out_of_line_bug();
 		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled=20
-			 * tlb flush IPI delivery. We must flush our tlb.
+			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
-			local_flush_tlb();
+			load_cr3(next->pgd);
 		}
 		if (!test_and_set_bit(cpu, &next->context.cpuvalid))
 			load_LDT(next);
diff -urN linux-2.4.19-pre9-ac3/include/asm-i386/pgalloc.h linux/include/as=
m-i386/pgalloc.h
--- linux-2.4.19-pre9-ac3/include/asm-i386/pgalloc.h	Thu May 30 16:34:04 20=
02
+++ linux/include/asm-i386/pgalloc.h	Thu May 30 16:54:58 2002
@@ -139,7 +139,7 @@
 	free_page((unsigned long)pte);
 }
=20
-#define pte_free(pte)		pte_free_slow(pte)
+#define pte_free(pte)		pte_free_fast(pte)
 #define pgd_free(pgd)		free_pgd_slow(pgd)
 #define pgd_alloc(mm)		get_pgd_fast()
=20
@@ -228,13 +228,12 @@
 };
 extern struct tlb_state cpu_tlbstate[NR_CPUS];
=20
-
-#endif
+#endif /* CONFIG_SMP */
=20
 static inline void flush_tlb_pgtables(struct mm_struct *mm,
 				      unsigned long start, unsigned long end)
 {
-	/* i386 does not keep any page table caches in TLB */
+	flush_tlb_mm(mm);
 }
=20
 #endif /* _I386_PGALLOC_H */
diff -urN linux-2.4.19-pre9-ac3/include/asm-i386/processor.h linux/include/=
asm-i386/processor.h
--- linux-2.4.19-pre9-ac3/include/asm-i386/processor.h	Thu May 30 16:34:04 =
2002
+++ linux/include/asm-i386/processor.h	Thu May 30 16:54:58 2002
@@ -191,6 +191,9 @@
 #define X86_CR4_OSFXSR		0x0200	/* enable fast FPU save and restore */
 #define X86_CR4_OSXMMEXCPT	0x0400	/* enable unmasked SSE exceptions */
=20
+#define load_cr3(pgdir) \
+	asm volatile("movl %0,%%cr3": :"r" (__pa(pgdir)));
+
 /*
  * Save the cr4 feature set we're using (ie
  * Pentium 4MB enable and PPro Global page
diff -urN linux-2.4.19-pre9-ac3/mm/memory.c linux/mm/memory.c
--- linux-2.4.19-pre9-ac3/mm/memory.c	Thu May 30 16:34:01 2002
+++ linux/mm/memory.c	Thu May 30 16:54:58 2002
@@ -164,6 +164,7 @@
 void clear_page_tables(struct mm_struct *mm, unsigned long first, int nr)
 {
 	pgd_t * page_dir =3D mm->pgd;
+	unsigned long last =3D first + nr;
=20
 	spin_lock(&mm->page_table_lock);
 	page_dir +=3D first;
@@ -173,6 +174,8 @@
 	} while (--nr);
 	spin_unlock(&mm->page_table_lock);
=20
+	flush_tlb_pgtables(mm, first * PGDIR_SIZE, last * PGDIR_SIZE);
+=09
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
 }
diff -urN linux-2.4.19-pre9-ac3/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.19-pre9-ac3/mm/mmap.c	Thu May 30 16:34:01 2002
+++ linux/mm/mmap.c	Thu May 30 16:54:58 2002
@@ -1073,7 +1073,6 @@
 	end_index =3D pgd_index(last);
 	if (end_index > start_index) {
 		clear_page_tables(mm, start_index, end_index - start_index);
-		flush_tlb_pgtables(mm, first & PGDIR_MASK, last & PGDIR_MASK);
 	}
 }
=20

--=-MUNQDNwUYPafcrXlBtk0--

