Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263684AbUD0CLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUD0CLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUD0CLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:11:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:9349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263684AbUD0CLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:11:02 -0400
X-Authenticated: #21910825
Message-ID: <408DC0E0.7090500@gmx.net>
Date: Tue, 27 Apr 2004 04:09:36 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Blacklist binary-only modules lying about their license
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070604010608020205040708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604010608020205040708
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

LinuxAnt offers binary only modules without any sources. To circumvent our
MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:

MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
LICENSE file applies");

Since string comparisons stop at the first "\0" character, the kernel is
tricked into thinking the modules are GPL. Btw, the "GPL" directory they
are speaking about is empty.

The attached patch blacklists all modules having "Linuxant" or "Conexant"
in their author string. This may seem a bit broad, but AFAIK both
companies never have released anything under the GPL and have a strong
history of binary-only modules.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------070604010608020205040708
Content-Type: text/plain;
 name="module_blacklist.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module_blacklist.diff"

--- linux-2.6.5/kernel/module.c~	2004-04-04 05:37:37.000000000 +0200
+++ linux-2.6.5/kernel/module.c	2004-04-27 01:24:14.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/vermagic.h>
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
+#include <linux/string.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -1112,6 +1113,14 @@
 	}
 }
 
+static inline int license_author_is_not_blacklisted(const char *author)
+{
+	/* LinuxAnt is known to ship non-GPL modules with license=="GPL"
+	   to cheat on our checks. Stop them from doing that. */
+	return !(strstr(author, "Linuxant")
+		|| strstr(author, "Conexant"));
+}
+
 static inline int license_is_gpl_compatible(const char *license)
 {
 	return (strcmp(license, "GPL") == 0
@@ -1121,12 +1130,16 @@
 		|| strcmp(license, "Dual MPL/GPL") == 0);
 }
 
-static void set_license(struct module *mod, const char *license)
+static void set_license(struct module *mod, const char *license,
+			const char *author)
 {
 	if (!license)
 		license = "unspecified";
+	if (!author)
+		author = "unspecified";
 
-	mod->license_gplok = license_is_gpl_compatible(license);
+	mod->license_gplok = license_is_gpl_compatible(license)
+				&& license_author_is_not_blacklisted(author);
 	if (!mod->license_gplok) {
 		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
 		       mod->name, license);
@@ -1466,7 +1479,8 @@
 	module_unload_init(mod);
 
 	/* Set up license info based on the info section */
-	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
+	set_license(mod, get_modinfo(sechdrs, infoindex, "license"),
+			get_modinfo(sechdrs, infoindex, "author"));
 
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,

--------------070604010608020205040708--


