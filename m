Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266181AbSKFWje>; Wed, 6 Nov 2002 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSKFWje>; Wed, 6 Nov 2002 17:39:34 -0500
Received: from pasky.ji.cz ([62.44.12.54]:1534 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S266181AbSKFWjL>;
	Wed, 6 Nov 2002 17:39:11 -0500
Date: Wed, 6 Nov 2002 23:45:29 +0100
From: Petr Baudis <pasky@ucw.cz>
To: mec@shout.net
Cc: zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [kconfig] Direct use of lxdialog routines by menuconfig
Message-ID: <20021106224529.GF5219@pasky.ji.cz>
Mail-Followup-To: mec@shout.net, zippel@linux-m68k.org,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.46) cleans up interaction between kconfig's mconf
(menuconfig frontend) and lxdialog. Its commandline interface (called
imaginatively lxdialog) no longer exists, instead a .so is packed from the
lxdialog objects and the relevant functions are called directly from mconf.

  In practice, this means that drawing on the screen is done with _MUCH_ less
overhead now (we can still do better, maybe I will make few more patches in
future; the difference won't be very big anymore though, I suppose), the screen
updates are better optimalized as ncurses aren't reset everytime you display
something, that also implies that the ugly screen flickering is done. As a cute
side-effect, the dialogs are now rendered on the top of the menu or help panel.

  Note that this patch depends on my previous patch (subj. "Possibility to
sanely link against off-directory .so"; if you can't see the mail anymore,
fetch it from http://pasky.ji.cz/~pasky/dev/kernel/kbuild_smartso.patch - it's
tiny). This patch also unfortunately conflicts with the singlemenu patch - I'm
probably going to wait for what's going to be included first and then rediff
the later ;-).

  It appears to work fine for me, and the change should cause overall
improvement of the configuration process. Please test, comment, apply ;-).

 scripts/kconfig/Makefile     |    1
 scripts/kconfig/mconf.c      |  379 ++++++++++++++-----------------------------
 scripts/lxdialog/Makefile    |   10 -
 scripts/lxdialog/checklist.c |   34 +--
 scripts/lxdialog/dialog.h    |   28 ++-
 scripts/lxdialog/lxdialog.c  |  226 -------------------------
 scripts/lxdialog/menubox.c   |   59 ++----
 scripts/lxdialog/textbox.c   |    2
 scripts/lxdialog/util.c      |   18 +-
 9 files changed, 213 insertions(+), 544 deletions(-)

  Kind regards,
                                Petr Baudis

diff -ruN linux/scripts/kconfig/Makefile linux+pasky/scripts/kconfig/Makefile
--- linux/scripts/kconfig/Makefile	Wed Nov  6 21:49:55 2002
+++ linux+pasky/scripts/kconfig/Makefile	Wed Nov  6 22:39:21 2002
@@ -14,6 +14,7 @@
 host-progs	:= conf mconf qconf
 conf-objs	:= conf.o  libkconfig.so
 mconf-objs	:= mconf.o libkconfig.so
+mconf-linkobjs	:= ../lxdialog/liblxdialog.so
 
 qconf-objs	:= kconfig_load.o
 qconf-cxxobjs	:= qconf.o
diff -ruN linux/scripts/kconfig/mconf.c linux+pasky/scripts/kconfig/mconf.c
--- linux/scripts/kconfig/mconf.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/kconfig/mconf.c	Wed Nov  6 23:28:09 2002
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
+ *
+ * Directly use liblxdialog library routines.
+ * 2002-11-06 Petr Baudis <pasky@ucw.cz>
  */
 
 #include <sys/ioctl.h>
@@ -14,10 +17,11 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "../lxdialog/dialog.h"
+
 #define LKC_DIRECT_LINK
 #include "lkc.h"
 
-static char menu_backtitle[128];
 static const char menu_instructions[] =
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus --->.  "
@@ -76,14 +80,13 @@
 	"leave this blank.\n"
 ;
 
-static char buf[4096], *bufptr = buf;
-static char input_buf[4096];
-static char *args[1024], **argptr = args;
 static int indent = 0;
 static int rows, cols;
 static struct menu *current_menu;
 static int child_count;
-static int do_resize;
+
+struct dialog_list_item *items[16384]; /* FIXME: This ought to be dynamic. */
+int item_no;
 
 static void conf(struct menu *menu);
 static void conf_choice(struct menu *menu);
@@ -95,11 +98,6 @@
 static void show_help(struct menu *menu);
 static void show_readme(void);
 
-static void cprint_init(void);
-static int cprint1(const char *fmt, ...);
-static void cprint_done(void);
-static int cprint(const char *fmt, ...);
-
 static void init_wsize(void)
 {
 	struct winsize ws;
@@ -122,135 +120,63 @@
 	cols -= 5;
 }
 
-static void cprint_init(void)
+static void cinit(void)
+{
+	item_no = 0;
+}
+
+static void cmake(void)
 {
-	bufptr = buf;
-	argptr = args;
-	memset(args, 0, sizeof(args));
-	indent = 0;
-	child_count = 0;
-	cprint("./scripts/lxdialog/lxdialog");
-	cprint("--backtitle");
-	cprint(menu_backtitle);
+	items[item_no] = malloc(sizeof(struct dialog_list_item));
+	memset(items[item_no], 0, sizeof(struct dialog_list_item));
+	items[item_no]->tag = malloc(32); items[item_no]->tag[0] = 0;
+	items[item_no]->name = malloc(512); items[item_no]->name[0] = 0;
+	items[item_no]->namelen = 0;
+	item_no++;
 }
 
