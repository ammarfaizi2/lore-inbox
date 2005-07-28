Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVG1WTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVG1WTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVG1WTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:19:02 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:6037 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261561AbVG1WRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:17:09 -0400
Date: Fri, 29 Jul 2005 00:18:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Joachim Nilsson <joachim.nilsson@vmlinux.org>,
       linux-kernel@vger.kernel.org, Lindsay Haisley <fmouse-n91xya@fmp.com>
Subject: [PATCH] fix gconfig crash
Message-ID: <20050728221803.GA31983@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joachim Nilsson <joachim.nilsson@vmlinux.org>

I ran glade-2 on the glade file, fixed two missing stock icons and
cleaned up the C code that inserts the single/split/full modes. The
rest of the patch is minor cleanups only. I refrained from using all
the included xpm icons in images.c (like qconf.cc does) in favour of
using the stock Gtk+ icons instead. Oh, yes there was a "back" bug
in split mode that I also removed, oh well...


It has been tested with success by several people, including
Jesper Juhl, Randy Dunlap and myself.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -178,17 +178,31 @@ const char *dbg_print_ptype(int val)
 }
 
 
-/* Main Window Initialization */
+void replace_button_icon(GladeXML * xml, GdkDrawable * window,
+			 GtkStyle * style, gchar * btn_name, gchar ** xpm)
+{
+	GdkPixmap *pixmap;
+	GdkBitmap *mask;
+	GtkToolButton *button;
+	GtkWidget *image;
 
+	pixmap = gdk_pixmap_create_from_xpm_d(window, &mask,
+					      &style->bg[GTK_STATE_NORMAL],
+					      xpm);
+
+	button = GTK_TOOL_BUTTON(glade_xml_get_widget(xml, btn_name));
+	image = gtk_image_new_from_pixmap(pixmap, mask);
+	gtk_widget_show(image);
+	gtk_tool_button_set_icon_widget(button, image);
+}
 
+/* Main Window Initialization */
 void init_main_window(const gchar * glade_file)
 {
 	GladeXML *xml;
 	GtkWidget *widget;
 	GtkTextBuffer *txtbuf;
 	char title[256];
-	GdkPixmap *pixmap;
-	GdkBitmap *mask;
 	GtkStyle *style;
 
 	xml = glade_xml_new(glade_file, "window1", NULL);
@@ -221,36 +235,22 @@ void init_main_window(const gchar * glad
 	style = gtk_widget_get_style(main_wnd);
 	widget = glade_xml_get_widget(xml, "toolbar1");
 
-	pixmap = gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
-					      &style->bg[GTK_STATE_NORMAL],
-					      (gchar **) xpm_single_view);
-	gtk_image_set_from_pixmap(GTK_IMAGE
-				  (((GtkToolbarChild
-				     *) (g_list_nth(GTK_TOOLBAR(widget)->
-						    children,
-						    5)->data))->icon),
-				  pixmap, mask);
-	pixmap =
-	    gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
-					 &style->bg[GTK_STATE_NORMAL],
-					 (gchar **) xpm_split_view);
-	gtk_image_set_from_pixmap(GTK_IMAGE
-				  (((GtkToolbarChild
-				     *) (g_list_nth(GTK_TOOLBAR(widget)->
-						    children,
-						    6)->data))->icon),
-				  pixmap, mask);
-	pixmap =
-	    gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
-					 &style->bg[GTK_STATE_NORMAL],
-					 (gchar **) xpm_tree_view);
-	gtk_image_set_from_pixmap(GTK_IMAGE
-				  (((GtkToolbarChild
-				     *) (g_list_nth(GTK_TOOLBAR(widget)->
-						    children,
-						    7)->data))->icon),
-				  pixmap, mask);
+#if 0	/* Use stock Gtk icons instead */
+	replace_button_icon(xml, main_wnd->window, style,
+			    "button1", (gchar **) xpm_back);
+	replace_button_icon(xml, main_wnd->window, style,
+			    "button2", (gchar **) xpm_load);
+	replace_button_icon(xml, main_wnd->window, style,
+			    "button3", (gchar **) xpm_save);
+#endif
+	replace_button_icon(xml, main_wnd->window, style,
+			    "button4", (gchar **) xpm_single_view);
+	replace_button_icon(xml, main_wnd->window, style,
+			    "button5", (gchar **) xpm_split_view);
+	replace_button_icon(xml, main_wnd->window, style,
+			    "button6", (gchar **) xpm_tree_view);
 
