Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUHNEvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUHNEvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 00:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUHNEvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 00:51:07 -0400
Received: from [195.23.16.24] ([195.23.16.24]:53903 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265910AbUHNEux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 00:50:53 -0400
Message-ID: <411D9A2A.1000202@grupopie.com>
Date: Sat, 14 Aug 2004 05:50:50 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it> <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de> <20040813135109.GA20638@elte.hu>
In-Reply-To: <20040813135109.GA20638@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------070200000600090005060508"
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070200000600090005060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
>...
> 
>>With binary search you would need to backward search to find the stem
>>for the stem compression. It's probably doable, but would be a bit
>>ugly I guess.
> 
> 
> yeah. Maybe someone will find the time to improve the algorithm. But
> it's not a highprio thing.

Well, I found some time and decided to give it a go :)

I first built a small test program that could provide the same symbol 
data to the lookup function, so that I could test using a user space app.

This way I could benchmark both the original algorithm and any 
improvement I could make, and do it confortably from user space.

The original algorithm took, on average, 1340us per lookup on my P4 
2.8GHz. The compile settings for the test are not the same on the 
kernel, so this can be only compared against other results from the same 
setup.

With the attached patch it takes 14us per lookup. This is almost a 100x 
improvement.

The largest portion of the time it took to do a lookup, was the 
decompression of the symbol names. It seemed a waste of time to keep 
strcpy'ing over the result lots of names that would probably not 
contribute to the final name.

With the strcpy's out, the speed-up was around 5x, but even then, 
looking sequentially for the symbol name was still slow.

The final algorithm pre-calculates markers on the compressed symbols so 
that the search time is almost divided by the number of markers.

There are still a few issues with this approach. The biggest issue is 
that this is clearly a speed/space trade-off, and maybe we don't want to 
waste the space on a code path that is not supposed to be "hot". If this 
is the case, I can make a smaller patch, that fixes just the name 
"decompression" strcpy's.

As always, any comments will be greatly appreciated.


Just one side note: gcc gives a warning about 2 variables that might be 
used before initialization. I know they are not, and it didn't seem a 
good idea to put extra code just to shut up gcc. What is the standard 
way to convince gcc that those vars are ok?

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

--------------070200000600090005060508
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- kernel/kallsyms.c.old	2004-08-14 00:28:58.000000000 +0100
+++ kernel/kallsyms.c	2004-08-14 05:10:09.873194752 +0100
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
+	unsigned long i, last_0idx;
+	unsigned long mark, low, high, mid;
+	char *last_0prefix;
 
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
 

--------------070200000600090005060508--
