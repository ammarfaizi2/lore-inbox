Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVC0Cti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVC0Cti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 21:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVC0Cth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 21:49:37 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:62734 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261396AbVC0Cry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 21:47:54 -0500
Date: Sat, 26 Mar 2005 23:47:41 -0300
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Thiago Macieira <thiago@kde.org>,
       kernel_ptbr@listas.cipsga.org.br, Augusto Campos <brain@br-linux.org>
Subject: [PATCH] Kconfig i18n support
Message-ID: <20050327024741.GB24264@conectiva.com.br>
Mail-Followup-To: acme@ghostprotocols.net,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Thiago Macieira <thiago@kde.org>,
	kernel_ptbr@listas.cipsga.org.br, Augusto Campos <brain@br-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.6i
From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

	This patch adds i18n support for make *config, allowing users to
have the config process in their own language.

	No printk was harmed in the process, don't worry, so all the bug
reports, kernel messages, etc, remain in english, just the user tools to
configure the kernel are internationalized.

	Users not interested in translations can just unset the related
LANG, LC_ALL, etc env variables and have the config process in plain
english, something like:

LANG=3D make menuconfig

is enough for having the whole config process in english. Or just don't
install any translation file.

	Translations for brazilian portuguese are being done by a team of
volunteers at:

http://www.visionflex.inf.br/kernel_ptbr/pmwiki.php/Principal/Traducoes

	To start the translation process:

make update-po-config

	This will generate the pot template named
scripts/kconfig/linux.pot, copy it to, say, ~/es.po, to start the
translation for spanish.

	To test your translation, as root issue this command:

msgfmt -o /usr/share/locale/es/LC_MESSAGES/linux.mo ~/es.po

	Replace "es" with your language code.

	Then execute, for instance:

make menuconfig

	The current patch doesn't use any optimization to reduce the size
of the generated .mo file, it is possible to use the config option as a
key, but this doesn't prevent the current patch from being used or the
translations done under the current scheme to be in any way lost if we
chose to do any kind of keying.

	Thanks to Fabr=EDcio Vaccari for starting the pt_BR (brazilian
portuguese) translation effort, Thiago Maciera for helping me with the
gconf.cc (QT frontent) i18n coding and to all the volunteers that are
already working on the first translation, to pt_BR.

	I left the question on wether to ship the translations with the
stock kernel sources to be discussed here, please share your suggestions.

	Available at:

bk://kernel.bkbits.net/acme/Kconfig-i18n-2.6

	Linus/Andrew, please consider applying.

- Arnaldo

--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Kconfig-i18n.patch"

===================================================================


ChangeSet@1.2228, 2005-03-26 23:21:36-03:00, acme@toy.ghostprotocols.net
  [KCONFIG] i18n support
  
  For the menu entries and help texts. A new tool, kxgettext, is now used with 
  the make update-po-config to extract the text entries and help texts into
  scripts/kconfig/linux.pot, that should be used as as the starting point for
  translations.
  
  Signed-off-by: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Linus Torvalds <torvalds@osdl.org


 Makefile    |   14 ++-
 POTFILES.in |    5 +
 conf.c      |   20 ++---
 confdata.c  |   16 ++--
 gconf.c     |   52 +++++++-------
 kxgettext.c |  221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lkc.h       |    8 ++
 mconf.c     |  120 +++++++++++++++++---------------
 menu.c      |    4 -
 qconf.cc    |   59 ++++++++++------
 10 files changed, 395 insertions(+), 124 deletions(-)


diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/Makefile	2005-03-26 23:25:33 -03:00
@@ -2,7 +2,7 @@
 # Kernel configuration targets
 # These targets are used from top-level makefile
 
-.PHONY: oldconfig xconfig gconfig menuconfig config silentoldconfig
+.PHONY: oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config
 
 xconfig: $(obj)/qconf
 	$< arch/$(ARCH)/Kconfig
@@ -23,6 +23,13 @@
 silentoldconfig: $(obj)/conf
 	$< -s arch/$(ARCH)/Kconfig
 
+update-po-config: $(obj)/kxgettext
+	xgettext --default-domain=linux \
+          --add-comments --keyword=_ --keyword=N_ \
+          --files-from=scripts/kconfig/POTFILES.in \
+	-o scripts/kconfig/linux.pot
+	scripts/kconfig/kxgettext arch/$(ARCH)/Kconfig >> scripts/kconfig/linux.pot
+
 .PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig
 
 randconfig: $(obj)/conf
@@ -72,9 +79,10 @@
 #         Based on GTK which needs to be installed to compile it
 # object files used by all kconfig flavours
 
-hostprogs-y	:= conf mconf qconf gconf
+hostprogs-y	:= conf mconf qconf gconf kxgettext
 conf-objs	:= conf.o  zconf.tab.o
 mconf-objs	:= mconf.o zconf.tab.o
+kxgettext-objs	:= kxgettext.o zconf.tab.o
 
 ifeq ($(MAKECMDGOALS),xconfig)
 	qconf-target := 1
@@ -107,7 +115,7 @@
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \
                           -D LKC_DIRECT_LINK
 