-static int cprint1(const char *fmt, ...)
+static int cprint_name(const char *fmt, ...)
 {
 	va_list ap;
 	int res;
 
-	if (!*argptr)
-		*argptr = bufptr;
+	if (!item_no)
+		cmake();
 	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
+	res = vsnprintf(items[item_no - 1]->name + items[item_no - 1]->namelen,
+			512 - items[item_no - 1]->namelen, fmt, ap);
+	if (res > 0)
+		items[item_no - 1]->namelen += res;
 	va_end(ap);
-	bufptr += res;
 
 	return res;
 }
 
-static void cprint_done(void)
-{
-	*bufptr++ = 0;
-	argptr++;
-}
-
-static int cprint(const char *fmt, ...)
+static int cprint_tag(const char *fmt, ...)
 {
 	va_list ap;
 	int res;
 
-	*argptr++ = bufptr;
+	if (!item_no)
+		cmake();
 	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
+	res = vsnprintf(items[item_no - 1]->tag, 32, fmt, ap);
 	va_end(ap);
-	bufptr += res;
-	*bufptr++ = 0;
 
 	return res;
 }
 
-pid_t pid;
-
-static void winch_handler(int sig)
+static void cdone(void)
 {
-	if (!do_resize) {
-		kill(pid, SIGINT);
-		do_resize = 1;
-	}
-}
+	int i;
 
-static int exec_conf(void)
-{
-	int pipefd[2], stat, size;
-	struct sigaction sa;
-	sigset_t sset, osset;
-
-	sigemptyset(&sset);
-	sigaddset(&sset, SIGINT);
-	sigprocmask(SIG_BLOCK, &sset, &osset);
-
-	signal(SIGINT, SIG_DFL);
-
-	sa.sa_handler = winch_handler;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGWINCH, &sa, NULL);
-
-	*argptr++ = NULL;
-
-	pipe(pipefd);
-	pid = fork();
-	if (pid == 0) {
-		sigprocmask(SIG_SETMASK, &osset, NULL);
-		dup2(pipefd[1], 2);
-		close(pipefd[0]);
-		close(pipefd[1]);
-		execv(args[0], args);
-		_exit(EXIT_FAILURE);
+	for (i = 0; i < item_no; i++) {
+		free(items[i]->tag);
+		free(items[i]->name);
+		free(items[i]);
 	}
 
-	close(pipefd[1]);
-	bufptr = input_buf;
-	while (1) {
-		size = input_buf + sizeof(input_buf) - bufptr;
-		size = read(pipefd[0], bufptr, size);
-		if (size <= 0) {
-			if (size < 0) {
-				if (errno == EINTR || errno == EAGAIN)
-					continue;
-				perror("read");
-			}
-			break;
-		}
-		bufptr += size;
-	}
-	*bufptr++ = 0;
-	close(pipefd[0]);
-	waitpid(pid, &stat, 0);
-
-	if (do_resize) {
-		init_wsize();
-		do_resize = 0;
-		sigprocmask(SIG_SETMASK, &osset, NULL);
-		return -1;
-	}
-	if (WIFSIGNALED(stat)) {
-		printf("\finterrupted(%d)\n", WTERMSIG(stat));
-		exit(1);
-	}
-#if 0
-	printf("\fexit state: %d\nexit data: '%s'\n", WEXITSTATUS(stat), input_buf);
-	sleep(1);
-#endif
-	sigpending(&sset);
-	if (sigismember(&sset, SIGINT)) {
-		printf("\finterrupted\n");
-		exit(1);
-	}
-	sigprocmask(SIG_SETMASK, &osset, NULL);
-
-	return WEXITSTATUS(stat);
+	item_no = 0;
 }
 
 static void build_conf(struct menu *menu)
@@ -273,17 +199,18 @@
 			switch (prop->type) {
 			case P_MENU:
 				child_count++;
-				cprint("m%p", menu);
+				cmake();
+				cprint_tag("m%p", menu);
 				if (menu->parent != &rootmenu)
-					cprint1("   %*c", indent + 1, ' ');
-				cprint1("%s  --->", prompt);
-				cprint_done();
+					cprint_name("   %*c", indent + 1, ' ');
+				cprint_name("%s  --->", prompt);
 				return;
 			default:
 				if (prompt) {
 					child_count++;
-					cprint(":%p", menu);
-					cprint("---%*c%s", indent + 1, ' ', prompt);
+					cmake();
+					cprint_tag(":%p", menu);
+					cprint_name("---%*c%s", indent + 1, ' ', prompt);
 				}
 			}
 		} else
@@ -291,6 +218,7 @@
 		goto conf_childs;
 	}
 
