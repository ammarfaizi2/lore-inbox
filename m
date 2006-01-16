Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWAPLPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWAPLPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWAPLPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:15:33 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29968 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751124AbWAPLPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:15:33 -0500
Date: Mon, 16 Jan 2006 12:15:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ren? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
Subject: [PATCH] kbuild: create .kernelrelease at *config step
Message-ID: <20060116111525.GA25581@mars.ravnborg.org>
References: <200601151051.14827.rene@exactcode.de> <200601151312.42391.rene@exactcode.de> <20060115123133.GB15881@mars.ravnborg.org> <200601151526.34236.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601151526.34236.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just added following patch to my tree.
It addresses all your inputs.

	Sam

[PATCH] kbuild: create .kernelrelease at *config step

To enable 'make kernelrelease' earlier now create .kernelrelease when
one of the *config targets are used.
Also introduce KERNELVERSION - only user is kconfig.
KERNELVERSION was needed to display kernel version in menuconfig -
KERNELRELEASE is not valid until configuration has completed.
kconfig files modified to use KERNELVERSION.
Bug reported by: Rene Rebe <rene@exactcode.de>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile                   |   19 ++++++++++---------
 scripts/kconfig/confdata.c |    2 +-
 scripts/kconfig/gconf.c    |    2 +-
 scripts/kconfig/mconf.c    |    2 +-
 scripts/kconfig/symbol.c   |    4 ++--
 5 files changed, 15 insertions(+), 14 deletions(-)

2244cbd8a9185c197ec5ba5de175aec288697223
diff --git a/Makefile b/Makefile
index b3dd9db..22e322f 100644
--- a/Makefile
+++ b/Makefile
@@ -338,8 +338,9 @@ AFLAGS		:= -D__ASSEMBLY__
 
 # Read KERNELRELEASE from .kernelrelease (if it exists)
 KERNELRELEASE = $(shell cat .kernelrelease 2> /dev/null)
+KERNELVERSION = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
-export	VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE \
+export	VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION \
 	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
@@ -434,6 +435,7 @@ export KBUILD_DEFCONFIG
 config %config: scripts_basic outputmakefile FORCE
 	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+	$(Q)$(MAKE) .kernelrelease
 
 else
 # ===========================================================================
@@ -784,12 +786,10 @@ endif
 localver-full = $(localver)$(localver-auto)
 
 # Store (new) KERNELRELASE string in .kernelrelease
-kernelrelease = \
-       $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(localver-full)
+kernelrelease = $(KERNELVERSION)$(localver-full)
 .kernelrelease: FORCE
-	$(Q)rm -f .kernelrelease
-	$(Q)echo $(kernelrelease) > .kernelrelease
-	$(Q)echo "  Building kernel $(kernelrelease)"
+	$(Q)rm -f $@
+	$(Q)echo $(kernelrelease) > $@
 
 
 # Things we need to do before we recursively start building the kernel
@@ -899,7 +899,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile FORCE
+include/linux/version.h: $(srctree)/Makefile .config FORCE
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------
@@ -1302,9 +1302,10 @@ checkstack:
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
 kernelrelease:
-	@echo $(KERNELRELEASE)
+	$(if $(wildcard .kernelrelease), $(Q)echo $(KERNELRELEASE), \
+	$(error kernelrelease not valid - run 'make *config' to update it))
 kernelversion:
-	@echo $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+	@echo $(KERNELVERSION)
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index ccd4513..b0cbbe2 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -375,7 +375,7 @@ int conf_write(const char *name)
 		if (!out_h)
 			return 1;
 	}
-	sym = sym_lookup("KERNELRELEASE", 0);
+	sym = sym_lookup("KERNELVERSION", 0);
 	sym_calc_value(sym);
 	time(&now);
 	env = getenv("KCONFIG_NOTIMESTAMP");
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 9f5aabd..665bd53 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -276,7 +276,7 @@ void init_main_window(const gchar * glad
 					  NULL);
 
 	sprintf(title, _("Linux Kernel v%s Configuration"),
-		getenv("KERNELRELEASE"));
+		getenv("KERNELVERSION"));
 	gtk_window_set_title(GTK_WINDOW(main_wnd), title);
 
 	gtk_widget_show(main_wnd);
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index d63d7fb..7f97319 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -1051,7 +1051,7 @@ int main(int ac, char **av)
 	conf_parse(av[1]);
 	conf_read(NULL);
 
-	sym = sym_lookup("KERNELRELEASE", 0);
+	sym = sym_lookup("KERNELVERSION", 0);
 	sym_calc_value(sym);
 	sprintf(menu_backtitle, _("Linux Kernel v%s Configuration"),
 		sym_get_string_value(sym));
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 69c2549..3d7877a 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -61,10 +61,10 @@ void sym_init(void)
 	if (p)
 		sym_add_default(sym, p);
 
-	sym = sym_lookup("KERNELRELEASE", 0);
+	sym = sym_lookup("KERNELVERSION", 0);
 	sym->type = S_STRING;
 	sym->flags |= SYMBOL_AUTO;
-	p = getenv("KERNELRELEASE");
+	p = getenv("KERNELVERSION");
 	if (p)
 		sym_add_default(sym, p);
 
-- 
1.0.GIT

