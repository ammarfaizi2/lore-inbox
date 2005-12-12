Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbVLLAqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbVLLAqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVLLAqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:46:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7060 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750953AbVLLAqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:46:14 -0500
From: Petr Baudis <pasky@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
Date: Mon, 12 Dec 2005 01:46:06 +0100
To: zippel@linux-m68k.org
Cc: sam@ravnborg.org, kbuild-devel@lists.sourceforge.net
Message-Id: <20051212004606.31263.37616.stgit@machine.or.cz>
In-Reply-To: <20051212004159.31263.89669.stgit@machine.or.cz>
References: <20051212004159.31263.89669.stgit@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After three years, the zombie walks again!  This patch (against the latest
git tree) cleans up interaction between kconfig's mconf (menuconfig
frontend) and lxdialog. Its commandline interface disappears in this patch,
instead a .so is packed from the lxdialog objects and the relevant
functions are called directly from mconf.

In practice, this means that drawing on the screen is done with _MUCH_
less overhead now, the screen updates are better optimalized as ncurses
won't get reset everytime you display something, that also implies that
the ugly screen flickering is done. As a cute side-effect, the dialogs
are now rendered on the top of the menu or help panel.  In the future,
this also gives us much more freedom for enhancing the user interface.

This opens space for plenty of cleanups of liblxdialog, removal of
superfluous stuff and temporary files usage, etc.

Compared to the previous version (from February 2003), this one should be
less buggy (especially wrt. the escape character handling), should not
crash while resizing and the resizing should have immediate effect
(although things can still start looking ugly when you are resizing while
not in a menu - to fix that properly, more liblxdialog integration is
required). Also, the code is considerably simplified on few places.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 scripts/kconfig/Makefile     |   18 +
 scripts/kconfig/mconf.c      |  538 ++++++++++++++++--------------------------
 scripts/lxdialog/.gitignore  |    4 
 scripts/lxdialog/Makefile    |   18 +
 scripts/lxdialog/checklist.c |  113 ++++-----
 scripts/lxdialog/dialog.h    |   58 +++--
 scripts/lxdialog/inputbox.c  |    5 
 scripts/lxdialog/lxdialog.c  |  226 ------------------
 scripts/lxdialog/menubox.c   |   95 ++++---
 scripts/lxdialog/msgbox.c    |    8 -
 scripts/lxdialog/textbox.c   |    8 +
 scripts/lxdialog/util.c      |   62 +++++
 scripts/lxdialog/yesno.c     |    6 
 13 files changed, 448 insertions(+), 711 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index a96153f..0dc42ea 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -10,9 +10,8 @@ xconfig: $(obj)/qconf
 gconfig: $(obj)/gconf
 	$< arch/$(ARCH)/Kconfig
 
-menuconfig: $(obj)/mconf
-	$(Q)$(MAKE) $(build)=scripts/lxdialog
-	$< arch/$(ARCH)/Kconfig
+menuconfig: build-lxdialog $(obj)/mconf
+	$(obj)/mconf arch/$(ARCH)/Kconfig
 
 config: $(obj)/conf
 	$< arch/$(ARCH)/Kconfig
@@ -83,7 +82,7 @@ help:
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
 # conf:	  Used for defconfig, oldconfig and related targets
-# mconf:  Used for the mconfig target.
+# mconf:  Used for the mconfig target
 #         Utilizes the lxdialog package
 # qconf:  Used for the xconfig target
 #         Based on QT which needs to be installed to compile it
@@ -94,6 +93,7 @@ help:
 hostprogs-y	:= conf mconf qconf gconf kxgettext
 conf-objs	:= conf.o  zconf.tab.o
 mconf-objs	:= mconf.o zconf.tab.o
+mconf-linkobjs	:= ../lxdialog/liblxdialog.so
 kxgettext-objs	:= kxgettext.o zconf.tab.o
 
 ifeq ($(MAKECMDGOALS),xconfig)
@@ -129,6 +129,9 @@ endif
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
+HOSTLOADLIBES_mconf	= -lncurses
+
+
 HOSTLOADLIBES_qconf	= $(KC_QT_LIBS) -ldl
 HOSTCXXFLAGS_qconf.o	= $(KC_QT_CFLAGS) -D LKC_DIRECT_LINK
 
@@ -226,6 +229,13 @@ $(obj)/lkc_defs.h: $(src)/lkc_proto.h
 	sed < $< > $@ 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
 
 
+# We need to do it indirectly since default kbuild rule will override
+# us otherwise.
+.PHONY: build-lxdialog
+build-lxdialog:	FORCE
+	$(Q)$(MAKE) $(build)=scripts/lxdialog
+
+
 ###
 # The following requires flex/bison/gperf
 # By default we use the _shipped versions, uncomment the following line if
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index d1ad405..6284de2 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -6,9 +6,12 @@
  * 2002-11-06 Petr Baudis <pasky@ucw.cz>
  *
  * i18n, 2005, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *
+ * Rewritten to use liblxdialog directly instead of calling it as an
+ * external tool.
+ * 2005-12-11 Petr Baudis <pasky@suse.cz>
  */
 
-#include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <ctype.h>
 #include <errno.h>
@@ -22,10 +25,11 @@
 #include <unistd.h>
 #include <locale.h>
 
+#include "../lxdialog/dialog.h"
+
 #define LKC_DIRECT_LINK
 #include "lkc.h"
 