+	cmake();
 	type = sym_get_type(sym);
 	if (sym_is_choice(sym)) {
 		struct symbol *def_sym = sym_get_choice_value(sym);
@@ -304,10 +232,10 @@
 
 		val = sym_get_tristate_value(sym);
 		if (sym_is_changable(sym)) {
-			cprint("t%p", menu);
+			cprint_tag("t%p", menu);
 			switch (type) {
 			case S_BOOLEAN:
-				cprint1("[%c]", val == no ? ' ' : '*');
+				cprint_name("[%c]", val == no ? ' ' : '*');
 				break;
 			case S_TRISTATE:
 				switch (val) {
@@ -315,66 +243,61 @@
 				case mod: ch = 'M'; break;
 				default:  ch = ' '; break;
 				}
-				cprint1("<%c>", ch);
+				cprint_name("<%c>", ch);
 				break;
 			}
 		} else {
-			cprint("%c%p", def_menu ? 't' : ':', menu);
-			cprint1("   ");
+			cprint_tag("%c%p", def_menu ? 't' : ':', menu);
+			cprint_name("   ");
 		}
 
-		cprint1("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+		cprint_name("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 		if (val == yes) {
 			if (def_menu) {
-				cprint1(" (%s)", menu_get_prompt(def_menu));
-				cprint1("  --->");
-				cprint_done();
+				cprint_name(" (%s)", menu_get_prompt(def_menu));
+				cprint_name("  --->");
 				if (def_menu->list) {
 					indent += 2;
 					build_conf(def_menu);
 					indent -= 2;
 				}
-			} else
-				cprint_done();
+			}
 			return;
 		}
-		cprint_done();
 	} else {
 		child_count++;
 		val = sym_get_tristate_value(sym);
 		if (sym_is_choice_value(sym) && val == yes) {
-			cprint(":%p", menu);
-			cprint1("   ");
+			cprint_tag(":%p", menu);
+			cprint_name("   ");
 		} else {
 			switch (type) {
 			case S_BOOLEAN:
-				cprint("t%p", menu);
-				cprint1("[%c]", val == no ? ' ' : '*');
+				cprint_tag("t%p", menu);
+				cprint_name("[%c]", val == no ? ' ' : '*');
 				break;
 			case S_TRISTATE:
-				cprint("t%p", menu);
+				cprint_tag("t%p", menu);
 				switch (val) {
 				case yes: ch = '*'; break;
 				case mod: ch = 'M'; break;
 				default:  ch = ' '; break;
 				}
-				cprint1("<%c>", ch);
+				cprint_name("<%c>", ch);
 				break;
 			default:
-				cprint("s%p", menu);
-				tmp = cprint1("(%s)", sym_get_string_value(sym));
+				cprint_tag("s%p", menu);
+				tmp = cprint_name("(%s)", sym_get_string_value(sym));
 				tmp = indent - tmp + 4;
 				if (tmp < 0)
 					tmp = 0;
-				cprint1("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
+				cprint_name("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
 					sym_has_value(sym) ? "" : " (NEW)");
-				cprint_done();
 				goto conf_childs;
 			}
 		}
-		cprint1("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
+		cprint_name("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
 			sym_has_value(sym) ? "" : " (NEW)");
-		cprint_done();
 	}
 
 conf_childs:
@@ -386,56 +309,51 @@
 
 static void conf(struct menu *menu)
 {
+	struct dialog_list_item *active_item = NULL;
 	struct menu *submenu;
 	const char *prompt = menu_get_prompt(menu);
 	struct symbol *sym;
 	char active_entry[40];
-	int stat, type, i;
+	int stat, type;
 
 	active_entry[0] = 0;
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : "Main Menu");
-		cprint("--menu");
-		cprint(menu_instructions);
-		cprint("%d", rows);
-		cprint("%d", cols);
-		cprint("%d", rows - 10);
-		cprint("%s", active_entry);
+		indent = 0;
+		child_count = 0;
 		current_menu = menu;
+		cdone(); cinit();
 		build_conf(menu);
 		if (!child_count)
 			break;
+
 		if (menu == &rootmenu) {
-			cprint(":");
-			cprint("--- ");
-			cprint("L");
-			cprint("Load an Alternate Configuration File");
-			cprint("S");
-			cprint("Save Configuration to an Alternate File");
-		}
-		stat = exec_conf();
+			cmake(); cprint_tag(":"); cprint_name("--- ");
+			cmake(); cprint_tag("L"); cprint_name("Load an Alternate Configuration File");
+			cmake(); cprint_tag("S"); cprint_name("Save Configuration to an Alternate File");
+		}
+		dialog_clear();
+		stat = dialog_menu(prompt ? prompt : "Main Menu",
+				menu_instructions, rows, cols, rows - 10,
+				active_entry, item_no, items);
 		if (stat < 0)
 			continue;
 
 		if (stat == 1 || stat == 255)
 			break;
 
-		type = input_buf[0];
+		active_item = first_sel_item(item_no, items);
+		if (!active_item)
+			continue;
+		active_item->selected = 0;
+		strncpy(active_entry, active_item->tag, sizeof(active_entry));
+		active_entry[sizeof(active_entry)-1] = 0;
+		type = active_entry[0];
 		if (!type)
 			continue;
 
-		for (i = 0; input_buf[i] && !isspace(input_buf[i]); i++)
-			;
-		if (i >= sizeof(active_entry))
-			i = sizeof(active_entry) - 1;
-		input_buf[i] = 0;
-		strcpy(active_entry, input_buf);
-
 		sym = NULL;
 		submenu = NULL;
-		if (sscanf(input_buf + 1, "%p", &submenu) == 1)
+		if (sscanf(active_entry + 1, "%p", &submenu) == 1)
 			sym = submenu->sym;
 
 		switch (stat) {
@@ -496,17 +414,8 @@
 	fd = creat(".help.tmp", 0777);
 	write(fd, text, strlen(text));
 	close(fd);
-	do {
-		cprint_init();
-		if (title) {
-			cprint("--title");
-			cprint("%s", title);
-		}
-		cprint("--textbox");
-		cprint(".help.tmp");
-		cprint("%d", r);
-		cprint("%d", c);
-	} while (exec_conf() < 0);
+	while (dialog_textbox(title, ".help.tmp", r, c) < 0)
+		;
 	unlink(".help.tmp");
 }
 
@@ -527,13 +436,8 @@
 
 static void show_readme(void)
 {
-	do {
-		cprint_init();
-		cprint("--textbox");
-		cprint("scripts/README.Menuconfig");
-		cprint("%d", rows);
-		cprint("%d", cols);
-	} while (exec_conf() == -1);
+	while (dialog_textbox(NULL, "scripts/README.Menuconfig", rows, cols) < 0)
+		;
 }
 
 static void conf_choice(struct menu *menu)
@@ -541,32 +445,25 @@
 	const char *prompt = menu_get_prompt(menu);
 	struct menu *child;
 	struct symbol *active;
-	int stat;
 
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : "Main Menu");
-		cprint("--radiolist");
-		cprint(radiolist_instructions);
-		cprint("15");
-		cprint("70");
-		cprint("6");
-
 		current_menu = menu;
 		active = sym_get_choice_value(menu->sym);
