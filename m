Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWEGPsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWEGPsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 11:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWEGPsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 11:48:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:43037 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932166AbWEGPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 11:48:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L/VRw8z3slfA39AvEmsvAyGw4ea9sfvEf24C1TYNPgQh9PVA3VBQH0/XFbAk6gg8K2fwekKcVPUVjWuHX+TJPviqvLLSIe1AtMnqMSYbQN/QPvfg0Qn6d5omfibciWoMOhj0x/AEqZdIiKAd7Fm96Tqil8ylh2c2rexch4FsRJY=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] a few small mconf improvements
Date: Sun, 7 May 2006 17:49:28 +0200
User-Agent: KMail/1.9.1
Cc: Roman Zippel <zippel@linux-m68k.org>, Petr Baudis <pasky@ucw.cz>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Sam Ravnborg <sam@ravnborg.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071749.28822.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just took a look at scripts/kconfig/mconf.c and found a few tiny things 
that I feel could be improved. So below is a patch for those.

The patch makes the following changes : 

 - use EXIT_SUCCESS/EXIT_FAILURE in place of 0/1.

 - rename main() arguments from "ac"/"av" to the more common "argc"/"argv".

 - when unlinking lxdialog.scrltmp, the return value of unlink() is not 
   checked. The patch adds a check of the return value and bails out if 
   unlink() fails for any reason other than ENOENT.

 - if the sscanf() call in conf() fails and stat==0 && type=='t', then 
   we'll end up dereferencing a NULL 'sym' in sym_is_choice(). The patch 
   adds a NULL check of 'sym' to that path and bails out with a big fat 
   error message if that should ever happen (better than just crashing 
   IMHO).

 - change the type if the 'i' variable in conf() from 'int' to 
   'unsigned int' to avoid a "comparison between signed and unsigned" 
   warning if building with gcc -W. Given the use of 'i', 'unsigned' is 
   also the logical type to use.

Please consider for inclusion.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 scripts/kconfig/mconf.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

--- linux-2.6.17-rc3-git12-orig/scripts/kconfig/mconf.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc3-git12/scripts/kconfig/mconf.c	2006-05-07 17:34:47.000000000 +0200
@@ -311,7 +311,7 @@ static void init_wsize(void)
 	if (rows < 19 || cols < 80) {
 		fprintf(stderr, N_("Your display is too small to run Menuconfig!\n"));
 		fprintf(stderr, N_("It must be at least 19 lines by 80 columns.\n"));
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 
 	rows -= 4;
@@ -505,7 +505,7 @@ static int exec_conf(void)
 	}
 	if (WIFSIGNALED(stat)) {
 		printf("\finterrupted(%d)\n", WTERMSIG(stat));
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 #if 0
 	printf("\fexit state: %d\nexit data: '%s'\n", WEXITSTATUS(stat), input_buf);
@@ -514,7 +514,7 @@ static int exec_conf(void)
 	sigpending(&sset);
 	if (sigismember(&sset, SIGINT)) {
 		printf("\finterrupted\n");
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 	sigprocmask(SIG_SETMASK, &osset, NULL);
 
@@ -718,9 +718,14 @@ static void conf(struct menu *menu)
 	const char *prompt = menu_get_prompt(menu);
 	struct symbol *sym;
 	char active_entry[40];
-	int stat, type, i;
+	int stat, type;
+	unsigned int i;
 
-	unlink("lxdialog.scrltmp");
+	if (unlink("lxdialog.scrltmp") == -1 && errno != ENOENT) {
+		fprintf(stderr, "mconf error, unable to unlink "
+			"lxdialog.scrltmp : %s\n", strerror(errno));
+		exit(EXIT_FAILURE);
+	}
 	active_entry[0] = 0;
 	while (1) {
 		cprint_init();
@@ -777,6 +782,12 @@ static void conf(struct menu *menu)
 					conf(submenu);
 				break;
 			case 't':
+				if (!sym) {
+					fprintf(stderr, "mconf error: "
+						"expected a symbol, got NULL."
+						" Something's badly broken\n");
+					exit(EXIT_FAILURE);
+				}
 				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
 					conf_choice(submenu);
 				else if (submenu->prompt->type == P_MENU)
@@ -1038,7 +1049,7 @@ static void conf_cleanup(void)
 	unlink("lxdialog.scrltmp");
 }
 
-int main(int ac, char **av)
+int main(int argc, char **argv)
 {
 	struct symbol *sym;
 	char *mode;
@@ -1048,7 +1059,7 @@ int main(int ac, char **av)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	conf_parse(av[1]);
+	conf_parse(argv[1]);
 	conf_read(NULL);
 
 	sym = sym_lookup("KERNELVERSION", 0);
@@ -1094,5 +1105,5 @@ int main(int ac, char **av)
 			"\n\n"));
 	}
 
-	return 0;
+	return EXIT_SUCCESS;
 }


