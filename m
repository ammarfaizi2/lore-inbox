Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272913AbRIMHrp>; Thu, 13 Sep 2001 03:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272915AbRIMHrf>; Thu, 13 Sep 2001 03:47:35 -0400
Received: from aemiaif.lip6.fr ([132.227.74.10]:19982 "EHLO aemiaif.lip6.fr")
	by vger.kernel.org with ESMTP id <S272913AbRIMHrT>;
	Thu, 13 Sep 2001 03:47:19 -0400
Subject: Re: Linux-2.2.20pre10
To: alan@lxorguk.ukuu.org
Date: Thu, 13 Sep 2001 08:59:38 +0200 (CEST)
CC: ratz@tac.ch, kai@tp1.ruhr-uni-bochum.de, rml@tech9.net,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15hQTK-0002hd-00@aemiaif.lip6.fr>
From: Willy TARREAU <tarreau@aemiaif.lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define MAX_ETH_CARDS 16
> +#define MAX_ETH_CARDS 32

I'd like this one in the kernel too since I've also patched
it (although I set it to 64 not to worry anymore). It's not
uncommon to put 4 or 5 quad ethernet cards into a system
that already hosts an on-board interface. I think that at
spare time, I'll backport net_init.c from 2.4 which doesn't
have sort of these limitations.

BTW, there are also a few very little patches that would 
have to be considered :

Kai Germaschewski proposed this single-liner fix for HiSax
that could not be linked into the kernel, but I don't see it 
here (perhaps he simply forgot it, or perhaps I'm wrong) :

--- linux/drivers/isdn/hisax/config.c   Fri Sep  7 20:33:48 2001
+++ linux/drivers/isdn/hisax/config.c   Fri Sep  7 20:59:59 2001
@@ -436,7 +436,7 @@
 }
  
 #ifndef MODULE
-static void __init
+void __init
 HiSax_setup(char *str, int *ints)
 {
	int i, j, argc;


I also found that sometimes, menuconfig didn't refresh correctly (in the CPU
dialog window). This patch fixes it for me :

--- linux-2.2.19/scripts/lxdialog/checklist.c   Wed Mar 28 18:00:02 2001
+++ linux-2.2.19-wt1/scripts/lxdialog/checklist.c       Mon Feb  1 21:03:20 1999
@@ -108,8 +104,8 @@
     print_button (dialog, "Select", y, x, selected == 0);
     print_button (dialog, " Help ", y, x + 14, selected == 1);

-    /*    wmove(dialog, y, x+1 + 14*selected);
-    wrefresh (dialog);*/
+    /*    wmove(dialog, y, x+1 + 14*selected);*/
+    wrefresh (dialog);
 }

 /*


This one, back-ported from 2.4, avoids eventual problems with parenthesis
in menuconfig choices :

--- 2.2.19-wt3-O12/scripts/Menuconfig   Wed Jun  6 00:02:45 2001
+++ 2.2.19-wt3-O13/scripts/Menuconfig   Wed Jun  6 00:21:29 2001
@@ -347,7 +347,7 @@
 
 	echo -e "
 	function $firstchoice () \
-               { l_choice '$title' \"$choices\" $current ;}" >>MCradiolists
+               { l_choice '$title' \"$choices\" \"$current\" ;}" >>MCradiolists
 }

 } # END load_functions()

Robert M. Love pointed out that the command line parse could forget arguments
if either MAX_INIT_ENVS or MAX_INIT_ARGS were reached, and his patch seems to
fix it correctly :

--- linux-2.2.19-wt5-OE/init/main.c     Sat Sep  8 23:11:00 2001
+++ linux-2.2.19-wt5-OF/init/main.c     Sat Sep  8 23:24:13 2001
@@ -1292,11 +1292,11 @@
                 */
 		if (strchr(line,'=')) {
 			if (envs >= MAX_INIT_ENVS)
-                               break;
+                               continue;
 			envp_init[++envs] = line;
  		} else {
 			if (args >= MAX_INIT_ARGS)
-                               break;
+                               continue;
  			argv_init[++args] = line;
 		}
 	}


Well, that's all for now ; I think that none of them is at risk, so if you
could apply them, that'd be great.

Thanks,
Willy

