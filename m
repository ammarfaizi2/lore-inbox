Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbTDWVSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTDWVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:18:46 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:24960 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263981AbTDWVSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:18:39 -0400
Date: Wed, 23 Apr 2003 23:30:38 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Oopses in apply_alternatives
Message-ID: <20030423213038.GA6389@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
  I somehow missed apply_alternatives inclusion into the kernel, so
I have no idea whether you are right person...

  It is not good idea to call apply_alternatives from module_finalize,
as apply_alternatives is __init function... It spectaculary crashed
here while inserting VMware's vmnet module. In standard kernel 
.altinstructions section occurs (from few modules I have) in uhci-hcd 
and usbcore.

  Patch below appears to fix problem.

vana:/tmp/vmware-config0$ objdump -h vmnet.o

vmnet.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00003f3d  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .fixup        00000014  00000000  00000000  00003f71  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  2 __ksymtab_strings 00000075  00000000  00000000  00003f85  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 __ksymtab     00000040  00000000  00000000  00003ffc  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  4 .rodata.str1.32 00000ae0  00000000  00000000  00004040  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rodata.str1.1 000001ba  00000000  00000000  00004b20  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 __ex_table    00000010  00000000  00000000  00004cdc  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  7 .altinstructions 0000000a  00000000  00000000  00004cec  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  8 .data         00000458  00000000  00000000  00004d00  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  9 .gnu.linkonce.this_module 00000280  00000000  00000000  00005180  2**7
                  CONTENTS, ALLOC, LOAD, RELOC, DATA, LINK_ONCE_DISCARD
 10 .bss          00000058  00000000  00000000  00005400  2**5
                  ALLOC
 11 .comment      0000011a  00000000  00000000  00005400  2**0
                  CONTENTS, READONLY

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux-2.5.68-c1179.dist/arch/i386/kernel/setup.c	2003-04-23 14:13:22.000000000 +0200
+++ linux-2.5.68-c1179/arch/i386/kernel/setup.c	2003-04-23 23:18:45.000000000 +0200
@@ -802,7 +802,7 @@
    APs have less capabilities than the boot processor are not handled. 
     
    In this case boot with "noreplacement". */ 
-void __init apply_alternatives(void *start, void *end) 
+void apply_alternatives(void *start, void *end) 
 { 
 	struct alt_instr *a; 
 	int diff, i, k;
