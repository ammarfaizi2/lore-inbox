Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUH3J2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUH3J2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUH3J2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:28:35 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:59802 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267553AbUH3J2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:28:12 -0400
Message-ID: <9ae345c004083002282ec691a9@mail.gmail.com>
Date: Mon, 30 Aug 2004 12:28:07 +0300
From: Yuval Turgeman <yuvalt@gmail.com>
Reply-To: Yuval Turgeman <yuvalt@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: searching for parameters in 'make menuconfig'
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_207_8550544.1093858087082"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_207_8550544.1093858087082
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I added the ability to search for parameters in make menuconfig (find
a given parameter's location in the tree).
The patch is for the 2.6.8.1 release.
Thanks,

-- 
Yuval Turgeman

------=_Part_207_8550544.1093858087082
Content-Type: text/plain; name="mconf_search.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="mconf_search.diff"

diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c=092004-08-14 13:54:51.000000000 +0300
+++ b/scripts/kconfig/mconf.c=092004-08-30 12:08:23.000000000 +0300
@@ -28,7 +28,7 @@
 =09"<Enter> selects submenus --->.  "
 =09"Highlighted letters are hotkeys.  "
 =09"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
-=09"Press <Esc><Esc> to exit, <?> for Help.  "
+=09"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
 =09"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
 radiolist_instructions[] =3D
 =09"Use the arrow keys to navigate this window or "
@@ -102,6 +102,7 @@
 static void show_helptext(const char *title, const char *text);
 static void show_help(struct menu *menu);
 static void show_readme(void);
+static void search_conf(char *);
=20
 static void cprint_init(void);
 static int cprint1(const char *fmt, ...);
@@ -274,6 +275,84 @@
 =09return WEXITSTATUS(stat);
 }
=20
+static struct menu *do_search(struct menu *menu, struct symbol *sym)
+{
+=09struct menu *child, *ret;
+=09/* Ignore invisible menus ?
+=09if (!menu_is_visible(menu))
+=09=09return NULL;
+=09*/
+
+=09if ( menu->sym ) {
+=09=09if ( menu->sym->name && !strcmp(menu->sym->name, sym->name )) {
+=09=09=09return menu;
+=09=09}
+=09}
+=09for (child =3D menu->list; child; child =3D child->next) {
+=09=09ret =3D do_search(child, sym);
+=09=09if ( ret ) return ret;
+=09}
+=09return NULL;
+}
+
+static void search_conf(char *search_str)
+{
+    struct symbol *sym;
+=09struct menu *menu[32] =3D { 0 };
+=09int i, j, k;
+=09FILE *fp;
+=09bool hit =3D false;
+
+=09fp =3D fopen(".search.tmp", "w");
+=09if ( fp =3D=3D NULL ) {
+=09=09perror("fopen");
+=09=09return;
+=09}
+=09for_all_symbols(i, sym) {
+=09=09if ( sym->name && strstr(sym->name, search_str) ) {
+=09=09=09struct menu *submenu =3D do_search(&rootmenu, sym);
+=09=09=09j =3D 0;
+=09=09=09while ( submenu ) {
+=09=09=09=09menu[j++] =3D submenu;
+=09=09=09=09submenu =3D submenu->parent;
+=09=09=09}
+=09=09=09if ( j > 0 ) {
+=09=09=09=09if ( sym->prop && sym->prop->text ) {
+=09=09=09=09=09fprintf(fp, "%s (%s)\n", sym->prop->text, sym->name);
+=09=09=09=09} else {
+=09=09=09=09=09fprintf(fp, "%s\n", sym->name);
+=09=09=09=09}
+=09=09=09}
+=09=09=09for (k =3D j-2; k > 0; k-- ) {
+=09=09=09=09if ( ! hit ) hit =3D true;
+=09=09=09=09submenu =3D menu[k];
+=09=09=09=09const char *prompt =3D menu_get_prompt(submenu);
+=09=09=09=09if ( submenu->sym ) {
+=09=09=09=09=09fprintf(fp, " -> %s (%s)\n", prompt, submenu->sym->name);
+=09=09=09=09} else {
+=09=09=09=09=09fprintf(fp, " -> %s\n", prompt);
+=09=09=09=09}
+=09=09=09}
+=09=09=09if ( hit )
+=09=09=09=09fprintf(fp, "\n");
+=09=09}
+    }
+=09if ( ! hit ) {
+=09=09fprintf(fp, "No matches found.");
+=09}
+=09fclose(fp);
+    do {
+        cprint_init();
+        cprint("--title");
+        cprint("Search Results");
+        cprint("--textbox");
+        cprint(".search.tmp");
+        cprint("%d", rows);
+        cprint("%d", cols);
+    } while (exec_conf() < 0);
+=09unlink(".search.tmp");
+}
+
 static void build_conf(struct menu *menu)
 {
 =09struct symbol *sym;
@@ -463,6 +542,23 @@
 =09=09=09cprint("    Save Configuration to an Alternate File");
 =09=09}
 =09=09stat =3D exec_conf();
+=09=09if ( stat =3D=3D 26 ) {
+=09=09=09if ( ! strlen(input_buf) ) continue;
+=09=09=09char *search_str =3D (char*)malloc(sizeof(char)*sizeof(input_buf)=
);
+=09=09=09if ( search_str =3D=3D NULL ) {
+=09=09=09=09perror("malloc");
+=09=09=09=09continue;
+=09=09=09}
+=09=09=09/* Capitalizing the string */
+=09=09=09for ( i =3D 0; input_buf[i]; i++ ) {
+=09=09=09=09search_str[i] =3D toupper(input_buf[i]);
+=09=09=09}
+=09=09=09search_str[i] =3D '\0';
+=09=09=09/* Searching and displaying all matches */
+=09=09=09search_conf( search_str );
+=09=09=09free(search_str);
+=09=09=09continue;
+=09=09}
 =09=09if (stat < 0)
 =09=09=09continue;
=20
diff -Nru a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
--- a/scripts/lxdialog/menubox.c=092004-08-14 13:56:22.000000000 +0300
+++ b/scripts/lxdialog/menubox.c=092004-08-30 12:09:02.000000000 +0300
@@ -276,6 +276,16 @@
=20
     while (key !=3D ESC) {
 =09key =3D wgetch(menu);
+=09if ( key =3D=3D '/' ) {
+=09=09int ret =3D dialog_inputbox("Search Configuration Parameter",=20
+=09=09=09=09=09=09=09=09  "Enter Keyword", height, width,=20
+=09=09=09=09=09=09=09=09  (char *) NULL);
+=09=09if ( ret =3D=3D 0 )
+=09=09{
+=09=09=09fprintf(stderr, "%s", dialog_input_result);
+=09=09=09return 26;
+=09=09}
+=09}
=20
 =09if (key < 256 && isalpha(key)) key =3D tolower(key);
=20

------=_Part_207_8550544.1093858087082--
