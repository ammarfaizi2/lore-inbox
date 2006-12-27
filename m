Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbWL0Lus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWL0Lus (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWL0Lur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:50:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42894 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292AbWL0Luq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:50:46 -0500
Date: Wed, 27 Dec 2006 17:20:40 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/4] Modpost whitelist reference to more symbols (pattern 3)
Message-ID: <20061227115040.GD22606@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o MODPOST generates warning on i386 if kernel is compiled with
  CONFIG_RELOCATABLE=y.

WARNING: vmlinux - Section mismatch: reference to .init.text:__init_begin from .text between 'free_initmem' (at offset 0xc0114fd3) and 'do_test_wp_bit'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0xc012aeae) and 'kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'core_kernel_text' (at offset 0xc012aeb7) and 'kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'get_symbol_pos' (at offset 0xc0135776) and 'reset_iter'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'get_symbol_pos' (at offset 0xc013577d) and 'reset_iter'

o These symbols (__init_begin, _sinittext, _einittext) belong to init
  section and generally represent a section boundary. These are special
  symbols in the sense that their size is zero and no memory is allocated
  for them in init section. Their addr and value are same. So even if
  we free the init section, it is ok to reference them.

o Whitelist access to such select symbols in MODPOST.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 scripts/mod/modpost.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff -puN scripts/mod/modpost.c~modpost-whitelist-references-to-some-specific-symbols scripts/mod/modpost.c
--- linux-2.6.20-rc2-reloc/scripts/mod/modpost.c~modpost-whitelist-references-to-some-specific-symbols	2006-12-27 16:25:01.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/scripts/mod/modpost.c	2006-12-27 16:25:01.000000000 +0530
@@ -582,9 +582,19 @@ static int strrcmp(const char *s, const 
  *   tosec   = .init.text | .exit.text | .init.data
  *   fromsec = .data
  *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
+ *
+ * Pattern 3:
+ *   Some symbols belong to init section but still it is ok to reference
+ *   these from non-init sections as these symbols don't have any memory
+ *   allocated for them and symbol address and value are same. So even
+ *   if init section is freed, its ok to reference those symbols.
+ *   For ex. symbols marking the init section boundaries.
+ *   This pattern is identified by
+ *   refsymname = __init_begin, _sinittext, _einittext
  **/
 static int secref_whitelist(const char *modname, const char *tosec,
-			    const char *fromsec, const char *atsym)
+			    const char *fromsec, const char *atsym,
+			    const char *refsymname)
 {
 	int f1 = 1, f2 = 1;
 	const char **s;
@@ -599,6 +609,13 @@ static int secref_whitelist(const char *
 		NULL
 	};
 
+	const char *pat3refsym[] = {
+		"__init_begin",
+		"_sinittext",
+		"_einittext",
+		NULL
+	};
+
 	/* Check for pattern 1 */
 	if (strcmp(tosec, ".init.data") != 0)
 		f1 = 0;
@@ -637,6 +654,11 @@ static int secref_whitelist(const char *
 			((strcmp(tosec, ".init.data") == 0) ||
 			(strcmp(tosec, ".init.text") == 0)))
 		return 1;
+
+		/* Check for pattern 3 */
+		for (s = pat3refsym; *s; s++)
+			if (strcmp(refsymname, *s) == 0)
+				return 1;
 	}
 	return 0;
 }
@@ -746,7 +768,7 @@ static void warn_sec_mismatch(const char
 	/* check whitelist - we may ignore it */
 	if (before &&
 	    secref_whitelist(modname, secname, fromsec,
-			     elf->strtab + before->st_name))
+			     elf->strtab + before->st_name, refsymname))
 		return;
 
 	if (before && after) {
_
