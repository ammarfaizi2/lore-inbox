Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbTBECwq>; Tue, 4 Feb 2003 21:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbTBECwo>; Tue, 4 Feb 2003 21:52:44 -0500
Received: from pasky.ji.cz ([62.44.12.54]:50424 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S267753AbTBECvg>;
	Tue, 4 Feb 2003 21:51:36 -0500
Date: Wed, 5 Feb 2003 04:01:04 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kconfig] Direct use of lxdialog routines by menuconfig (v3)
Message-ID: <20030205030104.GK10207@pasky.ji.cz>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20021123095040.GY25628@pasky.ji.cz> <Pine.LNX.4.44.0211240159240.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211240159240.2113-100000@serv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Nov 24, 2002 at 02:48:23AM CET, I got a letter,
where Roman Zippel <zippel@linux-m68k.org> told me, that...
> Hi,

Hello,

first I apologize for a slight delay.

> On Sat, 23 Nov 2002, Petr Baudis wrote:
> 
> >   this patch (against 2.5.49) cleans up interaction between kconfig's mconf
> > (menuconfig frontend) and lxdialog. Its commandline interface (called
> > imaginatively lxdialog) no longer exists, instead a huge .o is packed from the
> > lxdialog objects and the relevant functions are called directly from mconf.
> 
> It didn't apply cleanly, I had one reject from menubox.c, which I had to 
> apply manually.

Huh.. unreproducible here :-(. It applies cleanly to my clean 2.5.49 tree.

Late note: so does it to 2.5.59.

> Anyway, some minor comments about the code:
> 
> > +struct dialog_list_item *items[16384]; /* FIXME: This ought to be dynamic. */
> > +int item_no;
> > +
> 
> These should be static.

Oops, fixed.

> > -static void cprint_init(void)
> > +static void cinit(void)
> 
> You can join this with cdone(), they are always called together.

Hmm.. I thought I could use it separately sometimes, but changed my mind then
;-).  Merged (well, rather cinit() annihilated) and renamed to creset().

> > +	if (!item_no)
> > +		cmake();
> 
> This could be "if (!items[item_no]) cmake()" to allocate the data as 
> needed. Increment item_no after you done, this avoids also all the 
> "item_no - 1" as index.

We don't clean the items array in cdone^H^H^H^Hreset(). Thus, this won't work
after first pass, IMHO. I think this is probably more straightforward anyway.
*shrug*

> > -static int cprint(const char *fmt, ...)
> > +static int cprint_tag(const char *fmt, ...)
> >  {
> >  	va_list ap;
> >  	int res;
> >  
> > -	*argptr++ = bufptr;
> > +	if (!item_no)
> > +		cmake();
> >  	va_start(ap, fmt);
> > -	res = vsprintf(bufptr, fmt, ap);
> > +	res = vsnprintf(items[item_no - 1]->tag, 32, fmt, ap);
> >  	va_end(ap);
> > -	bufptr += res;
> > -	*bufptr++ = 0;
> >  
> >  	return res;
> >  }
> 
> Could you change the tag field of dialog_list_item into a "char type" and 
> a void pointer? I don't really see a reason to convert them from/into 
> strings anymore.

Bigger diff ;-). Ok, you asked for it. Done.

> > -	sa.sa_handler = winch_handler;
> > -	sigemptyset(&sa.sa_mask);
> > -	sa.sa_flags = SA_RESTART;
> > -	sigaction(SIGWINCH, &sa, NULL);
> 
> Could you please add this one back and just reinitialize curses? (I 
> actually liked the new resize feature. :) )

Well I tried to do something, but it is relatively complex, since we can't do
almost anything useful in the signal handler itself. The problem is that for a
reason which I'm unable to hunt down now (after approx. 4 hours of mainly
trying to accomplish that) in some percentage of cases when the window is
resized, something terribly pollutes the stack and we're screwed. Thus I
temporarily disabled the functional part of the winch handler for now, the rest
of code is in place and ready to be used by anyone brave enough to s/#if 0/#if
1/ in the winch handler.

Otherwise (with the resizing disabled) it's quite stable about my personal
stresstesting through, and the crash always happens inside of ncurses, so I
don't really know... thus I believe it's ready for inclusion, we can fix the
resizing issue later as it's not anything critical, is it? *hopeful smile*

