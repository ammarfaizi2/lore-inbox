Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWFWWXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWFWWXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWFWWXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:23:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60079 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752129AbWFWWXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:23:48 -0400
Date: Fri, 23 Jun 2006 23:23:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Section mismatch warnings
Message-ID: <20060623222346.GC27946@ftp.linux.org.uk>
References: <Pine.LNX.4.61.0606231938080.26864@yvahk01.tjqt.qr> <20060623221217.GA372@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623221217.GA372@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 12:12:18AM +0200, Sam Ravnborg wrote:
> All the .smp_locks related warnings are gone when I get the kbuild.git
> tree pushed linus wise. Needs to spend only an hour or so before it is
> ready and will do so during the weekend.

Another fun toy that might be interesting there:

>From nobody Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 26 May 2006 08:35:22 -0400
Subject: [PATCH] add make listconfig (show all kconfig symbols seen by parser)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 scripts/kconfig/Makefile   |    8 ++++++--
 scripts/kconfig/confsyms.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 scripts/kconfig/confsyms.c

9af44436bd3940c50b7cf68a8f2bf14e07ad2081
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index fd518f0..b655f60 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -2,7 +2,7 @@ # ======================================
 # Kernel configuration targets
 # These targets are used from top-level makefile
 
-PHONY += oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config
+PHONY += oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config listconfig
 
 xconfig: $(obj)/qconf
 	$< arch/$(ARCH)/Kconfig
@@ -23,6 +23,9 @@ oldconfig: $(obj)/conf
 silentoldconfig: $(obj)/conf
 	$< -s arch/$(ARCH)/Kconfig
 
+listconfig: $(obj)/confsyms
+	$< arch/$(ARCH)/Kconfig
+
 update-po-config: $(obj)/kxgettext
 	xgettext --default-domain=linux \
           --add-comments --keyword=_ --keyword=N_ \
@@ -95,10 +98,11 @@ # gconf:  Used for the gconfig target
 #         Based on GTK which needs to be installed to compile it
 # object files used by all kconfig flavours
 
-hostprogs-y	:= conf mconf qconf gconf kxgettext
+hostprogs-y	:= conf mconf qconf gconf kxgettext confsyms
 conf-objs	:= conf.o  zconf.tab.o
 mconf-objs	:= mconf.o zconf.tab.o
 kxgettext-objs	:= kxgettext.o zconf.tab.o
+confsyms-objs	:= confsyms.o zconf.tab.o
 
 ifeq ($(MAKECMDGOALS),xconfig)
 	qconf-target := 1
diff --git a/scripts/kconfig/confsyms.c b/scripts/kconfig/confsyms.c
new file mode 100644
index 0000000..3b20065
--- /dev/null
+++ b/scripts/kconfig/confsyms.c
@@ -0,0 +1,31 @@
+#define LKC_DIRECT_LINK
+#include "lkc.h"
+
+static char type[] = {
+	[S_BOOLEAN] = 'b',
+	[S_TRISTATE] = 't',
+	[S_INT] = 'i',
+	[S_HEX] = 'h',
+	[S_STRING] = 's',
+};
+
+static void list_symbols(struct menu *m)
+{
+	for (m = m->list; m; m = m->next) {
+		struct symbol *s = m->sym;
+		if (s && !sym_is_choice(s)) {
+			char c = s->type >= sizeof(type) ? '\0' : type[s->type];
+			printf("%c %s\n", c ? c : '?', s->name);
+		}
+		list_symbols(m);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	if (argc > 1) {
+		conf_parse(argv[1]);
+		list_symbols(&rootmenu);
+	}
+	return 0;
+}
-- 
1.3.GIT