+#if 0
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		widget = glade_xml_get_widget(xml, "button4");
@@ -265,7 +265,7 @@ void init_main_window(const gchar * glad
 		g_signal_emit_by_name(widget, "clicked");
 		break;
 	}
-
+#endif
 	txtbuf = gtk_text_view_get_buffer(GTK_TEXT_VIEW(text_w));
 	tag1 = gtk_text_buffer_create_tag(txtbuf, "mytag1",
 					  "foreground", "red",
@@ -322,7 +322,7 @@ void init_left_tree(void)
 	gtk_tree_view_set_model(view, model1);
 	gtk_tree_view_set_headers_visible(view, TRUE);
 	gtk_tree_view_set_rules_hint(view, FALSE);
-	
+
 	column = gtk_tree_view_column_new();
 	gtk_tree_view_append_column(view, column);
 	gtk_tree_view_column_set_title(column, _("Options"));
@@ -334,11 +334,11 @@ void init_left_tree(void)
 					    renderer,
 					    "active", COL_BTNACT,
 					    "inconsistent", COL_BTNINC,
-					    "visible", COL_BTNVIS, 
+					    "visible", COL_BTNVIS,
 					    "radio", COL_BTNRAD, NULL);
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_column_pack_start(GTK_TREE_VIEW_COLUMN(column),
-					renderer, FALSE);	
+					renderer, FALSE);
 	gtk_tree_view_column_set_attributes(GTK_TREE_VIEW_COLUMN(column),
 					    renderer,
 					    "text", COL_OPTION,
@@ -386,7 +386,7 @@ void init_right_tree(void)
 					    renderer,
 					    "active", COL_BTNACT,
 					    "inconsistent", COL_BTNINC,
-					    "visible", COL_BTNVIS, 
+					    "visible", COL_BTNVIS,
 					    "radio", COL_BTNRAD, NULL);
 	/*g_signal_connect(G_OBJECT(renderer), "toggled",
 	   G_CALLBACK(renderer_toggled), NULL); */
@@ -806,7 +806,7 @@ void on_license1_activate(GtkMenuItem * 
 }
 
 
-void on_back_pressed(GtkButton * button, gpointer user_data)
+void on_back_clicked(GtkButton * button, gpointer user_data)
 {
 	enum prop_type ptype;
 
@@ -821,13 +821,13 @@ void on_back_pressed(GtkButton * button,
 }
 
 
-void on_load_pressed(GtkButton * button, gpointer user_data)
+void on_load_clicked(GtkButton * button, gpointer user_data)
 {
 	on_load1_activate(NULL, user_data);
 }
 
 
-void on_save_pressed(GtkButton * button, gpointer user_data)
+void on_save_clicked(GtkButton * button, gpointer user_data)
 {
 	on_save1_activate(NULL, user_data);
 }
@@ -850,9 +850,12 @@ void on_split_clicked(GtkButton * button
 	gtk_widget_show(tree1_w);
 	gtk_window_get_default_size(GTK_WINDOW(main_wnd), &w, &h);
 	gtk_paned_set_position(GTK_PANED(hpaned), w / 2);
-	if (tree2)	
+	if (tree2)
 		gtk_tree_store_clear(tree2);
 	display_list();
+
+	/* Disable back btn, like in full mode. */
+	gtk_widget_set_sensitive(back_btn, FALSE);
 }
 
 
@@ -868,13 +871,13 @@ void on_full_clicked(GtkButton * button,
 }
 
 
-void on_collapse_pressed(GtkButton * button, gpointer user_data)
+void on_collapse_clicked(GtkButton * button, gpointer user_data)
 {
 	gtk_tree_view_collapse_all(GTK_TREE_VIEW(tree2_w));
 }
 
 
-void on_expand_pressed(GtkButton * button, gpointer user_data)
+void on_expand_clicked(GtkButton * button, gpointer user_data)
 {
 	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
 }
@@ -1242,13 +1245,13 @@ static gchar **fill_row(struct menu *men
 			row[COL_VALUE] =
 			    g_strdup(menu_get_prompt(def_menu));
 	}
-	if(sym->flags & SYMBOL_CHOICEVAL)
+	if (sym->flags & SYMBOL_CHOICEVAL)
 		row[COL_BTNRAD] = GINT_TO_POINTER(TRUE);
 
 	stype = sym_get_type(sym);
 	switch (stype) {
 	case S_BOOLEAN:
-		if(GPOINTER_TO_INT(row[COL_PIXVIS]) == FALSE)
+		if (GPOINTER_TO_INT(row[COL_PIXVIS]) == FALSE)
 			row[COL_BTNVIS] = GINT_TO_POINTER(TRUE);
 		if (sym_is_choice(sym))
 			break;
@@ -1423,7 +1426,7 @@ static void update_tree(struct menu *src
 								 child2);
 				gtk_tree_store_remove(tree2, &tmp);
 				if (!valid)
-					return;	// next parent 
+					return;	// next parent
 				else
 					goto reparse;	// next child
 			} else
@@ -1448,7 +1451,7 @@ static void update_tree(struct menu *src
 								 child2);
 				gtk_tree_store_remove(tree2, &tmp);
 				if (!valid)
-					return;	// next parent 
+					return;	// next parent
 				else
 					goto reparse;	// next child
 			}