-$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h
+$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o $(obj)/kxgettext: $(obj)/zconf.tab.h
 
 $(obj)/zconf.tab.h: $(src)/zconf.tab.h_shipped
 $(obj)/zconf.tab.c: $(src)/zconf.tab.c_shipped
diff -Nru a/scripts/kconfig/POTFILES.in b/scripts/kconfig/POTFILES.in
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/kconfig/POTFILES.in	2005-03-26 23:25:33 -03:00
@@ -0,0 +1,5 @@
+scripts/kconfig/mconf.c
+scripts/kconfig/conf.c
+scripts/kconfig/confdata.c
+scripts/kconfig/gconf.c
+scripts/kconfig/qconf.cc
diff -Nru a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
--- a/scripts/kconfig/conf.c	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/conf.c	2005-03-26 23:25:33 -03:00
@@ -34,7 +34,7 @@
 static signed char line[128];
 static struct menu *rootEntry;
 
-static char nohelp_text[] = "Sorry, no help available for this option yet.\n";
+static char nohelp_text[] = N_("Sorry, no help available for this option yet.\n");
 
 static void strip(signed char *str)
 {
@@ -56,9 +56,9 @@
 static void check_stdin(void)
 {
 	if (!valid_stdin && input_mode == ask_silent) {
-		printf("aborted!\n\n");
-		printf("Console input/output is redirected. ");
-		printf("Run 'make oldconfig' to update configuration.\n\n");
+		printf(_("aborted!\n\n"));
+		printf(_("Console input/output is redirected. "));
+		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
 		exit(1);
 	}
 }
@@ -470,7 +470,7 @@
 	if (sym) {
 		if (sym_is_changable(sym) && !sym_has_value(sym)) {
 			if (!conf_cnt++)
-				printf("*\n* Restart config...\n*\n");
+				printf(_("*\n* Restart config...\n*\n"));
 			rootEntry = menu_get_parent_menu(menu);
 			conf(rootEntry);
 		}
@@ -504,7 +504,7 @@
 			input_mode = set_default;
 			defconfig_file = av[i++];
 			if (!defconfig_file) {
-				printf("%s: No default config file specified\n",
+				printf(_("%s: No default config file specified\n"),
 					av[0]);
 				exit(1);
 			}
@@ -530,7 +530,7 @@
 	}
   	name = av[i];
 	if (!name) {
-		printf("%s: Kconfig file missing\n", av[0]);
+		printf(_("%s: Kconfig file missing\n"), av[0]);
 	}
 	conf_parse(name);
 	//zconfdump(stdout);
@@ -547,12 +547,12 @@
 		break;
 	case ask_silent:
 		if (stat(".config", &tmpstat)) {
-			printf("***\n"
+			printf(_("***\n"
 				"*** You have not yet configured your kernel!\n"
 				"***\n"
 				"*** Please run some configurator (e.g. \"make oldconfig\" or\n"
 				"*** \"make menuconfig\" or \"make xconfig\").\n"
-				"***\n");
+				"***\n"));
 			exit(1);
 		}
 	case ask_all:
@@ -576,7 +576,7 @@
 		check_conf(&rootmenu);
 	} while (conf_cnt);
 	if (conf_write(NULL)) {
-		fprintf(stderr, "\n*** Error during writing of the kernel configuration.\n\n");
+		fprintf(stderr, _("\n*** Error during writing of the kernel configuration.\n\n"));
 		return 1;
 	}
 	return 0;
diff -Nru a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
--- a/scripts/kconfig/confdata.c	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/confdata.c	2005-03-26 23:25:33 -03:00
@@ -88,9 +88,9 @@
 			name = conf_expand_value(name);
 			in = zconf_fopen(name);
 			if (in) {
-				printf("#\n"
-				       "# using defaults found in %s\n"
-				       "#\n", name);
+				printf(_("#\n"
+				         "# using defaults found in %s\n"
+				         "#\n"), name);
 				break;
 			}
 		}
@@ -312,11 +312,11 @@
 	if (env && *env)
 		use_timestamp = 0;
 
-	fprintf(out, "#\n"
-		     "# Automatically generated make config: don't edit\n"
-		     "# Linux kernel version: %s\n"
-		     "%s%s"
-		     "#\n",
+	fprintf(out, _("#\n"
+		       "# Automatically generated make config: don't edit\n"
+		       "# Linux kernel version: %s\n"
+		       "%s%s"
+		       "#\n"),
 		     sym_get_string_value(sym),
 		     use_timestamp ? "# " : "",
 		     use_timestamp ? ctime(&now) : "");
diff -Nru a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
--- a/scripts/kconfig/gconf.c	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/gconf.c	2005-03-26 23:25:33 -03:00
@@ -40,7 +40,7 @@
 static gboolean config_changed = FALSE;
 
 static char nohelp_text[] =
-    "Sorry, no help available for this option yet.\n";
+    N_("Sorry, no help available for this option yet.\n");
 
 GtkWidget *main_wnd = NULL;
 GtkWidget *tree1_w = NULL;	// left  frame
@@ -190,7 +190,7 @@
 
 	xml = glade_xml_new(glade_file, "window1", NULL);
 	if (!xml)
-		g_error("GUI loading failed !\n");
+		g_error(_("GUI loading failed !\n"));
 	glade_xml_signal_autoconnect(xml);
 
 	main_wnd = glade_xml_get_widget(xml, "window1");
@@ -242,7 +242,7 @@
 					  /*"style", PANGO_STYLE_OBLIQUE, */
 					  NULL);
 
