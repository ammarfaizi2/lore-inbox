Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWACN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWACN3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWACN2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:28:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44293 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932359AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 16/26] kbuild: set correct KBUILD_MODNAME when using well known kernel symbols as module names
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947263806@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ustyugov Roman <dr_unique@ymg.ru>
Date: 1127450531 +0400

This patch fixes a problem when we use well known kernel symbols as module
names.

For example, if module source name is current.c, idle_stack.c or etc.,
we have a bad KBUILD_MODNAME value.
For example, KBUILD_MODNAME will be "get_current()" instead of "current", or
"(init_thread_union.stack)" instead of "idle_task".

The trick is to define a stringify macro on the commandline - named
KBUILD_STR for namespace reasons - and then to stringify the module
name.

There are a few uses of KBUILD_MODNAME throughout the tree but the usage
is for debug and will not be harmed by this change so left untouched for now.

While at it KBUILD_BASENAME was changed too. Any spinlock usage in the
unix module would have created wrong section names without it.
Usage in spinlock.h fixed so it no longer stringify KBUILD_BASENAME.

Original patch from Ustyogov Roman - all bugs introduced by me.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 include/linux/spinlock.h |    3 +--
 scripts/Makefile.lib     |    8 +++++---
 scripts/mod/modpost.c    |    3 +--
 3 files changed, 7 insertions(+), 7 deletions(-)

f83b5e323f57d6e1f35a839d663e91cebe985e54
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 0e9682c..799be67 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -59,8 +59,7 @@
 /*
  * Must define these before including other files, inline functions need them
  */
-#define LOCK_SECTION_NAME                       \
-        ".text.lock." __stringify(KBUILD_BASENAME)
+#define LOCK_SECTION_NAME ".text.lock."KBUILD_BASENAME
 
 #define LOCK_SECTION_START(extra)               \
         ".subsection 1\n\t"                     \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0f81dcf..550798f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -81,8 +81,10 @@ obj-dirs	:= $(addprefix $(obj)/,$(obj-di
 # Note: It's possible that one object gets potentially linked into more
 #       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
 #       where foo and bar are the name of the modules.
-basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
-modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
+name-fix = $(subst $(comma),_,$(subst -,_,$1))
+basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(*F)))"
+modname_flags  = $(if $(filter 1,$(words $(modname))),\
+                 -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
 
 _c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
@@ -113,7 +115,7 @@ endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__c_flags) $(modkern_cflags) \
-		 $(basename_flags) $(modname_flags)
+		 -D"KBUILD_STR(s)=\#s" $(basename_flags) $(modname_flags)
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8ce5a63..f70ff13 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -539,10 +539,9 @@ add_header(struct buffer *b, struct modu
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "\n");
-	buf_printf(b, "#undef unix\n"); /* We have a module called "unix" */
 	buf_printf(b, "struct module __this_module\n");
 	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = {\n");
-	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");
+	buf_printf(b, " .name = KBUILD_MODNAME,\n");
 	if (mod->has_init)
 		buf_printf(b, " .init = init_module,\n");
 	if (mod->has_cleanup)
-- 
1.0.6

