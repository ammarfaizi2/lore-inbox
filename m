Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268506AbUHQWoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268506AbUHQWoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268489AbUHQWmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:42:37 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:6917 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S268492AbUHQWlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:41:36 -0400
Message-ID: <41228862.1090001@vmware.com>
Date: Tue, 17 Aug 2004 15:36:18 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       linux-kernel@vger.kernel.org
Subject: [PATCH] i386-unbusy-tss
Content-Type: multipart/mixed;
 boundary="------------080001010106020106030909"
X-OriginalArrivalTime: 17 Aug 2004 22:36:18.0812 (UTC) FILETIME=[9D1803C0:01C484AA]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.17; host: mailhost1.vmware.com)
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.17; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080001010106020106030909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was looking at GDT updates in the Linux kernel and noticed some 
redundant code in initialization of the per-CPU GDT.  This code is no 
longer necessary or commented, so I removed it.   Basically, the code 
was trying to unbusy the TSS descriptor (which the set_tss_desc and 
__set_tss_desc functions already do by setting the descriptor type).  
This change saves only 20 bytes of space and makes the code more 
readable and maintainable.

Version: patched against 2.6.8.1-mm1
Testing: compile and boot a Linux 2.6 kernel with my patch.

Cheers,

Zachary Amsden

--------------080001010106020106030909
Content-Type: text/plain;
 name="i386-unbusy-tss.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-unbusy-tss.patch"

--- linux-2.6.8.1-mm1.orig/arch/i386/kernel/cpu/common.c	2004-08-17 15:09:03.000000000 -0700
+++ linux-2.6.8.1-mm1/arch/i386/kernel/cpu/common.c	2004-08-17 15:10:51.000000000 -0700
@@ -559,13 +559,11 @@
 
 	load_esp0(t, thread);
 	set_tss_desc(cpu,t);
-	per_cpu(cpu_gdt_table,cpu)[GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
 	/* Set up doublefault TSS pointer in the GDT */
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-	per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_DOUBLEFAULT_TSS].b &= 0xfffffdff;
 
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");

--------------080001010106020106030909
Content-Type: text/plain;
 name="README.i386-unbusy-tss"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.i386-unbusy-tss"

The TSS no longer needs to be unbusied before loading the task register,
since the set_tss_desc macros set the system gate type to Available IA-32 TSS.
This obscure, uncommented legacy code can now be removed for better
readability and saves 20 bytes of code space. 

Here is a breakdown of __set_tss_desc + load_TR before and after.  The
doublefault TSS GDT setup has similar savings.

- Zachary Amsden (zach@vmware.com)

before:
c01e0556:       ba 80 66 1f c0          mov    $0xc01f6680,%edx
c01e055b:       b8 e0 8f 1b c0          mov    $0xc01b8fe0,%eax
c01e0560:       66 c7 42 00 6b 20       movw   $0x206b,0x0(%edx)
c01e0566:       66 89 42 02             mov    %ax,0x2(%edx)
c01e056a:       c1 c8 10                ror    $0x10,%eax
c01e056d:       88 42 04                mov    %al,0x4(%edx)
c01e0570:       c6 42 05 89             movb   $0x89,0x5(%edx)
                                                  ^^ not busy TSS
c01e0574:       c6 42 06 00             movb   $0x0,0x6(%edx)
c01e0578:       88 62 07                mov    %ah,0x7(%edx)
c01e057b:       c1 c8 10                ror    $0x10,%eax
c01e057e:       81 25 84 66 1f c0 ff    andl   $0xfffffdff,0xc01f6684
c01e0585:       fd ff ff
                                                      ^^ clear busy
c01e0588:       b8 80 00 00 00          mov    $0x80,%eax
c01e058d:       0f 00 d8                ltr    %ax


after:

c01e0556:       ba 80 66 1f c0          mov    $0xc01f6680,%edx
c01e055b:       b8 e0 8f 1b c0          mov    $0xc01b8fe0,%eax
c01e0560:       66 c7 42 00 6b 20       movw   $0x206b,0x0(%edx)
c01e0566:       66 89 42 02             mov    %ax,0x2(%edx)
c01e056a:       c1 c8 10                ror    $0x10,%eax
c01e056d:       88 42 04                mov    %al,0x4(%edx)
c01e0570:       c6 42 05 89             movb   $0x89,0x5(%edx)
c01e0574:       c6 42 06 00             movb   $0x0,0x6(%edx)
c01e0578:       88 62 07                mov    %ah,0x7(%edx)
c01e057b:       c1 c8 10                ror    $0x10,%eax
c01e057e:       b8 80 00 00 00          mov    $0x80,%eax
c01e0583:       0f 00 d8                ltr    %ax


--------------080001010106020106030909--
