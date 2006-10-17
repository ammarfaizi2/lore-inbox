Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWJQW0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWJQW0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJQW0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:26:39 -0400
Received: from mout1.freenet.de ([194.97.50.132]:37328 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750798AbWJQW0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:26:39 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Make sym_change_count static, let it be altered by 2 functions only
Date: Wed, 18 Oct 2006 00:28:44 +0200
User-Agent: KMail/1.9.4
References: <200610180023.04978.annabellesgarden@yahoo.de> <200610180027.16967.annabellesgarden@yahoo.de>
In-Reply-To: <200610180027.16967.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610180028.45011.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Those two functions are
	void sym_set_change_count(int count)
and
	void sym_add_change_count(int count)
.
All write accesses to sym_change_count are replaced by calls to
above functions.
Variable and changer-functions are moved to confdata.c.
IMO thats ok, as sym_change_count is an attribute of the .config's
change state.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 scripts/kconfig/confdata.c          |   20 ++++++++++++++++----
 scripts/kconfig/lkc.h               |    2 ++
 scripts/kconfig/lkc_proto.h         |    1 -
 scripts/kconfig/symbol.c            |    3 +--
 scripts/kconfig/zconf.tab.c_shipped |    2 +-
 scripts/kconfig/zconf.y             |    2 +-
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 140742e..4bbbb5b 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -100,7 +100,7 @@ int conf_read_simple(const char *name, i
 		in = zconf_fopen(name);
 		if (in)
 			goto load;
-		sym_change_count++;
+		sym_add_change_count(1);
 		if (!sym_defconfig_list)
 			return 1;
 
@@ -312,7 +312,7 @@ int conf_read(const char *name)
 	struct expr *e;
 	int i, flags;
 
-	sym_change_count = 0;
+	sym_set_change_count(0);
 
 	if (conf_read_simple(name, S_DEF_USER))
 		return 1;
@@ -364,7 +364,7 @@ int conf_read(const char *name)
 		sym->flags &= flags | ~SYMBOL_DEF_USER;
 	}
 
-	sym_change_count += conf_warnings || conf_unsaved;
+	sym_add_change_count(conf_warnings || conf_unsaved);
 
 	return 0;
 }
@@ -528,7 +528,7 @@ int conf_write(const char *name)
 		 "# configuration written to %s\n"
 		 "#\n"), newname);
 
-	sym_change_count = 0;
+	sym_set_change_count(0);
 
 	return 0;
 }
@@ -766,6 +766,18 @@ int conf_write_autoconf(void)
 	return 0;
 }
 
+static int sym_change_count;
+
+void sym_set_change_count(int count)
+{
+	sym_change_count = count;
+}
+
+void sym_add_change_count(int count)
+{
+	sym_change_count += count;
+}
+
 bool conf_get_changed(void)
 {
 	return sym_change_count;
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 2628023..9b2706a 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -65,6 +65,8 @@ char *zconf_curname(void);
 
 /* confdata.c */
 char *conf_get_default_confname(void);
+void sym_set_change_count(int count);
+void sym_add_change_count(int count);
 
 /* kconfig_load.c */
 void kconfig_load(void);
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 9f1823c..84bb139 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -17,7 +17,6 @@ P(menu_get_parent_menu,struct menu *,(st
 
 /* symbol.c */
 P(symbol_hash,struct symbol *,[SYMBOL_HASHSIZE]);
-P(sym_change_count,int,);
 
 P(sym_lookup,struct symbol *,(const char *name, int isconst));
 P(sym_find,struct symbol *,(const char *name));
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index ee225ce..8f06c47 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -30,7 +30,6 @@ struct symbol symbol_yes = {
 	.flags = SYMBOL_VALID,
 };
 
-int sym_change_count;
 struct symbol *sym_defconfig_list;
 struct symbol *modules_sym;
 tristate modules_val;
@@ -379,7 +378,7 @@ void sym_clear_all_valid(void)
 
 	for_all_symbols(i, sym)
 		sym->flags &= ~SYMBOL_VALID;
-	sym_change_count++;
+	sym_add_change_count(1);
 	if (modules_sym)
 		sym_calc_value(modules_sym);
 }
diff --git a/scripts/kconfig/zconf.tab.c_shipped b/scripts/kconfig/zconf.tab.c_shipped
index 2fb0a4f..d777fe8 100644
--- a/scripts/kconfig/zconf.tab.c_shipped
+++ b/scripts/kconfig/zconf.tab.c_shipped
@@ -2135,7 +2135,7 @@ #endif
 		sym_check_deps(sym);
         }
 
-	sym_change_count = 1;
+	sym_set_change_count(1);
 }
 
 const char *zconf_tokenname(int token)
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index ab44feb..04a5864 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -504,7 +504,7 @@ #endif
 		sym_check_deps(sym);
         }
 
-	sym_change_count = 1;
+	sym_set_change_count(1);
 }
 
 const char *zconf_tokenname(int token)
-- 
1.4.2.3

