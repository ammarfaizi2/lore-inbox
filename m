Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTJYL0w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 07:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTJYL0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 07:26:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:56836 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262574AbTJYL0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 07:26:49 -0400
Date: Sat, 25 Oct 2003 13:26:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kconfig choice menu help text is not working in -test8
Message-ID: <20031025112637.GA901@mars.ravnborg.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200310250244.56881.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310250244.56881.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 02:44:56AM -0500, Rob Landley wrote:
> I'm banging away on the bzip patch, adding a choice menu to kconfig for 
> bzip/gzip/uncompressed, and I notice that the help text isn't working right.

Anders Gustafsson <andersg@0x63.nu> posted this patch some time ago.
I never came around testing it.

	Sam

ChangeSet@1.1292, 2003-08-24 22:22:55+02:00, andersg@0x63.nu
  Make menuconfig display helptext in "choice" menus.


 kconfig/mconf.c      |   20 ++++++++++++++++----
 lxdialog/checklist.c |    3 ++-
 2 files changed, 18 insertions(+), 5 deletions(-)


diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	Sun Aug 24 22:26:52 2003
+++ b/scripts/kconfig/mconf.c	Sun Aug 24 22:26:52 2003
@@ -607,6 +607,7 @@
 	struct symbol *active;
 	int stat;
 
+	active = sym_get_choice_value(menu->sym);
 	while (1) {
 		cprint_init();
 		cprint("--title");
@@ -618,13 +619,18 @@
 		cprint("6");
 
 		current_menu = menu;
-		active = sym_get_choice_value(menu->sym);
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
 			cprint("%p", child);
 			cprint("%s", menu_get_prompt(child));
-			cprint(child->sym == active ? "ON" : "OFF");
+			if (sym_get_choice_value(menu->sym) == child->sym) {
+				cprint("ON");
+			}else if (active== child->sym) {
+				cprint("SELECTED");
+			}else{
+				cprint("OFF");
+			}
 		}
 
 		stat = exec_conf();
@@ -634,9 +640,15 @@
 				break;
 			sym_set_tristate_value(menu->sym, yes);
 			return;
-		case 1:
-			show_help(menu);
+		case 1: {
+			struct menu *tmp;
+			if (sscanf(input_buf, "%p", &tmp) == 1) {
+				show_help(tmp);
+				active=tmp->sym;
+			} else
+				show_help(menu);
 			break;
+		}
 		case 255:
 			return;
 		}
diff -Nru a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
--- a/scripts/lxdialog/checklist.c	Sun Aug 24 22:26:52 2003
+++ b/scripts/lxdialog/checklist.c	Sun Aug 24 22:26:52 2003
@@ -138,7 +138,7 @@
     /* Initializes status */
     for (i = 0; i < item_no; i++) {
 	status[i] = !strcasecmp (items[i * 3 + 2], "on");
-	if (!choice && status[i])
+	if ((!choice && status[i]) || (!strcasecmp (items[i * 3 + 2], "selected")))
             choice = i;
     }
 
@@ -302,6 +302,7 @@
 	case 'H':
 	case 'h':
 	case '?':
+	    fprintf (stderr, "%s", items[(scroll + choice) * 3]);
 	    delwin (dialog);
 	    free (status);
 	    return 1;

