Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbQKTKxL>; Mon, 20 Nov 2000 05:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131396AbQKTKxB>; Mon, 20 Nov 2000 05:53:01 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:14084 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130067AbQKTKwn>; Mon, 20 Nov 2000 05:52:43 -0500
Date: Mon, 20 Nov 2000 11:22:30 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <slrn91fjfh.dta.kraxel@bogomips.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.21.0011201104040.1972-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2000, Gerd Knorr wrote:

> Some generic way to make module args available as kernel args too
> would be nice.  Or at least some simple one-liner I could put next to
> the MODULE_PARM() macro...

Well, I did a patch that does automagically convert MODULE_PARAM
stuff to __setup() functions - it even was in some 2.3.XX-acXX
but appearantly never got into Linus tree.

You may want to look at the "[PATCH] final support for MODULE_PARAM as
kernel commandline" thread, as well as "Re: Linux 2.3.18ac5". To look
at the newest version of the patch just grap the newest 2.3.18acXX,
I tried to rip it out and attached it (but I'm sure it does not
apply cleanly, but you get the idea).

It would be nice to hear from Linus if it was him, who rejected the
change or it was Alan who did not bother to send it.

Richard. 

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

diff -u --new-file --recursive --exclude-from ../exclude linux.vanilla/include/linux/module.h linux.ac/include/linux/module.h
--- linux.vanilla/include/linux/module.h	Tue Aug 17 17:27:42 1999
+++ linux.ac/include/linux/module.h	Wed Sep 22 17:00:20 1999
@@ -8,6 +8,7 @@
 #define _LINUX_MODULE_H
 
 #include <linux/config.h>
+#include <linux/init.h>
 
 #ifdef __GENKSYMS__
 #  define _set_ver(sym) sym
@@ -207,11 +208,17 @@
 #endif
 
 #else /* MODULE */
-
+extern int parse_parameters(void *var, char *type, char *str);
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
-#define MODULE_PARM(var,type)
+#define MODULE_PARM(var,type) \
+static char *modparm##var##_setup_type __initdata = type;\
+static int __init modparm##var##_setup(char *str)\
+{\
+  return parse_parameters((void *)&var, modparm##var##_setup_type, str);\
+}\
+__setup(MODULE_NAME #var "=", modparm##var##_setup);
 #define MODULE_PARM_DESC(var,desc)
 
 #ifndef __GENKSYMS__
diff -u --new-file --recursive --exclude-from ../exclude linux.vanilla/lib/Makefile linux.ac/lib/Makefile
--- linux.vanilla/lib/Makefile	Mon Nov 27 13:54:00 1995
+++ linux.ac/lib/Makefile	Mon Sep 13 00:04:31 1999
@@ -7,6 +7,6 @@
 #
 
 L_TARGET := lib.a
-L_OBJS   := errno.o ctype.o string.o vsprintf.o
+L_OBJS   := errno.o ctype.o string.o vsprintf.o parse.o
 
 include $(TOPDIR)/Rules.make
diff -u --new-file --recursive --exclude-from ../exclude linux.vanilla/lib/parse.c linux.ac/lib/parse.c
--- linux.vanilla/lib/parse.c	Thu Jan  1 01:00:00 1970
+++ linux.ac/lib/parse.c	Mon Sep 13 01:57:36 1999
@@ -0,0 +1,119 @@
+/*
+ *  linux/lib/parse.c
+ *
+ *  (C) Richard Guenther <richard.guenther@student.uni-tuebingen.de>
+ *
+ *  Heavily based on parts of modutil's insmod.c which is
+ *
+ *  Copyright 1996, 1997 Linux International.
+ *
+ *  New implementation contributed by Richard Henderson <rth@tamu.edu>
+ *  Based on original work by Bjorn Eckwall <bj0rn@blox.se>
+ *
+ *  This file is part of the Linux modutils.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software Foundation,
+ *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Fixes:
+ * 	Alan Cox		Make it get non arrays right.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+
+/* parse module parameters like insmod */
+int parse_parameters(void *var, char *type, char *str)
+{
+	char *p, t;
+	long min, max, val, cnt;
+	int array = 0;
+	
+	p = type;
+	if (isdigit(*p)) {
+		min = simple_strtoul(p, &p, 0);
+		if (*p == '-')
+		{
+			max = simple_strtoul(p+1, &p, 0);
+			array=1;
+		}
+		else
+			max = min;
+	} else
+		min = max = 1;
+	t = *p;
+	
+	/*
+	 *	We are passed a pointer to the object. Now the object
+	 *	could be an array, in which case we have a pointer to
+	 *	a pointer. It might be a direct value in which case
+	 *	we have a pointer the value to write.
+	 *
+	 *	For an array we want to the array base, for a non array
+	 *	pass, we want the value
+	 *
+	 *	Alan.
+	 */
+	 
+	if(array)
+		var=*(void **)var;
+
+	p = str;
+	cnt = 0;
+	do {
+		if (*p == ',') {
+			p++;
+			cnt++;
+			continue;
+		}
+		switch (t) {
+		case 'b':
+			val = simple_strtol(p, &p, 0);
+			((char *)var)[cnt] = (char)val;
+			break;
+		case 'h':
+			val = simple_strtol(p, &p, 0);
+			((short *)var)[cnt] = (short)val;
+			break;
+		case 'i':
+			val = simple_strtol(p, &p, 0);
+			((int *)var)[cnt] = (int)val;
+			break;
+		case 'l':
+			val = simple_strtol(p, &p, 0);
+			((long *)var)[cnt] = (long)val;
+			break;
+		case 's':
+			/* complex quoting is not possible, as parse_options()
+			 * just searches for ' ', so we can safely just leech
+			 * the whole string (multiple strings are impossible, too)
+			 * - where do we check for overflows?? */
+			strcpy((char *)(var), p);
+			break;
+		default:
+			printk(KERN_INFO "error in parsing arguments \"%s\" using format %s\n", str, type);
+			return 0;
+		}
+		if (*p == ',')
+			p++;
+		cnt++;
+	} while (*p && cnt < max);
+
+	return 1;
+}
+
+
+
+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
