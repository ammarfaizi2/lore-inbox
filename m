Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWBHTtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBHTtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWBHTtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:49:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:54537 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751135AbWBHTtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:49:49 -0500
Date: Wed, 8 Feb 2006 20:49:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       paul.mckenney@us.ibm.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch 01/03] add EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060208194926.GA8671@mars.ravnborg.org>
References: <20060208184816.GA17016@kroah.com> <20060208184922.GB17016@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208184922.GB17016@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 10:49:22AM -0800, Greg KH wrote:
> This patch adds the ability to mark symbols that will be changed in the
> future, so that non-GPL usage of them is flagged by the kernel and
> printed out to the system log.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
The patch duplicate too much code to my taste at least.
May I suggest to consolidate a little in module.c before applying the
GPL_FUTURE stuff.

Have you considered: EXPORT_GPL_SOON()?

	Sam

See sample patch for potential consolidation:
[compiletime tested only...]

diff --git a/kernel/module.c b/kernel/module.c
index 618ed6e..e07a22e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -135,6 +135,18 @@ extern const unsigned long __start___kcr
 #define symversion(base, idx) ((base) ? ((base) + (idx)) : NULL)
 #endif
 
+/* lookup symbol in given range of kernel_symbols */
+static int lookup_symbol(const char *name,
+			 const struct kernel_symbol *start,
+			 const struct kernel_symbol *stop)
+{
+	unsigned int i;
+	for (i = 0; start + i < stop; i++)
+		if (strcmp(start[i].name, name) == 0)
+			return i;
+	return -1;
+}
+
 /* Find a symbol, return value, crc and module which owns it */
 static unsigned long __find_symbol(const char *name,
 				   struct module **owner,
@@ -142,39 +154,40 @@ static unsigned long __find_symbol(const
 				   int gplok)
 {
 	struct module *mod;
-	unsigned int i;
+	int i;
 
 	/* Core kernel first. */ 
 	*owner = NULL;
-	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++) {
-		if (strcmp(__start___ksymtab[i].name, name) == 0) {
-			*crc = symversion(__start___kcrctab, i);
-			return __start___ksymtab[i].value;
-		}
+	i = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
+	if (i >= 0) {
+		*crc = symversion(__start___kcrctab, i);
+		return __start___ksymtab[i].value;
 	}
 	if (gplok) {
-		for (i = 0; __start___ksymtab_gpl+i<__stop___ksymtab_gpl; i++)
-			if (strcmp(__start___ksymtab_gpl[i].name, name) == 0) {
-				*crc = symversion(__start___kcrctab_gpl, i);
-				return __start___ksymtab_gpl[i].value;
-			}
+		i = lookup_symbol(name, __start___ksymtab_gpl,
+					__stop___ksymtab_gpl);
+		if (i >= 0) {
+			*crc = symversion(__start___kcrctab_gpl, i);
+			return __start___ksymtab_gpl[i].value;
+		}
 	}
 
 	/* Now try modules. */ 
 	list_for_each_entry(mod, &modules, list) {
 		*owner = mod;
-		for (i = 0; i < mod->num_syms; i++)
-			if (strcmp(mod->syms[i].name, name) == 0) {
-				*crc = symversion(mod->crcs, i);
-				return mod->syms[i].value;
-			}
+		i = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
+		if (i >= 0) {
+			*crc = symversion(mod->crcs, i);
+			return mod->syms[i].value;
+		}
 
 		if (gplok) {
-			for (i = 0; i < mod->num_gpl_syms; i++) {
-				if (strcmp(mod->gpl_syms[i].name, name) == 0) {
-					*crc = symversion(mod->gpl_crcs, i);
-					return mod->gpl_syms[i].value;
-				}
+			i = lookup_symbol(name, 
+					  mod->gpl_syms,
+					  mod->gpl_syms + mod->num_gpl_syms);
+			if (i >= 0) {
+				*crc = symversion(mod->gpl_crcs, i);
+				return mod->gpl_syms[i].value;
 			}
 		}
 	}
