Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUAZXeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAZXeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:34:18 -0500
Received: from palrel10.hp.com ([156.153.255.245]:25063 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265594AbUAZXd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:33:56 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16405.41953.344071.456754@napali.hpl.hp.com>
Date: Mon, 26 Jan 2004 15:33:53 -0800
To: Paul Mackerras <paulus@samba.org>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
In-Reply-To: <16402.19894.686335.695215@cargo.ozlabs.ibm.com>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
	<16402.19894.686335.695215@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 24 Jan 2004 21:49:26 +1100, Paul Mackerras <paulus@samba.org> said:

  Paul> David Mosberger writes:
  >> How about something along these lines?  If you want to
  >> standardize on a single instruction-address format, I'd strongly
  >> favor using the location-relative addresses used on Alpha and
  >> ia64 (it makes no sense to uses a full 64-bit address for those
  >> members).

  Paul> Won't you have to change the offset when you move the entry,
  Paul> if the value you store is relative to the address of the
  Paul> entry?

Details, details!

How about the attached one?  It will touch memory more when moving an
element down, but we're talking about exception tables here, and I
don't think module loading time would be affected in any noticable
fashion.

	--david

===== arch/ia64/mm/extable.c 1.7 vs edited =====
--- 1.7/arch/ia64/mm/extable.c	Sun Jan 18 03:36:30 2004
+++ edited/arch/ia64/mm/extable.c	Fri Jan 23 18:04:24 2004
@@ -10,11 +10,6 @@
 #include <asm/uaccess.h>
 #include <asm/module.h>
 
-void sort_extable(struct exception_table_entry *start,
-		  struct exception_table_entry *finish)
-{
-}
-
 const struct exception_table_entry *
 search_extable (const struct exception_table_entry *first,
 		const struct exception_table_entry *last,
===== include/asm-ia64/uaccess.h 1.16 vs edited =====
--- 1.16/include/asm-ia64/uaccess.h	Fri Jan 23 16:43:32 2004
+++ edited/include/asm-ia64/uaccess.h	Mon Jan 26 15:15:28 2004
@@ -283,13 +283,42 @@
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
+static inline int
+extable_compare_entries (struct exception_table_entry *l, struct exception_table_entry *r)
+{
+	u64 lip = (u64) &l->addr + l->addr;
+	u64 rip = (u64) &r->addr + r->addr;
+
+	if (lip < rip)
+		return -1;
+	if (lip == rip)
+		return 0;
+	else
+		return 1;
+}
+
+static inline void
+extable_swap_entries (struct exception_table_entry *l, struct exception_table_entry *r)
+{
+	u64 delta = (u64) r - (u64) l;
+	struct exception_table_entry tmp;
+
+	tmp = *l;
+	l->addr = r->addr + delta;
+	l->cont = r->cont + delta;
+	r->addr = tmp.addr - delta;
+	r->cont = tmp.cont - delta;
+}
+
+#define extable_compare_entries	extable_compare_entries
+#define extable_swap_entries	extable_swap_entries
 
 extern void handle_exception (struct pt_regs *regs, const struct exception_table_entry *e);
 extern const struct exception_table_entry *search_exception_tables (unsigned long addr);
===== lib/extable.c 1.3 vs edited =====
--- 1.3/lib/extable.c	Tue Jan 20 17:58:55 2004
+++ edited/lib/extable.c	Mon Jan 26 15:23:12 2004
@@ -18,7 +18,25 @@
 extern struct exception_table_entry __start___ex_table[];
 extern struct exception_table_entry __stop___ex_table[];
 
-#ifndef ARCH_HAS_SORT_EXTABLE
+#ifndef extable_compare_entries
+
+/*
+ * Compare exception-table entries L and R and return <0 if L is smaller, 0 if L and R are
+ * equal and >0 if L is bigger.
+ */
+# define extable_compare_entries(l,r)	((l)->insn - (r)->insn)
+
+static inline void
+extable_swap_entries (struct exception_table_entry *l, struct exception_table_entry *r)
+{
+	struct exception_table_entry tmp;
+
+	tmp = *l;
+	*l = *r;
+	*r = tmp;
+}
+#endif /* !extable_compare_entries */
+
 /*
  * The exception table needs to be sorted so that the binary
  * search that we use to find entries in it works properly.
@@ -28,25 +46,14 @@
 void sort_extable(struct exception_table_entry *start,
 		  struct exception_table_entry *finish)
 {
-	struct exception_table_entry el, *p, *q;
+	struct exception_table_entry *p, *q;
 
 	/* insertion sort */
-	for (p = start + 1; p < finish; ++p) {
-		/* start .. p-1 is sorted */
-		if (p[0].insn < p[-1].insn) {
-			/* move element p down to its right place */
-			el = *p;
-			q = p;
-			do {
-				/* el comes before q[-1], move q[-1] up one */
-				q[0] = q[-1];
-				--q;
-			} while (q > start && el.insn < q[-1].insn);
-			*q = el;
-		}
-	}
+	for (p = start + 1; p < finish; ++p)
+		/* start .. p-1 is sorted; push p down to it's proper place */
+		for (q = p; q > start && extable_compare_entries(&q[0], &q[-1]) < 0; --q)
+			extable_swap_entries(&q[0], &q[-1]);
 }
-#endif
 
 #ifndef ARCH_HAS_SEARCH_EXTABLE
 /*
