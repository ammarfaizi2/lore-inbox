Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWBZVXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWBZVXv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWBZVXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:23:51 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29202 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750810AbWBZVXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:23:51 -0500
Date: Sun, 26 Feb 2006 22:23:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [PATCH] kbuild: get rid of false positives in section mismatch warnings
Message-ID: <20060226212341.GA20340@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch committed to my kbuild tree and pushed out.
I removes most of the false positives I have seen.

There is still a way to go before we are warning free...

Please note - all the small fixes sent out earlier are not included in
my tree. I assume subsystem maintainers ar Andrew will pick them up.
But if requested I can drop them in a separate git tree.

	Sam

diff-tree 4c8fbca5836aaafd165aa8732d92ab5d4f3a6841 (from cc006288fb538005a14ca4297250abbf0beeb0b9)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Feb 26 22:18:11 2006 +0100

    kbuild: whitelist false section mismatch warnings
    
    In several cases the section mismatch check triggered false warnings.
    Following patch introduce a whitelist to 'false positives' are not warned of.
    Two types of patterns are recognised:
    1) Typical case when a module parameter is _initdata
    2) When a function pointer is assigned to a driver structure
    
    In both patterns we rely on the actual name of the variable assigned
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index de0a9ee..663b1ef 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -450,10 +450,93 @@ static char *get_modinfo(void *modinfo, 
 	}
 	return NULL;
 }
 
 /**
+ * Test if string s ends in string sub
+ * return 0 if match
+ **/
+static int strrcmp(const char *s, const char *sub)
+{
+        int slen, sublen;
+	
+	if (!s || !sub)
+		return 1;
+	
+	slen = strlen(s);
+        sublen = strlen(sub);
+	
+	if ((slen == 0) || (sublen == 0))
+		return 1;
+
+        if (sublen > slen)
+                return 1;
+
+        return memcmp(s + slen - sublen, sub, sublen);
+}
+
+/**
+ * Whitelist to allow certain references to pass with no warning.
+ * Pattern 1:
+ *   If a module parameter is declared __initdata and permissions=0
+ *   then this is legal despite the warning generated.
+ *   We cannot see value of permissions here, so just ignore
+ *   this pattern.
+ *   The pattern is identified by:
+ *   tosec   = .init.data
+ *   fromsec = .data
+ *   atsym   =__param*
+ *   
+ * Pattern 2:
+ *   Many drivers utilise a *_driver container with references to
+ *   add, remove, probe functions etc.
+ *   These functions may often be marked __init and we do not want to
+ *   warn here.
+ *   the pattern is identified by:
+ *   tosec   = .init.text | .exit.text
+ *   fromsec = .data
+ *   atsym = *_driver, *_ops, *_probe, *probe_one
+ **/
+static int secref_whitelist(const char *tosec, const char *fromsec,
+			  const char *atsym)
+{
+	int f1 = 1, f2 = 1;
+	const char **s;
+	const char *pat2sym[] = {
+		"_driver",
+		"_ops",
+		"_probe",
+		"_probe_one",
+		NULL
+	};
+	
+	/* Check for pattern 1 */
+	if (strcmp(tosec, ".init.data") != 0)
+		f1 = 0;
+	if (strcmp(fromsec, ".data") != 0)
+		f1 = 0;
+	if (strncmp(atsym, "__param", strlen("__param")) != 0)
+		f1 = 0;
+
+	if (f1)
+		return f1;
+
+	/* Check for pattern 2 */
+	if ((strcmp(tosec, ".init.text") != 0) && 
+	    (strcmp(tosec, ".exit.text") != 0))
+		f2 = 0;
+	if (strcmp(fromsec, ".data") != 0)
+		f2 = 0;
+
+	for (s = pat2sym; *s; s++)
+		if (strrcmp(atsym, *s) == 0)
+			f1 = 1;
+
+	return f1 && f2;
+}
+
+/**
  * Find symbol based on relocation record info.
  * In some cases the symbol supplied is a valid symbol so
  * return refsym. If st_name != 0 we assume this is a valid symbol.
  * In other cases the symbol needs to be looked up in the symbol table
  * based on section and address.
@@ -516,10 +599,11 @@ static void find_symbols_between(struct 
 }
 
 /**
  * Print a warning about a section mismatch.
  * Try to find symbols near it so user can find it.
+ * Check whitelist before warning - it may be a false positive.
  **/
 static void warn_sec_mismatch(const char *modname, const char *fromsec,
 			      struct elf_info *elf, Elf_Sym *sym, Elf_Rela r)
 {
 	const char *refsymname = "";
@@ -534,10 +618,15 @@ static void warn_sec_mismatch(const char
 	find_symbols_between(elf, r.r_offset, fromsec, &before, &after);
 
 	refsym = find_elf_symbol(elf, r.r_addend, sym);
 	if (refsym && strlen(elf->strtab + refsym->st_name))
 		refsymname = elf->strtab + refsym->st_name;
+
+	/* check whitelist - we may ignore it */
+	if (before && 
+	    secref_whitelist(secname, fromsec, elf->strtab + before->st_name))
+		return;
 	
 	if (before && after) {
 		warn("%s - Section mismatch: reference to %s:%s from %s "
 		     "between '%s' (at offset 0x%llx) and '%s'\n",
 		     modname, secname, refsymname, fromsec,
