Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbTIETSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbTIETS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:18:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:21393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265767AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:56:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [CFT] [1/15] table-driven filesystems option parsing
Message-Id: <20030905115615.283cab00.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is based on a patch that was begun by Al Viro and
Al asked that it be added to the must-fix list in the
May 21 "must fix" IRC discussion.
<http://lwn.net/Articles/33220/>

Current (full) patch is at
http://developer.osdl.org/rddunlap/patches/linux-260t4g-fsoptions.patch

These patches apply to 2.6.0-test4 or -current (Sept. 5/2003).

I have tested ext3, ext3, fat, isofs, jfs, & proc.

I'd appreciate others testing all of these, please, especially
the ones that I can't test (adfs, affs, hfs, hpfs, ufd, ufs,
autofs[4]).

--
~Randy


This is the parser library and header file.


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/include/linux/parser.h linux-260-test4-fs/include/linux/parser.h
--- linux-260-test4-pv/include/linux/parser.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-260-test4-fs/include/linux/parser.h	2003-09-03 13:01:25.000000000 -0700
@@ -0,0 +1,21 @@
+struct match_token {
+	int token;
+	char *pattern;
+};
+
+typedef struct match_token match_table_t[];
+
+enum {MAX_OPT_ARGS = 3};
+
+typedef struct {
+	char *from;
+	char *to;
+} substring_t;
+
+int match_token(char *s, match_table_t table, substring_t args[]);
+
+int match_int(substring_t *);
+int match_octal(substring_t *);
+int match_hex(substring_t *);
+void match_strcpy(char *, substring_t *);
+char *match_strdup(substring_t *);
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/lib/Makefile linux-260-test4-fs/lib/Makefile
--- linux-260-test4-pv/lib/Makefile	2003-08-22 16:51:34.000000000 -0700
+++ linux-260-test4-fs/lib/Makefile	2003-08-27 11:19:07.000000000 -0700
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o
+	 kobject.o idr.o div64.o parser.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/lib/parser.c linux-260-test4-fs/lib/parser.c
--- linux-260-test4-pv/lib/parser.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-260-test4-fs/lib/parser.c	2003-09-03 13:21:24.000000000 -0700
@@ -0,0 +1,131 @@
+/*
+ * lib/parser.c - simple parser for mount, etc. options.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/ctype.h>
+#include <linux/module.h>
+#include <linux/parser.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+static int match_one(char *s, char *p, substring_t args[])
+{
+	char *meta;
+	int argc = 0;
+
+	if (!p)
+		return 1;
+
+	while(1) {
+		int len = -1;
+		meta = strchr(p, '%');
+		if (!meta)
+			return strcmp(p, s) == 0;
+
+		if (strncmp(p, s, meta-p))
+			return 0;
+
+		s += meta - p;
+		p = meta + 1;
+
+		if (isdigit(*p))
+			len = simple_strtoul(p, &p, 10);
+		else if (*p == '%') {
+			if (*s++ != '%')
+				return 0;
+			continue;
+		}
+
+		if (argc >= MAX_OPT_ARGS)
+			return 0;
+
+		args[argc].from = s;
+		switch (*p++) {
+			case 's':
+				if (len == -1 || len > strlen(s))
+					len = strlen(s);
+				args[argc].to = s + len;
+				break;
+			case 'd':
+				simple_strtol(s, &args[argc].to, 0);
+				goto num;
+			case 'u':
+				simple_strtoul(s, &args[argc].to, 0);
+				goto num;
+			case 'o':
+				simple_strtoul(s, &args[argc].to, 8);
+				goto num;
+			case 'x':
+				simple_strtoul(s, &args[argc].to, 16);
+			num:
+				if (args[argc].to == args[argc].from)
+					return 0;
+				break;
+			default:
+				return 0;
+		}
+		s = args[argc].to;
+		argc++;
+	}
+}
+
+int match_token(char *s, match_table_t table, substring_t args[])
+{
+	struct match_token *p;
+
+	for (p = table; !match_one(s, p->pattern, args) ; p++)
+		;
+
+	return p->token;
+}
+
+int match_int(substring_t *s)
+{
+	char buf[s->to - s->from + 1];
+
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	return simple_strtol(buf, NULL, 0);
+}
+
+int match_octal(substring_t *s)
+{
+	char buf[s->to - s->from + 1];
+
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	return simple_strtoul(buf, NULL, 8);
+}
+
+int match_hex(substring_t *s)
+{
+	char buf[s->to - s->from + 1];
+
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	return simple_strtoul(buf, NULL, 16);
+}
+
+void match_strcpy(char *to, substring_t *s)
+{
+	memcpy(to, s->from, s->to - s->from);
+	to[s->to - s->from] = '\0';
+}
+
+char *match_strdup(substring_t *s)
+{
+	char *p = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+	if (p)
+		match_strcpy(p, s);
+	return p;
+}
+
+EXPORT_SYMBOL(match_token);
+EXPORT_SYMBOL(match_int);
+EXPORT_SYMBOL(match_octal);
+EXPORT_SYMBOL(match_hex);
+EXPORT_SYMBOL(match_strcpy);
+EXPORT_SYMBOL(match_strdup);
