Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUHNLm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUHNLm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUHNLm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:42:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28365 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268641AbUHNLl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:41:27 -0400
Date: Sat, 14 Aug 2004 13:42:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O8
Message-ID: <20040814114251.GA8462@elte.hu>
References: <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040814075135.GB20123@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814075135.GB20123@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> > other changes in -O8: the massive kallsyms-lookup speedup from Paulo
> > Marque
> 
> Do you have this as an independent patch - or an URL?

yeah, attached below.

	Ingo

--- linux/kernel/kallsyms.c.orig	
+++ linux/kernel/kallsyms.c	
@@ -22,6 +22,13 @@ extern char kallsyms_names[] __attribute
 /* Defined by the linker script. */
 extern char _stext[], _etext[], _sinittext[], _einittext[];
 
+/* auxiliary markers to speed up symbol lookup */
+#define KALLSYMS_STEM_MARKS	8
+
+static int kallsyms_stem_mark_idx[KALLSYMS_STEM_MARKS];
+static char *kallsyms_stem_mark[KALLSYMS_STEM_MARKS];
+
+
 static inline int is_kernel_inittext(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext
@@ -56,13 +63,42 @@ unsigned long kallsyms_lookup_name(const
 	return module_kallsyms_lookup_name(name);
 }
 
+/* build markers into the compressed symbol table, so that lookups can be faster */
+static void build_stem_marks(void)
+{
+	char *name = kallsyms_names;
+	int i, mark_cnt;
+
+	unsigned prefix;
+
+	mark_cnt = 0;
+	for (i = 0 ; i < kallsyms_num_syms; i++) { 
+		prefix=*name;
+		if (prefix == 0) {
+			/* if this is the first 0-prefix stem in the desired interval */
+			if(i > (mark_cnt + 1) * (kallsyms_num_syms / (KALLSYMS_STEM_MARKS + 1)) && 
+			   kallsyms_stem_mark_idx[mark_cnt]==0) {
+				kallsyms_stem_mark[mark_cnt] = name;
+				kallsyms_stem_mark_idx[mark_cnt] = i;
+				mark_cnt++;
+				if(mark_cnt >= KALLSYMS_STEM_MARKS) break;
+			}
+		}
+		do {
+			name++;
+		} while(*name);
+		name ++;
+	}
+}
 /* Lookup an address.  modname is set to NULL if it's in the kernel. */
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
-	unsigned long i, best = 0;
+	unsigned long i, last_0idx = 0;
+	unsigned long mark, low, high, mid;
+	char *last_0prefix = NULL;
 
 	/* This kernel should never had been booted. */
 	BUG_ON(!kallsyms_addresses);
@@ -72,39 +108,67 @@ const char *kallsyms_lookup(unsigned lon
 
 	if (is_kernel_text(addr) || is_kernel_inittext(addr)) {
 		unsigned long symbol_end;
-		char *name = kallsyms_names;
+		char *name;
 
-		/* They're sorted, we could be clever here, but who cares? */
-		for (i = 0; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best] &&
-			    kallsyms_addresses[i] <= addr)
-				best = i;
+		/* do a binary search on the sorted kallsyms_addresses array */
+		low = 0;
+		high = kallsyms_num_syms;
+		while( high-low > 1 ) { 
+			mid = (low + high) / 2;
+			if( kallsyms_addresses[mid] <= addr ) low = mid;
+			else high = mid;
 		}
 
 		/* Grab name */
-		for (i = 0; i <= best; i++) { 
-			unsigned prefix = *name++;
-			strncpy(namebuf + prefix, name, KSYM_NAME_LEN - prefix);
-			name += strlen(name) + 1;
-		}
+		i = 0;
+		name = kallsyms_names;
 
-		/* At worst, symbol ends at end of section. */
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else
-			symbol_end = (unsigned long)_etext;
+		if(kallsyms_stem_mark_idx[0]==0)
+			build_stem_marks();
+
+		for(mark = 0; mark < KALLSYMS_STEM_MARKS; mark++) {
+			if( low >= kallsyms_stem_mark_idx[mark] ) {
+				i = kallsyms_stem_mark_idx[mark];
+				name = kallsyms_stem_mark[mark];
+			}
+			else break;
+		}
 
-		/* Search for next non-aliased symbol */
-		for (i = best+1; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best]) {
-				symbol_end = kallsyms_addresses[i];
-				break;
+		/* find the last stem before the actual symbol that as 0 prefix */
+		unsigned prefix;
+		for (; i <= low; i++) { 
+			prefix=*name;
+			if (prefix == 0) {
+				last_0prefix = name;
+				last_0idx = i;
 			}
+			do {
+				name++;
+			} while(*name);
+			name ++;
 		}
 
-		*symbolsize = symbol_end - kallsyms_addresses[best];
+		/* build the name from there */
+		name = last_0prefix;
+		for (i = last_0idx; i <= low; i++) { 
+			prefix = *name++;
+			strncpy(namebuf + prefix, name, KSYM_NAME_LEN - prefix);
+			name += strlen(name) + 1;
+		}
+
+		if(low == kallsyms_num_syms - 1) {
+			/* At worst, symbol ends at end of section. */
+			if (is_kernel_inittext(addr))
+				symbol_end = (unsigned long)_einittext;
+			else
+				symbol_end = (unsigned long)_etext;
+		}
+		else
+			symbol_end = kallsyms_addresses[low + 1];
+		
+		*symbolsize = symbol_end - kallsyms_addresses[low];
 		*modname = NULL;
-		*offset = addr - kallsyms_addresses[best];
+		*offset = addr - kallsyms_addresses[low];
 		return namebuf;
 	}
 
