Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTAPV3P>; Thu, 16 Jan 2003 16:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTAPV3P>; Thu, 16 Jan 2003 16:29:15 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:3768 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267278AbTAPV2m>; Thu, 16 Jan 2003 16:28:42 -0500
Date: Thu, 16 Jan 2003 22:37:21 +0100
From: Romain Lievin <roms@tilp.info>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] gconf (kconfig & GTK+) : final release
Message-ID: <20030116213721.GB3120@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

you will find a full patch for adding gconf (GTK+ kernel configurator) to
the 2.5.58 kernel tree.

This patch contains gkc v1.04 (final release which includes the 3 views as
well as some minor enhancements).
I have tested it but others are welcome to test it, too...

People can take a look at http://tilp.info/perso/gkc.html for more informations
or for getting the full package...

Thanks, Romain.
================================[ cut here]============================
diff -Naur linux-2.5.58/Makefile linux-gconf/Makefile
--- linux-2.5.58/Makefile	Wed Jan 15 21:56:14 2003
+++ linux-gconf/Makefile	Wed Jan 15 21:58:13 2003
@@ -187,7 +187,7 @@
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
-noconfig_targets := xconfig menuconfig config oldconfig randconfig \
+noconfig_targets := xconfig menuconfig config oldconfig randconfig gconfig \
 		    defconfig allyesconfig allnoconfig allmodconfig \
 		    clean mrproper distclean \
 		    help tags TAGS sgmldocs psdocs pdfdocs htmldocs \
@@ -655,14 +655,17 @@
 # Kernel configuration
 # ---------------------------------------------------------------------------
 
-.PHONY: oldconfig xconfig menuconfig config \
+.PHONY: oldconfig xconfig menuconfig config gconfig \
 	make_with_config
 
-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf: scripts/fixdep FORCE
+scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf scripts/kconfig/gconf: scripts/fixdep FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
 
 xconfig: scripts/kconfig/qconf
 	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
+
+gconfig: scripts/kconfig/gconf
+	./scripts/kconfig/gconf arch/$(ARCH)/Kconfig
 
 menuconfig: scripts/kconfig/mconf
 	$(Q)$(MAKE) $(build)=scripts/lxdialog
diff -Naur linux-2.5.58/scripts/kconfig/Makefile linux-gconf/scripts/kconfig/Makefile
--- linux-2.5.58/scripts/kconfig/Makefile	Fri Jan 10 21:12:25 2003
+++ linux-gconf/scripts/kconfig/Makefile	Wed Jan 15 21:58:13 2003
@@ -6,29 +6,41 @@
 #         Utilizes the lxdialog package
 # qconf:  Used for the xconfig target
 #         Based on QT which needs to be installed to compile it
+# gconf:  Used for the gconfig target
+#         Based on GTK which needs to be installed to compile it
 #
+#################
 
 # object files used by all lkc flavours
 libkconfig-objs := zconf.tab.o
 
-host-progs	:= conf mconf qconf
+host-progs	:= conf mconf qconf gconf
 conf-objs	:= conf.o  libkconfig.so
 mconf-objs	:= mconf.o libkconfig.so
 
-qconf-objs	:= kconfig_load.o
-qconf-cxxobjs	:= qconf.o
+ifeq ($(MAKECMDGOALS),$(obj)/qconf)
+	qconf-objs	:= kconfig_load.o
+	qconf-cxxobjs	:= qconf.o
+endif
+
+ifeq ($(MAKECMDGOALS),$(obj)/gconf)
+	gconf-objs        := gconf.o kconfig_load.o
+endif
 
 clean-files	:= libkconfig.so lkc_defs.h qconf.moc .tmp_qtcheck \