> BTW just add the other patch to this one, it's not that important to keep 
> it separate.

Well it looks as it's included already...?



 Makefile                     |    7
 scripts/kconfig/Makefile     |    7
 scripts/kconfig/mconf.c      |  428 ++++++++++++++++---------------------------
 scripts/lxdialog/Makefile    |   26 ++
 scripts/lxdialog/checklist.c |   39 +--
 scripts/lxdialog/dialog.h    |   34 ++-
 scripts/lxdialog/inputbox.c  |    5
 scripts/lxdialog/lxdialog.c  |  226 ----------------------
 scripts/lxdialog/menubox.c   |   70 +++----
 scripts/lxdialog/msgbox.c    |    6
 scripts/lxdialog/textbox.c   |    9
 scripts/lxdialog/util.c      |   50 ++++-
 scripts/lxdialog/yesno.c     |    6
 13 files changed, 346 insertions(+), 567 deletions(-)

  Note also that this is the fifth resubmission of the patch. The changes are
mostly based on Roman's suggestions and also some mine minor enhancements. Also
one bug catched by Erik Andersen is fixed.

  Kind regards,
                                Petr Baudis

--- linux/Makefile	Tue Feb  4 15:41:06 2003
+++ linux+pasky/Makefile	Tue Feb  4 23:10:46 2003
@@ -675,8 +675,7 @@
 xconfig: scripts/kconfig/qconf
 	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
 
-menuconfig: scripts/kconfig/mconf
-	$(Q)$(MAKE) $(build)=scripts/lxdialog
+menuconfig: scripts/lxdialog/built-in.o scripts/kconfig/mconf
 	./scripts/kconfig/mconf arch/$(ARCH)/Kconfig
 
 config: scripts/kconfig/conf
@@ -699,6 +698,10 @@
 
 defconfig: scripts/kconfig/conf
 	./scripts/kconfig/conf -d arch/$(ARCH)/Kconfig
+
+scripts/lxdialog/built-in.o: FORCE
+	$(Q)$(MAKE) $(build)=scripts/lxdialog
+
 
 ###
 # Cleaning is done on three levels.
diff -ruN linux/scripts/kconfig/Makefile linux+pasky/scripts/kconfig/Makefile
--- linux/scripts/kconfig/Makefile	Tue Feb  4 15:39:16 2003
+++ linux+pasky/scripts/kconfig/Makefile	Wed Feb  5 03:37:02 2003
@@ -2,7 +2,7 @@
 #
 # Shared Makefile for the various lkc executables:
 # conf:	  Used for defconfig, oldconfig and related targets
-# mconf:  Used for the mconfig target.
+# mconf:  Used for the mconfig target
 #         Utilizes the lxdialog package
 # qconf:  Used for the xconfig target
 #         Based on QT which needs to be installed to compile it
@@ -24,6 +24,11 @@
 # generated files seem to need this to find local include files
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
+
+# See scripts/lxdialog/Makefile header for reason of this:
+$(obj)/mconf.o: $(obj)/../lxdialog/built-in.o
+HOSTLOADLIBES_mconf	= $(obj)/../lxdialog/built-in.o -lncurses
+
 
 HOSTLOADLIBES_qconf	= -L$(QTDIR)/lib -Wl,-rpath,$(QTDIR)/lib -l$(QTLIB) -ldl
 HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include 
diff -ruN linux/scripts/kconfig/mconf.c linux+pasky/scripts/kconfig/mconf.c
--- linux/scripts/kconfig/mconf.c	Tue Feb  4 15:38:25 2003
+++ linux+pasky/scripts/kconfig/mconf.c	Wed Feb  5 03:45:04 2003
@@ -4,6 +4,9 @@
  *
  * Introduced single menu mode (show all sub-menus in one large tree).
  * 2002-11-06 Petr Baudis <pasky@ucw.cz>
+ *
+ * Direct use of liblxdialog library routines.
+ * 2003-02-04 Petr Baudis <pasky@ucw.cz>
  */
 
 #include <sys/ioctl.h>
@@ -19,10 +22,11 @@
 #include <termios.h>
 #include <unistd.h>
 
