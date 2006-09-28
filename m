Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWI1Jy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWI1Jy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWI1Jyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:54:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20911 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751816AbWI1Jyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:54:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=f7K8seXMoWhazDb5PbajMQyh/ywhEltRgtaEmXzaMk8wb+16lb64VZ3ycW3e7TAGRqIt3v0dPmwyfay4B/lCXtLeoKjP/ZQ26qBRJB3YtZGhAj9lDjF1e6rzH9CDBQPg3s1hB+ajV/eJGDfu/2ChMSyQlwnmtdlgSzwxypDPgnY=
Message-ID: <451B9C1F.3050502@innova-card.com>
Date: Thu, 28 Sep 2006 11:55:43 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: akpm@osdl.org
CC: pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Create kallsyms_lookup_size_offset() [try #2]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some uses of kallsyms_lookup() do not need to find out the name of
a symbol and its module's name it belongs. This is specially true
in arch specific code, which needs to unwind the stack to show the
back trace during oops (mips is an example). In this specific case,
we just need to retreive the function's size and the offset of the
active intruction inside it.

This simple patch adds a new entry "kallsyms_lookup_size_offset()"
This new entry does exactly the same as kallsyms_lookup() but does
not require any buffers to store any names.

It returns 0 if it fails otherwise 1.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/kallsyms.h |   11 ++++
 kernel/kallsyms.c        |  125 ++++++++++++++++++++++++++++++----------------
 kernel/module.c          |    3 +
 3 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 849043c..1cebcbc 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -12,6 +12,10 @@ #ifdef CONFIG_KALLSYMS
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
 
+extern int kallsyms_lookup_size_offset(unsigned long addr,
+				  unsigned long *symbolsize,
+				  unsigned long *offset);
+
 /* Lookup an address.  modname is set to NULL if it's in the kernel. */
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
@@ -28,6 +32,13 @@ static inline unsigned long kallsyms_loo
 	return 0;
 }
 
+static inline int kallsyms_lookup_size_offset(unsigned long addr,
+					      unsigned long *symbolsize,
+					      unsigned long *offset)
+{
+	return 0;
+}
+
 static inline const char *kallsyms_lookup(unsigned long addr,
 					  unsigned long *symbolsize,
 					  unsigned long *offset,
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index ab16a5a..168619a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -69,6 +69,15 @@ static inline int is_kernel(unsigned lon
 	return in_gate_area_no_task(addr);
 }
 
+static int is_ksym_addr(unsigned long addr)
+{
+	if (all_var)
+		return is_kernel(addr);
+
+	return is_kernel_text(addr) || is_kernel_inittext(addr) ||
+		is_kernel_extratext(addr);
+}
+
 /* expand a compressed symbol data into the resulting uncompressed string,
    given the offset to where the symbol is in the compressed stream */
 static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
@@ -156,6 +165,73 @@ unsigned long kallsyms_lookup_name(const
 }
 EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
+static unsigned long get_symbol_pos(unsigned long addr,
+				    unsigned long *symbolsize,
+				    unsigned long *offset)
+{
+	unsigned long symbol_start = 0, symbol_end = 0;
+	unsigned long i, low, high, mid;
+
+	/* This kernel should never had been booted. */
+	BUG_ON(!kallsyms_addresses);
+
+	/* do a binary search on the sorted kallsyms_addresses array */
+	low = 0;
+	high = kallsyms_num_syms;
+
+	while (high - low > 1) {
+		mid = (low + high) / 2;
+		if (kallsyms_addresses[mid] <= addr)
+			low = mid;
+		else
+			high = mid;
+	}
+
+	/*
+	 * search for the first aliased symbol. Aliased
+	 * symbols are symbols with the same address
+	 */
+	while (low && kallsyms_addresses[low-1] == kallsyms_addresses[low])
+		--low;
+
+	symbol_start = kallsyms_addresses[low];
+
+	/* Search for next non-aliased symbol */
+	for (i = low + 1; i < kallsyms_num_syms; i++) {
+		if (kallsyms_addresses[i] > symbol_start) {
+			symbol_end = kallsyms_addresses[i];
+			break;
+		}
+	}
+	
+	/* if we found no next symbol, we use the end of the section */
+	if (!symbol_end) {
+		if (is_kernel_inittext(addr))
+			symbol_end = (unsigned long)_einittext;
+		else if (all_var)
+			symbol_end = (unsigned long)_end;
+		else 
+			symbol_end = (unsigned long)_etext;
+	}
+
+	*symbolsize = symbol_end - symbol_start;
+	*offset = addr - symbol_start;
+
+	return low;
+}
+
+/*
+ * Lookup an address but don't bother to find any names.
+ */
+int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
+				unsigned long *offset)
+{
+	if (is_ksym_addr(addr))
+		return !!get_symbol_pos(addr, symbolsize, offset);
+
+	return !!module_address_lookup(addr, symbolsize, offset, NULL);
+}
+
 /*
  * Lookup an address
  * - modname is set to NULL if it's in the kernel
@@ -168,57 +244,18 @@ const char *kallsyms_lookup(unsigned lon
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
-	unsigned long i, low, high, mid;
 	const char *msym;
 
-	/* This kernel should never had been booted. */
-	BUG_ON(!kallsyms_addresses);
-
 	namebuf[KSYM_NAME_LEN] = 0;
 	namebuf[0] = 0;
 
-	if ((all_var && is_kernel(addr)) ||
-	    (!all_var && (is_kernel_text(addr) || is_kernel_inittext(addr) ||
-				is_kernel_extratext(addr)))) {
-		unsigned long symbol_end = 0;
-
-		/* do a binary search on the sorted kallsyms_addresses array */
-		low = 0;
-		high = kallsyms_num_syms;
-
-		while (high-low > 1) {
-			mid = (low + high) / 2;
-			if (kallsyms_addresses[mid] <= addr) low = mid;
-			else high = mid;
-		}
-
-		/* search for the first aliased symbol. Aliased symbols are
-		   symbols with the same address */
-		while (low && kallsyms_addresses[low - 1] == kallsyms_addresses[low])
-			--low;
-
+	if (is_ksym_addr(addr)) {
+		unsigned long pos;
+		
+		pos = get_symbol_pos(addr, symbolsize, offset);
 		/* Grab name */
-		kallsyms_expand_symbol(get_symbol_offset(low), namebuf);
-
-		/* Search for next non-aliased symbol */
-		for (i = low + 1; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[low]) {
-				symbol_end = kallsyms_addresses[i];
-				break;
-			}
-		}
-
-		/* if we found no next symbol, we use the end of the section */
-		if (!symbol_end) {
-			if (is_kernel_inittext(addr))
-				symbol_end = (unsigned long)_einittext;
-			else
-				symbol_end = all_var ? (unsigned long)_end : (unsigned long)_etext;
-		}
-
-		*symbolsize = symbol_end - kallsyms_addresses[low];
+		kallsyms_expand_symbol(get_symbol_offset(pos), namebuf);
 		*modname = NULL;
-		*offset = addr - kallsyms_addresses[low];
 		return namebuf;
 	}
 
diff --git a/kernel/module.c b/kernel/module.c
index 2a19cd4..0e3e6ab 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2012,7 +2012,8 @@ const char *module_address_lookup(unsign
 	list_for_each_entry(mod, &modules, list) {
 		if (within(addr, mod->module_init, mod->init_size)
 		    || within(addr, mod->module_core, mod->core_size)) {
-			*modname = mod->name;
+			if (modname)
+				*modname = mod->name;
 			return get_ksymbol(mod, addr, size, offset);
 		}
 	}
-- 
1.4.2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

