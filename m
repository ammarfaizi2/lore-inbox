Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTJYS34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbTJYS3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 14:29:02 -0400
Received: from havoc.gtf.org ([63.247.75.124]:20110 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262758AbTJYS2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 14:28:50 -0400
Date: Sat, 25 Oct 2003 14:28:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [AMD64 1/3] fix C99-style declarations
Message-ID: <20031025182824.GA12117@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Although the compiler has always supposed C99 style, I feel that until
the kernel as a whole moves to C99 style, such code reduces portability
to other compilers.  In particular, I am willing to bet Intel's Yamhill
will eventually be supported by the x86-64 code, and non-gcc compilers
will eventually be used to build this platform.


# --------------------------------------------
# 03/10/25	jgarzik@redhat.com	1.1351
# [AMD64] Fix C99-ish mix of declarations and code.
# --------------------------------------------

diff -Nru a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
--- a/arch/x86_64/ia32/syscall32.c	Sat Oct 25 06:08:19 2003
+++ b/arch/x86_64/ia32/syscall32.c	Sat Oct 25 06:08:19 2003
@@ -30,10 +30,12 @@
 int map_syscall32(struct mm_struct *mm, unsigned long address) 
 { 
 	pte_t *pte;
+	pmd_t *pmd;
 	int err = 0;
+
 	down_read(&mm->mmap_sem);
 	spin_lock(&mm->page_table_lock); 
-	pmd_t *pmd = pmd_alloc(mm, pgd_offset(mm, address), address); 
+	pmd = pmd_alloc(mm, pgd_offset(mm, address), address); 
 	if (pmd && (pte = pte_alloc_map(mm, pmd, address)) != NULL) { 
 		if (pte_none(*pte)) { 
 			set_pte(pte, 
diff -Nru a/arch/x86_64/kernel/bluesmoke.c b/arch/x86_64/kernel/bluesmoke.c
--- a/arch/x86_64/kernel/bluesmoke.c	Sat Oct 25 06:08:19 2003
+++ b/arch/x86_64/kernel/bluesmoke.c	Sat Oct 25 06:08:19 2003
@@ -200,11 +200,14 @@
 static void check_k8_nb(int header)
 {
 	struct pci_dev *nb;
+	u32 statuslow, statushigh;
+	unsigned short errcode;
+	int i;
+
 	nb = find_k8_nb(); 
 	if (nb == NULL)
 		return;
 
-	u32 statuslow, statushigh;
 	pci_read_config_dword(nb, 0x48, &statuslow);
 	pci_read_config_dword(nb, 0x4c, &statushigh);
 	if (!(statushigh & (1<<31)))
@@ -215,7 +218,7 @@
 	printk(KERN_ERR "Northbridge status %08x%08x\n",
 	       statushigh,statuslow); 
 
-	unsigned short errcode = statuslow & 0xffff;	
+	errcode = statuslow & 0xffff;	
 	switch (errcode >> 8) { 
 	case 0: 					
 		printk(KERN_ERR "    GART TLB error %s %s\n", 
@@ -249,7 +252,6 @@
 	/* should only print when it was a HyperTransport related error. */
 	printk(KERN_ERR "    link number %x\n", (statushigh >> 4) & 3);
 
-	int i;
 	for (i = 0; i < 32; i++) 
 		if (highbits[i] && (statushigh & (1<<i)))
 			printk(KERN_ERR "    %s\n", highbits[i]); 
diff -Nru a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Sat Oct 25 06:08:19 2003
+++ b/arch/x86_64/kernel/setup.c	Sat Oct 25 06:08:19 2003
@@ -332,6 +332,7 @@
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long low_mem_size;
+	unsigned long kernel_end;
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
@@ -380,7 +381,6 @@
 				(table_end - table_start) << PAGE_SHIFT);
 
 	/* reserve kernel */
-	unsigned long kernel_end;
 	kernel_end = round_up(__pa_symbol(&_end),PAGE_SIZE);
 	reserve_bootmem_generic(HIGH_MEMORY, kernel_end - HIGH_MEMORY);
 