+#include "../lxdialog/dialog.h"
+
 #define LKC_DIRECT_LINK
 #include "lkc.h"
 
-static char menu_backtitle[128];
 static const char menu_instructions[] =
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus --->.  "
@@ -81,18 +85,17 @@
 	"leave this blank.\n"
 ;
 
-static char buf[4096], *bufptr = buf;
-static char input_buf[4096];
 static char filename[PATH_MAX+1] = ".config";
-static char *args[1024], **argptr = args;
 static int indent = 0;
 static struct termios ios_org;
 static int rows, cols;
 static struct menu *current_menu;
 static int child_count;
-static int do_resize;
 static int single_menu_mode;
 
+static struct dialog_list_item *items[32768]; /* FIXME: This ought to be dynamic. */
+static int item_no;
+
 static void conf(struct menu *menu);
 static void conf_choice(struct menu *menu);
 static void conf_string(struct menu *menu);
@@ -103,11 +106,6 @@
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
@@ -136,6 +134,7 @@
 	}
 
 	if (rows < 19 || cols < 80) {
+		end_dialog();
 		fprintf(stderr, "Your display is too small to run Menuconfig!\n");
 		fprintf(stderr, "It must be at least 19 lines by 80 columns.\n");
 		exit(1);
@@ -145,135 +144,66 @@
 	cols -= 5;
 }
 
-static void cprint_init(void)
+static void creset(void)
 {
-	bufptr = buf;
-	argptr = args;
-	memset(args, 0, sizeof(args));
-	indent = 0;
-	child_count = 0;
-	cprint("./scripts/lxdialog/lxdialog");
-	cprint("--backtitle");
-	cprint(menu_backtitle);
-}
+	int i;
 
-static int cprint1(const char *fmt, ...)
-{
-	va_list ap;
-	int res;
-
-	if (!*argptr)
-		*argptr = bufptr;
-	va_start(ap, fmt);
-	res = vsprintf(bufptr, fmt, ap);
-	va_end(ap);
-	bufptr += res;
+	for (i = 0; i < item_no; i++) {
+		free(items[i]->name);
+		free(items[i]);
+	}
 
-	return res;
+	item_no = 0;
 }
 
-static void cprint_done(void)
+static void cmake(void)
 {
-	*bufptr++ = 0;
-	argptr++;
+	items[item_no] = calloc(1, sizeof(struct dialog_list_item));
+	items[item_no]->name = malloc(512); items[item_no]->name[0] = 0;
+	items[item_no]->namelen = 0;
+	item_no++;
 }
 
-static int cprint(const char *fmt, ...)
+static int cprint_name(const char *fmt, ...)
 {
 	va_list ap;
 	int res;
 
-	*argptr++ = bufptr;
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
-	*bufptr++ = 0;
 
 	return res;
 }
 
-pid_t pid;
-
-static void winch_handler(int sig)
+static int cset_tag(char type, void *ptr)
 {
-	if (!do_resize) {
-		kill(pid, SIGINT);
-		do_resize = 1;
-	}
+	items[item_no - 1]->type = type;
+	items[item_no - 1]->data = ptr;
+	return 0;
 }
 
-static int exec_conf(void)
+static void winch_handler(int sig)
 {
-	int pipefd[2], stat, size;
-	struct sigaction sa;
-	sigset_t sset, osset;
-
-	sigemptyset(&sset);
-	sigaddset(&sset, SIGINT);
-	sigprocmask(SIG_BLOCK, &sset, &osset);
-
-	signal(SIGINT, SIG_DFL);
+	static int lock;
 
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
+	if (!lock) {
+		lock = 1;
+		/* I just can't figure out how to make this thing not to crash
+		 * (it won't crash everytime but at least in 1 of 10 tries).
+		 * FIXME: Something rotten causes stack corruption to us, not a
+		 * good thing to live with. --pasky */
 #if 0
-	printf("\fexit state: %d\nexit data: '%s'\n", WEXITSTATUS(stat), input_buf);
-	sleep(1);
+		init_wsize();
+		resize_dialog(rows + 4, cols + 5);
 #endif
-	sigpending(&sset);
-	if (sigismember(&sset, SIGINT)) {
-		printf("\finterrupted\n");
-		exit(1);
+		lock = 0;
 	}
-	sigprocmask(SIG_SETMASK, &osset, NULL);
-
-	return WEXITSTATUS(stat);
 }
 
 static void build_conf(struct menu *menu)
@@ -296,27 +226,28 @@
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
 				} else {
 					if (menu->parent != &rootmenu)
-						cprint1("   %*c", indent + 1, ' ');
-					cprint1("%s  --->", prompt);
+						cprint_name("   %*c", indent + 1, ' ');
+					cprint_name("%s  --->", prompt);
 				}
 
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
@@ -324,6 +255,7 @@
 		goto conf_childs;
 	}
 