-	sprintf(title, "Linux Kernel v%s Configuration",
+	sprintf(title, _("Linux Kernel v%s Configuration"),
 		getenv("KERNELRELEASE"));
 	gtk_window_set_title(GTK_WINDOW(main_wnd), title);
 
@@ -292,7 +292,7 @@
 	
 	column = gtk_tree_view_column_new();
 	gtk_tree_view_append_column(view, column);
-	gtk_tree_view_column_set_title(column, "Options");
+	gtk_tree_view_column_set_title(column, _("Options"));
 
 	renderer = gtk_cell_renderer_toggle_new();
 	gtk_tree_view_column_pack_start(GTK_TREE_VIEW_COLUMN(column),
@@ -337,7 +337,7 @@
 
 	column = gtk_tree_view_column_new();
 	gtk_tree_view_append_column(view, column);
-	gtk_tree_view_column_set_title(column, "Options");
+	gtk_tree_view_column_set_title(column, _("Options"));
 
 	renderer = gtk_cell_renderer_pixbuf_new();
 	gtk_tree_view_column_pack_start(GTK_TREE_VIEW_COLUMN(column),
@@ -368,7 +368,7 @@
 
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    "Name", renderer,
+						    _("Name"), renderer,
 						    "text", COL_NAME,
 						    "foreground-gdk",
 						    COL_COLOR, NULL);
@@ -392,7 +392,7 @@
 						    COL_COLOR, NULL);
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_insert_column_with_attributes(view, -1,
-						    "Value", renderer,
+						    _("Value"), renderer,
 						    "text", COL_VALUE,
 						    "editable",
 						    COL_EDIT,
@@ -433,15 +433,15 @@
 	GtkTextIter start, end;
 	const char *prompt = menu_get_prompt(menu);
 	gchar *name;
-	const char *help = nohelp_text;
+	const char *help = _(nohelp_text);
 
 	if (!menu->sym)
 		help = "";
 	else if (menu->sym->help)
-		help = menu->sym->help;
+		help = _(menu->sym->help);
 
 	if (menu->sym && menu->sym->name)
-		name = g_strdup_printf(menu->sym->name);
+		name = g_strdup_printf(_(menu->sym->name));
 	else
 		name = g_strdup("");
 
@@ -497,7 +497,7 @@
 	if (config_changed == FALSE)
 		return FALSE;
 
-	dialog = gtk_dialog_new_with_buttons("Warning !",
+	dialog = gtk_dialog_new_with_buttons(_("Warning !"),
 					     GTK_WINDOW(main_wnd),
 					     (GtkDialogFlags)
 					     (GTK_DIALOG_MODAL |
@@ -511,7 +511,7 @@
 	gtk_dialog_set_default_response(GTK_DIALOG(dialog),
 					GTK_RESPONSE_CANCEL);
 
-	label = gtk_label_new("\nSave configuration ?\n");
+	label = gtk_label_new(_("\nSave configuration ?\n"));
 	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), label);
 	gtk_widget_show(label);
 
@@ -571,7 +571,7 @@
 					     (user_data));
 
 	if (conf_read(fn))
-		text_insert_msg("Error", "Unable to load configuration !");
+		text_insert_msg(_("Error"), _("Unable to load configuration !"));
 	else
 		display_tree(&rootmenu);
 }
@@ -580,7 +580,7 @@
 {
 	GtkWidget *fs;
 
-	fs = gtk_file_selection_new("Load file...");
+	fs = gtk_file_selection_new(_("Load file..."));
 	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
 			 "clicked",
 			 G_CALLBACK(load_filename), (gpointer) fs);
@@ -599,7 +599,7 @@
 void on_save1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	if (conf_write(NULL))
-		text_insert_msg("Error", "Unable to save configuration !");
+		text_insert_msg(_("Error"), _("Unable to save configuration !"));
 
 	config_changed = FALSE;
 }
@@ -614,7 +614,7 @@
 					     (user_data));
 
 	if (conf_write(fn))
-		text_insert_msg("Error", "Unable to save configuration !");
+		text_insert_msg(_("Error"), _("Unable to save configuration !"));
 
 	gtk_widget_destroy(GTK_WIDGET(user_data));
 }
@@ -623,7 +623,7 @@
 {
 	GtkWidget *fs;
 
-	fs = gtk_file_selection_new("Save file as...");
+	fs = gtk_file_selection_new(_("Save file as..."));
 	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
 			 "clicked",
 			 G_CALLBACK(store_filename), (gpointer) fs);
@@ -707,7 +707,7 @@
 void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	GtkWidget *dialog;