-		   zconf.tab.c zconf.tab.h lex.zconf.c
+		   zconf.tab.c zconf.tab.h lex.zconf.c .tmp_gtkcheck
 
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
-HOSTLOADLIBES_qconf	= -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
-HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
+HOSTLOADLIBES_qconf  = -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
+HOSTCXXFLAGS_qconf.o = -I$(QTDIR)/include 
+
+HOSTLOADLIBES_gconf  = `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
+HOSTCFLAGS_gconf.o   = `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`
 
-$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o: $(obj)/zconf.tab.h
+$(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
@@ -60,11 +72,39 @@
 	fi
 endif
 
+$(obj)/gconf.o: $(obj)/.tmp_gtkcheck
+
+ifeq ($(MAKECMDGOALS),$(obj)/gconf)
+-include $(obj)/.tmp_gtkcheck
+
+# GTK needs some extra effort, too...
+$(obj)/.tmp_gtkcheck:
+	@if `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --exists`; then		\
+		if `pkg-config gtk+-2.0 --atleast-version=2.0.0`; then			\
+			true;								\
+		else									\
+			echo "*"; 							\
+			echo "* GTK+ is present but version >= 2.0.0 is required.";	\
+			echo "*";							\
+			false;								\
+		fi									\
+	else										\
+		echo "*"; 								\
+		echo "* Unable to find the GTK+ installation. Please make sure that"; 	\
+		echo "* the GTK+ 2.0 development package is correctly installed..."; 	\
+		echo "* You need gtk+-2.0, glib-2.0 and libglade-2.0."; 		\
+		echo "*"; 								\
+		false;									\
+	fi
+endif
+
 $(obj)/zconf.tab.o: $(obj)/lex.zconf.c
 
 $(obj)/kconfig_load.o: $(obj)/lkc_defs.h
 
 $(obj)/qconf.o: $(obj)/qconf.moc $(obj)/lkc_defs.h
+
+$(obj)/gconf.o: $(obj)/lkc_defs.h
 
 $(obj)/%.moc: $(src)/%.h
 	$(MOC) -i $< -o $@
diff -Naur linux-2.5.58/scripts/kconfig/gconf.c linux-gconf/scripts/kconfig/gconf.c
--- linux-2.5.58/scripts/kconfig/gconf.c	Thu Jan  1 01:00:00 1970
+++ linux-gconf/scripts/kconfig/gconf.c	Thu Jan 16 20:31:58 2003
@@ -0,0 +1,1465 @@
+/* Hey EMACS -*- linux-c -*-
+ *
+ * Copyright (C) 2002 Romain Lievin <roms@lpg.ticalc.org>
+ * Released under the terms of the GNU GPL v2.0.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#  include <config.h>
+#endif
+
+#include "lkc.h"
+#include "images.c"
+
+#include <glade/glade.h>
+#include <gtk/gtk.h>
+#include <glib.h>
+#include <gdk/gdkkeysyms.h>
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+#include <stdlib.h>
+
+//#define DEBUG
+
+enum {
+	SINGLE_VIEW, SPLIT_VIEW, FULL_VIEW
+};
+
+static gint view_mode = SPLIT_VIEW;
+static gboolean show_name = TRUE;
+static gboolean show_range = TRUE;
+static gboolean show_value = TRUE;
+static gboolean show_all = FALSE;
+static gboolean show_debug = FALSE;
+static gboolean resizeable = FALSE;
+
+static gboolean config_changed = FALSE;
+
+static char nohelp_text[] =
+    "Sorry, no help available for this option yet.\n";
+
+GtkWidget *main_wnd = NULL;
+GtkWidget *tree1_w = NULL;	// left  frame
+GtkWidget *tree2_w = NULL;	// right frame
+GtkWidget *text_w = NULL;
+GtkWidget *entry_w = NULL;
+GtkWidget *hpaned = NULL;
+GtkWidget *vpaned = NULL;
+
+GtkTextTag *tag1, *tag2;
+GdkColor color;
+
+GtkTreeStore *tree1, *tree2, *tree;
+GtkTreeModel *model1, *model2;
+static GtkTreeIter *parents[256] = { 0 };
+static gint indent;
+
+static struct menu *current;
+
+enum {
+	COLUMN_OPTION, COLUMN_NAME, COLUMN_N, COLUMN_M, COLUMN_Y,
+	    COLUMN_VALUE,
+	COLUMN_MENU, COLUMN_COLOR,	// hidden
+	COLUMN_NUMBER
+};
+
+static void display_tree(struct menu *menu);
+static void display_tree_part(void);
+static void update_tree(struct menu *src, GtkTreeIter * dst);
+static void set_node2(GtkTreeIter * node, struct menu *menu, gchar ** row);
+static gchar **fill_row(struct menu *menu);
+
+
+/* Helping/Debugging Functions */
+
+
+const char *dbg_print_stype(int val)
+{
+	static char buf[256];
+
+	bzero(buf, 256);
+
+	if (val == S_UNKNOWN)
+		strcpy(buf, "unknown");
+	if (val == S_BOOLEAN)
+		strcpy(buf, "boolean");
+	if (val == S_TRISTATE)
+		strcpy(buf, "tristate");
+	if (val == S_INT)
+		strcpy(buf, "int");
+	if (val == S_HEX)
+		strcpy(buf, "hex");
+	if (val == S_STRING)
+		strcpy(buf, "string");
+	if (val == S_OTHER)
+		strcpy(buf, "other");
+
+#ifdef DEBUG
+	printf("%s", buf);
+#endif
+
+	return buf;
+}
+
+const char *dbg_print_flags(int val)
+{
+	static char buf[256] = { 0 };
+
+	bzero(buf, 256);
+
+	if (val & SYMBOL_YES)
+		strcat(buf, "yes/");
+	if (val & SYMBOL_MOD)
+		strcat(buf, "mod/");
+	if (val & SYMBOL_NO)
+		strcat(buf, "no/");
+	if (val & SYMBOL_CONST)
+		strcat(buf, "const/");
+	if (val & SYMBOL_CHECK)
+		strcat(buf, "check/");
+	if (val & SYMBOL_CHOICE)
+		strcat(buf, "choice/");
+	if (val & SYMBOL_CHOICEVAL)
+		strcat(buf, "choiceval/");
+	if (val & SYMBOL_PRINTED)
+		strcat(buf, "printed/");
+	if (val & SYMBOL_VALID)
+		strcat(buf, "valid/");
+	if (val & SYMBOL_OPTIONAL)
+		strcat(buf, "optional/");
+	if (val & SYMBOL_WRITE)
+		strcat(buf, "write/");
+	if (val & SYMBOL_CHANGED)
+		strcat(buf, "changed/");
+	if (val & SYMBOL_NEW)
+		strcat(buf, "new/");
+	if (val & SYMBOL_AUTO)
+		strcat(buf, "auto/");
+
+	buf[strlen(buf) - 1] = '\0';
+#ifdef DEBUG
+	printf("%s", buf);
+#endif
+
+	return buf;
+}
+
+
+const char *dbg_print_ptype(int val)
+{
+	static char buf[256];
+
+	bzero(buf, 256);
+
+	if (val == P_UNKNOWN)
+		strcpy(buf, "unknown");
+	if (val == P_PROMPT)
+		strcpy(buf, "prompt");
+	if (val == P_COMMENT)
+		strcpy(buf, "comment");
+	if (val == P_MENU)
+		strcpy(buf, "menu");
+	if (val == P_ROOTMENU)
+		strcpy(buf, "rootmenu");
+	if (val == P_DEFAULT)
+		strcpy(buf, "default");
+	if (val == P_CHOICE)
+		strcpy(buf, "choice");
+
+
+
+#ifdef DEBUG
+	printf("%s", buf);
+#endif
+
+	return buf;
+}
+
+
+/* Main Window Initialization */
+
+
+void init_main_window(const gchar * glade_file)
+{
+	GladeXML *xml;
+	GtkWidget *widget;
+	GtkTextBuffer *txtbuf;
+	char title[256];
+	GdkPixmap *pixmap;
+	GdkBitmap *mask;
+	GtkStyle *style;
+
+	xml = glade_xml_new(glade_file, "window1", NULL);
+	if (!xml)
+		g_error("GUI loading failed !\n");
+	glade_xml_signal_autoconnect(xml);
+
+	main_wnd = glade_xml_get_widget(xml, "window1");
+	hpaned = glade_xml_get_widget(xml, "hpaned1");
+	vpaned = glade_xml_get_widget(xml, "vpaned1");
+	tree1_w = glade_xml_get_widget(xml, "treeview1");
+	tree2_w = glade_xml_get_widget(xml, "treeview2");
+	text_w = glade_xml_get_widget(xml, "textview3");
+
+	widget = glade_xml_get_widget(xml, "show_name1");
+	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
+				       show_name);
+
+	widget = glade_xml_get_widget(xml, "show_range1");
+	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
+				       show_range);
+
+	widget = glade_xml_get_widget(xml, "show_data1");
+	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
+				       show_value);
+
+	style = gtk_widget_get_style(main_wnd);
+	widget = glade_xml_get_widget(xml, "toolbar1");
+
+	pixmap = gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
+					      &style->bg[GTK_STATE_NORMAL],
+					      (gchar **) xpm_single_view);
+	gtk_image_set_from_pixmap(GTK_IMAGE
+				  (((GtkToolbarChild
+				     *) (g_list_nth(GTK_TOOLBAR(widget)->
+						    children,
+						    5)->data))->icon),
+				  pixmap, mask);
+	pixmap =
+	    gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
+					 &style->bg[GTK_STATE_NORMAL],
+					 (gchar **) xpm_split_view);
+	gtk_image_set_from_pixmap(GTK_IMAGE
+				  (((GtkToolbarChild
+				     *) (g_list_nth(GTK_TOOLBAR(widget)->
+						    children,
+						    6)->data))->icon),
+				  pixmap, mask);
+	pixmap =
+	    gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
+					 &style->bg[GTK_STATE_NORMAL],
+					 (gchar **) xpm_tree_view);
+	gtk_image_set_from_pixmap(GTK_IMAGE
+				  (((GtkToolbarChild
+				     *) (g_list_nth(GTK_TOOLBAR(widget)->
+						    children,
+						    7)->data))->icon),
+				  pixmap, mask);
+
+	switch (view_mode) {
+	case SINGLE_VIEW:
+		widget = glade_xml_get_widget(xml, "button4");
+		gtk_button_clicked(GTK_BUTTON(widget));
+		break;
+	case SPLIT_VIEW:
+		widget = glade_xml_get_widget(xml, "button5");
+		gtk_button_clicked(GTK_BUTTON(widget));
+		break;
+	case FULL_VIEW:
+		widget = glade_xml_get_widget(xml, "button6");
+		gtk_button_clicked(GTK_BUTTON(widget));
+		break;
+	}
+
+	entry_w = glade_xml_get_widget(xml, "entry2");
+	gtk_widget_hide(entry_w);
+
+	txtbuf = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_w));
+	tag1 = gtk_text_buffer_create_tag(txtbuf, "mytag1",
+					  "foreground", "red",
+					  "weight", PANGO_WEIGHT_BOLD,
+					  NULL);
+	tag2 = gtk_text_buffer_create_tag(txtbuf, "mytag2",
+					  /*"style", PANGO_STYLE_OBLIQUE, */
+					  NULL);
+
+	sprintf(title, "Linux Kernel v%s.%s.%s%s Configuration",
+		getenv("VERSION"), getenv("PATCHLEVEL"),
+		getenv("SUBLEVEL"), getenv("EXTRAVERSION"));
+	gtk_window_set_title(GTK_WINDOW(main_wnd), title);
+
+	gtk_widget_show(main_wnd);
+}
+
+void init_tree_model(void)
+{
+	gint i;
+
+	tree = tree2 = gtk_tree_store_new(COLUMN_NUMBER,
+					  G_TYPE_STRING, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_STRING,
+					  G_TYPE_POINTER, GDK_TYPE_COLOR);
+	model2 = GTK_TREE_MODEL(tree2);
+
+	for (parents[0] = NULL, i = 1; i < 256; i++)
+		parents[i] = (GtkTreeIter *) g_malloc(sizeof(GtkTreeIter));
+
+	tree1 = gtk_tree_store_new(COLUMN_NUMBER,
+				   G_TYPE_STRING, G_TYPE_STRING,
+				   G_TYPE_STRING, G_TYPE_STRING,
+				   G_TYPE_STRING, G_TYPE_STRING,
+				   G_TYPE_POINTER, GDK_TYPE_COLOR);
+	model1 = GTK_TREE_MODEL(tree1);
+}
+
+void init_left_tree(void)
+{
+	GtkTreeView *view = GTK_TREE_VIEW(tree1_w);
+	GtkCellRenderer *renderer;
+	GtkTreeSelection *sel;
+
+	gtk_tree_view_set_model(view, model1);
+	gtk_tree_view_set_headers_visible(view, TRUE);
+	gtk_tree_view_set_rules_hint(view, FALSE);
+
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "Options", renderer,
+						    "text", COLUMN_OPTION,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+
+	sel = gtk_tree_view_get_selection(view);
+	gtk_tree_selection_set_mode(sel, GTK_SELECTION_SINGLE);
+	gtk_widget_realize(tree1_w);
+}
+
+void init_right_tree(void)
+{
+	GtkTreeView *view = GTK_TREE_VIEW(tree2_w);
+	GtkCellRenderer *renderer;
+	GtkTreeSelection *sel;
+	GtkTreeViewColumn *col;
+	gint i;
+
+	gtk_tree_view_set_model(view, model2);
+	gtk_tree_view_set_headers_visible(view, TRUE);
+	gtk_tree_view_set_rules_hint(view, FALSE);
+
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "Options", renderer,
+						    "text", COLUMN_OPTION,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "Name", renderer,
+						    "text", COLUMN_NAME,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "N", renderer,
+						    "text", COLUMN_N,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "M", renderer,
+						    "text", COLUMN_M,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "Y", renderer,
+						    "text", COLUMN_Y,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_insert_column_with_attributes(view, -1,
+						    "Value", renderer,
+						    "text", COLUMN_VALUE,
+						    "foreground-gdk",
+						    COLUMN_COLOR, NULL);
+
+	col = gtk_tree_view_get_column(view, COLUMN_NAME);
+	gtk_tree_view_column_set_visible(col, show_name);
+	col = gtk_tree_view_get_column(view, COLUMN_N);
+	gtk_tree_view_column_set_visible(col, show_range);
+	col = gtk_tree_view_get_column(view, COLUMN_M);
+	gtk_tree_view_column_set_visible(col, show_range);
+	col = gtk_tree_view_get_column(view, COLUMN_Y);
+	gtk_tree_view_column_set_visible(col, show_range);
+	col = gtk_tree_view_get_column(view, COLUMN_VALUE);
+	gtk_tree_view_column_set_visible(col, show_value);
+
+	if (resizeable) {
+		for (i = 0; i < COLUMN_VALUE; i++) {
+			GtkTreeViewColumn *col;
+
+			col = gtk_tree_view_get_column(view, i);
+			gtk_tree_view_column_set_resizable(col, TRUE);
+		}
+	}
+
+	sel = gtk_tree_view_get_selection(view);
+	gtk_tree_selection_set_mode(sel, GTK_SELECTION_SINGLE);
+}
+
+
+/* Utility Functions */
+
+
+static void text_insert_help(struct menu *menu)
+{
+	GtkTextBuffer *buffer;
+	GtkTextIter start, end;
+	const char *prompt = menu_get_prompt(menu);
+	gchar *name;
+	const char *help = nohelp_text;
+
+	if (!menu->sym)
+		help = "";
+	else if (menu->sym->help)
+		help = menu->sym->help;
+
+	if (menu->sym && menu->sym->name)
+		name = g_strdup_printf(menu->sym->name);
+	else
+		name = g_strdup("");
+
+	buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_w));
+	gtk_text_buffer_get_bounds(buffer, &start, &end);
+	gtk_text_buffer_delete(buffer, &start, &end);
+	gtk_text_view_set_left_margin(GTK_TEXT_VIEW(text_w), 15);
+
+	gtk_text_buffer_get_end_iter(buffer, &end);
+	gtk_text_buffer_insert_with_tags(buffer, &end, prompt, -1, tag1,
+					 NULL);
+	gtk_text_buffer_insert_at_cursor(buffer, " ", 1);
+	gtk_text_buffer_get_end_iter(buffer, &end);
+	gtk_text_buffer_insert_with_tags(buffer, &end, name, -1, tag1,
+					 NULL);
+	gtk_text_buffer_insert_at_cursor(buffer, "\n\n", 2);
+	gtk_text_buffer_get_end_iter(buffer, &end);
+	gtk_text_buffer_insert_with_tags(buffer, &end, help, -1, tag2,
+					 NULL);
+}
+
+
+static void text_insert_msg(const char *title, const char *message)
+{
+	GtkTextBuffer *buffer;
+	GtkTextIter start, end;
+	const char *msg = message;
+
+	buffer = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_w));
+	gtk_text_buffer_get_bounds(buffer, &start, &end);
+	gtk_text_buffer_delete(buffer, &start, &end);
+	gtk_text_view_set_left_margin(GTK_TEXT_VIEW(text_w), 15);
+
+	gtk_text_buffer_get_end_iter(buffer, &end);
+	gtk_text_buffer_insert_with_tags(buffer, &end, title, -1, tag1,
+					 NULL);
+	gtk_text_buffer_insert_at_cursor(buffer, "\n\n", 2);
+	gtk_text_buffer_get_end_iter(buffer, &end);
+	gtk_text_buffer_insert_with_tags(buffer, &end, msg, -1, tag2,
+					 NULL);
+}
+
+
+/* Main Windows Callbacks */
+
+
+void on_window1_destroy(GtkObject * object, gpointer user_data)
+{
+	gtk_widget_destroy(GTK_WIDGET(user_data));
+	gtk_main_quit();
+}
+
+
+void
+on_window1_size_request(GtkWidget * widget,
+			GtkRequisition * requisition, gpointer user_data)
+{
+	static gint old_h = 0;
+	gint w, h;
+
+	if (widget->window == NULL)
+		gtk_window_get_default_size(GTK_WINDOW(main_wnd), &w, &h);
+	else
+		gdk_window_get_size(widget->window, &w, &h);
+
+	if (h == old_h)
+		return;
+	old_h = h;
+
+	gtk_paned_set_position(GTK_PANED(vpaned), 2 * h / 3);
+}
+
+
+/* Menu & Toolbar Callbacks */
+
+
+static void
+load_filename(GtkFileSelection * file_selector, gpointer user_data)
+{
+	const gchar *fn;
+
+	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
+					     (user_data));
+
+	if (conf_read(fn))
+		text_insert_msg("Error", "Unable to load configuration !");
+	else
+		display_tree(&rootmenu);
+}
+
+void on_load1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkWidget *fs;
+
+	fs = gtk_file_selection_new("Load file...");
+	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
+			 "clicked",
+			 G_CALLBACK(load_filename), (gpointer) fs);
+	g_signal_connect_swapped(GTK_OBJECT
+				 (GTK_FILE_SELECTION(fs)->ok_button),
+				 "clicked", G_CALLBACK(gtk_widget_destroy),
+				 (gpointer) fs);
+	g_signal_connect_swapped(GTK_OBJECT
+				 (GTK_FILE_SELECTION(fs)->cancel_button),
+				 "clicked", G_CALLBACK(gtk_widget_destroy),
+				 (gpointer) fs);
+	gtk_widget_show(fs);
+}
+
+
+void on_save1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	if (conf_write(NULL))
+		text_insert_msg("Error", "Unable to save configuration !");
+
+	config_changed = FALSE;
+}
+
+
+static void
+store_filename(GtkFileSelection * file_selector, gpointer user_data)
+{
+	const gchar *fn;
+
+	fn = gtk_file_selection_get_filename(GTK_FILE_SELECTION
+					     (user_data));
+
+	if (conf_write(fn))
+		text_insert_msg("Error", "Unable to save configuration !");
+
+	gtk_widget_destroy(GTK_WIDGET(user_data));
+}
+
+void on_save_as1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkWidget *fs;
+
+	fs = gtk_file_selection_new("Save file as...");
+	g_signal_connect(GTK_OBJECT(GTK_FILE_SELECTION(fs)->ok_button),
+			 "clicked",
+			 G_CALLBACK(store_filename), (gpointer) fs);
+	g_signal_connect_swapped(GTK_OBJECT
+				 (GTK_FILE_SELECTION(fs)->ok_button),
+				 "clicked", G_CALLBACK(gtk_widget_destroy),
+				 (gpointer) fs);
+	g_signal_connect_swapped(GTK_OBJECT
+				 (GTK_FILE_SELECTION(fs)->cancel_button),
+				 "clicked", G_CALLBACK(gtk_widget_destroy),
+				 (gpointer) fs);
+	gtk_widget_show(fs);
+}
+
+
+void on_quit1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkWidget *dialog, *label;
+	gint result;
+
+	if (config_changed == FALSE) {
+		gtk_widget_destroy(GTK_WIDGET(main_wnd));
+		return;
+	}
+
+	dialog = gtk_dialog_new_with_buttons("Warning !",
+					     GTK_WINDOW(main_wnd),
+					     (GtkDialogFlags)
+					     (GTK_DIALOG_MODAL |
+					      GTK_DIALOG_DESTROY_WITH_PARENT),
+					     GTK_STOCK_OK,
+					     GTK_RESPONSE_YES,
+					     GTK_STOCK_NO,
+					     GTK_RESPONSE_NO,
+					     GTK_STOCK_CANCEL,
+					     GTK_RESPONSE_CANCEL, NULL);
+	gtk_dialog_set_default_response(GTK_DIALOG(dialog),
+					GTK_RESPONSE_CANCEL);
+
+	label = gtk_label_new("\nSave configuration ?\n");
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), label);
+	gtk_widget_show(label);
+
+	result = gtk_dialog_run(GTK_DIALOG(dialog));
+	switch (result) {
+	case GTK_RESPONSE_YES:
+		on_save1_activate(NULL, NULL);
+		gtk_widget_destroy(GTK_WIDGET(user_data));
+		gtk_main_quit();
+		break;
+	case GTK_RESPONSE_NO:
+		gtk_widget_destroy(GTK_WIDGET(user_data));
+		gtk_main_quit();
+		break;
+	case GTK_RESPONSE_CANCEL:
+	case GTK_RESPONSE_DELETE_EVENT:
+	default:
+		break;
+	}
+	gtk_widget_destroy(dialog);
+}
+
+
+void on_show_name1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkTreeViewColumn *col;
+
+	show_name = GTK_CHECK_MENU_ITEM(menuitem)->active;
+	col =
+	    gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), COLUMN_NAME);
+	if (col)
+		gtk_tree_view_column_set_visible(col, show_name);
+}
+
+
+void on_show_range1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkTreeViewColumn *col;
+
+	show_range = GTK_CHECK_MENU_ITEM(menuitem)->active;
+	col = gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), COLUMN_N);
+	if (col)
+		gtk_tree_view_column_set_visible(col, show_range);
+	col = gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), COLUMN_M);
+	if (col)
+		gtk_tree_view_column_set_visible(col, show_range);
+	col = gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), COLUMN_Y);
+	if (col)
+		gtk_tree_view_column_set_visible(col, show_range);
+
+}
+
+
+void on_show_data1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkTreeViewColumn *col;
+
+	show_value = GTK_CHECK_MENU_ITEM(menuitem)->active;
+	col =
+	    gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), COLUMN_VALUE);
+	if (col)
+		gtk_tree_view_column_set_visible(col, show_value);
+}
+
+
+void
+on_show_all_options1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	show_all = GTK_CHECK_MENU_ITEM(menuitem)->active;
+
+	gtk_tree_store_clear(tree2);
+	display_tree(&rootmenu);	// instead of update_tree for speed reasons
+}
+
+
+void
+on_show_debug_info1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	show_debug = GTK_CHECK_MENU_ITEM(menuitem)->active;
+	update_tree(&rootmenu, NULL);
+}
+
+
+void on_introduction1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkWidget *dialog;
+	const gchar *intro_text =
+	    "Welcome to gkc, the GTK+ graphical kernel configuration tool\n"
+	    "for Linux.\n"
+	    "For each option, a blank box indicates the feature is disabled, a\n"
+	    "check indicates it is enabled, and a dot indicates that it is to\n"
+	    "be compiled as a module.  Clicking on the box will cycle through the three states.\n"
+	    "\n"
+	    "If you do not see an option (e.g., a device driver) that you\n"
+	    "believe should be present, try turning on Show All Options\n"
+	    "under the Options menu.\n"
+	    "Although there is no cross reference yet to help you figure out\n"
+	    "what other options must be enabled to support the option you\n"
+	    "are interested in, you can still view the help of a grayed-out\n"
+	    "option.\n"
+	    "\n"
+	    "Toggling Show Debug Info under the Options menu will show \n"
+	    "the dependencies, which you can then match by examining other options.";
+
+	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
+					GTK_DIALOG_DESTROY_WITH_PARENT,
+					GTK_MESSAGE_INFO,
+					GTK_BUTTONS_CLOSE, intro_text);
+	g_signal_connect_swapped(GTK_OBJECT(dialog), "response",
+				 G_CALLBACK(gtk_widget_destroy),
+				 GTK_OBJECT(dialog));
+	gtk_widget_show_all(dialog);
+}
+
+
+void on_about1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkWidget *dialog;
+	const gchar *about_text =
+	    "gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+	    "Based on the source code from Roman Zippel.\n";
+
+	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
+					GTK_DIALOG_DESTROY_WITH_PARENT,
+					GTK_MESSAGE_INFO,
+					GTK_BUTTONS_CLOSE, about_text);
+	g_signal_connect_swapped(GTK_OBJECT(dialog), "response",
+				 G_CALLBACK(gtk_widget_destroy),
+				 GTK_OBJECT(dialog));
+	gtk_widget_show_all(dialog);
+}
+
+
+void on_license1_activate(GtkMenuItem * menuitem, gpointer user_data)
+{
+	GtkWidget *dialog;
+	const gchar *license_text =
+	    "gkc is released under the terms of the GNU GPL v2.\n"
+	    "For more information, please see the source code or\n"
+	    "visit http://www.fsf.org/licenses/licenses.html\n";
+
+	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
+					GTK_DIALOG_DESTROY_WITH_PARENT,
+					GTK_MESSAGE_INFO,
+					GTK_BUTTONS_CLOSE, license_text);
+	g_signal_connect_swapped(GTK_OBJECT(dialog), "response",
+				 G_CALLBACK(gtk_widget_destroy),
+				 GTK_OBJECT(dialog));
+	gtk_widget_show_all(dialog);
+}
+
+
+void on_back_pressed(GtkButton * button, gpointer user_data)
+{
+	if ((current == &rootmenu) || (view_mode != SINGLE_VIEW))
+		return;
+	current = current->parent;
+	display_tree_part();
+}
+
+
+void on_load_pressed(GtkButton * button, gpointer user_data)
+{
+	on_load1_activate(NULL, user_data);
+}
+
+
+void on_save_pressed(GtkButton * button, gpointer user_data)
+{
+	on_save1_activate(NULL, user_data);
+}
+
+
+void on_single_clicked(GtkButton * button, gpointer user_data)
+{
+	view_mode = SINGLE_VIEW;
+	gtk_paned_set_position(GTK_PANED(hpaned), 0);
+	gtk_widget_hide(tree1_w);
+	if (tree2)
+		gtk_tree_store_clear(tree2);
+	current = &rootmenu;
+	display_tree_part();
+}
+
+
+void on_split_clicked(GtkButton * button, gpointer user_data)
+{
+	gint w, h;
+	view_mode = SPLIT_VIEW;
+	gtk_widget_show(tree1_w);
+	gtk_window_get_default_size(GTK_WINDOW(main_wnd), &w, &h);
+	gtk_paned_set_position(GTK_PANED(hpaned), w / 2);
+	if (tree2)
+		gtk_tree_store_clear(tree2);
+}
+
+
+void on_full_clicked(GtkButton * button, gpointer user_data)
+{
+	view_mode = FULL_VIEW;
+	gtk_paned_set_position(GTK_PANED(hpaned), 0);
+	gtk_widget_hide(tree1_w);
+	if (tree2)
+		gtk_tree_store_clear(tree2);
+	display_tree(&rootmenu);
+}
+
+
+void on_collapse_pressed(GtkButton * button, gpointer user_data)
+{
+	gtk_tree_view_collapse_all(GTK_TREE_VIEW(tree2_w));
+}
+
+
+void on_expand_pressed(GtkButton * button, gpointer user_data)
+{
+	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
+}
+
+
+/* CTree Callbacks */
+
+
+static gint handler_id = -1;
+
+/* Numerical value entry */
+void on_entry1_activate(GtkEntry * entry, gpointer user_data)
+{
+
+	const char *def;
+	struct menu *menu = (struct menu *) user_data;
+	struct symbol *sym = menu->sym;
+
+	def = gtk_entry_get_text(entry);
+	sym_set_string_value(sym, def);
+
+	gtk_widget_hide(entry_w);
+	gtk_signal_disconnect(GTK_OBJECT(entry_w), handler_id);
+
+	config_changed = TRUE;
+	update_tree(&rootmenu, NULL);
+}
+
+
+gboolean
+on_entry1_key_press_event(GtkWidget * widget,
+			  GdkEventKey * event, gpointer user_data)
+{
+	if (event->keyval == GDK_Escape) {
+		gtk_widget_hide(entry_w);
+		gtk_signal_disconnect(GTK_OBJECT(entry_w), handler_id);
+	}
+	return FALSE;
+}
+
+/* Change the value of a symbol and update the tree */
+static void change_sym_value(struct menu *menu, gint col)
+{
+	struct symbol *sym = menu->sym;
+	const char *def;
+	int stype;
+	tristate oldval, newval;
+
+	newval = no;
+	switch (col) {
+	case COLUMN_OPTION:
+		return;
+	case COLUMN_NAME:
+		return;
+	case COLUMN_N:
+		newval = no;
+		break;
+	case COLUMN_M:
+		newval = mod;
+		break;
+	case COLUMN_Y:
+		newval = yes;
+		break;
+	default:
+		break;
+	}
+
+	if (!sym)
+		return;
+
+	stype = sym_get_type(sym);
+	switch (stype) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		if (col == COLUMN_VALUE)
+			return;
+		else {
+			oldval = sym_get_tristate_value(sym);
+			sym_set_tristate_value(sym, newval);
+			config_changed = TRUE;
+			if (view_mode == FULL_VIEW)
+				update_tree(&rootmenu, NULL);
+			else
+				//display_tree_part();	//fixme: keep exp/coll
+				update_tree(current, NULL);
+		}
+		break;
+	case S_INT:
+	case S_HEX:
+	case S_STRING:
+		if (col == COLUMN_VALUE) {
+			def = sym_get_string_value(sym);
+			gtk_widget_show(entry_w);
+			gtk_entry_set_text(GTK_ENTRY(entry_w), def);
+			handler_id =
+			    gtk_signal_connect(GTK_OBJECT(entry_w),
+					       "activate",
+					       GTK_SIGNAL_FUNC
+					       (on_entry1_activate), menu);
+		}
+		break;
+	}
+}
+
+
+static gint column2index(GtkTreeViewColumn * column)
+{
+	gint i;
+
+	for (i = 0; i < COLUMN_NUMBER; i++) {
+		GtkTreeViewColumn *col;
+
+		col = gtk_tree_view_get_column(GTK_TREE_VIEW(tree2_w), i);
+		if (col == column)
+			return i;
+	}
+
+	return -1;
+}
+
+
+//#define GTK_BUG_FIXED // GTK+ 2.1.4 mini
+
+/* User click: update choice (full) or goes down (single) */
+gboolean
+on_treeview2_button_press_event(GtkWidget * widget,
+				GdkEventButton * event, gpointer user_data)
+{
+	GtkTreeView *view = GTK_TREE_VIEW(widget);
+	GtkTreePath *path;
+	GtkTreeViewColumn *column;
+	GtkTreeIter iter;
+	struct menu *menu;
+	gint col;
+
+#ifdef GTK_BUG_FIXED
+	gint tx = (gint) event->x;
+	gint ty = (gint) event->y;
+	gint cx, cy;
+
+	gtk_tree_view_get_path_at_pos(view, tx, ty, &path, &column, &cx,
+				      &cy);
+#else
+	gtk_tree_view_get_cursor(view, &path, &column);
+#endif
+	if (path == NULL)
+		return FALSE;
+
+	gtk_tree_model_get_iter(model2, &iter, path);
+	gtk_tree_model_get(model2, &iter, COLUMN_MENU, &menu, -1);
+
+	col = column2index(column);
+	if ((col == COLUMN_OPTION) && (event->type == GDK_2BUTTON_PRESS) &&
+	    (view_mode == SINGLE_VIEW) && menu->list) {
+		current = menu;
+		display_tree_part();
+	} else
+		change_sym_value(menu, col);
+
+	return FALSE;
+}
+
+/* Key pressed: update choice */
+gboolean
+on_treeview2_key_press_event(GtkWidget * widget,
+			     GdkEventKey * event, gpointer user_data)
+{
+	GtkTreeView *view = GTK_TREE_VIEW(widget);
+	GtkTreePath *path;
+	GtkTreeViewColumn *column;
+	GtkTreeIter iter;
+	struct menu *menu;
+	gint col;
+
+	gtk_tree_view_get_cursor(view, &path, &column);
+	if (path == NULL) {
+		//g_warning("key_press_event: path is NULL !\n");
+		return FALSE;
+	}
+
+	if (event->keyval == GDK_space) {
+		if (gtk_tree_view_row_expanded(view, path))
+			gtk_tree_view_collapse_row(view, path);
+		else
+			gtk_tree_view_expand_row(view, path, FALSE);
+		return FALSE;
+	}
+	if (widget == tree1_w)
+		return FALSE;
+
+	gtk_tree_model_get_iter(model2, &iter, path);
+	gtk_tree_model_get(model2, &iter, COLUMN_MENU, &menu, -1);
+
+	if (!strcasecmp(event->string, "n"))
+		col = COLUMN_N;
+	else if (!strcasecmp(event->string, "m"))
+		col = COLUMN_M;
+	else if (!strcasecmp(event->string, "y"))
+		col = COLUMN_Y;
+	else if (!strcasecmp(event->string, "e"))
+		col = COLUMN_VALUE;
+	else
+		col = 0;
+
+	change_sym_value(menu, col);
+
+	return FALSE;
+}
+
+
+/* Row selection changed: update help */
+void
+on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
+{
+	GtkTreeSelection *selection;
+	GtkTreeIter iter;
+	struct menu *menu;
+
+	selection = gtk_tree_view_get_selection(treeview);
+	if (gtk_tree_selection_get_selected(selection, &model2, &iter)) {
+		gtk_tree_model_get(model2, &iter, COLUMN_MENU, &menu, -1);
+		text_insert_help(menu);
+	}
+}
+
+
+/* User click: display sub-tree in the right frame. */
+gboolean
+on_treeview1_button_press_event(GtkWidget * widget,
+				GdkEventButton * event, gpointer user_data)
+{
+	GtkTreeView *view = GTK_TREE_VIEW(widget);
+	GtkTreePath *path;
+	GtkTreeViewColumn *column;
+	GtkTreeIter iter;
+	struct menu *menu;
+
+	gint tx = (gint) event->x;
+	gint ty = (gint) event->y;
+	gint cx, cy;
+
+	gtk_tree_view_get_path_at_pos(view, tx, ty, &path, &column, &cx,
+				      &cy);
+	if (path == NULL)
+		return FALSE;
+
+	gtk_tree_model_get_iter(model1, &iter, path);
+	gtk_tree_model_get(model1, &iter, COLUMN_MENU, &menu, -1);
+
+	current = menu;
+	display_tree_part();
+
+	return FALSE;
+}
+
+/* Conf management */
+
+
+/* Fill a row of strings */
+static gchar **fill_row(struct menu *menu)
+{
+	static gchar **row;
+	struct symbol *sym = menu->sym;
+	const char *def;
+	int stype;
+	tristate oldval;
+
+	row = (gchar **) g_malloc0(COLUMN_NUMBER * sizeof(gchar *));
+
+	row[0] = g_strdup_printf("%s %s", menu_get_prompt(menu),
+				 sym ?
+				 (sym->flags & SYMBOL_NEW ? "(NEW)" : "") :
+				 "");
+	if (!sym)
+		return row;
+
+	row[1] = g_strdup(sym->name);
+
+	sym_calc_value(sym);
+	sym->flags &= ~SYMBOL_CHANGED;
+
+	if (sym_is_choice(sym)) {	// parse childs for getting final value
+		struct menu *child;
+		struct symbol *def_sym = sym_get_choice_value(sym);
+		struct menu *def_menu = NULL;
+
+		for (child = menu->list; child; child = child->next) {
+			if (menu_is_visible(child)
+			    && child->sym == def_sym)
+				def_menu = child;
+		}
+
+		if (def_menu)
+			row[5] = g_strdup(menu_get_prompt(def_menu));
+	}
+
+	stype = sym_get_type(sym);
+	switch (stype) {
+	case S_BOOLEAN:
+		if (sym_is_choice(sym))
+			break;
+	case S_TRISTATE:
+		oldval = sym_get_tristate_value(sym);
+		switch (oldval) {
+		case no:
+			row[5] = g_strdup("N");
+			row[2] = g_strdup("N");
+			break;
+		case mod:
+			row[5] = g_strdup("M");
+			row[3] = g_strdup("M");
+			break;
+		case yes:
+			row[5] = g_strdup("Y");
+			row[4] = g_strdup("Y");
+			break;
+		}
+
+		if (oldval != no && sym_tristate_within_range(sym, no))
+			row[2] = g_strdup("_");
+		if (oldval != mod && sym_tristate_within_range(sym, mod))
+			row[3] = g_strdup("_");
+		if (oldval != yes && sym_tristate_within_range(sym, yes))
+			row[4] = g_strdup("_");
+		break;
+	case S_INT:
+	case S_HEX:
+	case S_STRING:
+		def = sym_get_string_value(sym);
+		row[5] = g_strdup(def);
+		break;
+	}
+
+	return row;
+}
+
+
+/* Set the node content with a row of strings */
+static void set_node2(GtkTreeIter * node, struct menu *menu, gchar ** row)
+{
+	GdkColor color;
+	gboolean success;
+
+	if (show_all && !menu_is_visible(menu))
+		gdk_color_parse("DarkGray", &color);
+	else
+		gdk_color_parse("Black", &color);
+	gdk_colormap_alloc_colors(gdk_colormap_get_system(), &color, 1,
+				  FALSE, FALSE, &success);
+
+	gtk_tree_store_set(tree, node,
+			   COLUMN_OPTION, row[COLUMN_OPTION],
+			   COLUMN_NAME, row[COLUMN_NAME],
+			   COLUMN_N, row[COLUMN_N],
+			   COLUMN_M, row[COLUMN_M],
+			   COLUMN_Y, row[COLUMN_Y],
+			   COLUMN_VALUE, row[COLUMN_VALUE],
+			   COLUMN_MENU, (gpointer) menu,
+			   COLUMN_COLOR, &color, -1);
+	g_strfreev(row);
+}
+
+
+/* Add a node to the tree */
+static void place_node2(struct menu *menu, char **row)
+{
+	GtkTreeIter *parent = parents[indent - 1];
+	GtkTreeIter *node = parents[indent];
+
+	gtk_tree_store_append(tree, node, parent);
+	set_node2(node, menu, row);
+}
+
+
+/* Find a node in the GTK+ tree */
+static GtkTreeIter found;
+
+/*
+ * Find a menu in the GtkTree starting at parent.
+ */
+GtkTreeIter *gtktree_iter_find_node(GtkTreeIter * parent,
+				    struct menu *tofind)
+{
+	GtkTreeIter iter;
+	GtkTreeIter *child = &iter;
+	gboolean valid;
+	GtkTreeIter *ret;
+
+	valid = gtk_tree_model_iter_children(model2, child, parent);
+	while (valid) {
+		struct menu *menu;
+
+		gtk_tree_model_get(model2, child, 6, &menu, -1);
+
+		if (menu == tofind) {
+			memcpy(&found, child, sizeof(GtkTreeIter));
+			return &found;
+		}
+
+		ret = gtktree_iter_find_node(child, tofind);
+		if (ret)
+			return ret;
+
+		valid = gtk_tree_model_iter_next(model2, child);
+	}
+
+	return NULL;
+}
+
+
+/*
+ * Update the tree by adding/removing entries
+ * Does not change other nodes
+ */
+static void update_tree(struct menu *src, GtkTreeIter * dst)
+{
+	struct menu *child1;
+	GtkTreeIter iter, tmp;
+	GtkTreeIter *child2 = &iter;
+	gboolean valid;
+	GtkTreeIter *sibling;
+	struct symbol *sym;
+	struct property *prop;
+	struct menu *menu1, *menu2;
+
+	if (src == &rootmenu)
+		indent = 1;
+
+	valid = gtk_tree_model_iter_children(model2, child2, dst);
+	for (child1 = src->list; child1; child1 = child1->next) {
+
+		prop = child1->prompt;
+		sym = child1->sym;
+
+	      reparse:
+		menu1 = child1;
+		if (valid)
+			gtk_tree_model_get(model2, child2, COLUMN_MENU,
+					   &menu2, -1);
+		else
+			menu2 = NULL;	// force adding of a first child
+
+#ifdef DEBUG
+		printf("%*c%s | %s\n", indent, ' ',
+		       menu1 ? menu_get_prompt(menu1) : "nil",
+		       menu2 ? menu_get_prompt(menu2) : "nil");
+#endif
+
+		if (!menu_is_visible(child1) && !show_all) {	// remove node
+			if (gtktree_iter_find_node(dst, menu1) != NULL) {
+				memcpy(&tmp, child2, sizeof(GtkTreeIter));
+				valid = gtk_tree_model_iter_next(model2,
+								 child2);
+				gtk_tree_store_remove(tree2, &tmp);
+				if (!valid)
+					return;	// next parent 
+				else
+					goto reparse;	// next child
+			} else
+				continue;
+		}
+
+		if (menu1 != menu2) {
+			if (gtktree_iter_find_node(dst, menu1) == NULL) {	// add node
+				if (!valid && !menu2)
+					sibling = NULL;
+				else
+					sibling = child2;
+				gtk_tree_store_insert_before(tree2,
+							     child2,
+							     dst, sibling);
+				set_node2(child2, menu1, fill_row(menu1));
+				if (menu2 == NULL)
+					valid = TRUE;
+			} else {	// remove node
+				memcpy(&tmp, child2, sizeof(GtkTreeIter));
+				valid = gtk_tree_model_iter_next(model2,
+								 child2);
+				gtk_tree_store_remove(tree2, &tmp);
+				if (!valid)
+					return;	// next parent 
+				else
+					goto reparse;	// next child
+			}
+		} else if (sym && (sym->flags & SYMBOL_CHANGED)) {
+			set_node2(child2, menu1, fill_row(menu1));
+		}
+
+		indent++;
+		update_tree(child1, child2);
+		indent--;
+
+		valid = gtk_tree_model_iter_next(model2, child2);
+	}
+}
+
+
+/* Display the whole tree (single/split/full view) */
+static void display_tree(struct menu *menu)
+{
+	struct symbol *sym;
+	struct property *prop;
+	struct menu *child;
+	enum prop_type ptype;
+
+	if (menu == &rootmenu) {
+		indent = 1;
+		current = &rootmenu;
+	}
+
+	for (child = menu->list; child; child = child->next) {
+		prop = child->prompt;
+		sym = child->sym;
+		ptype = child->prompt ? child->prompt->type : P_UNKNOWN;
+
+		if (sym)
+			sym->flags &= ~SYMBOL_CHANGED;
+
+		if ((view_mode == SPLIT_VIEW) && (ptype != P_ROOTMENU) &&
+		    (tree == tree1))
+			continue;
+
+		if ((view_mode == SPLIT_VIEW) && (ptype == P_ROOTMENU) &&
+		    (tree == tree2))
+			continue;
+
+		if (menu_is_visible(child) || show_all)
+			place_node2(child, fill_row(child));
+#ifdef DEBUG
+		printf("%*c%s: ", indent, ' ', menu_get_prompt(child));
+		dbg_print_ptype(ptype);
+		printf(" | ");
+		if (sym) {
+			dbg_print_stype(sym->type);
+			printf(" | ");
+			dbg_print_flags(sym->flags);
+			printf("\n");
+		} else
+			printf("\n");
+#endif
+		if (((menu != &rootmenu) && (ptype != P_ROOTMENU)) ||
+		    (view_mode == FULL_VIEW)
+		    || (view_mode == SPLIT_VIEW)) {
+			indent++;
+			display_tree(child);
+			indent--;
+		}
+	}
+}
+
+/* Display a part of the tree starting at current node (single/split view) */
+static void display_tree_part(void)
+{
+	gtk_tree_store_clear(tree2);
+	display_tree(current);
+	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
+}
+
+/* Display the list in the left frame (split view) */
+static void display_list(void)
+{
+	tree = tree1;
+	display_tree(&rootmenu);
+	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree1_w));
+	tree = tree2;
+}
+
+static void fixup_rootmenu(struct menu *menu)
+{
+	struct menu *child;
+
+	if (!menu->prompt || menu->prompt->type != P_MENU)
+		return;
+	menu->prompt->type = P_ROOTMENU;
+	for (child = menu->list; child; child = child->next)
+		fixup_rootmenu(child);
+}
+
+
+/* Main */
+
+
+int main(int ac, char *av[])
+{
+	const char *name;
+	gchar *cur_dir, *exe_path;
+	gchar *glade_file;
+
+#ifndef LKC_DIRECT_LINK
+	kconfig_load();
+#endif
+
+	/* GTK stuffs */
+	gtk_set_locale();
+	gtk_init(&ac, &av);
+	glade_init();
+
+	//add_pixmap_directory (PACKAGE_DATA_DIR "/" PACKAGE "/pixmaps");
+	//add_pixmap_directory (PACKAGE_SOURCE_DIR "/pixmaps");
+
+	/* Determine GUI path */
+	cur_dir = g_get_current_dir();
+	exe_path = g_strdup(av[0]);
+	exe_path[0] = '/';
+	glade_file = g_strconcat(cur_dir, exe_path, ".glade", NULL);
+	g_free(cur_dir);
+	g_free(exe_path);
+
+	/* Load the interface and connect signals */
+	init_main_window(glade_file);
+	init_tree_model();
+	init_left_tree();
+	init_right_tree();
+
+	/* Conf stuffs */
+	if (ac > 1 && av[1][0] == '-') {
+		switch (av[1][1]) {
+		case 'a':
+			//showAll = 1;
+			break;
+		case 'h':
+		case '?':
+			printf("%s <config>\n", av[0]);
+			exit(0);
+		}
+		name = av[2];
+	} else
+		name = av[1];
+
+	conf_parse(name);
+	fixup_rootmenu(&rootmenu);
+	conf_read(NULL);
+
+	switch (view_mode) {
+	case SINGLE_VIEW:
+		display_tree_part();
+		break;
+	case SPLIT_VIEW:
+		display_list();
+		break;
+	case FULL_VIEW:
+		display_tree(&rootmenu);
+		break;
+	}
+
+	gtk_main();
+
+	return 0;
+}
diff -Naur linux-2.5.58/scripts/kconfig/gconf.glade linux-gconf/scripts/kconfig/gconf.glade
--- linux-2.5.58/scripts/kconfig/gconf.glade	Thu Jan  1 01:00:00 1970
+++ linux-gconf/scripts/kconfig/gconf.glade	Wed Jan 15 21:58:13 2003
@@ -0,0 +1,575 @@
+<?xml version="1.0" standalone="no"?> <!--*- mode: xml -*-->
+<!DOCTYPE glade-interface SYSTEM "http://glade.gnome.org/glade-2.0.dtd">
+
+<glade-interface>
+
+<widget class="GtkWindow" id="window1">
+  <property name="visible">True</property>
+  <property name="title" translatable="yes">Gtk Kernel Configurator</property>
+  <property name="type">GTK_WINDOW_TOPLEVEL</property>
+  <property name="window_position">GTK_WIN_POS_NONE</property>
+  <property name="modal">False</property>
+  <property name="default_width">640</property>
+  <property name="default_height">480</property>
+  <property name="resizable">True</property>
+  <property name="destroy_with_parent">False</property>
+  <signal name="destroy" handler="on_window1_destroy" object="window1"/>
+  <signal name="size_request" handler="on_window1_size_request" object="vpaned1" last_modification_time="Fri, 11 Jan 2002 16:17:11 GMT"/>
+
+  <child>
+    <widget class="GtkVBox" id="vbox1">
+      <property name="visible">True</property>
+      <property name="homogeneous">False</property>
+      <property name="spacing">0</property>
+
+      <child>
+	<widget class="GtkMenuBar" id="menubar1">
+	  <property name="visible">True</property>
+
+	  <child>
+	    <widget class="GtkMenuItem" id="file1">
+	      <property name="visible">True</property>
+	      <property name="label" translatable="yes">_File</property>
+	      <property name="use_underline">True</property>
+
+	      <child>
+		<widget class="GtkMenu" id="file1_menu">
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="load1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Load a config file</property>
+		      <property name="label" translatable="yes">_Load</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_load1_activate"/>
+		      <accelerator key="L" modifiers="GDK_CONTROL_MASK" signal="activate"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image21">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-open</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="save1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Save the config in .config</property>
+		      <property name="label" translatable="yes">_Save</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_save1_activate"/>
+		      <accelerator key="S" modifiers="GDK_CONTROL_MASK" signal="activate"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image22">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-save</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="save_as1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Save the config in a file</property>
+		      <property name="label" translatable="yes">Save _as</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_save_as1_activate"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image23">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-save-as</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkMenuItem" id="separator1">
+		      <property name="visible">True</property>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="quit1">
+		      <property name="visible">True</property>
+		      <property name="label" translatable="yes">_Quit</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_quit1_activate"/>
+		      <accelerator key="Q" modifiers="GDK_CONTROL_MASK" signal="activate"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image24">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-quit</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+		</widget>
+	      </child>
+	    </widget>
+	  </child>
+
+	  <child>
+	    <widget class="GtkMenuItem" id="options1">
+	      <property name="visible">True</property>
+	      <property name="label" translatable="yes">_Options</property>
+	      <property name="use_underline">True</property>
+
+	      <child>
+		<widget class="GtkMenu" id="options1_menu">
+
+		  <child>
+		    <widget class="GtkCheckMenuItem" id="show_name1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Show name</property>
+		      <property name="label" translatable="yes">Show _name</property>
+		      <property name="use_underline">True</property>
+		      <property name="active">True</property>
+		      <signal name="activate" handler="on_show_name1_activate"/>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkCheckMenuItem" id="show_range1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Show range (Y/M/N)</property>
+		      <property name="label" translatable="yes">Show _range</property>
+		      <property name="use_underline">True</property>
+		      <property name="active">False</property>
+		      <signal name="activate" handler="on_show_range1_activate"/>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkCheckMenuItem" id="show_data1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Show value of the option</property>
+		      <property name="label" translatable="yes">Show _data</property>
+		      <property name="use_underline">True</property>
+		      <property name="active">False</property>
+		      <signal name="activate" handler="on_show_data1_activate"/>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkMenuItem" id="separator2">
+		      <property name="visible">True</property>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkCheckMenuItem" id="show_all_options1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Show all options</property>
+		      <property name="label" translatable="yes">Show all _options</property>
+		      <property name="use_underline">True</property>
+		      <property name="active">False</property>
+		      <signal name="activate" handler="on_show_all_options1_activate"/>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkCheckMenuItem" id="show_debug_info1">
+		      <property name="visible">True</property>
+		      <property name="tooltip" translatable="yes">Show masked options</property>
+		      <property name="label" translatable="yes">Show _debug info</property>
+		      <property name="use_underline">True</property>
+		      <property name="active">False</property>
+		      <signal name="activate" handler="on_show_debug_info1_activate"/>
+		    </widget>
+		  </child>
+		</widget>
+	      </child>
+	    </widget>
+	  </child>
+
+	  <child>
+	    <widget class="GtkMenuItem" id="help1">
+	      <property name="visible">True</property>
+	      <property name="label" translatable="yes">_Help</property>
+	      <property name="use_underline">True</property>
+
+	      <child>
+		<widget class="GtkMenu" id="help1_menu">
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="introduction1">
+		      <property name="visible">True</property>
+		      <property name="label" translatable="yes">_Introduction</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_introduction1_activate" last_modification_time="Fri, 15 Nov 2002 20:26:30 GMT"/>
+		      <accelerator key="I" modifiers="GDK_CONTROL_MASK" signal="activate"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image25">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-dialog-question</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="about1">
+		      <property name="visible">True</property>
+		      <property name="label" translatable="yes">_About</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_about1_activate" last_modification_time="Fri, 15 Nov 2002 20:26:30 GMT"/>
+		      <accelerator key="A" modifiers="GDK_CONTROL_MASK" signal="activate"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image26">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-properties</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+
+		  <child>
+		    <widget class="GtkImageMenuItem" id="license1">
+		      <property name="visible">True</property>
+		      <property name="label" translatable="yes">_License</property>
+		      <property name="use_underline">True</property>
+		      <signal name="activate" handler="on_license1_activate" last_modification_time="Fri, 15 Nov 2002 20:26:30 GMT"/>
+
+		      <child internal-child="image">
+			<widget class="GtkImage" id="image27">
+			  <property name="visible">True</property>
+			  <property name="stock">gtk-justify-fill</property>
+			  <property name="icon_size">1</property>
+			  <property name="xalign">0.5</property>
+			  <property name="yalign">0.5</property>
+			  <property name="xpad">0</property>
+			  <property name="ypad">0</property>
+			</widget>
+		      </child>
+		    </widget>
+		  </child>
+		</widget>
+	      </child>
+	    </widget>
+	  </child>
+	</widget>
+	<packing>
+	  <property name="padding">0</property>
+	  <property name="expand">False</property>
+	  <property name="fill">False</property>
+	</packing>
+      </child>
+
+      <child>
+	<widget class="GtkHandleBox" id="handlebox1">
+	  <property name="visible">True</property>
+	  <property name="shadow_type">GTK_SHADOW_OUT</property>
+	  <property name="handle_position">GTK_POS_LEFT</property>
+	  <property name="snap_edge">GTK_POS_TOP</property>
+
+	  <child>
+	    <widget class="GtkToolbar" id="toolbar1">
+	      <property name="visible">True</property>
+	      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
+	      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
+	      <property name="tooltips">True</property>
+
+	      <child>
+		<widget class="button" id="button1">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Goes up of one level (single view)</property>
+		  <property name="label" translatable="yes">Back</property>
+		  <property name="use_underline">True</property>
+		  <property name="stock_pixmap">gtk-undo</property>
+		  <signal name="pressed" handler="on_back_pressed"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="GtkVSeparator" id="vseparator1">
+		  <property name="visible">True</property>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button2">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Load a config file</property>
+		  <property name="label" translatable="yes">Load</property>
+		  <property name="use_underline">True</property>
+		  <property name="stock_pixmap">gtk-open</property>
+		  <signal name="pressed" handler="on_load_pressed"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button3">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Save a config file</property>
+		  <property name="label" translatable="yes">Save</property>
+		  <property name="use_underline">True</property>
+		  <property name="stock_pixmap">gtk-save</property>
+		  <signal name="pressed" handler="on_save_pressed"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="GtkVSeparator" id="vseparator2">
+		  <property name="visible">True</property>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button4">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Single view</property>
+		  <property name="label" translatable="yes">Single</property>
+		  <property name="use_underline">True</property>
+		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <signal name="clicked" handler="on_single_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:39 GMT"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button5">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Split view</property>
+		  <property name="label" translatable="yes">Split</property>
+		  <property name="use_underline">True</property>
+		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <signal name="clicked" handler="on_split_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:45 GMT"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button6">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Full view</property>
+		  <property name="label" translatable="yes">Full</property>
+		  <property name="use_underline">True</property>
+		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <signal name="clicked" handler="on_full_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:50 GMT"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="GtkVSeparator" id="vseparator3">
+		  <property name="visible">True</property>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button7">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Collapse the whole tree in the right frame</property>
+		  <property name="label" translatable="yes">Collapse</property>
+		  <property name="use_underline">True</property>
+		  <signal name="pressed" handler="on_collapse_pressed"/>
+		</widget>
+	      </child>
+
+	      <child>
+		<widget class="button" id="button8">
+		  <property name="visible">True</property>
+		  <property name="tooltip" translatable="yes">Expand the whole tree in the right frame</property>
+		  <property name="label" translatable="yes">Expand</property>
+		  <property name="use_underline">True</property>
+		  <signal name="pressed" handler="on_expand_pressed"/>
+		</widget>
+	      </child>
+	    </widget>
+	  </child>
+	</widget>
+	<packing>
+	  <property name="padding">0</property>
+	  <property name="expand">False</property>
+	  <property name="fill">False</property>
+	</packing>
+      </child>
+
+      <child>
+	<widget class="GtkHPaned" id="hpaned1">
+	  <property name="width_request">1</property>
+	  <property name="visible">True</property>
+	  <property name="can_focus">True</property>
+	  <property name="position">0</property>
+
+	  <child>
+	    <widget class="GtkScrolledWindow" id="scrolledwindow1">
+	      <property name="visible">True</property>
+	      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
+	      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
+	      <property name="shadow_type">GTK_SHADOW_IN</property>
+	      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
+
+	      <child>
+		<widget class="GtkTreeView" id="treeview1">
+		  <property name="visible">True</property>
+		  <property name="can_focus">True</property>
+		  <property name="headers_visible">True</property>
+		  <property name="rules_hint">False</property>
+		  <property name="reorderable">False</property>
+		  <property name="enable_search">True</property>
+		  <signal name="cursor_changed" handler="on_treeview2_cursor_changed" last_modification_time="Sun, 12 Jan 2003 15:58:22 GMT"/>
+		  <signal name="button_press_event" handler="on_treeview1_button_press_event" last_modification_time="Sun, 12 Jan 2003 16:03:52 GMT"/>
+		  <signal name="key_press_event" handler="on_treeview2_key_press_event" last_modification_time="Sun, 12 Jan 2003 16:11:44 GMT"/>
+		</widget>
+	      </child>
+	    </widget>
+	    <packing>
+	      <property name="shrink">True</property>
+	      <property name="resize">False</property>
+	    </packing>
+	  </child>
+
+	  <child>
+	    <widget class="GtkVPaned" id="vpaned1">
+	      <property name="visible">True</property>
+	      <property name="can_focus">True</property>
+	      <property name="position">0</property>
+
+	      <child>
+		<widget class="GtkVBox" id="vbox2">
+		  <property name="visible">True</property>
+		  <property name="homogeneous">False</property>
+		  <property name="spacing">0</property>
+
+		  <child>
+		    <widget class="GtkScrolledWindow" id="scrolledwindow2">
+		      <property name="visible">True</property>
+		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
+		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
+		      <property name="shadow_type">GTK_SHADOW_IN</property>
+		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
+
+		      <child>
+			<widget class="GtkTreeView" id="treeview2">
+			  <property name="visible">True</property>
+			  <property name="can_focus">True</property>
+			  <property name="has_focus">True</property>
+			  <property name="headers_visible">True</property>
+			  <property name="rules_hint">False</property>
+			  <property name="reorderable">False</property>
+			  <property name="enable_search">True</property>
+			  <signal name="cursor_changed" handler="on_treeview2_cursor_changed" last_modification_time="Sun, 12 Jan 2003 15:57:55 GMT"/>
+			  <signal name="button_press_event" handler="on_treeview2_button_press_event" last_modification_time="Sun, 12 Jan 2003 15:57:58 GMT"/>
+			  <signal name="key_press_event" handler="on_treeview2_key_press_event" last_modification_time="Sun, 12 Jan 2003 15:58:01 GMT"/>
+			</widget>
+		      </child>
+		    </widget>
+		    <packing>
+		      <property name="padding">0</property>
+		      <property name="expand">True</property>
+		      <property name="fill">True</property>
+		    </packing>
+		  </child>
+
+		  <child>
+		    <widget class="GtkEntry" id="entry2">
+		      <property name="visible">True</property>
+		      <property name="can_focus">True</property>
+		      <property name="editable">True</property>
+		      <property name="visibility">True</property>
+		      <property name="max_length">0</property>
+		      <property name="text" translatable="yes"></property>
+		      <property name="has_frame">True</property>
+		      <property name="invisible_char" translatable="yes">*</property>
+		      <property name="activates_default">False</property>
+		      <signal name="key_press_event" handler="on_entry1_key_press_event" last_modification_time="Sun, 01 Dec 2002 17:01:28 GMT"/>
+		    </widget>
+		    <packing>
+		      <property name="padding">0</property>
+		      <property name="expand">False</property>
+		      <property name="fill">False</property>
+		    </packing>
+		  </child>
+		</widget>
+		<packing>
+		  <property name="shrink">True</property>
+		  <property name="resize">False</property>
+		</packing>
+	      </child>
+
+	      <child>
+		<widget class="GtkScrolledWindow" id="scrolledwindow3">
+		  <property name="visible">True</property>
+		  <property name="hscrollbar_policy">GTK_POLICY_NEVER</property>
+		  <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
+		  <property name="shadow_type">GTK_SHADOW_IN</property>
+		  <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
+
+		  <child>
+		    <widget class="GtkTextView" id="textview3">
+		      <property name="visible">True</property>
+		      <property name="can_focus">True</property>
+		      <property name="editable">False</property>
+		      <property name="justification">GTK_JUSTIFY_LEFT</property>
+		      <property name="wrap_mode">GTK_WRAP_WORD</property>
+		      <property name="cursor_visible">True</property>
+		      <property name="pixels_above_lines">0</property>
+		      <property name="pixels_below_lines">0</property>
+		      <property name="pixels_inside_wrap">0</property>
+		      <property name="left_margin">0</property>
+		      <property name="right_margin">0</property>
+		      <property name="indent">0</property>
+		      <property name="text" translatable="yes">Sorry, no help available for this option yet.</property>
+		    </widget>
+		  </child>
+		</widget>
+		<packing>
+		  <property name="shrink">True</property>
+		  <property name="resize">True</property>
+		</packing>
+	      </child>
+	    </widget>
+	    <packing>
+	      <property name="shrink">True</property>
+	      <property name="resize">True</property>
+	    </packing>
+	  </child>
+	</widget>
+	<packing>
+	  <property name="padding">0</property>
+	  <property name="expand">True</property>
+	  <property name="fill">True</property>
+	</packing>
+      </child>
+    </widget>
+  </child>
+</widget>
+
+</glade-interface>  
-- 
Romain Lievin, aka 'roms'  	<roms@tilp.info>
The TiLP project is on 		<http://www.ti-lpg.org>
"Linux, y'a moins bien mais c'est plus cher !"