@@ -1486,12 +1489,12 @@ static void display_tree(struct menu *me
 		if (sym)
 			sym->flags &= ~SYMBOL_CHANGED;
 
-		if ((view_mode == SPLIT_VIEW) && !(child->flags & MENU_ROOT) &&
-		    (tree == tree1))
+		if ((view_mode == SPLIT_VIEW)
+		    && !(child->flags & MENU_ROOT) && (tree == tree1))
 			continue;
 
-		if ((view_mode == SPLIT_VIEW) && (child->flags & MENU_ROOT) &&
-		    (tree == tree2))
+		if ((view_mode == SPLIT_VIEW) && (child->flags & MENU_ROOT)
+		    && (tree == tree2))
 			continue;
 
 		if (menu_is_visible(child) || show_all)
@@ -1513,11 +1516,12 @@ static void display_tree(struct menu *me
 		    && (tree == tree2))
 			continue;
 /*
-		if (((menu != &rootmenu) && !(menu->flags & MENU_ROOT)) ||
-		    (view_mode == FULL_VIEW)
+                if (((menu != &rootmenu) && !(menu->flags & MENU_ROOT))
+		    || (view_mode == FULL_VIEW)
 		    || (view_mode == SPLIT_VIEW))*/
 		if (((view_mode == SINGLE_VIEW) && (menu->flags & MENU_ROOT))
-		    || (view_mode == FULL_VIEW) || (view_mode == SPLIT_VIEW)) {
+		    || (view_mode == FULL_VIEW)
+		    || (view_mode == SPLIT_VIEW)) {
 			indent++;
 			display_tree(child);
 			indent--;
@@ -1530,9 +1534,9 @@ static void display_tree_part(void)
 {
 	if (tree2)
 		gtk_tree_store_clear(tree2);
-	if(view_mode == SINGLE_VIEW)
+	if (view_mode == SINGLE_VIEW)
 		display_tree(current);
- 	else if(view_mode == SPLIT_VIEW)
+	else if (view_mode == SPLIT_VIEW)
 		display_tree(browsed);
 	gtk_tree_view_expand_all(GTK_TREE_VIEW(tree2_w));
 }
@@ -1551,24 +1555,22 @@ static void display_list(void)
 
 void fixup_rootmenu(struct menu *menu)
 {
-        struct menu *child;
-        static int menu_cnt = 0;
+	struct menu *child;
+	static int menu_cnt = 0;
 
-        menu->flags |= MENU_ROOT;
-        for (child = menu->list; child; child = child->next) {
-                if (child->prompt && child->prompt->type == P_MENU) {
-                        menu_cnt++;
-                        fixup_rootmenu(child);
-                        menu_cnt--;
-                } else if (!menu_cnt)
-                        fixup_rootmenu(child);
-        }
+	menu->flags |= MENU_ROOT;
+	for (child = menu->list; child; child = child->next) {
+		if (child->prompt && child->prompt->type == P_MENU) {
+			menu_cnt++;
+			fixup_rootmenu(child);
+			menu_cnt--;
+		} else if (!menu_cnt)
+			fixup_rootmenu(child);
+	}
 }
 
 
 /* Main */
-
-
 int main(int ac, char *av[])
 {
 	const char *name;
diff --git a/scripts/kconfig/gconf.glade b/scripts/kconfig/gconf.glade
--- a/scripts/kconfig/gconf.glade
+++ b/scripts/kconfig/gconf.glade
@@ -13,6 +13,11 @@
   <property name="default_height">480</property>
   <property name="resizable">True</property>
   <property name="destroy_with_parent">False</property>
+  <property name="decorated">True</property>
+  <property name="skip_taskbar_hint">False</property>
+  <property name="skip_pager_hint">False</property>
+  <property name="type_hint">GDK_WINDOW_TYPE_HINT_NORMAL</property>
+  <property name="gravity">GDK_GRAVITY_NORTH_WEST</property>
   <signal name="destroy" handler="on_window1_destroy" object="window1"/>
   <signal name="size_request" handler="on_window1_size_request" object="vpaned1" last_modification_time="Fri, 11 Jan 2002 16:17:11 GMT"/>
   <signal name="delete_event" handler="on_window1_delete_event" object="window1" last_modification_time="Sun, 09 Mar 2003 19:42:46 GMT"/>
@@ -46,7 +51,7 @@
 		      <accelerator key="L" modifiers="GDK_CONTROL_MASK" signal="activate"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image27">
+			<widget class="GtkImage" id="image39">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-open</property>
 			  <property name="icon_size">1</property>
@@ -69,7 +74,7 @@
 		      <accelerator key="S" modifiers="GDK_CONTROL_MASK" signal="activate"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image28">
+			<widget class="GtkImage" id="image40">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-save</property>
 			  <property name="icon_size">1</property>
@@ -91,7 +96,7 @@
 		      <signal name="activate" handler="on_save_as1_activate"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image29">
+			<widget class="GtkImage" id="image41">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-save-as</property>
 			  <property name="icon_size">1</property>
@@ -105,7 +110,7 @@
 		  </child>
 
 		  <child>
-		    <widget class="GtkMenuItem" id="separator1">
+		    <widget class="GtkSeparatorMenuItem" id="separator1">
 		      <property name="visible">True</property>
 		    </widget>
 		  </child>
@@ -119,7 +124,7 @@
 		      <accelerator key="Q" modifiers="GDK_CONTROL_MASK" signal="activate"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image30">
+			<widget class="GtkImage" id="image42">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-quit</property>
 			  <property name="icon_size">1</property>
@@ -179,7 +184,7 @@
 		  </child>
 
 		  <child>
-		    <widget class="GtkMenuItem" id="separator2">
+		    <widget class="GtkSeparatorMenuItem" id="separator2">
 		      <property name="visible">True</property>
 		    </widget>
 		  </child>
@@ -228,7 +233,7 @@
 		      <accelerator key="I" modifiers="GDK_CONTROL_MASK" signal="activate"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image31">
+			<widget class="GtkImage" id="image43">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-dialog-question</property>
 			  <property name="icon_size">1</property>
@@ -250,7 +255,7 @@
 		      <accelerator key="A" modifiers="GDK_CONTROL_MASK" signal="activate"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image32">
+			<widget class="GtkImage" id="image44">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-properties</property>
 			  <property name="icon_size">1</property>
@@ -271,7 +276,7 @@
 		      <signal name="activate" handler="on_license1_activate" last_modification_time="Fri, 15 Nov 2002 20:26:30 GMT"/>
 
 		      <child internal-child="image">
-			<widget class="GtkImage" id="image33">
+			<widget class="GtkImage" id="image45">
 			  <property name="visible">True</property>
 			  <property name="stock">gtk-justify-fill</property>
 			  <property name="icon_size">1</property>
@@ -308,109 +313,207 @@
 	      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
 	      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
 	      <property name="tooltips">True</property>
+	      <property name="show_arrow">True</property>
 
 	      <child>
-		<widget class="button" id="button1">
+		<widget class="GtkToolButton" id="button1">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Goes up of one level (single view)</property>
 		  <property name="label" translatable="yes">Back</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-undo</property>
-		  <signal name="pressed" handler="on_back_pressed"/>
+		  <property name="stock_id">gtk-undo</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+		  <signal name="clicked" handler="on_back_clicked"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="GtkVSeparator" id="vseparator1">
+		<widget class="GtkToolItem" id="toolitem1">
 		  <property name="visible">True</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+
+		  <child>
+		    <widget class="GtkVSeparator" id="vseparator1">
+		      <property name="visible">True</property>
+		    </widget>
+		  </child>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">False</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button2">
+		<widget class="GtkToolButton" id="button2">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Load a config file</property>
 		  <property name="label" translatable="yes">Load</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-open</property>
-		  <signal name="pressed" handler="on_load_pressed"/>
+		  <property name="stock_id">gtk-open</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+		  <signal name="clicked" handler="on_load_clicked"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button3">
+		<widget class="GtkToolButton" id="button3">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Save a config file</property>
 		  <property name="label" translatable="yes">Save</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-save</property>
-		  <signal name="pressed" handler="on_save_pressed"/>
+		  <property name="stock_id">gtk-save</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+		  <signal name="clicked" handler="on_save_clicked"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="GtkVSeparator" id="vseparator2">
+		<widget class="GtkToolItem" id="toolitem2">
 		  <property name="visible">True</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+
+		  <child>
+		    <widget class="GtkVSeparator" id="vseparator2">
+		      <property name="visible">True</property>
+		    </widget>
+		  </child>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">False</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button4">
+		<widget class="GtkToolButton" id="button4">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Single view</property>
 		  <property name="label" translatable="yes">Single</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <property name="stock_id">gtk-missing-image</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
 		  <signal name="clicked" handler="on_single_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:39 GMT"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button5">
+		<widget class="GtkToolButton" id="button5">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Split view</property>
 		  <property name="label" translatable="yes">Split</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <property name="stock_id">gtk-missing-image</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
 		  <signal name="clicked" handler="on_split_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:45 GMT"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button6">
+		<widget class="GtkToolButton" id="button6">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Full view</property>
 		  <property name="label" translatable="yes">Full</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <property name="stock_id">gtk-missing-image</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
 		  <signal name="clicked" handler="on_full_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:50 GMT"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="GtkVSeparator" id="vseparator3">
+		<widget class="GtkToolItem" id="toolitem3">
 		  <property name="visible">True</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+
+		  <child>
+		    <widget class="GtkVSeparator" id="vseparator3">
+		      <property name="visible">True</property>
+		    </widget>
+		  </child>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">False</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button7">
+		<widget class="GtkToolButton" id="button7">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Collapse the whole tree in the right frame</property>
 		  <property name="label" translatable="yes">Collapse</property>
 		  <property name="use_underline">True</property>
-		  <signal name="pressed" handler="on_collapse_pressed"/>
+		  <property name="stock_id">gtk-remove</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+		  <signal name="clicked" handler="on_collapse_clicked"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button8">
+		<widget class="GtkToolButton" id="button8">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Expand the whole tree in the right frame</property>
 		  <property name="label" translatable="yes">Expand</property>
 		  <property name="use_underline">True</property>
-		  <signal name="pressed" handler="on_expand_pressed"/>
+		  <property name="stock_id">gtk-add</property>
+		  <property name="visible_horizontal">True</property>
+		  <property name="visible_vertical">True</property>
+		  <property name="is_important">False</property>
+		  <signal name="clicked" handler="on_expand_clicked"/>
 		</widget>
+		<packing>
+		  <property name="expand">False</property>
+		  <property name="homogeneous">True</property>
+		</packing>
 	      </child>
 	    </widget>
 	  </child>
@@ -505,6 +608,8 @@
 		      <property name="visible">True</property>
 		      <property name="can_focus">True</property>
 		      <property name="editable">False</property>
+		      <property name="overwrite">False</property>
+		      <property name="accepts_tab">True</property>
 		      <property name="justification">GTK_JUSTIFY_LEFT</property>
 		      <property name="wrap_mode">GTK_WRAP_WORD</property>
 		      <property name="cursor_visible">True</property>
