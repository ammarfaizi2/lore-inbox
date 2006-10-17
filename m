Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWJQWZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWJQWZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWJQWZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:25:16 -0400
Received: from mout2.freenet.de ([194.97.50.155]:4304 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750825AbWJQWZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:25:14 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] New function "bool conf_get_changed(void)"
Date: Wed, 18 Oct 2006 00:27:16 +0200
User-Agent: KMail/1.9.4
References: <200610180023.04978.annabellesgarden@yahoo.de>
In-Reply-To: <200610180023.04978.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610180027.16967.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Returns sym_change_count to reflect the .config's change state.
All read only accesses of
	sym_change_count
are replaced by calls to
	conf_get_changed()
.
mconfig.c is manipulated to ask for saving only when
conf_get_changed() returned true.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 scripts/kconfig/conf.c      |    2 +-
 scripts/kconfig/confdata.c  |    7 ++++++-
 scripts/kconfig/lkc_proto.h |    1 +
 scripts/kconfig/mconf.c     |   21 ++++++++++++++-------
 scripts/kconfig/qconf.cc    |    2 +-
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 4dcb886..124b341 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -600,7 +600,7 @@ int main(int ac, char **av)
 			input_mode = ask_silent;
 			valid_stdin = 1;
 		}
-	} else if (sym_change_count) {
+	} else if (conf_get_changed()) {
 		name = getenv("KCONFIG_NOSILENTUPDATE");
 		if (name && *name) {
 			fprintf(stderr, _("\n*** Kernel configuration requires explicit update.\n\n"));
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 66b15ef..140742e 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -432,7 +432,7 @@ int conf_write(const char *name)
 		     use_timestamp ? "# " : "",
 		     use_timestamp ? ctime(&now) : "");
 
-	if (!sym_change_count)
+	if (!conf_get_changed())
 		sym_clear_all_valid();
 
 	menu = rootmenu.list;
@@ -765,3 +765,8 @@ int conf_write_autoconf(void)
 
 	return 0;
 }
+
+bool conf_get_changed(void)
+{
+	return sym_change_count;
+}
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index a263746..9f1823c 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -5,6 +5,7 @@ P(conf_read,int,(const char *name));
 P(conf_read_simple,int,(const char *name, int));
 P(conf_write,int,(const char *name));
 P(conf_write_autoconf,int,(void));
+P(conf_get_changed,bool,(void));
 
 /* menu.c */
 P(rootmenu,struct menu,);
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 08a4c7a..3f9a132 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -890,14 +890,19 @@ int main(int ac, char **av)
 	do {
 		conf(&rootmenu);
 		dialog_clear();
-		res = dialog_yesno(NULL,
-				   _("Do you wish to save your "
-				     "new kernel configuration?\n"
-				     "<ESC><ESC> to continue."),
-				   6, 60);
+		if (conf_get_changed())
+			res = dialog_yesno(NULL,
+					   _("Do you wish to save your "
+					     "new kernel configuration?\n"
+					     "<ESC><ESC> to continue."),
+					   6, 60);
+		else
+			res = -1;
 	} while (res == KEY_ESC);
 	end_dialog();
-	if (res == 0) {
+
+	switch (res) {
+	case 0:
 		if (conf_write(NULL)) {
 			fprintf(stderr, _("\n\n"
 				"Error during writing of the kernel configuration.\n"
@@ -905,11 +910,13 @@ int main(int ac, char **av)
 				"\n\n"));
 			return 1;
 		}
+	case -1:
 		printf(_("\n\n"
 			"*** End of Linux kernel configuration.\n"
 			"*** Execute 'make' to build the kernel or try 'make help'."
 			"\n\n"));
-	} else {
+		break;
+	default:
 		fprintf(stderr, _("\n\n"
 			"Your kernel configuration changes were NOT saved."
 			"\n\n"));
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 393f374..64d1060 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1584,7 +1584,7 @@ void ConfigMainWindow::showFullView(void
  */
 void ConfigMainWindow::closeEvent(QCloseEvent* e)
 {
-	if (!sym_change_count) {
+	if (!conf_get_changed()) {
 		e->accept();
 		return;
 	}
-- 
1.4.2.3

