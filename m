Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUASCyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 21:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUASCyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 21:54:24 -0500
Received: from [211.167.76.68] ([211.167.76.68]:16831 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262050AbUASCxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 21:53:34 -0500
Date: Mon, 19 Jan 2004 10:52:37 +0800
From: Hugang <hugang@soulinfo.com>
To: ncunningham@clear.net.nz, linux-kernel@vger.kernel.org,
       debian-powerpc@lists.debian.org
Subject: Help port swsusp to ppc.
Message-Id: <20040119105237.62a43f65@localhost>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__19_Jan_2004_10_52_37_+0800_CyrBEuU.jnjUrst1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__19_Jan_2004_10_52_37_+0800_CyrBEuU.jnjUrst1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello guys:

I'm try to porting Software Suspend to PowerPC. But I'm not family with
PowerPC assemble languae. So need someone to help me write the save
process state function in assemble language.

1: Download i386 suspend patch for 2.6.1 from swsusp.sf.net
 you need two patch 
 software-suspend-core-2.0-rc4-whole.bz2
 software-suspend-linux-2.6.1-rev1-whole.bz2
2: first you need apply linux-2.6.1 to 2.6.1 clean kernel
   then apply core-2.0-rc4 to current patched kernel
3: then apply ppc-swsusp.patch to patched kernel
4: do make menuconfig
 CONFIG_SOFTWARE_SUSPEND2=y
 CONFIG_SOFTWARE_SUSPEND_DEBUG=y
 CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION=y
 CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE=y
 CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION=y
 CONFIG_SOFTWARE_SUSPEND_SWAPWRITER=y
5: test with swsusp enable kernel.
 in yaboot prompt:
 /vmlinux.swsusp root=/dev/hda13 resume2=swap:/dev/hda10 init=/bin/sh
 
 /dev/hda13 is the root device name
 /dev/hda10 is swap device name
 
6: run suspend script to do software suspend, now the machine will power
 off.

7: power on machin, in yaboot prompt:
  /vmlinux.swsusp root=/dev/hda13 resume2=swap:/dev/hda10 init=/bin/sh

But for now the save and restore processor state is not finish, the
resume will oops.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Mon__19_Jan_2004_10_52_37_+0800_CyrBEuU.jnjUrst1
Content-Type: text/plain;
 name="ppc_swsusp.diff"
Content-Disposition: attachment;
 filename="ppc_swsusp.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-ppc/suspend.h
===================================================================
--- include/asm-ppc/suspend.h	(revision 0)
+++ include/asm-ppc/suspend.h	(revision 0)
@@ -0,0 +1,6 @@
+#ifndef _PPC_SUSPEND_H
+#define _PPC_SUSPEND_H
+
+/* Nothing */
+
+#endif
Index: arch/ppc/Kconfig
===================================================================
--- arch/ppc/Kconfig	(revision 192)
+++ arch/ppc/Kconfig	(working copy)
@@ -193,6 +193,8 @@
 
 	  If in doubt, say Y here.
 
+source kernel/power/Kconfig
+
 source arch/ppc/platforms/4xx/Kconfig
 
 config PPC64BRIDGE
Index: arch/ppc/kernel/swsusp2-asm.S
===================================================================
--- arch/ppc/kernel/swsusp2-asm.S	(revision 0)
+++ arch/ppc/kernel/swsusp2-asm.S	(revision 0)
@@ -0,0 +1,523 @@
+	.file	"swsusp2.c"
+gcc2_compiled.:
+	.section	".rodata"
+	.align 2
+.LC0:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/cpumask.h"
+	.align 2
+.LC1:
+	.string	"next_online_cpu"
+	.align 2
+.LC2:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/module.h"
+	.align 2
+.LC3:
+	.string	"__module_get"
+	.align 2
+.LC4:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/dcache.h"
+	.align 2
+.LC5:
+	.string	"dget"
+	.align 2
+.LC6:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/mm.h"
+	.align 2
+.LC7:
+	.string	"put_page"
+	.align 2
+.LC8:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/highmem.h"
+	.align 2
+.LC9:
+	.string	"memclear_highpage_flush"
+	.align 2
+.LC10:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/blkdev.h"
+	.align 2
+.LC11:
+	.string	"blkdev_dequeue_request"
+	.align 2
+.LC12:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/skbuff.h"
+	.align 2
+.LC13:
+	.string	"__skb_put"
+	.align 2
+.LC14:
+	.string	"skb_put"
+	.align 2
+.LC15:
+	.string	"__skb_pull"
+	.align 2
+.LC16:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/netdevice.h"
+	.align 2
+.LC17:
+	.string	"netif_rx_complete"
+	.align 2
+.LC18:
+	.string	"__netif_rx_complete"
+	.align 2
+.LC19:
+	.string	"BUG: dst underflow %d: %p\n"
+	.align 2
+.LC20:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/net/sock.h"
+	.align 2
+.LC21:
+	.string	"sk_del_node_init"
+	.align 2
+.LC22:
+	.string	"sk_set_owner"
+	.align 2
+.LC23:
+	.string	"kiocb_to_siocb"
+	.align 2
+.LC24:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/kernel_stat.h"
+	.align 2
+.LC25:
+	.string	"kstat_irqs"
+	.align 2
+.LC26:
+	.string	"/scm/svn/dell/pub/linux-kernel/2.6/tags/linux-2.6.1-swsusp2/include/linux/raid/md_k.h"
+	.align 2
+.LC27:
+	.string	"pers_to_level"
+	.section	".data.nosave","aw"
+	.align 2
+	.type	 loop,@object
+	.size	 loop,4
+loop:
+	.long 0
+	.align 2
+	.type	 state1,@object
+	.size	 state1,4
+state1:
+	.long 0
+	.align 2
+	.type	 state2,@object
+	.size	 state2,4
+state2:
+	.long 0
+	.align 2
+	.type	 state3,@object
+	.size	 state3,4
+state3:
+	.long 0
+	.align 2
+	.type	 c_loops_per_jiffy_ref,@object
+	.size	 c_loops_per_jiffy_ref,4
+c_loops_per_jiffy_ref:
+	.long 0
+	.align 2
+	.type	 cpu_khz_ref,@object
+	.size	 cpu_khz_ref,4
+cpu_khz_ref:
+	.long 0
+	.section	".text"
+	.align 2
+	.globl do_swsusp_lowlevel
+	.type	 do_swsusp_lowlevel,@function
+do_swsusp_lowlevel:
+	stwu 1,-48(1)
+	mflr 0
+	stmw 23,12(1)
+	stw 0,52(1)
+	cmpwi 0,3,0
+	bc 4,2,.L3612
+	bl do_swsusp2_suspend_1
+	//bl ppc_save_reg
+	/* bl save_processor_state
+	bl save_stack */
+	bl do_swsusp2_suspend_2
+	b .L3611
+.L3612:
+	lis	2,swapper_pg_dir@ha	   
+	addi 2,2,swapper_pg_dir@l
+	bl do_swsusp2_resume_1
+	lis 9,swsusp_action@ha
+	lwz 0,swsusp_action@l(9)
+	lis 11,swsusp_debug_state@ha
+	lis 9,state1@ha
+	stw 0,state1@l(9)
+	lwz 8,swsusp_debug_state@l(11)
+	lis 10,console_printk@ha
+	lis 9,state2@ha
+	lis 11,pagedir_resume@ha
+	stw 8,state2@l(9)
+	la 11,pagedir_resume@l(11)
+	lwz 0,console_printk@l(10)
+	lwz 5,12(11)
+	lis 9,state3@ha
+	stw 0,state3@l(9)
+	lwz 10,0(5)
+	lwz 4,56(11)
+	lis 9,origoffset@ha
+	stw 10,origoffset@l(9)
+	lwz 0,0(4)
+	lis 11,copyoffset@ha
+	stw 0,copyoffset@l(11)
+	lwz 10,origoffset@l(9)
+	lwz 8,copyoffset@l(11)
+	slwi 9,10,2
+	slwi 11,8,2
+	add 9,9,10
+	add 11,11,8
+	lis 0,0xcccc
+	ori 0,0,52429
+	slwi 9,9,3
+	slwi 11,11,3
+	mullw 11,11,0
+	mullw 9,9,0
+	slwi 11,11,9
+	slwi 9,9,9
+	cmpwi 0,5,0
+	addis 9,9,0xc000
+	addis 11,11,0xc000
+	lis 7,origrange@ha
+	lis 6,copyrange@ha
+	lis 10,origpage@ha
+	lis 8,copypage@ha
+	lis 24,origrange@ha
+	lis 25,copyrange@ha
+	lis 12,origoffset@ha
+	lis 3,copyoffset@ha
+	stw 9,origpage@l(10)
+	stw 11,copypage@l(8)
+	stw 5,origrange@l(7)
+	stw 4,copyrange@l(6)
+	bc 12,2,.L3631
+	lis 4,0xcccc
+	lis 28,loop@ha
+	lis 26,origoffset@ha
+	lis 29,origrange@ha
+	lis 30,origpage@ha
+	ori 4,4,52429
+	lis 27,copyoffset@ha
+	lis 31,copypage@ha
+.L3617:
+	li 0,0
+	stw 0,loop@l(28)
+	lwz 9,loop@l(28)
+	cmplwi 0,9,1023
+	bc 12,1,.L3622
+	lis 7,loop@ha
+	lis 5,origpage@ha
+	lis 6,copypage@ha
+.L3620:
+	lwz 8,loop@l(7)
+	lwz 9,loop@l(7)
+	lwz 11,copypage@l(6)
+	slwi 9,9,2
+	lwzx 0,9,11
+	lwz 10,origpage@l(5)
+	slwi 8,8,2
+	stwx 0,8,10
+	lwz 9,loop@l(7)
+	addi 9,9,1
+	stw 9,loop@l(7)
+	lwz 0,loop@l(7)
+	cmplwi 0,0,1023
+	bc 4,1,.L3620
+.L3622:
+	lwz 11,origrange@l(29)
+	lwz 9,origoffset@l(26)
+	lwz 0,4(11)
+	cmplw 0,9,0
+	bc 4,0,.L3623
+	lwz 9,origoffset@l(12)
+	lwz 11,origpage@l(30)
+	addi 9,9,1
+	addi 11,11,4096
+	stw 9,origoffset@l(12)
+	stw 11,origpage@l(30)
+	b .L3624
+.L3623:
+	lwz 9,8(11)
+	cmpwi 0,9,0
+	stw 9,origrange@l(24)
+	bc 12,2,.L3624
+	lwz 9,0(9)
+	stw 9,origoffset@l(12)
+	lwz 0,origoffset@l(12)
+	slwi 9,0,2
+	add 9,9,0
+	slwi 9,9,3
+	mullw 9,9,4
+	slwi 9,9,9
+	addis 9,9,0xc000
+	stw 9,origpage@l(30)
+.L3624:
+	lis 9,copyrange@ha
+	lwz 9,copyrange@l(9)
+	lwz 11,copyoffset@l(27)
+	lwz 0,4(9)
+	cmplw 0,11,0
+	bc 4,0,.L3627
+	lwz 9,copyoffset@l(3)
+	lwz 11,copypage@l(31)
+	addi 9,9,1
+	addi 11,11,4096
+	stw 9,copyoffset@l(3)
+	stw 11,copypage@l(31)
+	b .L3615
+.L3627:
+	lwz 9,8(9)
+	cmpwi 0,9,0
+	stw 9,copyrange@l(25)
+	bc 12,2,.L3615
+	lwz 9,0(9)
+	stw 9,copyoffset@l(3)
+	lwz 0,copyoffset@l(3)
+	slwi 9,0,2
+	add 9,9,0
+	slwi 9,9,3
+	mullw 9,9,4
+	slwi 9,9,9
+	addis 9,9,0xc000
+	stw 9,copypage@l(31)
+.L3615:
+	lwz 0,origrange@l(29)
+	cmpwi 0,0,0
+	bc 4,2,.L3617
+.L3631:
+	lis 9,state1@ha
+	lwz 7,state1@l(9)
+	lis 11,state2@ha
+	lwz 8,state2@l(11)
+	lis 9,state3@ha
+	lwz 0,state3@l(9)
+	lis 11,swsusp_action@ha
+	lis 9,swsusp_debug_state@ha
+	lis 10,console_printk@ha
+	stw 7,swsusp_action@l(11)
+	stw 8,swsusp_debug_state@l(9)
+	stw 0,console_printk@l(10)
+	/* bl restore_stack
+	bl restore_processor_state */
+	//bl ppc_restore_reg
+	bl do_swsusp2_resume_2
+.L3611:
+	lwz 0,52(1)
+	mtlr 0
+	lmw 23,12(1)
+	la 1,48(1)
+	blr
+.Lfe1:
+	.size	 do_swsusp_lowlevel,.Lfe1-do_swsusp_lowlevel
+	.section	".data.nosave"
+	.align 2
+	.type	 origrange,@object
+	.size	 origrange,4
+origrange:
+	.space	4
+	.align 2
+	.type	 copyrange,@object
+	.size	 copyrange,4
+copyrange:
+	.space	4
+	.align 2
+	.type	 origoffset,@object
+	.size	 origoffset,4
+origoffset:
+	.space	4
+	.align 2
+	.type	 copyoffset,@object
+	.size	 copyoffset,4
+copyoffset:
+	.space	4
+	.align 2
+	.type	 origpage,@object
+	.size	 origpage,4
+origpage:
+	.space	4
+	.align 2
+	.type	 copypage,@object
+	.size	 copypage,4
+copypage:
+	.space	4
+	.align 2
+	.type	 orig_min_free,@object
+	.size	 orig_min_free,4
+orig_min_free:
+	.space	4
+	.section	".text"
+	.align 2
+	.globl do_swsusp2_copyback
+	.type	 do_swsusp2_copyback,@function
+do_swsusp2_copyback:
+	stwu 1,-48(1)
+	stmw 23,12(1)
+	lis 9,swsusp_action@ha
+	lwz 0,swsusp_action@l(9)
+	lis 11,swsusp_debug_state@ha
+	lis 9,state1@ha
+	stw 0,state1@l(9)
+	lwz 8,swsusp_debug_state@l(11)
+	lis 10,console_printk@ha
+	lis 9,state2@ha
+	lis 11,pagedir_resume@ha
+	stw 8,state2@l(9)
+	la 11,pagedir_resume@l(11)
+	lwz 0,console_printk@l(10)
+	lwz 5,12(11)
+	lis 9,state3@ha
+	stw 0,state3@l(9)
+	lwz 10,0(5)
+	lwz 4,56(11)
+	lis 9,origoffset@ha
+	stw 10,origoffset@l(9)
+	lwz 0,0(4)
+	lis 11,copyoffset@ha
+	stw 0,copyoffset@l(11)
+	lwz 10,origoffset@l(9)
+	lwz 8,copyoffset@l(11)
+	slwi 9,10,2
+	slwi 11,8,2
+	add 9,9,10
+	add 11,11,8
+	lis 0,0xcccc
+	ori 0,0,52429
+	slwi 9,9,3
+	slwi 11,11,3
+	mullw 11,11,0
+	mullw 9,9,0
+	slwi 11,11,9
+	slwi 9,9,9
+	cmpwi 0,5,0
+	addis 9,9,0xc000
+	addis 11,11,0xc000
+	lis 7,origrange@ha
+	lis 6,copyrange@ha
+	lis 10,origpage@ha
+	lis 8,copypage@ha
+	stw 9,origpage@l(10)
+	stw 11,copypage@l(8)
+	stw 5,origrange@l(7)
+	stw 4,copyrange@l(6)
+	lis 24,origrange@ha
+	lis 25,copyrange@ha
+	lis 12,origoffset@ha
+	lis 3,copyoffset@ha
+	bc 12,2,.L3594
+	lis 4,0xcccc
+	lis 28,loop@ha
+	lis 26,origoffset@ha
+	lis 29,origrange@ha
+	lis 30,origpage@ha
+	ori 4,4,52429
+	lis 27,copyoffset@ha
+	lis 31,copypage@ha
+.L3595:
+	li 0,0
+	stw 0,loop@l(28)
+	lwz 9,loop@l(28)
+	cmplwi 0,9,1023
+	bc 12,1,.L3597
+	lis 7,loop@ha
+	lis 5,origpage@ha
+	lis 6,copypage@ha
+.L3599:
+	lwz 8,loop@l(7)
+	lwz 9,loop@l(7)
+	lwz 11,copypage@l(6)
+	slwi 9,9,2
+	lwzx 0,9,11
+	lwz 10,origpage@l(5)
+	slwi 8,8,2
+	stwx 0,8,10
+	lwz 9,loop@l(7)
+	addi 9,9,1
+	stw 9,loop@l(7)
+	lwz 0,loop@l(7)
+	cmplwi 0,0,1023
+	bc 4,1,.L3599
+.L3597:
+	lwz 11,origrange@l(29)
+	lwz 9,origoffset@l(26)
+	lwz 0,4(11)
+	cmplw 0,9,0
+	bc 4,0,.L3601
+	lwz 9,origoffset@l(12)
+	lwz 11,origpage@l(30)
+	addi 9,9,1
+	addi 11,11,4096
+	stw 9,origoffset@l(12)
+	stw 11,origpage@l(30)
+	b .L3602
+.L3601:
+	lwz 9,8(11)
+	cmpwi 0,9,0
+	stw 9,origrange@l(24)
+	bc 12,2,.L3602
+	lwz 9,0(9)
+	stw 9,origoffset@l(12)
+	lwz 0,origoffset@l(12)
+	slwi 9,0,2
+	add 9,9,0
+	slwi 9,9,3
+	mullw 9,9,4
+	slwi 9,9,9
+	addis 9,9,0xc000
+	stw 9,origpage@l(30)
+.L3602:
+	lis 9,copyrange@ha
+	lwz 9,copyrange@l(9)
+	lwz 11,copyoffset@l(27)
+	lwz 0,4(9)
+	cmplw 0,11,0
+	bc 4,0,.L3605
+	lwz 9,copyoffset@l(3)
+	lwz 11,copypage@l(31)
+	addi 9,9,1
+	addi 11,11,4096
+	stw 9,copyoffset@l(3)
+	stw 11,copypage@l(31)
+	b .L3593
+.L3605:
+	lwz 9,8(9)
+	cmpwi 0,9,0
+	stw 9,copyrange@l(25)
+	bc 12,2,.L3593
+	lwz 9,0(9)
+	stw 9,copyoffset@l(3)
+	lwz 0,copyoffset@l(3)
+	slwi 9,0,2
+	add 9,9,0
+	slwi 9,9,3
+	mullw 9,9,4
+	slwi 9,9,9
+	addis 9,9,0xc000
+	stw 9,copypage@l(31)
+.L3593:
+	lwz 0,origrange@l(29)
+	cmpwi 0,0,0
+	bc 4,2,.L3595
+.L3594:
+	lis 9,state1@ha
+	lwz 7,state1@l(9)
+	lis 11,state2@ha
+	lwz 8,state2@l(11)
+	lis 9,state3@ha
+	lwz 0,state3@l(9)
+	lis 11,swsusp_action@ha
+	lis 9,swsusp_debug_state@ha
+	lis 10,console_printk@ha
+	stw 7,swsusp_action@l(11)
+	stw 8,swsusp_debug_state@l(9)
+	stw 0,console_printk@l(10)
+	lmw 23,12(1)
+	la 1,48(1)
+	blr
+.Lfe2:
+	.size	 do_swsusp2_copyback,.Lfe2-do_swsusp2_copyback
+	.align 2
+	.globl flush_tlb_all
+	.type	 flush_tlb_all,@function
+flush_tlb_all:
+	blr
+.Lfe3:
+	.size	 flush_tlb_all,.Lfe3-flush_tlb_all
+	.ident	"GCC: (GNU) 2.95.4 20011002 (Debian prerelease)"
Index: arch/ppc/kernel/Makefile
===================================================================
--- arch/ppc/kernel/Makefile	(revision 192)
+++ arch/ppc/kernel/Makefile	(working copy)
@@ -34,3 +34,5 @@
 obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif
 
+obj-$(CONFIG_SOFTWARE_SUSPEND2) += swsusp2-asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND2) += ppc_reg.o
Index: arch/ppc/kernel/ppc_reg.S
===================================================================
--- arch/ppc/kernel/ppc_reg.S	(revision 0)
+++ arch/ppc/kernel/ppc_reg.S	(revision 0)
@@ -0,0 +1,250 @@
+/*
+ * This file contains sleep low-level functions for PowerBook G3.
+ *    Copyright (C) 1999 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *    and Paul Mackerras (paulus@samba.org).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/cputable.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+#include <asm/offsets.h>
+
+#define MAGIC	0x4c617273	/* 'Lars' */
+
+/*
+ * Structure for storing CPU registers on the stack.
+ */
+#define SL_SP		0
+#define SL_PC		4
+#define SL_MSR		8
+#define SL_SDR1		0xc
+#define SL_SPRG0	0x10	/* 4 sprg's */
+#define SL_DBAT0	0x20
+#define SL_IBAT0	0x28
+#define SL_DBAT1	0x30
+#define SL_IBAT1	0x38
+#define SL_DBAT2	0x40
+#define SL_IBAT2	0x48
+#define SL_DBAT3	0x50
+#define SL_IBAT3	0x58
+#define SL_TB		0x60
+#define SL_R2		0x68
+#define SL_CR		0x6c
+#define SL_R12		0x70	/* r12 to r31 */
+#define SL_SIZE		(SL_R12 + 80)
+
+	.section .text
+	.align	5
+
+/* This gets called by via-pmu.c late during the sleep process.
+ * The PMU was already send the sleep command and will shut us down
+ * soon. We need to save all that is needed and setup the wakeup
+ * vector that will be called by the ROM on wakeup
+ */
+_GLOBAL(ppc_save_reg)
+	mflr	r0
+	stw	r0,4(r1)
+	stwu	r1,-SL_SIZE(r1)
+	mfcr	r0
+	stw	r0,SL_CR(r1)
+	stw	r2,SL_R2(r1)
+	stmw	r12,SL_R12(r1)
+
+	/* Save MSR & SDR1 */
+	mfmsr	r4
+	stw	r4,SL_MSR(r1)
+	mfsdr1	r4
+	stw	r4,SL_SDR1(r1)
+
+	/* Get a stable timebase and save it */
+1:	mftbu	r4
+	stw	r4,SL_TB(r1)
+	mftb	r5
+	stw	r5,SL_TB+4(r1)
+	mftbu	r3
+	cmpw	r3,r4
+	bne	1b
+
+	/* Save SPRGs */
+	mfsprg	r4,0
+	stw	r4,SL_SPRG0(r1)
+	mfsprg	r4,1
+	stw	r4,SL_SPRG0+4(r1)
+	mfsprg	r4,2
+	stw	r4,SL_SPRG0+8(r1)
+	mfsprg	r4,3
+	stw	r4,SL_SPRG0+12(r1)
+
+	/* Save BATs */
+	mfdbatu	r4,0
+	stw	r4,SL_DBAT0(r1)
+	mfdbatl	r4,0
+	stw	r4,SL_DBAT0+4(r1)
+	mfdbatu	r4,1
+	stw	r4,SL_DBAT1(r1)
+	mfdbatl	r4,1
+	stw	r4,SL_DBAT1+4(r1)
+	mfdbatu	r4,2
+	stw	r4,SL_DBAT2(r1)
+	mfdbatl	r4,2
+	stw	r4,SL_DBAT2+4(r1)
+	mfdbatu	r4,3
+	stw	r4,SL_DBAT3(r1)
+	mfdbatl	r4,3
+	stw	r4,SL_DBAT3+4(r1)
+	mfibatu	r4,0
+	stw	r4,SL_IBAT0(r1)
+	mfibatl	r4,0
+	stw	r4,SL_IBAT0+4(r1)
+	mfibatu	r4,1
+	stw	r4,SL_IBAT1(r1)
+	mfibatl	r4,1
+	stw	r4,SL_IBAT1+4(r1)
+	mfibatu	r4,2
+	stw	r4,SL_IBAT2(r1)
+	mfibatl	r4,2
+	stw	r4,SL_IBAT2+4(r1)
+	mfibatu	r4,3
+	stw	r4,SL_IBAT3(r1)
+	mfibatl	r4,3
+	stw	r4,SL_IBAT3+4(r1)
+
+	/* Backup various CPU config stuffs */
+	bl	__save_cpu_setup
+
+	/* Store a pointer to our backup storage into
+	 * a kernel global
+	 */
+	lis r3,sleep_storage@ha
+	addi r3,r3,sleep_storage@l
+	stw r5,0(r3)
+	
+_GLOBAL(ppc_restore_reg)
+	/* Recover sleep storage */
+	lis	r3,sleep_storage@ha
+	addi	r3,r3,sleep_storage@l
+	tophys(r3,r3)
+	lwz	r1,0(r3)
+	
+	/* Restore various CPU config stuffs */
+	bl	__restore_cpu_setup
+
+	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. */
+	lwz	r4,SL_SDR1(r1)
+	mtsdr1	r4
+	lwz	r4,SL_SPRG0(r1)
+	mtsprg	0,r4
+	lwz	r4,SL_SPRG0+4(r1)
+	mtsprg	1,r4
+	lwz	r4,SL_SPRG0+8(r1)
+	mtsprg	2,r4
+	lwz	r4,SL_SPRG0+12(r1)
+	mtsprg	3,r4
+
+	lwz	r4,SL_DBAT0(r1)
+	mtdbatu	0,r4
+	lwz	r4,SL_DBAT0+4(r1)
+	mtdbatl	0,r4
+	lwz	r4,SL_DBAT1(r1)
+	mtdbatu	1,r4
+	lwz	r4,SL_DBAT1+4(r1)
+	mtdbatl	1,r4
+	lwz	r4,SL_DBAT2(r1)
+	mtdbatu	2,r4
+	lwz	r4,SL_DBAT2+4(r1)
+	mtdbatl	2,r4
+	lwz	r4,SL_DBAT3(r1)
+	mtdbatu	3,r4
+	lwz	r4,SL_DBAT3+4(r1)
+	mtdbatl	3,r4
+	lwz	r4,SL_IBAT0(r1)
+	mtibatu	0,r4
+	lwz	r4,SL_IBAT0+4(r1)
+	mtibatl	0,r4
+	lwz	r4,SL_IBAT1(r1)
+	mtibatu	1,r4
+	lwz	r4,SL_IBAT1+4(r1)
+	mtibatl	1,r4
+	lwz	r4,SL_IBAT2(r1)
+	mtibatu	2,r4
+	lwz	r4,SL_IBAT2+4(r1)
+	mtibatl	2,r4
+	lwz	r4,SL_IBAT3(r1)
+	mtibatu	3,r4
+	lwz	r4,SL_IBAT3+4(r1)
+	mtibatl	3,r4
+BEGIN_FTR_SECTION
+	li	r4,0
+	mtspr	SPRN_DBAT4U,r4
+	mtspr	SPRN_DBAT4L,r4
+	mtspr	SPRN_DBAT5U,r4
+	mtspr	SPRN_DBAT5L,r4
+	mtspr	SPRN_DBAT6U,r4
+	mtspr	SPRN_DBAT6L,r4
+	mtspr	SPRN_DBAT7U,r4
+	mtspr	SPRN_DBAT7L,r4
+	mtspr	SPRN_IBAT4U,r4
+	mtspr	SPRN_IBAT4L,r4
+	mtspr	SPRN_IBAT5U,r4
+	mtspr	SPRN_IBAT5L,r4
+	mtspr	SPRN_IBAT6U,r4
+	mtspr	SPRN_IBAT6L,r4
+	mtspr	SPRN_IBAT7U,r4
+	mtspr	SPRN_IBAT7L,r4
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+
+#if 0
+	/* Flush all TLBs */
+	lis	r4,0x1000
+1:	addic.	r4,r4,-0x1000
+	tlbie	r4
+	blt	1b
+	sync
+
+	/* restore the MSR and turn on the MMU */
+	lwz	r3,SL_MSR(r1)
+	bl	turn_on_mmu
+
+	/* get back the stack pointer */
+	tovirt(r1,r1)
+
+	/* Restore TB */
+	li	r3,0
+	mttbl	r3
+	lwz	r3,SL_TB(r1)
+	lwz	r4,SL_TB+4(r1)
+	mttbu	r3
+	mttbl	r4
+
+	/* Restore the callee-saved registers and return */
+	lwz	r0,SL_CR(r1)
+	mtcr	r0
+	lwz	r2,SL_R2(r1)
+	lmw	r12,SL_R12(r1)
+	addi	r1,r1,SL_SIZE
+	lwz	r0,4(r1)
+	mtlr	r0
+	blr
+
+turn_on_mmu:
+	mflr	r4
+	tovirt(r4,r4)
+	mtsrr0	r4
+	mtsrr1	r3
+	sync
+	isync
+	rfi
+#endif
+	.section .data
+sleep_storage:
+	.long 0
Index: arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- arch/ppc/kernel/vmlinux.lds.S	(revision 192)
+++ arch/ppc/kernel/vmlinux.lds.S	(working copy)
@@ -72,6 +72,12 @@
     CONSTRUCTORS
   }
 
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
Index: arch/ppc/kernel/swsusp2.c
===================================================================
--- arch/ppc/kernel/swsusp2.c	(revision 0)
+++ arch/ppc/kernel/swsusp2.c	(revision 0)
@@ -0,0 +1,153 @@
+ /*
+  * Copyright 2003 Nigel Cunningham.
+  *
+  * This is the code that the code in swsusp2-asm.S for
+  * copying back the original kernel is based upon. It
+  * was based upon code that is...
+  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+  * Based on code
+  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+  */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/sysrq.h>
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/suspend-debug.h>
+#include <linux/suspend-common.h>
+#include <asm/uaccess.h>
+
+/* Local variables for do_swsusp2_suspend */
+volatile static int loop __nosavedata = 0;
+volatile static int state1 __nosavedata = 0;
+volatile static int state2 __nosavedata = 0;
+volatile static int state3 __nosavedata = 0;
+volatile static struct range *origrange __nosavedata;
+volatile static struct range *copyrange __nosavedata;
+volatile static int origoffset __nosavedata;
+volatile static int copyoffset __nosavedata;
+volatile static unsigned long * origpage __nosavedata;
+volatile static unsigned long * copypage __nosavedata;
+volatile static int orig_min_free __nosavedata;
+#ifndef CONFIG_SMP
+static unsigned long c_loops_per_jiffy_ref __nosavedata = 0;
+static unsigned long cpu_khz_ref __nosavedata = 0;
+#endif
+
+extern void do_swsusp2_suspend_1(void);
+extern void do_swsusp2_suspend_2(void);
+extern void do_swsusp2_resume_1(void);
+extern void do_swsusp2_resume_2(void);
+extern struct pagedir __nosavedata pagedir_resume;
+
+/*
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
+ */
+inline void do_swsusp2_copyback(void)
+{
+#ifdef CONFIG_PREEMPT
+	/*
+	 * Preempt disabled in kernel we're about to restore.
+	 * Make sure we match state now.
+	 */
+	preempt_disable();
+	PRINTPREEMPTCOUNT("Prior to copying old kernel back.");
+#endif
+
+	state1 = swsusp_action;
+	state2 = swsusp_debug_state;
+	state3 = console_loglevel;
+
+#ifndef CONFIG_SMP
+	//c_loops_per_jiffy_ref = cpu_data->loops_per_jiffy;
+	//cpu_khz_ref = cpu_khz;
+#endif
+	
+	origrange = pagedir_resume.origranges.first;
+	copyrange = pagedir_resume.destranges.first;
+	origoffset = origrange->minimum;
+	copyoffset = copyrange->minimum;
+	origpage = (unsigned long *) (page_address(mem_map + origoffset));
+	copypage = (unsigned long *) (page_address(mem_map + copyoffset));
+	//orig_min_free = swsusp_min_free;
+
+	while (origrange) {
+		for (loop=0; loop < (PAGE_SIZE / sizeof(unsigned long)); loop++)
+			*(origpage + loop) = *(copypage + loop);
+		
+		if (origoffset < origrange->maximum) {
+			origoffset++;
+			origpage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			origrange = origrange->next;
+			if (origrange) {
+				origoffset = origrange->minimum;
+				origpage = (unsigned long *) (page_address(mem_map + origoffset));
+			}
+		}
+
+		if (copyoffset < copyrange->maximum) {
+			copyoffset++;
+			copypage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			copyrange = copyrange->next;
+			if (copyrange) {
+				copyoffset = copyrange->minimum;
+				copypage = (unsigned long *) (page_address(mem_map + copyoffset));
+			}
+		}
+	}
+	
+/* Ahah, we now run with our old stack, and with registers copied from
+   suspend time */
+
+#ifndef CONFIG_SMP
+	//cpu_data->loops_per_jiffy = c_loops_per_jiffy_ref;
+	//loops_per_jiffy = c_loops_per_jiffy_ref;
+	//cpu_khz = cpu_khz_ref;
+#endif
+	swsusp_action = state1;
+	swsusp_debug_state = state2;
+	console_loglevel = state3;
+	//swsusp_min_free = orig_min_free;
+}
+
+extern void save_process_state();
+extern void restore_process_state();
+extern void save_stack();
+extern void restore_stack();
+
+void do_swsusp_lowlevel(int resume)
+{
+	if (!resume) {
+		do_swsusp2_suspend_1();
+		save_processor_state();
+		save_stack();
+		do_swsusp2_suspend_2();
+		return;
+	}
+	__asm__ __volatile__("lis %%r2, %0":"=m"(swapper_pg_dir));	
+//	__asm__ __volatile__("addi %%r2, %%r2, %0":"memory"(swapper_pg_dir));
+	do_swsusp2_resume_1();
+	do_swsusp2_copyback();
+	restore_stack();
+	restore_processor_state();
+	do_swsusp2_resume_2();
+	return;
+}
+
+void flush_tlb_all()
+{
+}
Index: kernel/power/swsusp2.c
===================================================================
--- kernel/power/swsusp2.c	(revision 192)
+++ kernel/power/swsusp2.c	(working copy)
@@ -54,7 +54,9 @@
 
 #include <linux/suspend-common.h>
 #include <linux/suspend-version-specific.h>
