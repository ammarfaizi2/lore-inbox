Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRAOTCJ>; Mon, 15 Jan 2001 14:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAOTB7>; Mon, 15 Jan 2001 14:01:59 -0500
Received: from ns.sysgo.de ([213.68.67.98]:61424 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129601AbRAOTBs>;
	Mon, 15 Jan 2001 14:01:48 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: [SOLVED + PATCH] Re: Anybody got 2.4.0 running on a 386 ?
Date: Mon, 15 Jan 2001 19:38:05 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01010922090000.02630@rob> <01011000082300.03050@rob> <3A5C8DB2.48A4A48@yahoo.com>
In-Reply-To: <3A5C8DB2.48A4A48@yahoo.com>
Cc: Ingo Molnar <mingo@elte.hu>, mo6 <sjoos@pandora.be>,
        Brian Gerst <bgerst@didntduck.org>, Miles Lane <miles@megapathdsl.net>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        "Tom G. Christensen" <tom.christensen@get2net.dk>,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <01011520014201.12336@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I finally found the reason why 386es have trouble booting the 2.4.0 kernel:

In routine pagetable_init() in arch/i386/mm/init.c, a pte gets installed before
it actually has been filled with valid entries. This causes the kernel text
segment to be temporarily unmapped. Pentiums are only lucky to not crash
because they have a bigger TLB than 386s.

Here is a patch to fix this:

--- init.c.orig	Wed Nov 29 07:43:39 2000
+++ init.c	Mon Jan 15 18:36:08 2001
@@ -317,7 +317,7 @@
 	pgd_t *pgd, *pgd_base;
 	int i, j, k;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, *pte_base;
 
 	/*
 	 * This can be zero as well - no problem, in that case we exit
@@ -366,11 +366,7 @@
 				continue;
 			}
 
-			pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-
-			if (pte != pte_offset(pmd, 0))
-				BUG();
+			pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 
 			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
 				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
@@ -378,6 +374,10 @@
 					break;
 				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
 			}
+			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
+			if (pte_base != pte_offset(pmd, 0))
+				BUG();
+
 		}
 	}
 
Thanks to everybody who helped with ideas and suggestions, especially Ingo
Molnar!


Cheers

Rob

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
