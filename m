Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbUJ0WCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUJ0WCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUJ0V7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:59:39 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25526 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262728AbUJ0VsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:48:01 -0400
Date: Wed, 27 Oct 2004 14:48:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zippel@linux-m68k.org, kai@germaschewski.name
Subject: [PATCH 2.6.9] Fix menuconfig on Solaris
Message-ID: <20041027214800.GA7223@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something occured to me after I sent my first round of Solaris patches,
people might want to use 'menuconfig' not just config/oldconfig.  The
following two bits are needed to get it working (not as colorful as on
Linux, but it functions) for me.  First, unless CURS_MACROS is defined,
scroll(x) doesn't get expanded to wscrl(x, 1).  I did some quick
grepping on Cygwin and Linux (debian/unstable) and didn't see
CURS_MACROS show up anywhere else, but to be safe I put it inside of
__sun__.  Next this uses libcurses instead of libncurses otherwise we
get a bunch of undefined refs to w32attrset, w32addch, acs32map and few
more.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.9.orig/scripts/lxdialog/dialog.h
+++ linux-2.6.9/scripts/lxdialog/dialog.h
@@ -26,6 +26,9 @@
 #include <stdlib.h>
 #include <string.h>
 
+#ifdef __sun__
+#define CURS_MACROS
+#endif
 #include CURSES_LOC
 
 /*
--- linux-2.6.9.orig/scripts/lxdialog/Makefile
+++ linux-2.6.9/scripts/lxdialog/Makefile
@@ -1,5 +1,9 @@
 HOST_EXTRACFLAGS := -DLOCALE 
+ifeq ($(shell uname),SunOS)
+HOST_LOADLIBES   := -lcurses
+else
 HOST_LOADLIBES   := -lncurses
+endif
 
 ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
         HOST_EXTRACFLAGS += -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"

-- 
Tom Rini
http://gate.crashing.org/~trini/