+#ifdef  CONFIG_X86
 #include <asm/i387.h> /* for kernel_fpu_end */
+#endif
 #ifdef	CONFIG_KDB
 #include <linux/kdb.h>
 #endif	/* CONFIG_KDB */
@@ -327,7 +329,9 @@
 	preempt_enable();
 #endif
 
+#ifdef CONFIG_X86
 	kernel_fpu_end();
+#endif
 
 	PRINTPREEMPTCOUNT("Prior to resuming drivers.");
 
@@ -486,10 +490,10 @@
 #endif
 
 	PRINTPREEMPTCOUNT("In resume_2 after copy back.");
-
+#ifdef CONFIG_X86
 	kernel_fpu_end();
-
 	PRINTPREEMPTCOUNT("In resume_2 after fpu end.");
+#endif
 	
 #ifdef CONFIG_PREEMPT
 	preempt_enable();

--Multipart=_Mon__19_Jan_2004_10_52_37_+0800_CyrBEuU.jnjUrst1
Content-Type: application/octet-stream;
 name="suspend"
Content-Disposition: attachment;
 filename="suspend"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpzd2Fwb24gLWEKc3luYwpzeW5jCgoKZm9yIGkgaW4gYGxzbW9kIHwgYXdrICd7
cHJpbnQgJDF9J2AKZG8KCXJtbW9kICRpCmRvbmUKCm1vdW50IC10IHByb2Mgbm9uZSAvcHJvYwpt
b3VudCAvc3lzCgplY2hvIC1uICJkaXNrIiA+IC9zeXMvcG93ZXIvc3RhdGUKZWNobyAtbiAiNiIg
PiAvcHJvYy9zd3N1c3AvZGVmYXVsdF9jb25zb2xlX2xldmVsCmVjaG8gLW4gIjEiID4gL3Byb2Mv
c3dzdXNwL3Nsb3cKZWNobyAtbiAiMSIgPiAvcHJvYy9zd3N1c3AvZGVidWdfc2VjdGlvbnMKZWNo
byAtbiAiMSIgPiAvcHJvYy9zd3N1c3AvYWN0aXZhdGUK

--Multipart=_Mon__19_Jan_2004_10_52_37_+0800_CyrBEuU.jnjUrst1--