-	const gchar *intro_text =
+	const gchar *intro_text = _(
 	    "Welcome to gkc, the GTK+ graphical kernel configuration tool\n"
 	    "for Linux.\n"
 	    "For each option, a blank box indicates the feature is disabled, a\n"
@@ -723,7 +723,7 @@
 	    "option.\n"
 	    "\n"
 	    "Toggling Show Debug Info under the Options menu will show \n"
-	    "the dependencies, which you can then match by examining other options.";
+	    "the dependencies, which you can then match by examining other options.");
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
@@ -740,8 +740,8 @@
 {
 	GtkWidget *dialog;
 	const gchar *about_text =
-	    "gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
-	    "Based on the source code from Roman Zippel.\n";
+	    _("gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+	      "Based on the source code from Roman Zippel.\n");
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
@@ -758,9 +758,9 @@
 {
 	GtkWidget *dialog;
 	const gchar *license_text =
-	    "gkc is released under the terms of the GNU GPL v2.\n"
-	    "For more information, please see the source code or\n"
-	    "visit http://www.fsf.org/licenses/licenses.html\n";
+	    _("gkc is released under the terms of the GNU GPL v2.\n"
+	      "For more information, please see the source code or\n"
+	      "visit http://www.fsf.org/licenses/licenses.html\n");
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
@@ -1581,6 +1581,10 @@
 #ifndef LKC_DIRECT_LINK
 	kconfig_load();
 #endif
+
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	bind_textdomain_codeset(PACKAGE, "UTF-8");
+	textdomain(PACKAGE);
 
 	/* GTK stuffs */
 	gtk_set_locale();
diff -Nru a/scripts/kconfig/kxgettext.c b/scripts/kconfig/kxgettext.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/scripts/kconfig/kxgettext.c	2005-03-26 23:25:33 -03:00
@@ -0,0 +1,221 @@
+/*
+ * Arnaldo Carvalho de Melo <acme@conectiva.com.br>, 2005
+ *
+ * Released under the terms of the GNU GPL v2.0
+ */
+
+#include <stdlib.h>
+#include <string.h>
+
+#define LKC_DIRECT_LINK
+#include "lkc.h"
+
+static char *escape(const char* text, char *bf, int len)
+{
+	char *bfp = bf;
+	int multiline = strchr(text, '\n') != NULL;
+
+	*bfp++ = '"';
+	--len;
+
+	if (multiline) {
+		*bfp++ = '"';
+		*bfp++ = '\n';
+		*bfp++ = '"';
+		len -= 3;
+	}
+
+	while (*text != '\0' && len > 1) {
+		if (*text == '"')
+			*bfp++ = '\\';
+		else if (*text == '\n') {
+			*bfp++ = '\\';
+			*bfp++ = 'n';
+			*bfp++ = '"';
+			*bfp++ = '\n';
+			*bfp++ = '"';
+			len -= 5;
+			++text;
+			goto next;
+		}
+		*bfp++ = *text++;
+next:
+		--len;
+	}
+
+	if (multiline)
+		bfp -= 3;
+
+	*bfp++ = '"';
+	*bfp = '\0';
+
+	return bf;
+}
+
+struct file_line {
+	struct file_line *next;
+	char*		 file;
+	int		 lineno;
+};
+
+static struct file_line *file_line__new(char *file, int lineno)
+{
+	struct file_line *self = malloc(sizeof(*self));
+
+	if (self == NULL)
+		goto out;
+
+	self->file   = file;
+	self->lineno = lineno;
+	self->next   = NULL;
+out:
+	return self;
+}
+
+struct message {
+	const char	 *msg;
+	const char	 *option;
+	struct message	 *next;
+	struct file_line *files;
+};
+
+static struct message *message__list;
+
+static struct message *message__new(const char *msg, char *option, char *file, int lineno)
+{
+	struct message *self = malloc(sizeof(*self));
+
+	if (self == NULL)
+		goto out;
+
+	self->files = file_line__new(file, lineno);
+	if (self->files == NULL)
+		goto out_fail;
+
+	self->msg = strdup(msg);
+	if (self->msg == NULL)
+		goto out_fail_msg;
+
+	self->option = option;
+	self->next = NULL;
+out:
+	return self;
+out_fail_msg:
+	free(self->files);
+out_fail:
+	free(self);
+	self = NULL;
+	goto out;
+}
+
+static struct message *mesage__find(const char *msg)
+{
+	struct message *m = message__list;
+
+	while (m != NULL) {
+		if (strcmp(m->msg, msg) == 0)
+			break;
+		m = m->next;
+	}
+
+	return m;
+}
+
+static int message__add_file_line(struct message *self, char *file, int lineno)
+{
+	int rc = -1;
+	struct file_line *fl = file_line__new(file, lineno);
+
+	if (fl == NULL)
+		goto out;
+
+	fl->next    = self->files;
+	self->files = fl;
+	rc = 0;
+out:
+	return rc;
+}
+
+static int message__add(const char *msg, char *option, char *file, int lineno)
+{
+	int rc = 0;
+	char bf[16384];
+	char *escaped = escape(msg, bf, sizeof(bf));
+	struct message *m = mesage__find(escaped);
+
+	if (m != NULL)
+		rc = message__add_file_line(m, file, lineno);
+	else {
+		m = message__new(escaped, option, file, lineno);
+
+		if (m != NULL) {
+			m->next	      = message__list;
+			message__list = m;
+		} else
+			rc = -1;
+	}
+	return rc;
+}
+
+void menu_build_message_list(struct menu *menu)
+{
+	struct menu *child;
+
+	message__add(menu_get_prompt(menu), NULL,
+		     menu->file == NULL ? "Root Menu" : menu->file->name,
+		     menu->lineno);
+
+	if (menu->sym != NULL && menu->sym->help != NULL)
+		message__add(menu->sym->help, menu->sym->name,
+			     menu->file == NULL ? "Root Menu" : menu->file->name,
+			     menu->lineno);
+
+	for (child = menu->list; child != NULL; child = child->next)
+		if (child->prompt != NULL)
+			menu_build_message_list(child);
+}
+
+static void message__print_file_lineno(struct message *self)
+{
+	struct file_line *fl = self->files;
+
+	printf("\n#: %s:%d", fl->file, fl->lineno);
+	fl = fl->next;
+
+	while (fl != NULL) {
+		printf(", %s:%d", fl->file, fl->lineno);
+		fl = fl->next;
+	}
+
+	if (self->option != NULL)
+		printf(", %s:00000", self->option);
+
+	putchar('\n');
+}
+
+static void message__print_gettext_msgid_msgstr(struct message *self)
+{
+	message__print_file_lineno(self);
+
+	printf("msgid %s\n"
+	       "msgstr \"\"\n", self->msg);
+}
+
+void menu__xgettext(void)
+{
+	struct message *m = message__list;
+
+	while (m != NULL) {
+		message__print_gettext_msgid_msgstr(m);
+		m = m->next;
+	}
+}
+
+int main(int ac, char **av)
+{
+	conf_parse(av[1]);
+
+	menu_build_message_list(menu_get_root_menu(NULL));
+	menu__xgettext();
+	return 0;
+}
diff -Nru a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
--- a/scripts/kconfig/lkc.h	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/lkc.h	2005-03-26 23:25:33 -03:00
@@ -8,6 +8,8 @@
 
 #include "expr.h"
 
+#include <libintl.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -22,6 +24,12 @@
 #undef P
 
 #define SRCTREE "srctree"
+
+#define PACKAGE "linux"
+#define LOCALEDIR "/usr/share/locale"
+
+#define _(text) gettext(text)
+#define N_(text) (text)
 
 int zconfparse(void);
 void zconfdump(FILE *out);
diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/mconf.c	2005-03-26 23:25:33 -03:00
@@ -4,6 +4,8 @@
  *
  * Introduced single menu mode (show all sub-menus in one large tree).
  * 2002-11-06 Petr Baudis <pasky@ucw.cz>
+ *
+ * i18n, 2005, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 
 #include <sys/ioctl.h>
@@ -23,7 +25,7 @@
 #include "lkc.h"
 
 static char menu_backtitle[128];
-static const char mconf_readme[] =
+static const char mconf_readme[] = N_(
 "Overview\n"
 "--------\n"
 "Some kernel features may be built directly into the kernel.\n"
@@ -156,39 +158,39 @@
 "\n"
 "Note that this mode can eventually be a little more CPU expensive\n"
 "(especially with a larger number of unrolled categories) than the\n"
-"default mode.\n",
-menu_instructions[] =
+"default mode.\n"),
+menu_instructions[] = N_(
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus --->.  "
 	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
 	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
-	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
-radiolist_instructions[] =
+	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable"),
+radiolist_instructions[] = N_(
 	"Use the arrow keys to navigate this window or "
 	"press the hotkey of the item you wish to select "
 	"followed by the <SPACE BAR>. "
-	"Press <?> for additional information about this option.",
-inputbox_instructions_int[] =
+	"Press <?> for additional information about this option."),
+inputbox_instructions_int[] = N_(
 	"Please enter a decimal value. "
 	"Fractions will not be accepted.  "
-	"Use the <TAB> key to move from the input field to the buttons below it.",
-inputbox_instructions_hex[] =
+	"Use the <TAB> key to move from the input field to the buttons below it."),
+inputbox_instructions_hex[] = N_(
 	"Please enter a hexadecimal value. "
-	"Use the <TAB> key to move from the input field to the buttons below it.",
-inputbox_instructions_string[] =
+	"Use the <TAB> key to move from the input field to the buttons below it."),
+inputbox_instructions_string[] = N_(
 	"Please enter a string value. "
-	"Use the <TAB> key to move from the input field to the buttons below it.",
-setmod_text[] =
+	"Use the <TAB> key to move from the input field to the buttons below it."),
+setmod_text[] = N_(
 	"This feature depends on another which has been configured as a module.\n"
-	"As a result, this feature will be built as a module.",
-nohelp_text[] =
-	"There is no help available for this kernel option.\n",
-load_config_text[] =
+	"As a result, this feature will be built as a module."),
+nohelp_text[] = N_(
+	"There is no help available for this kernel option.\n"),
+load_config_text[] = N_(
 	"Enter the name of the configuration file you wish to load.  "
 	"Accept the name shown to restore the configuration you "
-	"last retrieved.  Leave blank to abort.",
-load_config_help[] =
+	"last retrieved.  Leave blank to abort."),
+load_config_help[] = N_(
 	"\n"
 	"For various reasons, one may wish to keep several different kernel\n"
 	"configurations available on a single machine.\n"
@@ -198,11 +200,11 @@
 	"to modify that configuration.\n"
 	"\n"
 	"If you are uncertain, then you have probably never used alternate\n"
-	"configuration files.  You should therefor leave this blank to abort.\n",
-save_config_text[] =
+	"configuration files.  You should therefor leave this blank to abort.\n"),
+save_config_text[] = N_(
 	"Enter a filename to which this configuration should be saved "
-	"as an alternate.  Leave blank to abort.",
-save_config_help[] =
+	"as an alternate.  Leave blank to abort."),
+save_config_help[] = N_(
 	"\n"
 	"For various reasons, one may wish to keep different kernel\n"
 	"configurations available on a single machine.\n"
@@ -212,8 +214,8 @@
 	"configuration options you have selected at that time.\n"
 	"\n"
 	"If you are uncertain what all this means then you should probably\n"
-	"leave this blank.\n",
-search_help[] =
+	"leave this blank.\n"),
+search_help[] = N_(
 	"\n"
 	"Search for CONFIG_ symbols and display their relations.\n"
 	"Example: search for \"^FOO\"\n"
@@ -250,7 +252,7 @@
 	"Examples: USB	=> find all CONFIG_ symbols containing USB\n"
 	"          ^USB => find all CONFIG_ symbols starting with USB\n"
 	"          USB$ => find all CONFIG_ symbols ending with USB\n"
-	"\n";
+	"\n");
 
 static signed char buf[4096], *bufptr = buf;
 static signed char input_buf[4096];
@@ -305,8 +307,8 @@
 	}
 
 	if (rows < 19 || cols < 80) {
-		fprintf(stderr, "Your display is too small to run Menuconfig!\n");
-		fprintf(stderr, "It must be at least 19 lines by 80 columns.\n");
+		fprintf(stderr, N_("Your display is too small to run Menuconfig!\n"));
+		fprintf(stderr, N_("It must be at least 19 lines by 80 columns.\n"));
 		exit(1);
 	}
 
@@ -526,9 +528,9 @@
 again:
 	cprint_init();
 	cprint("--title");
-	cprint("Search Configuration Parameter");
+	cprint(_("Search Configuration Parameter"));
 	cprint("--inputbox");
-	cprint("Enter Keyword");
+	cprint(_("Enter Keyword"));
 	cprint("10");
 	cprint("75");
 	cprint("");
@@ -539,7 +541,7 @@
 	case 0:
 		break;
 	case 1:
-		show_helptext("Search Configuration", search_help);
+		show_helptext(_("Search Configuration"), search_help);
 		goto again;
 	default:
 		return;
@@ -548,7 +550,7 @@
 	sym_arr = sym_re_search(input_buf);
 	res = get_relations_str(sym_arr);
 	free(sym_arr);
-	show_textbox("Search Results", str_get(&res), 0, 0);
+	show_textbox(_("Search Results"), str_get(&res), 0, 0);
 	str_free(&res);
 }
 
@@ -721,9 +723,9 @@
 	while (1) {
 		cprint_init();
 		cprint("--title");
-		cprint("%s", prompt ? prompt : "Main Menu");
+		cprint("%s", prompt ? prompt : _("Main Menu"));
 		cprint("--menu");
-		cprint(menu_instructions);
+		cprint(_(menu_instructions));
 		cprint("%d", rows);
 		cprint("%d", cols);
 		cprint("%d", rows - 10);
@@ -736,9 +738,9 @@
 			cprint(":");
 			cprint("--- ");
 			cprint("L");
-			cprint("    Load an Alternate Configuration File");
+			cprint(_("    Load an Alternate Configuration File"));
 			cprint("S");
-			cprint("    Save Configuration to an Alternate File");
+			cprint(_("    Save Configuration to an Alternate File"));
 		}
 		stat = exec_conf();
 		if (stat < 0)
@@ -793,7 +795,7 @@
 			if (sym)
 				show_help(submenu);
 			else
-				show_helptext("README", mconf_readme);
+				show_helptext("README", _(mconf_readme));
 			break;
 		case 3:
 			if (type == 't') {
@@ -849,7 +851,7 @@
 	{
 		if (sym->name) {
 			str_printf(&help, "CONFIG_%s:\n\n", sym->name);
-			str_append(&help, sym->help);
+			str_append(&help, _(sym->help));
 			str_append(&help, "\n");
 		}
 	} else {
@@ -886,9 +888,9 @@
 	while (1) {
 		cprint_init();
 		cprint("--title");
-		cprint("%s", prompt ? prompt : "Main Menu");
+		cprint("%s", prompt ? prompt : _("Main Menu"));
 		cprint("--radiolist");
-		cprint(radiolist_instructions);
+		cprint(_(radiolist_instructions));
 		cprint("15");
 		cprint("70");
 		cprint("6");
@@ -935,17 +937,17 @@
 	while (1) {
 		cprint_init();
 		cprint("--title");
-		cprint("%s", prompt ? prompt : "Main Menu");
+		cprint("%s", prompt ? prompt : _("Main Menu"));
 		cprint("--inputbox");
 		switch (sym_get_type(menu->sym)) {
 		case S_INT:
-			cprint(inputbox_instructions_int);
+			cprint(_(inputbox_instructions_int));
 			break;
 		case S_HEX:
-			cprint(inputbox_instructions_hex);
+			cprint(_(inputbox_instructions_hex));
 			break;
 		case S_STRING:
-			cprint(inputbox_instructions_string);
+			cprint(_(inputbox_instructions_string));
 			break;
 		default:
 			/* panic? */;
@@ -958,7 +960,7 @@
 		case 0:
 			if (sym_set_string_value(menu->sym, input_buf))
 				return;
-			show_textbox(NULL, "You have made an invalid entry.", 5, 43);
+			show_textbox(NULL, _("You have made an invalid entry."), 5, 43);
 			break;
 		case 1:
 			show_help(menu);
@@ -987,10 +989,10 @@
 				return;
 			if (!conf_read(input_buf))
 				return;
-			show_textbox(NULL, "File does not exist!", 5, 38);
+			show_textbox(NULL, _("File does not exist!"), 5, 38);
 			break;
 		case 1:
-			show_helptext("Load Alternate Configuration", load_config_help);
+			show_helptext(_("Load Alternate Configuration"), load_config_help);
 			break;
 		case 255:
 			return;
@@ -1016,10 +1018,10 @@
 				return;
 			if (!conf_write(input_buf))
 				return;
-			show_textbox(NULL, "Can't create file!  Probably a nonexistent directory.", 5, 60);
+			show_textbox(NULL, _("Can't create file!  Probably a nonexistent directory."), 5, 60);
 			break;
 		case 1:
-			show_helptext("Save Alternate Configuration", save_config_help);
+			show_helptext(_("Save Alternate Configuration"), save_config_help);
 			break;
 		case 255:
 			return;
@@ -1040,12 +1042,16 @@
 	char *mode;
 	int stat;
 
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
 	conf_parse(av[1]);
 	conf_read(NULL);
 
 	sym = sym_lookup("KERNELRELEASE", 0);
 	sym_calc_value(sym);
-	sprintf(menu_backtitle, "Linux Kernel v%s Configuration",
+	sprintf(menu_backtitle, _("Linux Kernel v%s Configuration"),
 		sym_get_string_value(sym));
 
 	mode = getenv("MENUCONFIG_MODE");
@@ -1062,7 +1068,7 @@
 	do {
 		cprint_init();
 		cprint("--yesno");
-		cprint("Do you wish to save your new kernel configuration?");
+		cprint(_("Do you wish to save your new kernel configuration?"));
 		cprint("5");
 		cprint("60");
 		stat = exec_conf();
@@ -1070,20 +1076,20 @@
 
 	if (stat == 0) {
 		if (conf_write(NULL)) {
-			fprintf(stderr, "\n\n"
+			fprintf(stderr, _("\n\n"
 				"Error during writing of the kernel configuration.\n"
 				"Your kernel configuration changes were NOT saved."
-				"\n\n");
+				"\n\n"));
 			return 1;
 		}
-		printf("\n\n"
+		printf(_("\n\n"
 			"*** End of Linux kernel configuration.\n"
 			"*** Execute 'make' to build the kernel or try 'make help'."
-			"\n\n");
+			"\n\n"));
 	} else {
-		fprintf(stderr, "\n\n"
+		fprintf(stderr, _("\n\n"
 			"Your kernel configuration changes were NOT saved."
-			"\n\n");
+			"\n\n"));
 	}
 
 	return 0;
diff -Nru a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
--- a/scripts/kconfig/menu.c	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/menu.c	2005-03-26 23:25:33 -03:00
@@ -365,9 +365,9 @@
 const char *menu_get_prompt(struct menu *menu)
 {
 	if (menu->prompt)
-		return menu->prompt->text;
+		return _(menu->prompt->text);
 	else if (menu->sym)
-		return menu->sym->name;
+		return _(menu->sym->name);
 	return NULL;
 }
 
diff -Nru a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
--- a/scripts/kconfig/qconf.cc	2005-03-26 23:25:33 -03:00
+++ b/scripts/kconfig/qconf.cc	2005-03-26 23:25:33 -03:00
@@ -26,8 +26,23 @@
 #include "qconf.moc"
 #include "images.c"
 
+#ifdef _
+# undef _
+# define _ qgettext
+#endif
+
 static QApplication *configApp;
 
+static inline QString qgettext(const char* str)
+{
+  return QString::fromLocal8Bit(gettext(str));
+}
+
+static inline QString qgettext(const QString& str)
+{
+  return QString::fromLocal8Bit(gettext(str.latin1()));
+}
+
 ConfigSettings::ConfigSettings()
 	: showAll(false), showName(false), showRange(false), showData(false)
 {
@@ -177,7 +192,7 @@
 
 	sym = menu->sym;
 	prop = menu->prompt;
-	prompt = menu_get_prompt(menu);
+	prompt = QString::fromLocal8Bit(menu_get_prompt(menu));
 
 	if (prop) switch (prop->type) {
 	case P_MENU:
@@ -203,7 +218,7 @@
 	if (!sym)
 		goto set_prompt;
 
-	setText(nameColIdx, sym->name);
+	setText(nameColIdx, QString::fromLocal8Bit(sym->name));
 
 	type = sym_get_type(sym);
 	switch (type) {
@@ -213,9 +228,9 @@
 
 		if (!sym_is_changable(sym) && !list->showAll) {
 			setPixmap(promptColIdx, 0);
-			setText(noColIdx, 0);
-			setText(modColIdx, 0);
-			setText(yesColIdx, 0);
+			setText(noColIdx, QString::null);
+			setText(modColIdx, QString::null);
+			setText(yesColIdx, QString::null);
 			break;
 		}
 		expr = sym_get_tristate_value(sym);
@@ -257,6 +272,7 @@
 		const char* data;
 
 		data = sym_get_string_value(sym);
+
 #if QT_VERSION >= 300
 		int i = list->mapIdx(dataColIdx);
 		if (i >= 0)
@@ -264,9 +280,9 @@
 #endif
 		setText(dataColIdx, data);
 		if (type == S_STRING)
-			prompt.sprintf("%s: %s", prompt.latin1(), data);
+			prompt = QString("%1: %2").arg(prompt).arg(data);
 		else
-			prompt.sprintf("(%s) %s", data, prompt.latin1());
+			prompt = QString("(%2) %1").arg(prompt).arg(data);
 		break;
 	}
 	if (!sym_has_value(sym) && visible)
@@ -343,9 +359,9 @@
 {
 	item = i;
 	if (sym_get_string_value(item->menu->sym))
-		setText(sym_get_string_value(item->menu->sym));
+		setText(QString::fromLocal8Bit(sym_get_string_value(item->menu->sym)));
 	else
-		setText(0);
+		setText(QString::null);
 	Parent::show();
 	setFocus();
 }
@@ -961,7 +977,7 @@
 	delete configSettings;
 }
 
-static QString print_filter(const char *str)
+static QString print_filter(const QString &str)
 {
 	QRegExp re("[<>&\"\\n]");
 	QString res = str;
@@ -994,7 +1010,7 @@
 
 static void expr_print_help(void *data, const char *str)
 {
-	((QString*)data)->append(print_filter(str));
+	reinterpret_cast<QString*>(data)->append(print_filter(str));
 }
 
 /*
@@ -1009,7 +1025,7 @@
 	if (item)
 		menu = ((ConfigItem*)item)->menu;
 	if (!menu) {
-		helpText->setText(NULL);
+		helpText->setText(QString::null);
 		return;
 	}
 
@@ -1019,16 +1035,16 @@
 	if (sym) {
 		if (menu->prompt) {
 			head += "<big><b>";
-			head += print_filter(menu->prompt->text);
+			head += print_filter(_(menu->prompt->text));
 			head += "</b></big>";
 			if (sym->name) {
 				head += " (";
-				head += print_filter(sym->name);
+				head += print_filter(_(sym->name));
 				head += ")";
 			}
 		} else if (sym->name) {
 			head += "<big><b>";
-			head += print_filter(sym->name);
+			head += print_filter(_(sym->name));
 			head += "</b></big>";
 		}
 		head += "<br><br>";
@@ -1049,7 +1065,7 @@
 				case P_PROMPT:
 				case P_MENU:
 					debug += "prompt: ";
-					debug += print_filter(prop->text);
+					debug += print_filter(_(prop->text));
 					debug += "<br>";
 					break;
 				case P_DEFAULT:
@@ -1088,10 +1104,10 @@
 			debug += "<br>";
 		}
 
-		help = print_filter(sym->help);
+		help = print_filter(_(sym->help));
 	} else if (menu->prompt) {
 		head += "<big><b>";
-		head += print_filter(menu->prompt->text);
+		head += print_filter(_(menu->prompt->text));
 		head += "</b></big><br><br>";
 		if (showDebug) {
 			if (menu->prompt->visible.expr) {
@@ -1111,7 +1127,7 @@
 	QString s = QFileDialog::getOpenFileName(".config", NULL, this);
 	if (s.isNull())
 		return;
-	if (conf_read(s.latin1()))
+	if (conf_read(QFile::encodeName(s)))
 		QMessageBox::information(this, "qconf", "Unable to load configuration!");
 	ConfigView::updateListAll();
 }
@@ -1127,7 +1143,7 @@
 	QString s = QFileDialog::getSaveFileName(".config", NULL, this);
 	if (s.isNull())
 		return;
-	if (conf_write(s.latin1()))
+	if (conf_write(QFile::encodeName(s)))
 		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 }
 
@@ -1371,6 +1387,9 @@
 {
 	ConfigMainWindow* v;
 	const char *name;
+
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
 
 #ifndef LKC_DIRECT_LINK
 	kconfig_load();


--CUfgB8w4ZwR/yMy5--