+	cmake();
 	type = sym_get_type(sym);
 	if (sym_is_choice(sym)) {
 		struct symbol *def_sym = sym_get_choice_value(sym);
@@ -337,10 +269,10 @@
 
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
@@ -348,66 +280,61 @@
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
-				cprint1("[%c]", val == no ? ' ' : '*');
+				cset_tag('t', menu);
+				cprint_name("[%c]", val == no ? ' ' : '*');
 				break;
 			case S_TRISTATE:
-				cprint("t%p", menu);
+				cset_tag('t', menu);
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
+				cset_tag('s', menu);
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
@@ -419,62 +346,62 @@
 
 static void conf(struct menu *menu)
 {
-	struct menu *submenu;
+	char active_type = 0; void *active_ptr = NULL;
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
+		creset();
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
+			cmake(); cset_tag(':', NULL); cprint_name("--- ");
+			cmake(); cset_tag('L', NULL); cprint_name("Load an Alternate Configuration File");
+			cmake(); cset_tag('S', NULL); cprint_name("Save Configuration to an Alternate File");
+		}
+		dialog_clear();
+		/* active_item itself can change after any creset() +
+		 * build_conf() :-( */
+		stat = dialog_menu(prompt ? prompt : "Main Menu",
+				menu_instructions, rows, cols, rows - 10,
+				active_type, active_ptr, item_no, items);
+		if (stat < -1)
+			continue; /* Window resized, let's redraw... */
 		if (stat < 0)
-			continue;
+			break;
 
 		if (stat == 1 || stat == 255)
 			break;
 
-		type = input_buf[0];
-		if (!type)
-			continue;
+		{
+			struct dialog_list_item *active_item;
 
-		for (i = 0; input_buf[i] && !isspace(input_buf[i]); i++)
-			;
-		if (i >= sizeof(active_entry))
-			i = sizeof(active_entry) - 1;
-		input_buf[i] = 0;
-		strcpy(active_entry, input_buf);
+			active_item = first_sel_item(item_no, items);
+			if (!active_item)
+				continue;
+			active_item->selected = 0;
+			active_type = active_item->type;
+			active_ptr = active_item->data;
+		}
+
+		if (!active_type)
+			continue;
 
 		sym = NULL;
-		submenu = NULL;
-		if (sscanf(input_buf + 1, "%p", &submenu) == 1)
-			sym = submenu->sym;
+		submenu = active_ptr;
+		if (submenu) sym = submenu->sym;
 
 		switch (stat) {
 		case 0:
-			switch (type) {
+			switch (active_type) {
 			case 'm':
 				if (single_menu_mode)
 					submenu->data = (void *) !submenu->data;
@@ -503,7 +430,7 @@
 				show_readme();
 			break;
 		case 3:
-			if (type == 't') {
+			if (active_type == 't') {
 				if (sym_set_tristate_value(sym, yes))
 					break;
 				if (sym_set_tristate_value(sym, mod))
@@ -511,18 +438,22 @@
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
 		}
 	}
@@ -535,17 +466,8 @@
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
 
@@ -574,13 +496,8 @@
 
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
@@ -588,32 +505,26 @@
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
+		creset();
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
-			cprint("%p", child);
-			cprint("%s", menu_get_prompt(child));
-			cprint(child->sym == active ? "ON" : "OFF");
+			cmake();
+			cset_tag(0, child);
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
+			menu = first_sel_item(item_no, items)->data;
+			if (!menu)
 				break;
 			sym_set_tristate_value(menu->sym, yes);
 			return;
@@ -629,33 +540,30 @@
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
@@ -670,21 +578,13 @@
 
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
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_read(input_buf))
+			if (!conf_read(dialog_input_result))
 				return;
 			show_textbox(NULL, "File does not exist!", 5, 38);
 			break;
@@ -699,21 +599,13 @@
 
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
 		case 0:
-			if (!input_buf[0])
+			if (!dialog_input_result[0])
 				return;
-			if (!conf_write(input_buf))
+			if (!conf_write(dialog_input_result))
 				return;
 			show_textbox(NULL, "Can't create file!  Probably a nonexistent directory.", 5, 60);
 			break;
@@ -742,9 +634,10 @@
 	conf_parse(av[1]);
 	conf_read(NULL);
 
+	backtitle = malloc(128);
 	sym = sym_lookup("KERNELRELEASE", 0);
 	sym_calc_value(sym);
-	sprintf(menu_backtitle, "Linux Kernel v%s Configuration",
+	snprintf(backtitle, 128, "Linux Kernel v%s Configuration",
 		sym_get_string_value(sym));
 
 	mode = getenv("MENUCONFIG_MODE");
@@ -753,19 +646,26 @@
 			single_menu_mode = 1;
 	}
 
+	{
+		struct sigaction sa;
+		sa.sa_handler = winch_handler;
+		sigemptyset(&sa.sa_mask);
+		sa.sa_flags = SA_RESTART;
+		sigaction(SIGWINCH, &sa, NULL);
+	}
+
 	tcgetattr(1, &ios_org);
 	atexit(conf_cleanup);
+	init_dialog();
 	init_wsize();
 	conf(&rootmenu);
 
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
--- linux/scripts/lxdialog/Makefile	Tue Feb  4 15:36:59 2003
+++ linux+pasky/scripts/lxdialog/Makefile	Wed Feb  5 03:36:55 2003
@@ -1,4 +1,18 @@
-HOST_EXTRACFLAGS := -DLOCALE 
+# A little excursion to the grand scheme of things:
+#
+# Unlike how it used to be in the past, now we don't use the external lxdialog
+# utility in make menuconfig, but we link the lxdialog suite directly against
+# mconf. This is a little hackish, though - we want to make up a variation
+# to the "static library" theme for lxdialog, and we have to use standart
+# kbuild tools for that; these are tuned for in-kernel use, though, thus we
+# need to do some flags swaps etc. The resulting object, built-in.o, is then
+# linked against mconf.o inside of scripts/kconfig/Makefile. Also, mconf is
+# linked against ncurses _THERE_, regardless to what you see here in
+# HOST_LOADLIBES; here we merely check for ncurses presence.
+#
+# 2003-02-04 Petr Baudis <pasky@ucw.cz>
+
+HOST_EXTRACFLAGS := -DLOCALE
 HOST_LOADLIBES   := -lncurses
 
 ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
@@ -15,11 +29,13 @@
 endif
 endif
 
-host-progs    := lxdialog
-build-targets := $(host-progs)
 
-lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
-		 util.o lxdialog.o msgbox.o
+# Replace kernel CFLAGS with host CFLAGS, which is what we want in fact.
+CFLAGS := $(HOSTCFLAGS) $(HOST_EXTRACFLAGS)
+NOSTDINC_FLAGS :=
+
+obj-y := checklist.o menubox.o textbox.o yesno.o inputbox.o util.o msgbox.o
+
 
 first_rule: ncurses
 
diff -ruN linux/scripts/lxdialog/checklist.c linux+pasky/scripts/lxdialog/checklist.c
--- linux/scripts/lxdialog/checklist.c	Mon Nov 18 11:30:49 2002
+++ linux+pasky/scripts/lxdialog/checklist.c	Wed Feb  5 02:32:34 2003
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
 
@@ -223,8 +224,11 @@
     while (key != ESC) {
 	key = wgetch (dialog);
 
+	if (should_resize)
+	    do_resize_dialog();
+
     	for (i = 0; i < max_choice; i++)
-            if (toupper(key) == toupper(items[(scroll+i)*3+1][0]))
+            if (toupper(key) == toupper(items[scroll + i]->name[0]))
                 break;
 
 
@@ -237,14 +241,14 @@
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
 
@@ -263,7 +267,7 @@
 		    /* Scroll list up */
 		    if (list_height > 1) {
 			/* De-highlight current last item before scrolling up */
-			print_item (list, items[(scroll + max_choice - 1) * 3 + 1],
+			print_item (list, items[scroll + max_choice - 1]->name,
 				    status[scroll + max_choice - 1],
 				    max_choice - 1, FALSE);
 			scrollok (list, TRUE);
@@ -271,7 +275,7 @@
 			scrollok (list, FALSE);
 		    }
 		    scroll++;
-		    print_item (list, items[(scroll + max_choice - 1) * 3 + 1],
+		    print_item (list, items[scroll + max_choice - 1]->name,
 				status[scroll + max_choice - 1],
 				max_choice - 1, TRUE);
 		    wnoutrefresh (list);
@@ -287,11 +291,11 @@
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
@@ -314,6 +318,8 @@
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (dialog);
 	    break;
+	case KEY_RESIZE:
+	    button = -2;
 	case 'S':
 	case 's':
 	case ' ':
@@ -330,7 +336,7 @@
 			    status[i] = 0;
 			status[scroll + choice] = 1;
 			for (i = 0; i < max_choice; i++)
-			    print_item (list, items[(scroll + i) * 3 + 1],
+			    print_item (list, items[scroll + i]->name,
 					status[scroll + i], i, i == choice);
 		    }
 		}
@@ -338,14 +344,7 @@
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
--- linux/scripts/lxdialog/dialog.h	Mon Nov 18 11:30:49 2002
+++ linux+pasky/scripts/lxdialog/dialog.h	Wed Feb  5 02:22:18 2003
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#ifdef CURSES_LOC
 #include CURSES_LOC
 
 /*
@@ -125,29 +126,39 @@
  * Global variables
  */
 extern bool use_colors;
-extern bool use_shadow;
+extern bool should_resize;
 
 extern chtype attributes[];
+#endif
+
+extern char *backtitle;
 
-extern const char *backtitle;
+struct dialog_list_item {
+	char *name;
+	int namelen;
+	char type;
+	void *data;
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
+void resize_dialog (int rows, int cols);
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
 int dialog_yesno (const char *title, const char *prompt, int height, int width);
@@ -155,15 +166,18 @@
 		int width, int pause);
 int dialog_textbox (const char *title, const char *file, int height, int width);
 int dialog_menu (const char *title, const char *prompt, int height, int width,
-		int menu_height, const char *choice, int item_no, 
-		const char * const * items);
+		int menu_height, const char choice_type, const void *choice_ptr,
+		int item_no, struct dialog_list_item ** items);
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
@@ -173,7 +187,9 @@
  *   -- the lowercase are used to signal mouse-enter events (M_EVENT + 'o')
  *   -- uppercase chars are used to invoke the button (M_EVENT + 'O')
  */
+#ifdef CURSES_LOC
 #define M_EVENT (KEY_MAX+1)
+#endif
 
 
 /*
diff -ruN linux/scripts/lxdialog/inputbox.c linux+pasky/scripts/lxdialog/inputbox.c
--- linux/scripts/lxdialog/inputbox.c	Wed Nov  6 18:46:10 2002
+++ linux+pasky/scripts/lxdialog/inputbox.c	Wed Feb  5 02:32:29 2003
@@ -123,6 +123,9 @@
     while (key != ESC) {
 	key = wgetch (dialog);
 
+	if (should_resize)
+	    do_resize_dialog();
+
 	if (button == -1) {	/* Input box selected */
 	    switch (key) {
 	    case TAB:
@@ -223,6 +226,8 @@
 		break;
 	    }
 	    break;
+	case KEY_RESIZE:
+	    button = -2;
 	case ' ':
 	case '\n':
 	    delwin (dialog);
diff -ruN linux/scripts/lxdialog/lxdialog.c linux+pasky/scripts/lxdialog/lxdialog.c
--- linux/scripts/lxdialog/lxdialog.c	Mon Nov 18 11:30:49 2002
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
--- linux/scripts/lxdialog/menubox.c	Mon Nov 18 11:30:49 2002
+++ linux+pasky/scripts/lxdialog/menubox.c	Wed Feb  5 03:25:50 2003
@@ -93,7 +93,7 @@
     }
     if (selected) {
 	wmove (win, choice, item_x+1);
-	wrefresh (win);
+	wnoutrefresh (win);
     }
 }
 
@@ -164,9 +164,8 @@
  */
 int
 dialog_menu (const char *title, const char *prompt, int height, int width,
-		int menu_height, const char *current, int item_no,
-		const char * const * items)
-
+		int menu_height, const char choice_type, const void *choice_ptr,
+		int item_no, struct dialog_list_item ** items)
 {
     int i, j, x, y, box_x, box_y;
     int key = 0, button = 0, scroll = 0, choice = 0, first_item = 0, max_choice;
@@ -230,8 +229,9 @@
      */
     item_x = 0;
     for (i = 0; i < item_no; i++) {
-	item_x = MAX (item_x, MIN(menu_width, strlen (items[i * 2 + 1]) + 2));
-	if (strcmp(current, items[i*2]) == 0) choice = i;
+	item_x = MAX (item_x, MIN(menu_width, strlen (items[i]->name) + 2));
+	if (choice_type == items[i]->type && choice_ptr == items[i]->data)
+		choice = i;
     }
 
     item_x = (menu_width - item_x) / 2;
@@ -261,8 +261,8 @@
 
     /* Print the menu */
     for (i=0; i < max_choice; i++) {
-	print_item (menu, items[(first_item + i) * 2 + 1], i, i == choice,
-                    (items[(first_item + i)*2][0] != ':'));
+	print_item (menu, items[first_item + i]->name, i, i == choice,
+                    (items[first_item + i]->type != ':'));
     }
 
     wnoutrefresh (menu);
@@ -277,20 +277,23 @@
     while (key != ESC) {
 	key = wgetch(menu);
 
+	if (should_resize)
+	    do_resize_dialog();
+
 	if (key < 256 && isalpha(key)) key = tolower(key);
 
 	if (strchr("ynm", key))
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
@@ -300,8 +303,8 @@
             key == '-' || key == '+' ||
             key == KEY_PPAGE || key == KEY_NPAGE) {
 
-            print_item (menu, items[(scroll+choice)*2+1], choice, FALSE,
-                       (items[(scroll+choice)*2][0] != ':'));
+            print_item (menu, items[scroll + choice]->name, choice, FALSE,
+                       (items[scroll + choice]->type != ':'));
 
 	    if (key == KEY_UP || key == '-') {
                 if (choice < 2 && scroll) {
@@ -312,15 +315,15 @@
 
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
                     (scroll + max_choice < item_no)
@@ -332,9 +335,9 @@
 
                     scroll++;
 
-                    print_item (menu, items[(scroll+max_choice-1)*2+1],
+                    print_item (menu, items[scroll + max_choice - 1]->name,
                                max_choice-1, FALSE,
-                               (items[(scroll+max_choice-1)*2][0] != ':'));
+                               (items[scroll + max_choice - 1]->type != ':'));
                 } else
                     choice = MIN(choice+1, max_choice-1);
 
@@ -344,8 +347,8 @@
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
@@ -360,9 +363,9 @@
 			scroll(menu);
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
@@ -372,8 +375,8 @@
             } else
                 choice = i;
 
-            print_item (menu, items[(scroll+choice)*2+1], choice, TRUE,
-                       (items[(scroll+choice)*2][0] != ':'));
+            print_item (menu, items[scroll + choice]->name, choice, TRUE,
+                       (items[scroll + choice]->type != ':'));
 
             print_arrows(dialog, item_no, scroll,
                          box_y, box_x+item_x+1, menu_height);
@@ -394,18 +397,19 @@
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (menu);
 	    break;
-	case ' ':
+	case KEY_RESIZE:
 	case 's':
 	case 'y':
 	case 'n':
 	case 'm':
+	case ' ':
 	    /* save scroll info */
 	    if ( (f=fopen("lxdialog.scrltmp","w")) != NULL ) {
 		fprintf(f,"%d\n",scroll);
 		fclose(f);
 	    }
 	    delwin (dialog);
-            fprintf(stderr, "%s\n", items[(scroll + choice) * 2]);
+            items[scroll + choice]->selected = 1;
             switch (key) {
             case 's': return 3;
             case 'y': return 3;
@@ -413,19 +417,13 @@
             case 'm': return 5;
             case ' ': return 6;
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
+	    items[scroll + choice]->selected = 1;
 
 	    remove("lxdialog.scrltmp");
 	    return button;
diff -ruN linux/scripts/lxdialog/msgbox.c linux+pasky/scripts/lxdialog/msgbox.c
--- linux/scripts/lxdialog/msgbox.c	Wed Nov  6 18:46:10 2002
+++ linux+pasky/scripts/lxdialog/msgbox.c	Wed Feb  5 02:26:00 2003
@@ -73,8 +73,12 @@
 
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
diff -ruN linux/scripts/lxdialog/textbox.c linux+pasky/scripts/lxdialog/textbox.c
--- linux/scripts/lxdialog/textbox.c	Mon Nov 18 11:30:49 2002
+++ linux+pasky/scripts/lxdialog/textbox.c	Wed Feb  5 02:32:17 2003
@@ -133,7 +133,12 @@
 
     while ((key != ESC) && (key != '\n')) {
 	key = wgetch (dialog);
+
+	if (should_resize)
+	    do_resize_dialog();
+
 	switch (key) {
+	case KEY_RESIZE:
 	case 'E':		/* Exit */
 	case 'e':
 	case 'X':
@@ -141,7 +146,7 @@
 	    delwin (dialog);
 	    free (buf);
 	    close (fd);
-	    return 0;
+	    return key == KEY_RESIZE ? -2 : 0;
 	case 'g':		/* First page */
 	case KEY_HOME:
 	    if (!begin_reached) {
@@ -317,7 +322,7 @@
     delwin (dialog);
     free (buf);
     close (fd);
-    return -1;			/* ESC pressed */
+    return 1;			/* ESC pressed */
 }
 
 /*
diff -ruN linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
--- linux/scripts/lxdialog/util.c	Tue Feb  4 15:36:21 2003
+++ linux+pasky/scripts/lxdialog/util.c	Wed Feb  5 03:41:42 2003
@@ -25,7 +25,7 @@
 /* use colors by default? */
 bool use_colors = 1;
 
-const char *backtitle = NULL;
+char *backtitle = NULL;
 
 const char *dialog_result;
 
@@ -187,6 +187,38 @@
     endwin ();
 }
 
+/*
+ * This is the backend part of the resizing magic. We can't do almost anything
+ * in resize_dialog() since we are most probably in an evil place like a
+ * malloc() --- in fact we can't even ungetch()! And since we have no way how
+ * to interrupt wgetch(), we can't react sooner than after the user presses a
+ * key. Then we will immediatelly call do_resize_dialog(), process the key
+ * pressed by user and next wgetch() should immediatelly yield KEY_RESIZE,
+ * which is going to make the dialog being redrawn. It could look a little
+ * weird when the key pressed by user will close the dialog, well... ;-)
+ */
+
+static int new_rows, new_cols;
+bool should_resize = 0;
+
+void
+resize_dialog (int rows, int cols)
+{
+    should_resize = 1;
+    new_rows = rows;
+    new_cols = cols;
+}
+
+void
+do_resize_dialog ()
+{
+    should_resize = 0;
+    resizeterm(new_rows, new_cols);
+    COLS = new_cols;
+    LINES = new_rows;
+    ungetch(KEY_RESIZE);
+}
+
 
 /*
  * Print a string of text in a window, automatically wrap around to the
@@ -356,4 +388,20 @@
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
diff -ruN linux/scripts/lxdialog/yesno.c linux+pasky/scripts/lxdialog/yesno.c
--- linux/scripts/lxdialog/yesno.c	Wed Nov  6 18:46:10 2002
+++ linux+pasky/scripts/lxdialog/yesno.c	Wed Feb  5 02:32:13 2003
@@ -85,6 +85,10 @@
 
     while (key != ESC) {
 	key = wgetch (dialog);
+
+	if (should_resize)
+	    do_resize_dialog();
+
 	switch (key) {
 	case 'Y':
 	case 'y':
@@ -104,6 +108,8 @@
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (dialog);
 	    break;
+	case KEY_RESIZE:
+	    button = -2;
 	case ' ':
 	case '\n':
 	    delwin (dialog);
