Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316718AbSEQWvD>; Fri, 17 May 2002 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316719AbSEQWvC>; Fri, 17 May 2002 18:51:02 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:51461 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S316718AbSEQWvB>; Fri, 17 May 2002 18:51:01 -0400
Date: Fri, 17 May 2002 16:50:51 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org, Marcelo Tossati <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Compilation trouble in drivers/video
Message-ID: <20020517165051.A6114@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a compilation issue in 'drivers/video'.  Namely 'fbgen.o' is
used by some other objects ('pm2fb.o', 'pm3fb.o', 'clgenfb.o',
'tridentfb.o', 'tgafb.o', 'stifb.o').  Now if at least one of these
"users" is configured as built-in, implying that fbgen.o will be compiled
as an integral part of a kernel, and some other(s) as modules then you
will see from 'depmod' complaints about unresolved symbols for functions
provided by fbgen.

A fix is obvious.  Add missing EXPORT_SYMBOL(...) to 'fbgen.c' and
'fbgen.o' to a list of export-objs in drivers/video/Makefile.
Here is a patch (for 2.4.19-pre8 but this did not really change
for quite a while).


--- linux-2.4.19-pre/drivers/video/fbgen.c~	Wed Mar 27 17:03:46 2002
+++ linux-2.4.19-pre/drivers/video/fbgen.c	Fri May 17 16:08:17 2002
@@ -448,3 +448,21 @@
 	fbgen_install_cmap(currcon, info2);
 }
 MODULE_LICENSE("GPL");
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(fbgen_get_var);
+EXPORT_SYMBOL(fbgen_get_cmap);
+EXPORT_SYMBOL(fbgen_get_fix);
+EXPORT_SYMBOL(fbgen_set_var);
+EXPORT_SYMBOL(fbgen_set_cmap);
+EXPORT_SYMBOL(fbgen_set_disp);
+EXPORT_SYMBOL(fbgen_install_cmap);
+EXPORT_SYMBOL(fbgen_pan_display);
+EXPORT_SYMBOL(fbgen_update_var);
+EXPORT_SYMBOL(fbgen_do_set_var);
+EXPORT_SYMBOL(fbgen_switch);
+EXPORT_SYMBOL(fbgen_blank);
--- linux-2.4.19-pre/drivers/video/Makefile~	Sat Mar 30 11:07:18 2002
+++ linux-2.4.19-pre/drivers/video/Makefile	Fri May 17 16:08:50 2002
@@ -15,7 +15,7 @@
 		  fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		  fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
 		  fbcon-cfb8.o fbcon-mac.o fbcon-mfb.o \
-		  cyber2000fb.o sa1100fb.o fbcon-hga.o
+		  cyber2000fb.o sa1100fb.o fbcon-hga.o fbgen.o
 
 # Each configuration option enables a list of files.

   Michal

 
