Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136106AbREGOBH>; Mon, 7 May 2001 10:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136114AbREGOA6>; Mon, 7 May 2001 10:00:58 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:5380 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S136106AbREGOAs>; Mon, 7 May 2001 10:00:48 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105071403.QAA01300@green.mif.pg.gda.pl>
Subject: [PATCH] koi8-ru support for 2.4
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 7 May 2001 16:03:37 +0200 (CEST)
Cc: lvm_ukr@yahoo.com, linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   The following patch adds koi8-ru (Belarussian) charset support for
2.4.4-ac kernels on top of nls_koi8-u module. They differ on two characters
only, so I don't think t is worth to create a new table for koi8-ru.

   Well it could be koi8-u on top of koi8-ru as well, but I choosed minimal-
changes-way for the patch.

Andrzej 


diff -uNr linux-2.4.4-ac5/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.4-ac5/Documentation/Configure.help	Wed May  2 23:42:15 2001
+++ linux/Documentation/Configure.help	Sun May  6 22:09:54 2001
@@ -12567,8 +12567,8 @@
   cp862, cp863, cp864, cp865, cp866, cp869, cp874, cp932, cp936,
   cp949, cp950, cp1251, cp1255, euc-jp, euc-kr, gb2312, iso8859-1,
   iso8859-2, iso8859-3, iso8859-4, iso8859-5, iso8859-6, iso8859-7,
-  iso8859-8, iso8859-9, iso8859-14, iso8859-15, koi8-r, koi8-u, sjis,
-  tis-620, utf8.
+  iso8859-8, iso8859-9, iso8859-14, iso8859-15, koi8-r, koi8-ru,
+  koi8-u, sjis, tis-620, utf8.
   If you specify a wrong value, it will use the built-in NLS;
   compatible with iso8859-1.
 
@@ -12937,13 +12937,13 @@
   input/output character sets. Say Y here for the preferred Russian
   character set.
 
-NLS KOI8-U (Ukrainian) 
+NLS KOI8-U/RU (Ukrainian, Belarussian) 
 CONFIG_NLS_KOI8_U
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the preferred Ukrainian
-  character set.
+  (koi8-u) and Belarussian (koi8-ru) character sets.
 
 NLS UTF8
 CONFIG_NLS_UTF8
diff -uNr linux-2.4.4-ac5/fs/nls/Config.in linux/fs/nls/Config.in
--- linux-2.4.4-ac5/fs/nls/Config.in	Sat Apr 28 20:35:03 2001
+++ linux/fs/nls/Config.in	Sun May  6 22:05:35 2001
@@ -56,7 +56,7 @@
   tristate 'NLS ISO 8859-14 (Latin 8; Celtic)'      CONFIG_NLS_ISO8859_14
   tristate 'NLS ISO 8859-15 (Latin 9; Western European Languages with Euro)' CONFIG_NLS_ISO8859_15
   tristate 'NLS KOI8-R (Russian)'                   CONFIG_NLS_KOI8_R
-  tristate 'NLS KOI8-U (Ukrainian)'                 CONFIG_NLS_KOI8_U
+  tristate 'NLS KOI8-U/RU (Ukrainian, Belarussian)' CONFIG_NLS_KOI8_U
   tristate 'NLS UTF8'                               CONFIG_NLS_UTF8
   endmenu
 fi
diff -uNr linux-2.4.4-ac5/fs/nls/Makefile linux/fs/nls/Makefile
--- linux-2.4.4-ac5/fs/nls/Makefile	Sat Apr 28 20:35:03 2001
+++ linux/fs/nls/Makefile	Sun May  6 21:41:41 2001
@@ -49,7 +49,7 @@
 obj-$(CONFIG_NLS_ISO8859_14)	+= nls_iso8859-14.o
 obj-$(CONFIG_NLS_ISO8859_15)	+= nls_iso8859-15.o
 obj-$(CONFIG_NLS_KOI8_R)	+= nls_koi8-r.o
-obj-$(CONFIG_NLS_KOI8_U)	+= nls_koi8-u.o
+obj-$(CONFIG_NLS_KOI8_U)	+= nls_koi8-u.o nls_koi8-ru.o
 obj-$(CONFIG_NLS_ABC)		+= nls_abc.o
 obj-$(CONFIG_NLS_UTF8)		+= nls_utf8.o
 
diff -uNr linux-2.4.4-ac5/fs/nls/nls_koi8-ru.c linux/fs/nls/nls_koi8-ru.c
--- linux-2.4.4-ac5/fs/nls/nls_koi8-ru.c	Thu Jan  1 01:00:00 1970
+++ linux/fs/nls/nls_koi8-ru.c	Sun May  6 21:47:28 2001
@@ -0,0 +1,99 @@
+/*
+ * linux/fs/nls_koi8-ru.c
+ *
+ * Charset koi8-ru translation based on charset koi8-u.
+ * The Unicode to charset table has only exact mappings.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/nls.h>
+#include <linux/errno.h>
+
+static struct nls_table *p_nls;
+
+static int uni2char(const wchar_t uni,
+		    unsigned char *out, int boundlen)
+{
+	if (boundlen <= 0)
+		return -ENAMETOOLONG;
+
+	if ((uni & 0xffaf) == 0x040e || (uni & 0xffce) == 0x254c) {
+		/* koi8-ru and koi8-u differ only on two characters */
+		if (uni == 0x040e)
+			return 0xbe;
+		else if (uni == 0x045e)
+			return 0xae;
+		else if (uni == 0x255d || uni == 0x256c)
+			return 0;
+		else
+			return p_nls->uni2char(uni, out, boundlen);
+	}
+	else
+		/* fast path */
+		return p_nls->uni2char(uni, out, boundlen);
+}
+
+static int char2uni(const unsigned char *rawstring, int boundlen,
+		    wchar_t *uni)
+{
+	int n;
+
+	if ((*rawstring & 0xef) != 0xae) {
+		/* koi8-ru and koi8-u differ only on two characters */
+		*uni = (*rawstring & 0x10) ? 0x040e : 0x045e;
+		return 1;
+	}
+
+	n = p_nls->char2uni(rawstring, boundlen, uni);
+	return n;
+}
+
+static struct nls_table table = {
+	"koi8-ru",
+	uni2char,
+	char2uni,
+	NULL,
+	NULL,
+	THIS_MODULE,
+};
+
+static int __init init_nls_koi8_ru(void)
+{
+	p_nls = load_nls("koi8-u");
+
+	if (p_nls) {
+		table.charset2upper = p_nls->charset2upper;
+		table.charset2lower = p_nls->charset2lower;
+		return register_nls(&table);
+	}
+
+	return -EINVAL;
+}
+
+static void __exit exit_nls_koi8_ru(void)
+{
+	unregister_nls(&table);
+	unload_nls(p_nls);
+}
+
+module_init(init_nls_koi8_ru)
+module_exit(exit_nls_koi8_ru)
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-indent-level: 8
+ * c-brace-imaginary-offset: 0
+ * c-brace-offset: -8
+ * c-argdecl-indent: 8
+ * c-label-offset: -8
+ * c-continued-statement-offset: 8
+ * c-continued-brace-offset: 0
+ * End:
+ */


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
