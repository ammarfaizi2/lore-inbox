Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTH1Fqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbTH1FqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:46:16 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:26012 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263759AbTH1FQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:16:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Give v850 its own version of the vmlinux.lds.h RODATA macro
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030828051554.C75443729@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 28 Aug 2003 14:15:54 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

While it would be nice to keep using the generic version of RODATA, the
v850's linker-script structure is sufficiently different from that of
typical archs that it's not possible to use RODATA as it's currently
defined.  I earlier suggested splitting the generic definition of RODATA
into `RODATA_CONTENTS' and `RODATA' (a wrapper around RODATA_CONTENTS)
where most archs would use RODATA, and the v850 would use
RODATA_CONTENTS, however Kai didn't like that idea.

It _may_ be possible to rewrite the v850's linker scripts into something
more typical (using lots of individual output sections), but it doesn't
seem at all straightforward, so I don't have the time to do it right
now.

Anyway, this is the short-term work-around so that Linus's kernel works
on the v850.

diff -ruN -X../cludes linux-2.6.0-test4-uc0/arch/v850/kernel/vmlinux.lds.S linux-2.6.0-test4-uc0-v850-20030827/arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.0-test4-uc0/arch/v850/kernel/vmlinux.lds.S	2003-08-25 13:23:18.000000000 +0900
+++ linux-2.6.0-test4-uc0-v850-20030827/arch/v850/kernel/vmlinux.lds.S	2003-08-26 16:21:26.000000000 +0900
@@ -33,6 +33,30 @@
 			*(.intv.mach)	/* Machine-specific int. vectors.  */ \
 		__intv_end = . ;
 
+#define RODATA_CONTENTS							      \
+		. = ALIGN (16) ;					      \
+			*(.rodata) *(.rodata.*)				      \
+			*(__vermagic)		/* Kernel version magic */    \
+			*(.rodata1)					      \
+		/* Kernel symbol table: Normal symbols */		      \
+		___start___ksymtab = .;					      \
+			*(__ksymtab)					      \
+		___stop___ksymtab = .;					      \
+		/* Kernel symbol table: GPL-only symbols */		      \
+		___start___ksymtab_gpl = .;				      \
+			*(__ksymtab_gpl)				      \
+		___stop___ksymtab_gpl = .;				      \
+		/* Kernel symbol table: strings */			      \
+			*(__ksymtab_strings)				      \
+		/* Kernel symbol table: Normal symbols */		      \
+		___start___kcrctab = .;					      \
+			*(__kcrctab)					      \
+		___stop___kcrctab = .;					      \
+		/* Kernel symbol table: GPL-only symbols */		      \
+		___start___kcrctab_gpl = .;				      \
+			*(__kcrctab_gpl)				      \
+		___stop___kcrctab_gpl = .;				      \
+
 /* Kernel text segment, and some constant data areas.  */
 #define TEXT_CONTENTS							      \
 		__stext = . ;						      \
@@ -42,7 +66,7 @@
 			*(.text.lock)					      \
 			*(.exitcall.exit)				      \
 		__real_etext = . ;	/* There may be data after here.  */  \
-		RODATA                                                        \
+		RODATA_CONTENTS						      \
 		. = ALIGN (4) ;						      \
 		    	*(.call_table_data)				      \
 			*(.call_table_text)				      \
