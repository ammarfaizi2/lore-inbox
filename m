Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUAXDAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 22:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266647AbUAXDAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 22:00:46 -0500
Received: from palrel13.hp.com ([156.153.255.238]:41437 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265549AbUAXDAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 22:00:37 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16401.57298.175645.749468@napali.hpl.hp.com>
Date: Fri, 23 Jan 2004 19:00:34 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, paulus@samba.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
In-Reply-To: <20040120090004.48995f2a.akpm@osdl.org>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 20 Jan 2004 09:00:04 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> Jes Sorensen <jes@trained-monkey.org> wrote:
  >>  The new sort_extable and shares search_extable code doesn't work
  >> on ia64.

  Andrew> hm, OK.  It would be nice if ia64 could use the generic code
  Andrew> at some stage, of course.

How about something along these lines?  If you want to standardize on
a single instruction-address format, I'd strongly favor using the
location-relative addresses used on Alpha and ia64 (it makes no sense
to uses a full 64-bit address for those members).

	--david

===== lib/extable.c 1.3 vs edited =====
--- 1.3/lib/extable.c	Tue Jan 20 17:58:55 2004
+++ edited/lib/extable.c	Fri Jan 23 18:10:10 2004
@@ -19,6 +19,12 @@
 extern struct exception_table_entry __stop___ex_table[];
 
 #ifndef ARCH_HAS_SORT_EXTABLE
+
+# ifndef exception_table_entry_insn
+   /* Return the instruction address to which exception tabl entry E applies.  */
+#  define exception_table_entry_insn(e)	((e)->insn)
+# endif
+
 /*
  * The exception table needs to be sorted so that the binary
  * search that we use to find entries in it works properly.
@@ -33,7 +39,7 @@
 	/* insertion sort */
 	for (p = start + 1; p < finish; ++p) {
 		/* start .. p-1 is sorted */
-		if (p[0].insn < p[-1].insn) {
+		if (exception_table_entry_insn(&p[0]) < exception_table_entry_insn(&p[-1])) {
 			/* move element p down to its right place */
 			el = *p;
 			q = p;
@@ -41,7 +47,8 @@
 				/* el comes before q[-1], move q[-1] up one */
 				q[0] = q[-1];
 				--q;
-			} while (q > start && el.insn < q[-1].insn);
+			} while (q > start && (exception_table_entry_insn(&el)
+					       < exception_table_entry_insn(&q[-1])));
 			*q = el;
 		}
 	}
===== include/asm-ia64/uaccess.h 1.16 vs edited =====
--- 1.16/include/asm-ia64/uaccess.h	Fri Jan 23 16:43:32 2004
+++ edited/include/asm-ia64/uaccess.h	Fri Jan 23 18:06:38 2004
@@ -283,13 +283,18 @@
 	__su_ret;						\
 })
 
-#define ARCH_HAS_SORT_EXTABLE
 #define ARCH_HAS_SEARCH_EXTABLE
 
 struct exception_table_entry {
-	int addr;	/* gp-relative address of insn this fixup is for */
-	int cont;	/* gp-relative continuation address; if bit 2 is set, r9 is set to 0 */
+	int addr;	/* loc-relative address of insn this fixup is for */
+	int cont;	/* loc-relative continuation address; if bit 2 is set, r9 is set to 0 */
 };
+
+#define exception_table_entry_insn(e)				\
+({								\
+	const struct exception_table_entry *_etei_e = (e);	\
+	(u64) &(_etei_e)->addr + (_etei_e)->addr;		\
+})
 
 extern void handle_exception (struct pt_regs *regs, const struct exception_table_entry *e);
 extern const struct exception_table_entry *search_exception_tables (unsigned long addr);
