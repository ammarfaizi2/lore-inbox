Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWIENnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWIENnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWIENnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:43:51 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:49226 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965060AbWIENnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:43:49 -0400
Message-ID: <44FD7FED.7000603@sw.ru>
Date: Tue, 05 Sep 2006 17:47:25 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>
Subject: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
Content-Type: multipart/mixed;
 boundary="------------030102030104060903020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030102030104060903020101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

At stage 2 modpost utility is used to check modules.
In case of unresolved symbols modpost only prints warning.

IMHO it is a good idea to fail compilation process in case of
unresolved symbols, since usually such errors are left unnoticed,
but kernel modules are broken.

Signed-Off-By: Andrey Mirkin <amirkin@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dfde0e8..81cbf95 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1187,16 +1187,19 @@ static void add_header(struct buffer *b,
 /**
  * Record CRCs for unresolved symbols
  **/
-static void add_versions(struct buffer *b, struct module *mod)
+static int add_versions(struct buffer *b, struct module *mod)
 {
 	struct symbol *s, *exp;
+	int err = 0;
 
 	for (s = mod->unres; s; s = s->next) {
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
-			if (have_vmlinux && !s->weak)
+			if (have_vmlinux && !s->weak) {
 				warn("\"%s\" [%s.ko] undefined!\n",
 				     s->name, mod->name);
+				err = 1;
+			}
 			continue;
 		}
 		s->module = exp->module;
@@ -1205,7 +1208,7 @@ static void add_versions(struct buffer *
 	}
 
 	if (!modversions)
-		return;
+		return err;
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const struct modversion_info ____versions[]\n");
@@ -1225,6 +1228,8 @@ static void add_versions(struct buffer *
 	}
 
 	buf_printf(b, "};\n");
+
+	return err;
 }
 
 static void add_depends(struct buffer *b, struct module *mod,
@@ -1402,6 +1407,7 @@ int main(int argc, char **argv)
 	char *kernel_read = NULL, *module_read = NULL;
 	char *dump_write = NULL;
 	int opt;
+	int err;
 
 	while ((opt = getopt(argc, argv, "i:I:mo:a")) != -1) {
 		switch(opt) {
@@ -1441,6 +1447,8 @@ int main(int argc, char **argv)
 		check_exports(mod);
 	}
 
+	err = 0;
+
 	for (mod = modules; mod; mod = mod->next) {
 		if (mod->skip)
 			continue;
@@ -1448,7 +1456,7 @@ int main(int argc, char **argv)
 		buf.pos = 0;
 
 		add_header(&buf, mod);
-		add_versions(&buf, mod);
+		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
 		add_srcversion(&buf, mod);
@@ -1460,5 +1468,5 @@ int main(int argc, char **argv)
 	if (dump_write)
 		write_dump(dump_write);
 
-	return 0;
+	return err;
 }


--------------030102030104060903020101
Content-Type: text/plain;
 name="diff-modpost-undefined-symbols-20060905"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-modpost-undefined-symbols-20060905"

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dfde0e8..81cbf95 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1187,16 +1187,19 @@ static void add_header(struct buffer *b,
 /**
  * Record CRCs for unresolved symbols
  **/
-static void add_versions(struct buffer *b, struct module *mod)
+static int add_versions(struct buffer *b, struct module *mod)
 {
 	struct symbol *s, *exp;
+	int err = 0;
 
 	for (s = mod->unres; s; s = s->next) {
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
-			if (have_vmlinux && !s->weak)
+			if (have_vmlinux && !s->weak) {
 				warn("\"%s\" [%s.ko] undefined!\n",
 				     s->name, mod->name);
+				err = 1;
+			}
 			continue;
 		}
 		s->module = exp->module;
@@ -1205,7 +1208,7 @@ static void add_versions(struct buffer *
 	}
 
 	if (!modversions)
-		return;
+		return err;
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const struct modversion_info ____versions[]\n");
@@ -1225,6 +1228,8 @@ static void add_versions(struct buffer *
 	}
 
 	buf_printf(b, "};\n");
+
+	return err;
 }
 
 static void add_depends(struct buffer *b, struct module *mod,
@@ -1402,6 +1407,7 @@ int main(int argc, char **argv)
 	char *kernel_read = NULL, *module_read = NULL;
 	char *dump_write = NULL;
 	int opt;
+	int err;
 
 	while ((opt = getopt(argc, argv, "i:I:mo:a")) != -1) {
 		switch(opt) {
@@ -1441,6 +1447,8 @@ int main(int argc, char **argv)
 		check_exports(mod);
 	}
 
+	err = 0;
+
 	for (mod = modules; mod; mod = mod->next) {
 		if (mod->skip)
 			continue;
@@ -1448,7 +1456,7 @@ int main(int argc, char **argv)
 		buf.pos = 0;
 
 		add_header(&buf, mod);
-		add_versions(&buf, mod);
+		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
 		add_srcversion(&buf, mod);
@@ -1460,5 +1468,5 @@ int main(int argc, char **argv)
 	if (dump_write)
 		write_dump(dump_write);
 
-	return 0;
+	return err;
 }


--------------030102030104060903020101--
