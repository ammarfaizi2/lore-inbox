Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWJQW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJQW3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWJQW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:29:29 -0400
Received: from mout2.freenet.de ([194.97.50.155]:22950 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750844AbWJQW32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:29:28 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Set gconf's save-widget's sensitivity according to .config's changed state
Date: Wed, 18 Oct 2006 00:31:34 +0200
User-Agent: KMail/1.9.4
References: <200610180023.04978.annabellesgarden@yahoo.de> <200610180028.45011.annabellesgarden@yahoo.de> <200610180030.07972.annabellesgarden@yahoo.de>
In-Reply-To: <200610180030.07972.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610180031.34485.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clean up a little.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 scripts/kconfig/gconf.c     |   35 ++++++++++++++++++-----------------
 scripts/kconfig/gconf.glade |    4 ++--
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 7b0d3a9..61d8166 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -38,8 +38,6 @@ static gboolean show_all = FALSE;
 static gboolean show_debug = FALSE;
 static gboolean resizeable = FALSE;
 
-static gboolean config_changed = FALSE;
-
 static char nohelp_text[] =
     N_("Sorry, no help available for this option yet.\n");
 
@@ -50,6 +48,8 @@ GtkWidget *text_w = NULL;
 GtkWidget *hpaned = NULL;
 GtkWidget *vpaned = NULL;
 GtkWidget *back_btn = NULL;
+GtkWidget *save_btn = NULL;
+GtkWidget *save_menu_item = NULL;
 
 GtkTextTag *tag1, *tag2;
 GdkColor color;
@@ -75,7 +75,7 @@ static void display_tree_part(void);
 static void update_tree(struct menu *src, GtkTreeIter * dst);
 static void set_node(GtkTreeIter * node, struct menu *menu, gchar ** row);
 static gchar **fill_row(struct menu *menu);
-
+static void conf_changed(void);
 
 /* Helping/Debugging Functions */
 
@@ -224,6 +224,10 @@ void init_main_window(const gchar * glad
 	gtk_check_menu_item_set_active((GtkCheckMenuItem *) widget,
 				       show_value);
 
+	save_btn = glade_xml_get_widget(xml, "button3");
+	save_menu_item = glade_xml_get_widget(xml, "save1");
+	conf_set_changed_callback(conf_changed);
+
 	style = gtk_widget_get_style(main_wnd);
 	widget = glade_xml_get_widget(xml, "toolbar1");
 
@@ -512,14 +516,14 @@ static void text_insert_msg(const char *
 
 /* Main Windows Callbacks */
 
-void on_save1_activate(GtkMenuItem * menuitem, gpointer user_data);
+void on_save_activate(GtkMenuItem * menuitem, gpointer user_data);
 gboolean on_window1_delete_event(GtkWidget * widget, GdkEvent * event,
 				 gpointer user_data)
 {
 	GtkWidget *dialog, *label;
 	gint result;
 
-	if (config_changed == FALSE)
+	if (!conf_get_changed())
 		return FALSE;
 
 	dialog = gtk_dialog_new_with_buttons(_("Warning !"),
@@ -543,7 +547,7 @@ gboolean on_window1_delete_event(GtkWidg
 	result = gtk_dialog_run(GTK_DIALOG(dialog));
 	switch (result) {
 	case GTK_RESPONSE_YES:
-		on_save1_activate(NULL, NULL);
+		on_save_activate(NULL, NULL);
 		return FALSE;
 	case GTK_RESPONSE_NO:
 		return FALSE;
@@ -621,12 +625,10 @@ void on_load1_activate(GtkMenuItem * men
 }
 
 
-void on_save1_activate(GtkMenuItem * menuitem, gpointer user_data)
+void on_save_activate(GtkMenuItem * menuitem, gpointer user_data)
 {
 	if (conf_write(NULL))
 		text_insert_msg(_("Error"), _("Unable to save configuration !"));
-
-	config_changed = FALSE;
 }
 
 
@@ -819,12 +821,6 @@ void on_load_clicked(GtkButton * button,
 }
 
 
-void on_save_clicked(GtkButton * button, gpointer user_data)
-{
-	on_save1_activate(NULL, user_data);
-}
-
-
 void on_single_clicked(GtkButton * button, gpointer user_data)
 {
 	view_mode = SINGLE_VIEW;
@@ -899,7 +895,6 @@ static void renderer_edited(GtkCellRende
 
 	sym_set_string_value(sym, new_def);
 
-	config_changed = TRUE;
 	update_tree(&rootmenu, NULL);
 
 	gtk_tree_path_free(path);
@@ -930,7 +925,6 @@ static void change_sym_value(struct menu
 		if (!sym_tristate_within_range(sym, newval))
 			newval = yes;
 		sym_set_tristate_value(sym, newval);
-		config_changed = TRUE;
 		if (view_mode == FULL_VIEW)
 			update_tree(&rootmenu, NULL);
 		else if (view_mode == SPLIT_VIEW) {
@@ -1633,3 +1627,10 @@ #endif
 
 	return 0;
 }
+
+static void conf_changed(void)
+{
+	bool changed = conf_get_changed();
+	gtk_widget_set_sensitive(save_btn, changed);
+	gtk_widget_set_sensitive(save_menu_item, changed);
+}
diff --git a/scripts/kconfig/gconf.glade b/scripts/kconfig/gconf.glade
index f8744ed..803233f 100644
--- a/scripts/kconfig/gconf.glade
+++ b/scripts/kconfig/gconf.glade
@@ -70,7 +70,7 @@
 		      <property name="tooltip" translatable="yes">Save the config in .config</property>
 		      <property name="label" translatable="yes">_Save</property>
 		      <property name="use_underline">True</property>
-		      <signal name="activate" handler="on_save1_activate"/>
+		      <signal name="activate" handler="on_save_activate"/>
 		      <accelerator key="S" modifiers="GDK_CONTROL_MASK" signal="activate"/>
 
 		      <child internal-child="image">
@@ -380,7 +380,7 @@
 		  <property name="visible_horizontal">True</property>
 		  <property name="visible_vertical">True</property>
 		  <property name="is_important">False</property>
-		  <signal name="clicked" handler="on_save_clicked"/>
+		  <signal name="clicked" handler="on_save_activate"/>
 		</widget>
 		<packing>
 		  <property name="expand">False</property>
-- 
1.4.2.3

