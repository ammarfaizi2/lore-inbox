Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267610AbUHMWZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267610AbUHMWZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUHMWZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:25:49 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:63498 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S267610AbUHMWZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:25:41 -0400
Message-ID: <411D3C24.4030006@vmware.com>
Date: Fri, 13 Aug 2004 15:09:40 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@codemonkey.org, hpa@zytor.com
Subject: [PATCH] i386 - remove unnecessary unbusy TSS code
Content-Type: multipart/mixed;
 boundary="------------010702030605090307070203"
X-OriginalArrivalTime: 13 Aug 2004 22:09:40.0127 (UTC) FILETIME=[3A8D0AF0:01C48182]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: mailhost1.vmware.com)
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702030605090307070203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was looking at GDT updates in the Linux kernel and noticed some 
redundant code in initialization of the per-CPU GDT.  This code is no 
longer necessary or commented, so I removed it for simplicity (and it 
saves 20 bytes of code space).

Version: patched against 2.6.7
Testing: compile and boot a Linux 2.6.7 kernel with my patch.

--------------010702030605090307070203
Content-Type: text/plain;
 name="README.gdt-unbusy"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.gdt-unbusy"

The TSS no longer needs to be unbusied before loading the task register,
since the set_tss_desc macros set the system gate type to Available IA-32 TSS.
This obscure, uncommented legacy code can now be removed for better
readability and saves 20 bytes of code space. 

Here is a breakdown of __set_tss_desc + load_TR before and after.  The
doublefault TSS GDT setup has similar savings.

- Zachary Amsden (zach@vmware.com)

before:
c01d4535:       ba 80 20 1b c0          mov    $0xc01b2080,%edx
c01d453a:       b8 00 d8 1c c0          mov    $0xc01cd800,%eax
c01d453f:       66 c7 42 00 eb 00       movw   $0xeb,0x0(%edx)
c01d4545:       66 89 42 02             mov    %ax,0x2(%edx)
c01d4549:       c1 c8 10                ror    $0x10,%eax
c01d454c:       88 42 04                mov    %al,0x4(%edx)
c01d454f:       c6 42 05 89             movb   $0x89,0x5(%edx)
                                                  ^^ non-busy
c01d4553:       c6 42 06 00             movb   $0x0,0x6(%edx)
c01d4557:       88 62 07                mov    %ah,0x7(%edx)
c01d455a:       c1 c8 10                ror    $0x10,%eax
c01d455d:       81 25 84 20 1b c0 ff    andl   $0xfffffdff,0xc01b2084
c01d4564:       fd ff ff
c01d4567:       b8 80 00 00 00          mov    $0x80,%eax
c01d456c:       0f 00 d8                ltr    %ax

now:
c01d4535:       ba 80 20 1b c0          mov    $0xc01b2080,%edx
c01d453a:       b8 00 d8 1c c0          mov    $0xc01cd800,%eax
c01d453f:       66 c7 42 00 eb 00       movw   $0xeb,0x0(%edx)
c01d4545:       66 89 42 02             mov    %ax,0x2(%edx)
c01d4549:       c1 c8 10                ror    $0x10,%eax
c01d454c:       88 42 04                mov    %al,0x4(%edx)
c01d454f:       c6 42 05 89             movb   $0x89,0x5(%edx)
c01d4553:       c6 42 06 00             movb   $0x0,0x6(%edx)
c01d4557:       88 62 07                mov    %ah,0x7(%edx)
c01d455a:       c1 c8 10                ror    $0x10,%eax
c01d455d:       b8 80 00 00 00          mov    $0x80,%eax
c01d4562:       0f 00 d8                ltr    %ax


--------------010702030605090307070203
Content-Type: text/plain;
 name="gdt-unbusy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdt-unbusy.patch"

--- arch/i386/kernel/cpu/common.c.orig	2004-08-13 14:16:28.000000000 -0700
+++ arch/i386/kernel/cpu/common.c	2004-08-13 14:16:46.000000000 -0700
@@ -552,13 +552,11 @@
 
 	load_esp0(t, thread);
 	set_tss_desc(cpu,t);
-	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-	cpu_gdt_table[cpu][GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
 
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");

--------------010702030605090307070203--