-static char menu_backtitle[128];
 static const char mconf_readme[] = N_(
 "Overview\n"
 "--------\n"
@@ -256,18 +260,17 @@ search_help[] = N_(
 	"          USB$ => find all CONFIG_ symbols ending with USB\n"
 	"\n");
 
-static char buf[4096], *bufptr = buf;
-static char input_buf[4096];
 static char filename[PATH_MAX+1] = ".config";
-static char *args[1024], **argptr = args;
 static int indent;
 static struct termios ios_org;
-static int rows = 0, cols = 0;
 static struct menu *current_menu;
 static int child_count;
-static int do_resize;
 static int single_menu_mode;
 
+/* FIXME: This ought to be dynamic. */
+static struct dialog_list_item *items[32768];
+static int items_count;
+
 static void conf(struct menu *menu);
 static void conf_choice(struct menu *menu);
 static void conf_string(struct menu *menu);
@@ -278,94 +281,65 @@ static void show_helptext(const char *ti
 static void show_help(struct menu *menu);
 static void show_file(const char *filename, const char *title, int r, int c);
 
-static void cprint_init(void);
-static int cprint1(const char *fmt, ...);
-static void cprint_done(void);
-static int cprint(const char *fmt, ...);
-
-static void init_wsize(void)
-{
-	struct winsize ws;
-	char *env;
-
-	if (!ioctl(STDIN_FILENO, TIOCGWINSZ, &ws)) {
-		rows = ws.ws_row;
-		cols = ws.ws_col;
-	}
 
-	if (!rows) {
-		env = getenv("LINES");
-		if (env)
-			rows = atoi(env);
-		if (!rows)
-			rows = 24;
-	}
-	if (!cols) {
-		env = getenv("COLUMNS");
-		if (env)
-			cols = atoi(env);
-		if (!cols)
-			cols = 80;
-	}
+static void winch_handler(int sig)
+{
+	static int lock;
 
-	if (rows < 19 || cols < 80) {
-		fprintf(stderr, N_("Your display is too small to run Menuconfig!\n"));
-		fprintf(stderr, N_("It must be at least 19 lines by 80 columns.\n"));
-		exit(1);
+	lock++;
+	if (lock == 1) {
+		resize_dialog();
+		lock--;
 	}
-
-	rows -= 4;
-	cols -= 5;
 }
 
-static void cprint_init(void)
-{
-	bufptr = buf;
-	argptr = args;
-	memset(args, 0, sizeof(args));
-	indent = 0;
-	child_count = 0;
-	cprint("./scripts/lxdialog/lxdialog");
-	cprint("--backtitle");
-	cprint(menu_backtitle);
-}
 
-static int cprint1(const char *fmt, ...)
+static void creset(void)
 {
-	va_list ap;
-	int res;
-
-	if (!*argptr)
-		*argptr = bufptr;
-	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
-	va_end(ap);
-	bufptr += res;
+	int i;
 
-	return res;
+	for (i = 0; i < items_count; i++) {
+		free(items[i]->name);
+		free(items[i]);
+	}
+	items_count = 0;
 }
 
-static void cprint_done(void)
+static void cmake(void)
 {
-	*bufptr++ = 0;
-	argptr++;
+	items[items_count] = calloc(1, sizeof(struct dialog_list_item));
+	items[items_count]->name = malloc(512); items[items_count]->name[0] = 0;
+	items[items_count]->namelen = 0;
+	items_count++;
 }
 
-static int cprint(const char *fmt, ...)
+static int cprint_name(const char *fmt, ...)
 {
 	va_list ap;
-	int res;
+	int i, res;
+
+	if (!items_count)
+		cmake();
+	i = items_count - 1;
 
-	*argptr++ = bufptr;
 	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
+	res = vsnprintf(items[i]->name + items[i]->namelen,
+			512 - items[i]->namelen, fmt, ap);
+	if (res > 0)
+		items[i]->namelen += res;
 	va_end(ap);
-	bufptr += res;
-	*bufptr++ = 0;
 
 	return res;
 }
 
+static int cset_tag(char type, void *ptr)
+{
+	items[items_count - 1]->type = type;
+	items[items_count - 1]->data = ptr;
+	return 0;
+}
+
+
 static void get_prompt_str(struct gstr *r, struct property *prop)
 {
 	int i, j;
@@ -438,108 +412,18 @@ static struct gstr get_relations_str(str
 	return res;
 }
 
-pid_t pid;
-
-static void winch_handler(int sig)
-{
-	if (!do_resize) {
-		kill(pid, SIGINT);
-		do_resize = 1;
-	}
-}
-
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
-	}
-
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
-}
 
 static void search_conf(void)
 {
 	struct symbol **sym_arr;
-	int stat;
 	struct gstr res;
 
 again:
-	cprint_init();
-	cprint("--title");
-	cprint(_("Search Configuration Parameter"));
-	cprint("--inputbox");
-	cprint(_("Enter CONFIG_ (sub)string to search for (omit CONFIG_)"));
-	cprint("10");
-	cprint("75");
-	cprint("");
-	stat = exec_conf();
-	if (stat < 0)
+	switch (dialog_inputbox(_("Search Configuration Parameter"),
+				_("Enter CONFIG_ (sub)string to search for (omit CONFIG_)"),
+				10, 75, "")) {
+	case -1:
 		goto again;
-	switch (stat) {
 	case 0:
 		break;
 	case 1:
@@ -549,7 +433,7 @@ again:
 		return;
 	}
 
-	sym_arr = sym_re_search(input_buf);
+	sym_arr = sym_re_search(dialog_input_result);
 	res = get_relations_str(sym_arr);
 	free(sym_arr);
 	show_textbox(_("Search Results"), str_get(&res), 0, 0);
@@ -576,24 +460,25 @@ static void build_conf(struct menu *menu
 			switch (prop->type) {
 			case P_MENU:
 				child_count++;
-				cprint("m%p", menu);
+				cmake();
+				cset_tag('m', menu);
 
 				if (single_menu_mode) {
-					cprint1("%s%*c%s",
+					cprint_name("%s%*c%s",
 						menu->data ? "-->" : "++>",
 						indent + 1, ' ', prompt);
 				} else
-					cprint1("   %*c%s  --->", indent + 1, ' ', prompt);
+					cprint_name("   %*c%s  --->", indent + 1, ' ', prompt);
 
-				cprint_done();
 				if (single_menu_mode && menu->data)
 					goto conf_childs;
 				return;
 			default:
 				if (prompt) {
 					child_count++;
-					cprint(":%p", menu);
-					cprint("---%*c%s", indent + 1, ' ', prompt);
+					cmake();
+					cset_tag(':', menu);
+					cprint_name("---%*c%s", indent + 1, ' ', prompt);
 				}
 			}
 		} else
@@ -601,6 +486,7 @@ static void build_conf(struct menu *menu
 		goto conf_childs;
 	}
 
+	cmake();
 	type = sym_get_type(sym);
 	if (sym_is_choice(sym)) {
 		struct symbol *def_sym = sym_get_choice_value(sym);
@@ -614,10 +500,10 @@ static void build_conf(struct menu *menu
 
 		val = sym_get_tristate_value(sym);
 		if (sym_is_changable(sym)) {
-			cprint("t%p", menu);
+			cset_tag('t', menu);
 			switch (type) {
 			case S_BOOLEAN:
-				cprint1("[%c]", val == no ? ' ' : '*');
+				cprint_name("[%c]", val == no ? ' ' : '*');
 				break;
 			case S_TRISTATE:
 				switch (val) {
@@ -625,84 +511,78 @@ static void build_conf(struct menu *menu
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
+			cset_tag(def_menu ? 't' : ':', menu);
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
 		if (menu == current_menu) {
-			cprint(":%p", menu);
-			cprint("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+			cset_tag(':', menu);
+			cprint_name("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 			goto conf_childs;
 		}
 		child_count++;
 		val = sym_get_tristate_value(sym);
 		if (sym_is_choice_value(sym) && val == yes) {
-			cprint(":%p", menu);
-			cprint1("   ");
+			cset_tag(':', menu);
+			cprint_name("   ");
 		} else {
 			switch (type) {
 			case S_BOOLEAN:
-				cprint("t%p", menu);
+				cset_tag('t', menu);
 				if (sym_is_changable(sym))
-					cprint1("[%c]", val == no ? ' ' : '*');
+					cprint_name("[%c]", val == no ? ' ' : '*');
 				else
-					cprint1("---");
+					cprint_name("---");
 				break;
 			case S_TRISTATE:
-				cprint("t%p", menu);
+				cset_tag('t', menu);
 				switch (val) {
 				case yes: ch = '*'; break;
 				case mod: ch = 'M'; break;
 				default:  ch = ' '; break;
 				}
 				if (sym_is_changable(sym))
-					cprint1("<%c>", ch);
+					cprint_name("<%c>", ch);
 				else
-					cprint1("---");
+					cprint_name("---");
 				break;
 			default:
-				cprint("s%p", menu);
-				tmp = cprint1("(%s)", sym_get_string_value(sym));
+				cset_tag('s', menu);
+				tmp = cprint_name("(%s)", sym_get_string_value(sym));
 				tmp = indent - tmp + 4;
 				if (tmp < 0)
 					tmp = 0;
-				cprint1("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
+				cprint_name("%*c%s%s", tmp, ' ', menu_get_prompt(menu),
 					(sym_has_value(sym) || !sym_is_changable(sym)) ?
 					"" : " (NEW)");
-				cprint_done();
 				goto conf_childs;
 			}
 		}
-		cprint1("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
+		cprint_name("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
 			(sym_has_value(sym) || !sym_is_changable(sym)) ?
 			"" : " (NEW)");
 		if (menu->prompt->type == P_MENU) {
-			cprint1("  --->");
-			cprint_done();
+			cprint_name("  --->");
 			return;
 		}
-		cprint_done();
 	}
 
 conf_childs:
@@ -714,62 +594,58 @@ conf_childs:
 
 static void conf(struct menu *menu)
 {
-	struct menu *submenu;
+	char active_type = 0; void *active_ptr = NULL;
+	int choice;
 	const char *prompt = menu_get_prompt(menu);
+	struct menu *submenu;
 	struct symbol *sym;
-	char active_entry[40];
-	int stat, type, i;
+	int stat;
 
 	unlink("lxdialog.scrltmp");
-	active_entry[0] = 0;
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : _("Main Menu"));
-		cprint("--menu");
-		cprint(_(menu_instructions));
-		cprint("%d", rows);
-		cprint("%d", cols);
-		cprint("%d", rows - 10);
-		cprint("%s", active_entry);
+		indent = 0;
+		child_count = 0;
 		current_menu = menu;
+		creset();
 		build_conf(menu);
 		if (!child_count)
 			break;
+
 		if (menu == &rootmenu) {
-			cprint(":");
-			cprint("--- ");
-			cprint("L");
-			cprint(_("    Load an Alternate Configuration File"));
-			cprint("S");
-			cprint(_("    Save Configuration to an Alternate File"));
+			cmake(); cset_tag(':', NULL); cprint_name("--- ");
+			cmake(); cset_tag('L', NULL); cprint_name(_("    Load an Alternate Configuration File"));
+			cmake(); cset_tag('S', NULL); cprint_name(_("    Save Configuration to an Alternate File"));
+		}
+
+		/* We must find choice again because build_conf() can shift
+		 * the items[] back/forth. */
+		/* This way, choice defaults to 0. */
+		for (choice = items_count - 1; choice; choice--) {
+			if (active_type == items[choice]->type
+			    && active_ptr == items[choice]->data)
+				break;
 		}
-		stat = exec_conf();
-		if (stat < 0)
-			continue;
-
-		if (stat == 1 || stat == 255)
-			break;
-
-		type = input_buf[0];
-		if (!type)
-			continue;
-
-		for (i = 0; input_buf[i] && !isspace(input_buf[i]); i++)
-			;
-		if (i >= sizeof(active_entry))
-			i = sizeof(active_entry) - 1;
-		input_buf[i] = 0;
-		strcpy(active_entry, input_buf);
+
+		dialog_clear();
+		stat = dialog_menu(prompt ? prompt : _("Main Menu"),
+				menu_instructions, rows, cols, rows - 10,
+				&choice, items_count, items);
+		if (stat < -1)
+			continue; /* Window resized, let's redraw... */
+		if (stat < 0 || stat == 1)
+			break;
+
+		active_type = items[choice]->type;
+		active_ptr = items[choice]->data;
 
 		sym = NULL;
-		submenu = NULL;
-		if (sscanf(input_buf + 1, "%p", &submenu) == 1)
+		submenu = active_ptr;
+		if (submenu)
 			sym = submenu->sym;
 
 		switch (stat) {
 		case 0:
-			switch (type) {
+			switch (active_type) {
 			case 'm':
 				if (single_menu_mode)
 					submenu->data = (void *) (long) !submenu->data;
@@ -800,7 +676,7 @@ static void conf(struct menu *menu)
 				show_helptext("README", _(mconf_readme));
 			break;
 		case 3:
-			if (type == 't') {
+			if (active_type == 't') {
 				if (sym_set_tristate_value(sym, yes))
 					break;
 				if (sym_set_tristate_value(sym, mod))
@@ -808,18 +684,22 @@ static void conf(struct menu *menu)
 			}
 			break;
 		case 4:
-			if (type == 't')
+			if (active_type == 't')
 				sym_set_tristate_value(sym, no);
 			break;
 		case 5:
-			if (type == 't')
+			if (active_type == 't')
 				sym_set_tristate_value(sym, mod);
 			break;
 		case 6:
-			if (type == 't')
+			if (active_type == 't') {
 				sym_toggle_tristate_value(sym);
-			else if (type == 'm')
-				conf(submenu);
+			} else if (active_type == 'm') {
+				if (single_menu_mode)
+					submenu->data = (void *) !submenu->data;
+				else
+					conf(submenu);
+			}
 			break;
 		case 7:
 			search_conf();
@@ -866,67 +746,55 @@ static void show_help(struct menu *menu)
 
 static void show_file(const char *filename, const char *title, int r, int c)
 {
-	do {
-		cprint_init();
-		if (title) {
-			cprint("--title");
-			cprint("%s", title);
-		}
-		cprint("--textbox");
-		cprint("%s", filename);
-		cprint("%d", r ? r : rows);
-		cprint("%d", c ? c : cols);
-	} while (exec_conf() < 0);
+	while (dialog_textbox(title, filename, r ? r : rows, c ? c : cols) < -1)
+		;
 }
 
 static void conf_choice(struct menu *menu)
 {
 	const char *prompt = menu_get_prompt(menu);
 	struct menu *child;
-	struct symbol *active;
-	int stat;
+	struct symbol *active_sym;
+	int active = 0, selected = 0;
 
-	active = sym_get_choice_value(menu->sym);
+	active_sym = sym_get_choice_value(menu->sym);
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : _("Main Menu"));
-		cprint("--radiolist");
-		cprint(_(radiolist_instructions));
-		cprint("15");
-		cprint("70");
-		cprint("6");
-
 		current_menu = menu;
+		creset();
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
-			cprint("%p", child);
-			cprint("%s", menu_get_prompt(child));
+			cmake();
+			cset_tag(0, child);
+			cprint_name("%s", menu_get_prompt(child));
 			if (child->sym == sym_get_choice_value(menu->sym))
-				cprint("ON");
-			else if (child->sym == active)
-				cprint("SELECTED");
-			else
-				cprint("OFF");
+				selected = items_count - 1;
+			if (child->sym == active_sym)
+				active = items_count - 1;
 		}
 
-		stat = exec_conf();
-		switch (stat) {
+		switch (dialog_checklist(prompt ? prompt : _("Main Menu"),
+					_(radiolist_instructions), 15, 70, 6,
+					&active, &selected,
+					items_count, items)) {
+		case -2:
+			break;
+		case -1:
+			return;
 		case 0:
-			if (sscanf(input_buf, "%p", &child) != 1)
+			child = items[selected]->data;
+			if (!child)
 				break;
 			sym_set_tristate_value(child->sym, yes);
 			return;
 		case 1:
-			if (sscanf(input_buf, "%p", &child) == 1) {
+			child = items[active]->data;
+			if (child) {
 				show_help(child);
-				active = child->sym;
+				active_sym = child->sym;
 			} else
 				show_help(menu);
 			break;
-		case 255:
-			return;
 		}
 	}
 }
@@ -934,99 +802,86 @@ static void conf_choice(struct menu *men
 static void conf_string(struct menu *menu)
 {
 	const char *prompt = menu_get_prompt(menu);
-	int stat;
 
 	while (1) {
-		cprint_init();
-		cprint("--title");
-		cprint("%s", prompt ? prompt : _("Main Menu"));
-		cprint("--inputbox");
+		char *heading;
+
 		switch (sym_get_type(menu->sym)) {
 		case S_INT:
-			cprint(_(inputbox_instructions_int));
+			heading = _(inputbox_instructions_int);
 			break;
 		case S_HEX:
-			cprint(_(inputbox_instructions_hex));
+			heading = _(inputbox_instructions_hex);
 			break;
 		case S_STRING:
-			cprint(_(inputbox_instructions_string));
+			heading = _(inputbox_instructions_string);
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
+		switch (dialog_inputbox(prompt ? prompt : _("Main Menu"),
+					heading, 10, 75,
+					sym_get_string_value(menu->sym))) {
+		case -2:
+			break;
+		case -1:
+			return;
 		case 0:
-			if (sym_set_string_value(menu->sym, input_buf))
+			if (sym_set_string_value(menu->sym, dialog_input_result))
 				return;
 			show_textbox(NULL, _("You have made an invalid entry."), 5, 43);
 			break;
 		case 1:
 			show_help(menu);
 			break;
-		case 255:
-			return;
 		}
 	}
 }
 
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
-		cprint("%s", filename);
-		stat = exec_conf();
-		switch(stat) {
+		switch (dialog_inputbox(NULL, load_config_text, 11, 55,
+					filename)) {
+		case -2:
+			break;
+		case -1:
+			return;
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_read(input_buf))
+			if (!conf_read(dialog_input_result))
 				return;
 			show_textbox(NULL, _("File does not exist!"), 5, 38);
 			break;
 		case 1:
 			show_helptext(_("Load Alternate Configuration"), load_config_help);
 			break;
-		case 255:
-			return;
 		}
 	}
 }
 
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
-		cprint("%s", filename);
-		stat = exec_conf();
-		switch(stat) {
+		switch (dialog_inputbox(NULL, save_config_text, 11, 55,
+					filename)) {
+		case -2:
+			break;
+		case -1:
+			return;
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_write(input_buf))
+			if (!conf_write(dialog_input_result))
 				return;
 			show_textbox(NULL, _("Can't create file!  Probably a nonexistent directory."), 5, 60);
 			break;
 		case 1:
 			show_helptext(_("Save Alternate Configuration"), save_config_help);
 			break;
-		case 255:
-			return;
 		}
 	}
 }
@@ -1051,9 +906,10 @@ int main(int ac, char **av)
 	conf_parse(av[1]);
 	conf_read(NULL);
 
+	backtitle = malloc(128);
 	sym = sym_lookup("KERNELRELEASE", 0);
 	sym_calc_value(sym);
-	sprintf(menu_backtitle, _("Linux Kernel v%s Configuration"),
+	snprintf(backtitle, 128, _("Linux Kernel v%s Configuration"),
 		sym_get_string_value(sym));
 
 	mode = getenv("MENUCONFIG_MODE");
@@ -1062,19 +918,25 @@ int main(int ac, char **av)
 			single_menu_mode = 1;
 	}
 
+	{
+		struct sigaction sa;
+		sa.sa_handler = winch_handler;
+		sigemptyset(&sa.sa_mask);
+		sa.sa_flags = 0;
+		sigaction(SIGWINCH, &sa, NULL);
+	}
+
 	tcgetattr(1, &ios_org);
 	atexit(conf_cleanup);
+	init_dialog();
 	init_wsize();
 	conf(&rootmenu);
-
 	do {
-		cprint_init();
-		cprint("--yesno");
-		cprint(_("Do you wish to save your new kernel configuration?"));
-		cprint("5");
-		cprint("60");
-		stat = exec_conf();
+		stat = dialog_yesno(NULL,
+				_("Do you wish to save your new kernel configuration?"),
+				5, 60);
 	} while (stat < 0);
+	end_dialog();
 
 	if (stat == 0) {
 		if (conf_write(NULL)) {
diff --git a/scripts/lxdialog/.gitignore b/scripts/lxdialog/.gitignore
new file mode 100644
index 0000000..4519018
--- /dev/null
+++ b/scripts/lxdialog/.gitignore
@@ -0,0 +1,4 @@
+#
+# The library
+#
+liblxdialog.so
diff --git a/scripts/lxdialog/Makefile b/scripts/lxdialog/Makefile
index a45a13f..9f65107 100644
--- a/scripts/lxdialog/Makefile
+++ b/scripts/lxdialog/Makefile
@@ -1,4 +1,14 @@
-HOST_EXTRACFLAGS := -DLOCALE 
+# A little excursion to the grand scheme of things:
+#
+# Unlike how it used to be in the past, now we don't use the external lxdialog
+# utility in make menuconfig, but we link the lxdialog suite directly against
+# mconf. Also, mconf is linked against ncurses only over there, regardless
+# to what you see here in HOST_LOADLIBES; here we merely check for ncurses
+# presence.
+#
+# 2005-12-11 Petr Baudis <pasky@suse.cz>
+
+HOST_EXTRACFLAGS := -DLOCALE
 ifeq ($(shell uname),SunOS)
 HOST_LOADLIBES   := -lcurses
 else
@@ -19,11 +29,11 @@ endif
 endif
 endif
 
-hostprogs-y	:= lxdialog
+hostprogs-y	:= liblxdialog.so
 always		:= ncurses $(hostprogs-y)
 
-lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
-		 util.o lxdialog.o msgbox.o
+liblxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
+		util.o msgbox.o
 
 .PHONY: $(obj)/ncurses
 $(obj)/ncurses:
diff --git a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
index 7aba17c..4788480 100644
--- a/scripts/lxdialog/checklist.c
+++ b/scripts/lxdialog/checklist.c
@@ -23,7 +23,7 @@
 
 #include "dialog.h"
 
-static int list_width, check_x, item_x, checkflag;
+static int list_width, check_x, item_x;
 
 /*
  * Print list item
@@ -42,10 +42,7 @@ print_item (WINDOW * win, const char *it
 
     wmove (win, choice, check_x);
     wattrset (win, selected ? check_selected_attr : check_attr);
-    if (checkflag == FLAG_CHECK)
-	wprintw (win, "[%c]", status ? 'X' : ' ');
-    else
-	wprintw (win, "(%c)", status ? 'X' : ' ');
+    wprintw (win, "(%c)", status ? 'X' : ' ');
 
     wattrset (win, selected ? tag_selected_attr : tag_attr);
     mvwaddch(win, choice, item_x, item[0]);
@@ -61,7 +58,7 @@ print_item (WINDOW * win, const char *it
  * Print the scroll indicators.
  */
 static void
-print_arrows (WINDOW * win, int choice, int item_no, int scroll,
+print_arrows (WINDOW * win, int choice, int items_count, int scroll,
 		int y, int x, int height)
 {
     wmove(win, y, x);
@@ -82,7 +79,7 @@ print_arrows (WINDOW * win, int choice, 
    y = y + height + 1;
    wmove(win, y, x);
 
-   if ((height < item_no) && (scroll + choice < item_no - 1)) {
+   if ((height < items_count) && (scroll + choice < items_count - 1)) {
 	wattrset (win, darrow_attr);
 	waddch (win, ACS_DARROW);
 	waddstr (win, "(+)");
@@ -113,22 +110,22 @@ print_buttons( WINDOW *dialog, int heigh
 }
 
 /*
- * Display a dialog box with a list of options that can be turned on or off
- * The `flag' parameter is used to select between radiolist and checklist.
+ * Display a dialog box with a list of options that can be turned on or off,
+ * in the style of radiobuttons (only one option valid at a time)
  */
 int
-dialog_checklist (const char *title, const char *prompt, int height, int width,
-	int list_height, int item_no, const char * const * items, int flag)
-	
+dialog_checklist (const char *title, const char *prompt,
+		int height, int width, int list_height,
+		int *active, int *checked,
+		int items_count, struct dialog_list_item ** items)
 {
     int i, x, y, box_x, box_y;
     int key = 0, button = 0, choice = 0, scroll = 0, max_choice, *status;
     WINDOW *dialog, *list;
 
-    checkflag = flag;
-
     /* Allocate space for storing item on/off status */
-    if ((status = malloc (sizeof (int) * item_no)) == NULL) {
+    /* XXX: This whole status[] thing can be killed now. */
+    if ((status = malloc (sizeof (int) * items_count)) == NULL) {
 	endwin ();
 	fprintf (stderr,
 		 "\nCan't allocate memory in dialog_checklist().\n");
@@ -136,15 +133,12 @@ dialog_checklist (const char *title, con
     }
 
     /* Initializes status */
-    for (i = 0; i < item_no; i++) {
-	status[i] = !strcasecmp (items[i * 3 + 2], "on");
-	if ((!choice && status[i]) || !strcasecmp (items[i * 3 + 2], "selected"))
-            choice = i + 1;
+    for (i = 0; i < items_count; i++) {
+	status[i] = 0;
     }
-    if (choice)
-	    choice--;
-
-    max_choice = MIN (list_height, item_no);
+    status[*checked] = 1;
+    choice = *active;
+    max_choice = MIN (list_height, items_count);
 
     /* center dialog box on screen */
     x = (COLS - width) / 2;
@@ -196,8 +190,8 @@ dialog_checklist (const char *title, con
 
     /* Find length of longest item in order to center checklist */
     check_x = 0;
-    for (i = 0; i < item_no; i++) 
-	check_x = MAX (check_x, + strlen (items[i * 3 + 1]) + 4);
+    for (i = 0; i < items_count; i++) 
+	check_x = MAX (check_x, + strlen (items[i]->name) + 4);
 
     check_x = (list_width - check_x) / 2;
     item_x = check_x + 4;
@@ -209,11 +203,11 @@ dialog_checklist (const char *title, con
 
     /* Print the list */
     for (i = 0; i < max_choice; i++) {
-	print_item (list, items[(scroll+i) * 3 + 1],
+	print_item (list, items[scroll + i]->name,
 		    status[i+scroll], i, i == choice);
     }
 
-    print_arrows(dialog, choice, item_no, scroll,
+    print_arrows(dialog, choice, items_count, scroll,
 			box_y, box_x + check_x + 5, list_height);
 
     print_buttons(dialog, height, width, 0);
@@ -225,8 +219,11 @@ dialog_checklist (const char *title, con
     while (key != ESC) {
 	key = wgetch (dialog);
 
+	if (should_resize)
+	    do_resize_dialog();
+
     	for (i = 0; i < max_choice; i++)
-            if (toupper(key) == toupper(items[(scroll+i)*3+1][0]))
+            if (toupper(key) == toupper(items[scroll + i]->name[0]))
                 break;
 
 
@@ -239,18 +236,18 @@ dialog_checklist (const char *title, con
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
 
-    		    print_arrows(dialog, choice, item_no, scroll,
+    		    print_arrows(dialog, choice, items_count, scroll,
 				box_y, box_x + check_x + 5, list_height);
 
 		    wrefresh (dialog);
@@ -260,12 +257,12 @@ dialog_checklist (const char *title, con
 		    i = choice - 1;
 	    } else if (key == KEY_DOWN || key == '+') {
 		if (choice == max_choice - 1) {
-		    if (scroll + choice >= item_no - 1)
+		    if (scroll + choice >= items_count - 1)
 			continue;
 		    /* Scroll list up */
 		    if (list_height > 1) {
 			/* De-highlight current last item before scrolling up */
-			print_item (list, items[(scroll + max_choice - 1) * 3 + 1],
+			print_item (list, items[scroll + max_choice - 1]->name,
 				    status[scroll + max_choice - 1],
 				    max_choice - 1, FALSE);
 			scrollok (list, TRUE);
@@ -273,12 +270,12 @@ dialog_checklist (const char *title, con
 			scrollok (list, FALSE);
 		    }
 		    scroll++;
-		    print_item (list, items[(scroll + max_choice - 1) * 3 + 1],
+		    print_item (list, items[scroll + max_choice - 1]->name,
 				status[scroll + max_choice - 1],
 				max_choice - 1, TRUE);
 		    wnoutrefresh (list);
 
-    		    print_arrows(dialog, choice, item_no, scroll,
+    		    print_arrows(dialog, choice, items_count, scroll,
 				box_y, box_x + check_x + 5, list_height);
 
 		    wrefresh (dialog);
@@ -289,11 +286,11 @@ dialog_checklist (const char *title, con
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
@@ -304,7 +301,7 @@ dialog_checklist (const char *title, con
 	case 'H':
 	case 'h':
 	case '?':
-	    fprintf (stderr, "%s", items[(scroll + choice) * 3]);
+	    *active = scroll + choice;
 	    delwin (dialog);
 	    free (status);
 	    return 1;
@@ -317,41 +314,26 @@ dialog_checklist (const char *title, con
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (dialog);
 	    break;
+	case KEY_RESIZE:
+	    button = -2;
 	case 'S':
 	case 's':
 	case ' ':
 	case '\n':
 	    if (!button) {
-		if (flag == FLAG_CHECK) {
-		    status[scroll + choice] = !status[scroll + choice];
-		    wmove (list, choice, check_x);
-		    wattrset (list, check_selected_attr);
-		    wprintw (list, "[%c]", status[scroll + choice] ? 'X' : ' ');
-		} else {
-		    if (!status[scroll + choice]) {
-			for (i = 0; i < item_no; i++)
-			    status[i] = 0;
-			status[scroll + choice] = 1;
-			for (i = 0; i < max_choice; i++)
-			    print_item (list, items[(scroll + i) * 3 + 1],
-					status[scroll + i], i, i == choice);
-		    }
+		if (!status[scroll + choice]) {
+		    for (i = 0; i < items_count; i++)
+		        status[i] = 0;
+		    status[scroll + choice] = 1;
+		    for (i = 0; i < max_choice; i++)
+		        print_item (list, items[scroll + i]->name,
+		    		status[scroll + i], i, i == choice);
 		}
 		wnoutrefresh (list);
 		wrefresh (dialog);
-            
-		for (i = 0; i < item_no; i++) {
-		    if (status[i]) {
-			if (flag == FLAG_CHECK) {
-			    fprintf (stderr, "\"%s\" ", items[i * 3]);
-			} else {
-			    fprintf (stderr, "%s", items[i * 3]);
-			}
-
-		    }
-		}
-            } else
-		fprintf (stderr, "%s", items[(scroll + choice) * 3]);
+		*checked = scroll + choice;
+	    }
+	    *active = scroll + choice;
 	    delwin (dialog);
 	    free (status);
 	    return button;
@@ -365,7 +347,6 @@ dialog_checklist (const char *title, con
 	/* Now, update everything... */
 	doupdate ();
     }
-    
 
     delwin (dialog);
     free (status);
diff --git a/scripts/lxdialog/dialog.h b/scripts/lxdialog/dialog.h
index eb63e1b..d9239a8 100644
--- a/scripts/lxdialog/dialog.h
+++ b/scripts/lxdialog/dialog.h
@@ -29,6 +29,9 @@
 #ifdef __sun__
 #define CURS_MACROS
 #endif
+/* CURSES_LOC is not defined when we #include this from mconf.c. So in
+ * general, parts guarded in CURSES_LOC are private to liblxdialog. */
+#ifdef CURSES_LOC
 #include CURSES_LOC
 
 /*
@@ -128,41 +131,62 @@
  * Global variables
  */
 extern bool use_colors;
-extern bool use_shadow;
+extern volatile bool should_resize;
 
 extern chtype attributes[];
+#endif
+
+extern int rows, cols;
+extern char *backtitle;
 
-extern const char *backtitle;
+struct dialog_list_item {
+	char *name;
+	int namelen;
+	char type;
+	void *data;
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
+void init_wsize (void);
+void resize_dialog (void);
+void do_resize_dialog (void);
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
+
+/* Generally, these functions return the id of the pressed button, -1 for
+ * escape and -2 when the window was resized (just call the function again). */
+/* If the function accepts *active (index to the items[] array), it will
+ * change it to the last active item when returning. *checked is similar
+ * but it denotes which item was checked when returning (may not be same
+ * e.g. when the [Help] button was pressed). */
+
 int dialog_yesno (const char *title, const char *prompt, int height, int width);
 int dialog_msgbox (const char *title, const char *prompt, int height,
 		int width, int pause);
 int dialog_textbox (const char *title, const char *file, int height, int width);
-int dialog_menu (const char *title, const char *prompt, int height, int width,
-		int menu_height, const char *choice, int item_no, 
-		const char * const * items);
-int dialog_checklist (const char *title, const char *prompt, int height,
-		int width, int list_height, int item_no,
-		const char * const * items, int flag);
+int dialog_menu (const char *title, const char *prompt,
+		int height, int width, int menu_height,
+		int *active,
+		int items_count, struct dialog_list_item ** items);
+int dialog_checklist (const char *title, const char *prompt,
+		int height, int width, int list_height,
+		int *active, int *checked,
+		int items_count, struct dialog_list_item ** items);
 extern char dialog_input_result[];
 int dialog_inputbox (const char *title, const char *prompt, int height,
 		int width, const char *init);
@@ -176,12 +200,6 @@ int dialog_inputbox (const char *title, 
  *   -- the lowercase are used to signal mouse-enter events (M_EVENT + 'o')
  *   -- uppercase chars are used to invoke the button (M_EVENT + 'O')
  */
+#ifdef CURSES_LOC
 #define M_EVENT (KEY_MAX+1)
-
-
-/*
- * The `flag' parameter in checklist is used to select between
- * radiolist and checklist
- */
-#define FLAG_CHECK 1
-#define FLAG_RADIO 0
+#endif
diff --git a/scripts/lxdialog/inputbox.c b/scripts/lxdialog/inputbox.c
index 074d2d6..e32ac9a 100644
--- a/scripts/lxdialog/inputbox.c
+++ b/scripts/lxdialog/inputbox.c
@@ -123,6 +123,9 @@ dialog_inputbox (const char *title, cons
     while (key != ESC) {
 	key = wgetch (dialog);
 
+	if (should_resize)
+	    do_resize_dialog();
+
 	if (button == -1) {	/* Input box selected */
 	    switch (key) {
 	    case TAB:
@@ -223,6 +226,8 @@ dialog_inputbox (const char *title, cons
 		break;
 	    }
 	    break;
+	case KEY_RESIZE:
+	    button = -2;
 	case ' ':
 	case '\n':
 	    delwin (dialog);
diff --git a/scripts/lxdialog/lxdialog.c b/scripts/lxdialog/lxdialog.c
deleted file mode 100644
index f283a85..0000000
--- a/scripts/lxdialog/lxdialog.c
+++ /dev/null
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
-    int offset = 0, opt_clear = 0, end_common_opts = 0, retval;
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
-	    if (opt_clear) {		/* Hey, "--clear" can't appear twice! */
-		Usage (argv[0]);
-		exit (-1);
-	    } else if (argc == 2) {	/* we only want to clear the screen */
-		init_dialog ();
-		refresh ();	/* init_dialog() will clear the screen for us */
-		end_dialog ();
-		return 0;
-	    } else {
-		opt_clear = 1;
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
-    if (opt_clear) {		/* clear screen before exit */
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
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index 91d82ba..48df20a 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -93,7 +93,7 @@ print_item (WINDOW * win, const char *it
     }
     if (selected) {
 	wmove (win, choice, item_x+1);
-	wrefresh (win);
+	wnoutrefresh (win);
     }
 }
 
@@ -101,7 +101,7 @@ print_item (WINDOW * win, const char *it
  * Print the scroll indicators.
  */
 static void
-print_arrows (WINDOW * win, int item_no, int scroll,
+print_arrows (WINDOW * win, int items_count, int scroll,
 		int y, int x, int height)
 {
     int cur_y, cur_x;
@@ -126,7 +126,7 @@ print_arrows (WINDOW * win, int item_no,
    y = y + height + 1;
    wmove(win, y, x);
 
-   if ((height < item_no) && (scroll + height < item_no)) {
+   if ((height < items_count) && (scroll + height < items_count)) {
 	wattrset (win, darrow_attr);
 	waddch (win, ACS_DARROW);
 	waddstr (win, "(+)");
@@ -163,17 +163,18 @@ print_buttons (WINDOW *win, int height, 
  * Display a menu for choosing among a number of options
  */
 int
-dialog_menu (const char *title, const char *prompt, int height, int width,
-		int menu_height, const char *current, int item_no,
-		const char * const * items)
-
+dialog_menu (const char *title, const char *prompt,
+		int height, int width, int menu_height,
+		int *active,
+		int items_count, struct dialog_list_item ** items)
 {
     int i, j, x, y, box_x, box_y;
     int key = 0, button = 0, scroll = 0, choice = 0, first_item = 0, max_choice;
     WINDOW *dialog, *menu;
     FILE *f;
 
-    max_choice = MIN (menu_height, item_no);
+    choice = *active;
+    max_choice = MIN (menu_height, items_count);
 
     /* center dialog box on screen */
     x = (COLS - width) / 2;
@@ -226,12 +227,10 @@ dialog_menu (const char *title, const ch
 
     /*
      * Find length of longest item in order to center menu.
-     * Set 'choice' to default item. 
      */
     item_x = 0;
-    for (i = 0; i < item_no; i++) {
-	item_x = MAX (item_x, MIN(menu_width, strlen (items[i * 2 + 1]) + 2));
-	if (strcmp(current, items[i*2]) == 0) choice = i;
+    for (i = 0; i < items_count; i++) {
+	item_x = MAX (item_x, MIN(menu_width, strlen (items[i]->name) + 2));
     }
 
     item_x = (menu_width - item_x) / 2;
@@ -240,7 +239,7 @@ dialog_menu (const char *title, const ch
     if ( (f=fopen("lxdialog.scrltmp","r")) != NULL ) {
 	if ( (fscanf(f,"%d\n",&scroll) == 1) && (scroll <= choice) &&
 	     (scroll+max_choice > choice) && (scroll >= 0) &&
-	     (scroll+max_choice <= item_no) ) {
+	     (scroll+max_choice <= items_count) ) {
 	    first_item = scroll;
 	    choice = choice - scroll;
 	    fclose(f);
@@ -252,8 +251,8 @@ dialog_menu (const char *title, const ch
 	}
     }
     if ( (choice >= max_choice) || (f==NULL && choice >= max_choice/2) ) {
-	if (choice >= item_no-max_choice/2)
-	    scroll = first_item = item_no-max_choice;
+	if (choice >= items_count-max_choice/2)
+	    scroll = first_item = items_count-max_choice;
 	else
 	    scroll = first_item = choice - max_choice/2;
 	choice = choice - scroll;
@@ -261,13 +260,13 @@ dialog_menu (const char *title, const ch
 
     /* Print the menu */
     for (i=0; i < max_choice; i++) {
-	print_item (menu, items[(first_item + i) * 2 + 1], i, i == choice,
-                    (items[(first_item + i)*2][0] != ':'));
+	print_item (menu, items[first_item + i]->name, i, i == choice,
+                    (items[first_item + i]->type != ':'));
     }
 
     wnoutrefresh (menu);
 
-    print_arrows(dialog, item_no, scroll,
+    print_arrows(dialog, items_count, scroll,
 		 box_y, box_x+item_x+1, menu_height);
 
     print_buttons (dialog, height, width, 0);
@@ -277,20 +276,23 @@ dialog_menu (const char *title, const ch
     while (key != ESC) {
 	key = wgetch(menu);
 
+	if (should_resize)
+	    do_resize_dialog();
+
 	if (key < 256 && isalpha(key)) key = tolower(key);
 
 	if (strchr("ynmh", key))
 		i = max_choice;
 	else {
         for (i = choice+1; i < max_choice; i++) {
-		j = first_alpha(items[(scroll+i)*2+1], "YyNnMmHh");
-		if (key == tolower(items[(scroll+i)*2+1][j]))
+		j = first_alpha(items[scroll + i]->name, "YyNnMmHh");
+		if (key == tolower(items[scroll + i]->name[j]))
                 	break;
 	}
 	if (i == max_choice)
        		for (i = 0; i < max_choice; i++) {
-			j = first_alpha(items[(scroll+i)*2+1], "YyNnMmHh");
-			if (key == tolower(items[(scroll+i)*2+1][j]))
+			j = first_alpha(items[scroll + i]->name, "YyNnMmHh");
+			if (key == tolower(items[scroll + i]->name[j]))
                 		break;
 		}
 	}
@@ -300,8 +302,8 @@ dialog_menu (const char *title, const ch
             key == '-' || key == '+' ||
             key == KEY_PPAGE || key == KEY_NPAGE) {
 
-            print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
-                       (items[(scroll+choice)*2][0] != ':'));
+            print_item (menu, items[scroll + choice]->name, choice, FALSE,
+                       (items[scroll + choice]->type != ':'));
 
 	    if (key == KEY_UP || key == '-') {
                 if (choice < 2 && scroll) {
@@ -312,18 +314,18 @@ dialog_menu (const char *title, const ch
 
                     scroll--;
 
-                    print_item (menu, items[scroll * 2 + 1], 0, FALSE,
-                               (items[scroll*2][0] != ':'));
+                    print_item (menu, items[scroll]->name, 0, FALSE,
+                               (items[scroll]->type != ':'));
 		} else
 		    choice = MAX(choice - 1, 0);
 
 	    } else if (key == KEY_DOWN || key == '+')  {
 
-		print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
-                                (items[(scroll+choice)*2][0] != ':'));
+		print_item (menu, items[scroll + choice]->name, choice, FALSE,
+                                (items[scroll + choice]->type != ':'));
 
                 if ((choice > max_choice-3) &&
-                    (scroll + max_choice < item_no)
+                    (scroll + max_choice < items_count)
                    ) {
 		    /* Scroll menu up */
 		    scrollok (menu, TRUE);
@@ -332,9 +334,9 @@ dialog_menu (const char *title, const ch
 
                     scroll++;
 
-                    print_item (menu, items[(scroll+max_choice-1)*2+1],
+                    print_item (menu, items[scroll + max_choice - 1]->name,
                                max_choice-1, FALSE,
-                               (items[(scroll+max_choice-1)*2][0] != ':'));
+                               (items[scroll + max_choice - 1]->type != ':'));
                 } else
                     choice = MIN(choice+1, max_choice-1);
 
@@ -344,8 +346,8 @@ dialog_menu (const char *title, const ch
                     if (scroll > 0) {
                 	wscrl (menu, -1);
                 	scroll--;
-                	print_item (menu, items[scroll * 2 + 1], 0, FALSE,
-                	(items[scroll*2][0] != ':'));
+                	print_item (menu, items[scroll]->name, 0, FALSE,
+                	(items[scroll]->type != ':'));
                     } else {
                         if (choice > 0)
                             choice--;
@@ -355,14 +357,14 @@ dialog_menu (const char *title, const ch
 
             } else if (key == KEY_NPAGE) {
                 for (i=0; (i < max_choice); i++) {
-                    if (scroll+max_choice < item_no) {
+                    if (scroll+max_choice < items_count) {
 			scrollok (menu, TRUE);
 			wscrl (menu, 1);
 			scrollok (menu, FALSE);
                 	scroll++;
-                	print_item (menu, items[(scroll+max_choice-1)*2+1],
+                	print_item (menu, items[scroll + max_choice - 1]->name,
 			            max_choice-1, FALSE,
-			            (items[(scroll+max_choice-1)*2][0] != ':'));
+			            (items[scroll + max_choice - 1]->type != ':'));
 		    } else {
 			if (choice+1 < max_choice)
 			    choice++;
@@ -372,10 +374,10 @@ dialog_menu (const char *title, const ch
             } else
                 choice = i;
 
-            print_item (menu, items[(scroll+choice)*2+1], choice, TRUE,
-                       (items[(scroll+choice)*2][0] != ':'));
+            print_item (menu, items[scroll + choice]->name, choice, TRUE,
+                       (items[scroll + choice]->type != ':'));
 
-            print_arrows(dialog, item_no, scroll,
+            print_arrows(dialog, items_count, scroll,
                          box_y, box_x+item_x+1, menu_height);
 
             wnoutrefresh (dialog);
@@ -394,19 +396,20 @@ dialog_menu (const char *title, const ch
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (menu);
 	    break;
-	case ' ':
+	case KEY_RESIZE:
 	case 's':
 	case 'y':
 	case 'n':
 	case 'm':
 	case '/':
+	case ' ':
 	    /* save scroll info */
 	    if ( (f=fopen("lxdialog.scrltmp","w")) != NULL ) {
 		fprintf(f,"%d\n",scroll);
 		fclose(f);
 	    }
 	    delwin (dialog);
-            fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
+	    *active = scroll + choice;
             switch (key) {
             case 's': return 3;
             case 'y': return 3;
@@ -415,19 +418,13 @@ dialog_menu (const char *title, const ch
             case ' ': return 6;
             case '/': return 7;
             }
-	    return 0;
+	    return -2;
 	case 'h':
 	case '?':
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
+	    *active = scroll + choice;
 
 	    remove("lxdialog.scrltmp");
 	    return button;
diff --git a/scripts/lxdialog/msgbox.c b/scripts/lxdialog/msgbox.c
index 93692e1..a175532 100644
--- a/scripts/lxdialog/msgbox.c
+++ b/scripts/lxdialog/msgbox.c
@@ -73,13 +73,17 @@ dialog_msgbox (const char *title, const 
 
 	wrefresh (dialog);
 	while (key != ESC && key != '\n' && key != ' ' &&
-               key != 'O' && key != 'o' && key != 'X' && key != 'x')
+               key != 'O' && key != 'o' && key != 'X' && key != 'x' &&
+	       key != KEY_RESIZE) {
 	    key = wgetch (dialog);
+	    if (should_resize)
+		do_resize_dialog ();
+	}
     } else {
 	key = '\n';
 	wrefresh (dialog);
     }
 
     delwin (dialog);
-    return key == ESC ? -1 : 0;
+    return key == ESC ? -1 : key == KEY_RESIZE ? -2 : 0;
 }
diff --git a/scripts/lxdialog/textbox.c b/scripts/lxdialog/textbox.c
index ed23df2..dd4d985 100644
--- a/scripts/lxdialog/textbox.c
+++ b/scripts/lxdialog/textbox.c
@@ -133,7 +133,13 @@ dialog_textbox (const char *title, const
 
     while ((key != ESC) && (key != '\n')) {
 	key = wgetch (dialog);
+
+	if (should_resize) {
+	    do_resize_dialog();
+	}
+
 	switch (key) {
+	case KEY_RESIZE:
 	case 'E':		/* Exit */
 	case 'e':
 	case 'X':
@@ -141,7 +147,7 @@ dialog_textbox (const char *title, const
 	    delwin (dialog);
 	    free (buf);
 	    close (fd);
-	    return 0;
+	    return key == KEY_RESIZE ? -2 : 0;
 	case 'g':		/* First page */
 	case KEY_HOME:
 	    if (!begin_reached) {
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index e7bce9b..37dffdd 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -19,13 +19,16 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <sys/ioctl.h>
+
 #include "dialog.h"
 
 
 /* use colors by default? */
 bool use_colors = 1;
+int rows = 0, cols = 0;
 
-const char *backtitle = NULL;
+char *backtitle = NULL;
 
 const char *dialog_result;
 
@@ -188,6 +191,63 @@ end_dialog (void)
 }
 
 
+void
+init_wsize()
+{
+	struct winsize ws;
+	char *env;
+
+	if (!ioctl(STDIN_FILENO, TIOCGWINSZ, &ws)) {
+		rows = ws.ws_row;
+		cols = ws.ws_col;
+	}
+
+	if (!rows) {
+		env = getenv("LINES");
+		if (env)
+			rows = atoi(env);
+		if (!rows)
+			rows = 24;
+	}
+	if (!cols) {
+		env = getenv("COLUMNS");
+		if (env)
+			cols = atoi(env);
+		if (!cols)
+			cols = 80;
+	}
+
+	if (rows < 19 || cols < 80) {
+		end_dialog();
+		fprintf(stderr, "Your display is too small to run Menuconfig!\n");
+		fprintf(stderr, "It must be at least 19 lines by 80 columns.\n");
+		exit(1);
+	}
+
+	rows -= 4;
+	cols -= 5;
+}
+
+volatile bool should_resize = 0;
+
+void
+resize_dialog ()
+{
+    should_resize = 1;
+}
+
+void
+do_resize_dialog ()
+{
+    should_resize = 0;
+    init_wsize();
+    resizeterm(rows + 4, cols + 5);
+    LINES = rows + 4;
+    COLS = cols + 5;
+    ungetch(KEY_RESIZE);
+}
+
+
 /*
  * Print a string of text in a window, automatically wrap around to the
  * next line if the string is too long to fit on one line. Newline
diff --git a/scripts/lxdialog/yesno.c b/scripts/lxdialog/yesno.c
index 11fcc25..af59fe2 100644
--- a/scripts/lxdialog/yesno.c
+++ b/scripts/lxdialog/yesno.c
@@ -85,6 +85,10 @@ dialog_yesno (const char *title, const c
 
     while (key != ESC) {
 	key = wgetch (dialog);
+
+	if (should_resize)
+	    do_resize_dialog();
+
 	switch (key) {
 	case 'Y':
 	case 'y':
@@ -104,6 +108,8 @@ dialog_yesno (const char *title, const c
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (dialog);
 	    break;
+	case KEY_RESIZE:
+	    button = -2;
 	case ' ':
 	case '\n':
 	    delwin (dialog);