+		cdone(); cinit();
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
-			cprint("%p", child);
-			cprint("%s", menu_get_prompt(child));
-			cprint(child->sym == active ? "ON" : "OFF");
+			cmake();
+			cprint_tag("%p", child);
+			cprint_name("%s", menu_get_prompt(child));
+			items[item_no - 1]->selected = (child->sym == active);
 		}
 
-		stat = exec_conf();
-		switch (stat) {
+		switch (dialog_checklist(prompt ? prompt : "Main Menu",
+					radiolist_instructions, 15, 70, 6,
+					item_no, items, FLAG_RADIO)) {
 		case 0:
-			if (sscanf(input_buf, "%p", &menu) != 1)
+			if (sscanf(first_sel_item(item_no, items)->tag, "%p", &menu) != 1)
 				break;
 			sym_set_tristate_value(menu->sym, yes);
 			return;
@@ -582,33 +479,30 @@
 static void conf_string(struct menu *menu)
 {
 	const char *prompt = menu_get_prompt(menu);
-	int stat;
 
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : "Main Menu");
-		cprint("--inputbox");
+		char *heading;
+
 		switch (sym_get_type(menu->sym)) {
 		case S_INT:
-			cprint(inputbox_instructions_int);
+			heading = (char *) inputbox_instructions_int;
 			break;
 		case S_HEX:
-			cprint(inputbox_instructions_hex);
+			heading = (char *) inputbox_instructions_hex;
 			break;
 		case S_STRING:
-			cprint(inputbox_instructions_string);
+			heading = (char *) inputbox_instructions_string;
 			break;
 		default:
+			heading = "Internal mconf error!";
 			/* panic? */;
 		}
-		cprint("10");
-		cprint("75");
-		cprint("%s", sym_get_string_value(menu->sym));
-		stat = exec_conf();
-		switch (stat) {
+
+		switch (dialog_inputbox(prompt ? prompt : "Main Menu",
+					heading, 10, 75,
+					sym_get_string_value(menu->sym))) {
 		case 0:
-			if (sym_set_string_value(menu->sym, input_buf))
+			if (sym_set_string_value(menu->sym, dialog_input_result))
 				return;
 			show_textbox(NULL, "You have made an invalid entry.", 5, 43);
 			break;
@@ -623,21 +517,13 @@
 
 static void conf_load(void)
 {
-	int stat;
-
 	while (1) {
-		cprint_init();
-		cprint("--inputbox");
-		cprint(load_config_text);
-		cprint("11");
-		cprint("55");
-		cprint("%s", conf_filename);
-		stat = exec_conf();
-		switch(stat) {
+		switch (dialog_inputbox(NULL, load_config_text, 11, 55,
+					conf_filename)) {
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_read(input_buf))
+			if (!conf_read(dialog_input_result))
 				return;
 			show_textbox(NULL, "File does not exist!", 5, 38);
 			break;
@@ -652,21 +538,13 @@
 
 static void conf_save(void)
 {
-	int stat;
-
 	while (1) {
-		cprint_init();
-		cprint("--inputbox");
-		cprint(save_config_text);
-		cprint("11");
-		cprint("55");
-		cprint("%s", conf_filename);
-		stat = exec_conf();
-		switch(stat) {
+		switch (dialog_inputbox(NULL, save_config_text, 11, 55,
+					conf_filename)) {
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_write(input_buf))
+			if (!conf_write(dialog_input_result))
 				return;
 			show_textbox(NULL, "Can't create file!  Probably a nonexistent directory.", 5, 60);
 			break;
@@ -685,21 +563,20 @@
 	conf_parse(av[1]);
 	conf_read(NULL);
 
-	sprintf(menu_backtitle, "Linux Kernel v%s.%s.%s%s Configuration",
-		getenv("VERSION"), getenv("PATCHLEVEL"),
-		getenv("SUBLEVEL"), getenv("EXTRAVERSION"));
+	backtitle = malloc(128);
+	snprintf(backtitle, 128, "Linux Kernel v%s.%s.%s%s Configuration",
+		 getenv("VERSION"), getenv("PATCHLEVEL"),
+		 getenv("SUBLEVEL"), getenv("EXTRAVERSION"));
 
 	init_wsize();
+	init_dialog();
 	conf(&rootmenu);
-
 	do {
-		cprint_init();
-		cprint("--yesno");
-		cprint("Do you wish to save your new kernel configuration?");
-		cprint("5");
-		cprint("60");
-		stat = exec_conf();
+		stat = dialog_yesno(NULL,
+				"Do you wish to save your new kernel configuration?",
+				5, 60);
 	} while (stat < 0);
+	end_dialog();
 
 	if (stat == 0) {
 		conf_write(NULL);
diff -ruN linux/scripts/lxdialog/Makefile linux+pasky/scripts/lxdialog/Makefile
--- linux/scripts/lxdialog/Makefile	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/Makefile	Wed Nov  6 22:39:28 2002
@@ -15,12 +15,14 @@
 endif
 endif
 
-host-progs := lxdialog
+liblxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
+		    util.o msgbox.o
 
-lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
-		 util.o lxdialog.o msgbox.o
+clean-files := liblxdialog.so
 
-EXTRA_TARGETS := lxdialog
+host-cshlib-extra := liblxdialog.so
+
+EXTRA_TARGETS := liblxdialog.so
 
 first_rule: ncurses
 
diff -ruN linux/scripts/lxdialog/checklist.c linux+pasky/scripts/lxdialog/checklist.c
--- linux/scripts/lxdialog/checklist.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/checklist.c	Wed Nov  6 21:56:54 2002
@@ -118,7 +118,8 @@
  */
 int
 dialog_checklist (const char *title, const char *prompt, int height, int width,
-	int list_height, int item_no, const char * const * items, int flag)
+	int list_height, int item_no, struct dialog_list_item ** items,
+	int flag)
 	
 {
     int i, x, y, box_x, box_y;
@@ -137,7 +138,7 @@
 
     /* Initializes status */
     for (i = 0; i < item_no; i++) {
-	status[i] = !strcasecmp (items[i * 3 + 2], "on");
+	status[i] = items[i]->selected;
 	if (!choice && status[i])
             choice = i;
     }
@@ -195,7 +196,7 @@
     /* Find length of longest item in order to center checklist */
     check_x = 0;
     for (i = 0; i < item_no; i++) 
-	check_x = MAX (check_x, + strlen (items[i * 3 + 1]) + 4);
+	check_x = MAX (check_x, + strlen (items[i]->name) + 4);
 
     check_x = (list_width - check_x) / 2;
     item_x = check_x + 4;
@@ -207,7 +208,7 @@
 
     /* Print the list */
     for (i = 0; i < max_choice; i++) {
-	print_item (list, items[(scroll+i) * 3 + 1],
+	print_item (list, items[scroll + i]->name,
 		    status[i+scroll], i, i == choice);
     }
 
@@ -224,7 +225,7 @@
 	key = wgetch (dialog);
 
     	for (i = 0; i < max_choice; i++)
-            if (toupper(key) == toupper(items[(scroll+i)*3+1][0]))
+            if (toupper(key) == toupper(items[scroll + i]->name[0]))
                 break;
 
 
@@ -237,14 +238,14 @@
 		    /* Scroll list down */
 		    if (list_height > 1) {
 			/* De-highlight current first item */
-			print_item (list, items[scroll * 3 + 1],
+			print_item (list, items[scroll]->name,
 					status[scroll], 0, FALSE);
 			scrollok (list, TRUE);
 			wscrl (list, -1);
 			scrollok (list, FALSE);
 		    }
 		    scroll--;
-		    print_item (list, items[scroll * 3 + 1],
+		    print_item (list, items[scroll]->name,
 				status[scroll], 0, TRUE);
 		    wnoutrefresh (list);
 
@@ -263,7 +264,7 @@
 		    /* Scroll list up */
 		    if (list_height > 1) {
 			/* De-highlight current last item before scrolling up */
-			print_item (list, items[(scroll + max_choice - 1) * 3 + 1],
+			print_item (list, items[scroll + max_choice - 1]->name,
 				    status[scroll + max_choice - 1],
 				    max_choice - 1, FALSE);
 			scrollok (list, TRUE);
@@ -271,7 +272,7 @@
 			scrollok (list, FALSE);
 		    }
 		    scroll++;
-		    print_item (list, items[(scroll + max_choice - 1) * 3 + 1],
+		    print_item (list, items[scroll + max_choice - 1]->name,
 				status[scroll + max_choice - 1],
 				max_choice - 1, TRUE);
 		    wnoutrefresh (list);
@@ -287,11 +288,11 @@
 	    }
 	    if (i != choice) {
 		/* De-highlight current item */
-		print_item (list, items[(scroll + choice) * 3 + 1],
+		print_item (list, items[scroll + choice]->name,
 			    status[scroll + choice], choice, FALSE);
 		/* Highlight new item */
 		choice = i;
-		print_item (list, items[(scroll + choice) * 3 + 1],
+		print_item (list, items[scroll + choice]->name,
 			    status[scroll + choice], choice, TRUE);
 		wnoutrefresh (list);
 		wrefresh (dialog);
@@ -330,7 +331,7 @@
 			    status[i] = 0;
 			status[scroll + choice] = 1;
 			for (i = 0; i < max_choice; i++)
-			    print_item (list, items[(scroll + i) * 3 + 1],
+			    print_item (list, items[scroll + i]->name,
 					status[scroll + i], i, i == choice);
 		    }
 		}
@@ -338,14 +339,7 @@
 		wrefresh (dialog);
             
 		for (i = 0; i < item_no; i++) {
-		    if (status[i]) {
-			if (flag == FLAG_CHECK) {
-			    fprintf (stderr, "\"%s\" ", items[i * 3]);
-			} else {
-			    fprintf (stderr, "%s", items[i * 3]);
-			}
-
-		    }
+			items[i]->selected = status[i];
 		}
             }
 	    delwin (dialog);
diff -ruN linux/scripts/lxdialog/dialog.h linux+pasky/scripts/lxdialog/dialog.h
--- linux/scripts/lxdialog/dialog.h	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/dialog.h	Wed Nov  6 23:09:17 2002
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#ifdef CURSES_LOC
 #include CURSES_LOC
 
 /*
@@ -125,29 +126,35 @@
  * Global variables
  */
 extern bool use_colors;
-extern bool use_shadow;
 
 extern chtype attributes[];
+#endif
+
+extern char *backtitle;
 
-extern const char *backtitle;
+struct dialog_list_item {
+	char *name;
+	int namelen;
+	char *tag;
+	int selected; /* Set to 1 by dialog_*() function. */
+};
 
 /*
  * Function prototypes
  */
-extern void create_rc (const char *filename);
-extern int parse_rc (void);
-
 
 void init_dialog (void);
 void end_dialog (void);
-void attr_clear (WINDOW * win, int height, int width, chtype attr);
 void dialog_clear (void);
+#ifdef CURSES_LOC
+void attr_clear (WINDOW * win, int height, int width, chtype attr);
 void color_setup (void);
 void print_autowrap (WINDOW * win, const char *prompt, int width, int y, int x);
 void print_button (WINDOW * win, const char *label, int y, int x, int selected);
 void draw_box (WINDOW * win, int y, int x, int height, int width, chtype box,
 		chtype border);
 void draw_shadow (WINDOW * win, int y, int x, int height, int width);
+#endif
 
 int first_alpha (const char *string, const char *exempt);
 int dialog_yesno (const char *title, const char *prompt, int height, int width);
@@ -156,14 +163,17 @@
 int dialog_textbox (const char *title, const char *file, int height, int width);
 int dialog_menu (const char *title, const char *prompt, int height, int width,
 		int menu_height, const char *choice, int item_no, 
-		const char * const * items);
+		struct dialog_list_item ** items);
 int dialog_checklist (const char *title, const char *prompt, int height,
 		int width, int list_height, int item_no,
-		const char * const * items, int flag);
+		struct dialog_list_item ** items, int flag);
 extern unsigned char dialog_input_result[];
 int dialog_inputbox (const char *title, const char *prompt, int height,
 		int width, const char *init);
 
+struct dialog_list_item *first_sel_item(int item_no,
+		struct dialog_list_item ** items);
+
 /*
  * This is the base for fictitious keys, which activate
  * the buttons.
@@ -173,7 +183,9 @@
  *   -- the lowercase are used to signal mouse-enter events (M_EVENT + 'o')
  *   -- uppercase chars are used to invoke the button (M_EVENT + 'O')
  */
+#ifdef CURSES_LOC
 #define M_EVENT (KEY_MAX+1)
+#endif
 
 
 /*
diff -ruN linux/scripts/lxdialog/lxdialog.c linux+pasky/scripts/lxdialog/lxdialog.c
--- linux/scripts/lxdialog/lxdialog.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/lxdialog.c	Thu Jan  1 01:00:00 1970
@@ -1,226 +0,0 @@
-/*
- *  dialog - Display simple dialog boxes from shell scripts
- *
- *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
- *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include "dialog.h"
-
-static void Usage (const char *name);
-
-typedef int (jumperFn) (const char *title, int argc, const char * const * argv);
-
-struct Mode {
-    char *name;
-    int argmin, argmax, argmod;
-    jumperFn *jumper;
-};
-
-jumperFn j_menu, j_checklist, j_radiolist, j_yesno, j_textbox, j_inputbox;
-jumperFn j_msgbox, j_infobox;
-
-static struct Mode modes[] =
-{
-    {"--menu", 9, 0, 3, j_menu},
-    {"--checklist", 9, 0, 3, j_checklist},
-    {"--radiolist", 9, 0, 3, j_radiolist},
-    {"--yesno",    5,5,1, j_yesno},
-    {"--textbox",  5,5,1, j_textbox},
-    {"--inputbox", 5, 6, 1, j_inputbox},
-    {"--msgbox", 5, 5, 1, j_msgbox},
-    {"--infobox", 5, 5, 1, j_infobox},
-    {NULL, 0, 0, 0, NULL}
-};
-
-static struct Mode *modePtr;
-
-#ifdef LOCALE
-#include <locale.h>
-#endif
-
-int
-main (int argc, const char * const * argv)
-{
-    int offset = 0, clear_screen = 0, end_common_opts = 0, retval;
-    const char *title = NULL;
-
-#ifdef LOCALE
-    (void) setlocale (LC_ALL, "");
-#endif
-
-#ifdef TRACE
-    trace(TRACE_CALLS|TRACE_UPDATE);
-#endif
-    if (argc < 2) {
-	Usage (argv[0]);
-	exit (-1);
-    }
-
-    while (offset < argc - 1 && !end_common_opts) {	/* Common options */
-	if (!strcmp (argv[offset + 1], "--title")) {
-	    if (argc - offset < 3 || title != NULL) {
-		Usage (argv[0]);
-		exit (-1);
-	    } else {
-		title = argv[offset + 2];
-		offset += 2;
-	    }
-        } else if (!strcmp (argv[offset + 1], "--backtitle")) {
-            if (backtitle != NULL) {
-                Usage (argv[0]);
-                exit (-1);
-            } else {
-                backtitle = argv[offset + 2];
-                offset += 2;
-            }
-	} else if (!strcmp (argv[offset + 1], "--clear")) {
-	    if (clear_screen) {	/* Hey, "--clear" can't appear twice! */
-		Usage (argv[0]);
-		exit (-1);
-	    } else if (argc == 2) {	/* we only want to clear the screen */
-		init_dialog ();
-		refresh ();	/* init_dialog() will clear the screen for us */
-		end_dialog ();
-		return 0;
-	    } else {
-		clear_screen = 1;
-		offset++;
-	    }
-	} else			/* no more common options */
-	    end_common_opts = 1;
-    }
-
-    if (argc - 1 == offset) {	/* no more options */
-	Usage (argv[0]);
-	exit (-1);
-    }
-    /* use a table to look for the requested mode, to avoid code duplication */
-
-    for (modePtr = modes; modePtr->name; modePtr++)	/* look for the mode */
-	if (!strcmp (argv[offset + 1], modePtr->name))
-	    break;
-
-    if (!modePtr->name)
-	Usage (argv[0]);
-    if (argc - offset < modePtr->argmin)
-	Usage (argv[0]);
-    if (modePtr->argmax && argc - offset > modePtr->argmax)
-	Usage (argv[0]);
-
-
-
-    init_dialog ();
-    retval = (*(modePtr->jumper)) (title, argc - offset, argv + offset);
-
-    if (clear_screen) {		/* clear screen before exit */
-	attr_clear (stdscr, LINES, COLS, screen_attr);
-	refresh ();
-    }
-    end_dialog();
-
-    exit (retval);
-}
-
-/*
- * Print program usage
- */
-static void
-Usage (const char *name)
-{
-    fprintf (stderr, "\
-\ndialog, by Savio Lam (lam836@cs.cuhk.hk).\
-\n  patched by Stuart Herbert (S.Herbert@shef.ac.uk)\
-\n  modified/gutted for use as a Linux kernel config tool by \
-\n  William Roadcap (roadcapw@cfw.com)\
-\n\
-\n* Display dialog boxes from shell scripts *\
-\n\
-\nUsage: %s --clear\
-\n       %s [--title <title>] [--backtitle <backtitle>] --clear <Box options>\
-\n\
-\nBox options:\
-\n\
-\n  --menu      <text> <height> <width> <menu height> <tag1> <item1>...\
-\n  --checklist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
-\n  --radiolist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
-\n  --textbox   <file> <height> <width>\
-\n  --inputbox  <text> <height> <width> [<init>]\
-\n  --yesno     <text> <height> <width>\
-\n", name, name);
-    exit (-1);
-}
-
-/*
- * These are the program jumpers
- */
-
-int
-j_menu (const char *t, int ac, const char * const * av)
-{
-    return dialog_menu (t, av[2], atoi (av[3]), atoi (av[4]),
-			atoi (av[5]), av[6], (ac - 6) / 2, av + 7);
-}
-
-int
-j_checklist (const char *t, int ac, const char * const * av)
-{
-    return dialog_checklist (t, av[2], atoi (av[3]), atoi (av[4]),
-	atoi (av[5]), (ac - 6) / 3, av + 6, FLAG_CHECK);
-}
-
-int
-j_radiolist (const char *t, int ac, const char * const * av)
-{
-    return dialog_checklist (t, av[2], atoi (av[3]), atoi (av[4]),
-	atoi (av[5]), (ac - 6) / 3, av + 6, FLAG_RADIO);
-}
-
-int
-j_textbox (const char *t, int ac, const char * const * av)
-{
-    return dialog_textbox (t, av[2], atoi (av[3]), atoi (av[4]));
-}
-
-int
-j_yesno (const char *t, int ac, const char * const * av)
-{
-    return dialog_yesno (t, av[2], atoi (av[3]), atoi (av[4]));
-}
-
-int
-j_inputbox (const char *t, int ac, const char * const * av)
-{
-    int ret = dialog_inputbox (t, av[2], atoi (av[3]), atoi (av[4]),
-                            ac == 6 ? av[5] : (char *) NULL);
-    if (ret == 0)
-        fprintf(stderr, dialog_input_result);
-    return ret;
-}
-
-int
-j_msgbox (const char *t, int ac, const char * const * av)
-{
-    return dialog_msgbox (t, av[2], atoi (av[3]), atoi (av[4]), 1);
-}
-
-int
-j_infobox (const char *t, int ac, const char * const * av)
-{
-    return dialog_msgbox (t, av[2], atoi (av[3]), atoi (av[4]), 0);
-}
-
diff -ruN linux/scripts/lxdialog/menubox.c linux+pasky/scripts/lxdialog/menubox.c
--- linux/scripts/lxdialog/menubox.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/menubox.c	Wed Nov  6 21:56:54 2002
@@ -93,7 +93,7 @@
     }
     if (selected) {
 	wmove (win, choice, item_x+1);
-	wrefresh (win);
+	wnoutrefresh (win);
     }
 }
 
@@ -165,8 +165,7 @@
 int
 dialog_menu (const char *title, const char *prompt, int height, int width,
 		int menu_height, const char *current, int item_no,
-		const char * const * items)
-
+		struct dialog_list_item ** items)
 {
     int i, j, x, y, box_x, box_y;
     int key = 0, button = 0, scroll = 0, choice = 0, first_item = 0, max_choice;
@@ -230,8 +229,8 @@
      */
     item_x = 0;
     for (i = 0; i < item_no; i++) {
-	item_x = MAX (item_x, MIN(menu_width, strlen (items[i * 2 + 1]) + 2));
-	if (strcmp(current, items[i*2]) == 0) choice = i;
+	item_x = MAX (item_x, MIN(menu_width, strlen (items[i]->name) + 2));
+	if (strcmp(current, items[i]->tag) == 0) choice = i;
     }
 
     item_x = (menu_width - item_x) / 2;
@@ -261,8 +260,8 @@
 
     /* Print the menu */
     for (i=0; i < max_choice; i++) {
-	print_item (menu, items[(first_item + i) * 2 + 1], i, i == choice,
-                    (items[(first_item + i)*2][0] != ':'));
+	print_item (menu, items[first_item + i]->name, i, i == choice,
+                    (items[first_item + i]->tag[0] != ':'));
     }
 
     wnoutrefresh (menu);
@@ -283,14 +282,14 @@
 		i = max_choice;
 	else {
         for (i = choice+1; i < max_choice; i++) {
-		j = first_alpha(items[(scroll+i)*2+1], "YyNnMm>");
-		if (key == tolower(items[(scroll+i)*2+1][j]))
+		j = first_alpha(items[scroll + i]->name, "YyNnMm>");
+		if (key == tolower(items[scroll + i]->name[j]))
                 	break;
 	}
 	if (i == max_choice)
        		for (i = 0; i < max_choice; i++) {
-			j = first_alpha(items[(scroll+i)*2+1], "YyNnMm>");
-			if (key == tolower(items[(scroll+i)*2+1][j]))
+			j = first_alpha(items[scroll + i]->name, "YyNnMm>");
+			if (key == tolower(items[scroll + i]->name[j]))
                 		break;
 		}
 	}
@@ -300,8 +299,8 @@
             key == '-' || key == '+' ||
             key == KEY_PPAGE || key == KEY_NPAGE) {
 
-            print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
-                       (items[(scroll+choice)*2][0] != ':'));
+            print_item (menu, items[scroll + choice]->name, choice, FALSE,
+                       (items[scroll + choice]->tag[0] != ':'));
 
 	    if (key == KEY_UP || key == '-') {
                 if (choice < 2 && scroll) {
@@ -312,15 +311,15 @@
 
                     scroll--;
 
-                    print_item (menu, items[scroll * 2 + 1], 0, FALSE,
-                               (items[scroll*2][0] != ':'));
+                    print_item (menu, items[scroll * 2]->name, 0, FALSE,
+                               (items[scroll * 2]->tag[0] != ':'));
 		} else
 		    choice = MAX(choice - 1, 0);
 
 	    } else if (key == KEY_DOWN || key == '+')  {
 
-		print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
-                                (items[(scroll+choice)*2][0] != ':'));
+		print_item (menu, items[scroll + choice]->name, choice, FALSE,
+                                (items[scroll + choice]->tag[0] != ':'));
 
                 if ((choice > max_choice-3) &&
                     (scroll + max_choice < item_no)
@@ -332,9 +331,9 @@
 
                     scroll++;
 
-                    print_item (menu, items[(scroll+max_choice-1)*2+1],
+                    print_item (menu, items[scroll + max_choice - 1]->name,
                                max_choice-1, FALSE,
-                               (items[(scroll+max_choice-1)*2][0] != ':'));
+                               (items[scroll + max_choice - 1]->tag[0] != ':'));
                 } else
                     choice = MIN(choice+1, max_choice-1);
 
@@ -344,8 +343,8 @@
                     if (scroll > 0) {
                 	wscrl (menu, -1);
                 	scroll--;
-                	print_item (menu, items[scroll * 2 + 1], 0, FALSE,
-                	(items[scroll*2][0] != ':'));
+                	print_item (menu, items[scroll * 2]->name, 0, FALSE,
+                	(items[scroll * 2]->tag[0] != ':'));
                     } else {
                         if (choice > 0)
                             choice--;
@@ -360,9 +359,9 @@
 			scroll(menu);
 			scrollok (menu, FALSE);
                 	scroll++;
-                	print_item (menu, items[(scroll+max_choice-1)*2+1],
+                	print_item (menu, items[scroll + max_choice - 1]->name,
 			            max_choice-1, FALSE,
-			            (items[(scroll+max_choice-1)*2][0] != ':'));
+			            (items[scroll + max_choice - 1]->tag[0] != ':'));
 		    } else {
 			if (choice+1 < max_choice)
 			    choice++;
@@ -372,8 +371,8 @@
             } else
                 choice = i;
 
-            print_item (menu, items[(scroll+choice)*2+1], choice, TRUE,
-                       (items[(scroll+choice)*2][0] != ':'));
+            print_item (menu, items[scroll + choice]->name, choice, TRUE,
+                       (items[scroll + choice]->tag[0] != ':'));
 
             print_arrows(dialog, item_no, scroll,
                          box_y, box_x+item_x+1, menu_height);
@@ -405,7 +404,7 @@
 		fclose(f);
 	    }
 	    delwin (dialog);
-            fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
+            items[scroll + choice]->selected = 1;
             switch (key) {
             case 's': return 3;
             case 'y': return 3;
@@ -419,13 +418,7 @@
 	    button = 2;
 	case '\n':
 	    delwin (dialog);
-	    if (button == 2) 
-            	fprintf(stderr, "%s \"%s\"\n", 
-			items[(scroll + choice) * 2],
-			items[(scroll + choice) * 2 + 1] +
-			first_alpha(items[(scroll + choice) * 2 + 1],""));
-	    else
-            	fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
+	    items[scroll + choice]->selected = 1;
 
 	    remove("lxdialog.scrltmp");
 	    return button;
diff -ruN linux/scripts/lxdialog/textbox.c linux+pasky/scripts/lxdialog/textbox.c
--- linux/scripts/lxdialog/textbox.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/textbox.c	Wed Nov  6 22:08:18 2002
@@ -317,7 +317,7 @@
     delwin (dialog);
     free (buf);
     close (fd);
-    return -1;			/* ESC pressed */
+    return 1;			/* ESC pressed */
 }
 
 /*
diff -ruN linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
--- linux/scripts/lxdialog/util.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/util.c	Wed Nov  6 21:56:54 2002
@@ -25,7 +25,7 @@
 /* use colors by default? */
 bool use_colors = 1;
 
-const char *backtitle = NULL;
+char *backtitle = NULL;
 
 const char *dialog_result;
 
@@ -356,4 +356,20 @@
 	}
 
 	return 0;
+}
+
+/*
+ * Get the first selected item in the dialog_list_item list.
+ */
+struct dialog_list_item *
+first_sel_item(int item_no, struct dialog_list_item ** items)
+{
+	int i;
+
+	for (i = 0; i < item_no; i++) {
+		if (items[i]->selected)
+			return items[i];
+	}
+
+	return NULL;
 }
