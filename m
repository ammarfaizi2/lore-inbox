Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTAVIfS>; Wed, 22 Jan 2003 03:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTAVIfS>; Wed, 22 Jan 2003 03:35:18 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:24015 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267385AbTAVIfQ>; Wed, 22 Jan 2003 03:35:16 -0500
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0301211749390.5658-100000@spit.local>
	<87el76avlf.fsf@goat.bogus.local> <3E2E0874.1B95BA77@linux-m68k.org>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] restore modules compatibility
Date: Wed, 22 Jan 2003 09:44:02 +0100
Message-ID: <87y95da819.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> Olaf Dietsche wrote:
>
>> Although, "patch -l" applies without failures.
>
> Damn, another unpatched pine...
> The patch is also available from
> http://www.xs4all.nl/~zippel/modules-2.5.59.diff

Thanks, applies without errors now.

However, there is a problem with MODULE_PARM() vs. declaration order:

  gcc -Wp,-MD,drivers/input/keyboard/.atkbd.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=atkbd -DKBUILD_MODNAME=atkbd   -c -o drivers/input/keyboard/atkbd.o drivers/input/keyboard/atkbd.c
drivers/input/keyboard/atkbd.c:24: `atkbd_set' undeclared here (not in a function)
drivers/input/keyboard/atkbd.c:24: initializer element is not constant
drivers/input/keyboard/atkbd.c:24: (near initialization for `__module_param_atkbd_set.addr')
drivers/input/keyboard/atkbd.c:25: `atkbd_reset' undeclared here (not in a function)
drivers/input/keyboard/atkbd.c:25: initializer element is not constant
drivers/input/keyboard/atkbd.c:25: (near initialization for `__module_param_atkbd_reset.addr')
[...]
  gcc -Wp,-MD,drivers/input/serio/.i8042.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=i8042 -DKBUILD_MODNAME=i8042   -c -o drivers/input/serio/i8042.o drivers/input/serio/i8042.c
drivers/input/serio/i8042.c:28: `i8042_noaux' undeclared here (not in a function)
drivers/input/serio/i8042.c:28: initializer element is not constant
drivers/input/serio/i8042.c:28: (near initialization for `__module_param_i8042_noaux.addr')
drivers/input/serio/i8042.c:29: `i8042_nomux' undeclared here (not in a function)
drivers/input/serio/i8042.c:29: initializer element is not constant
drivers/input/serio/i8042.c:29: (near initialization for `__module_param_i8042_nomux.addr')
[...]
drivers/input/mouse/psmouse.c:23: `psmouse_noext' ...

When the associated variables are declared after the MODULE_PARM(),
you get this error. There may be more of this kind.

I fixed this by moving the declarations, see patch below.

Regards, Olaf.

--- a/drivers/input/keyboard/atkbd.c	Tue Jan 21 22:49:36 2003
+++ b/drivers/input/keyboard/atkbd.c	Wed Jan 22 09:30:22 2003
@@ -19,18 +19,18 @@
 #include <linux/serio.h>
 #include <linux/workqueue.h>
 
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
-MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
-MODULE_PARM(atkbd_set, "1i");
-MODULE_PARM(atkbd_reset, "1i");
-MODULE_LICENSE("GPL");
-
 static int atkbd_set = 2;
 #if defined(__i386__) || defined (__x86_64__)
 static int atkbd_reset;
 #else
 static int atkbd_reset = 1;
 #endif
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
+MODULE_PARM(atkbd_set, "1i");
+MODULE_PARM(atkbd_reset, "1i");
+MODULE_LICENSE("GPL");
 
 /*
  * Scancode to keycode tables. These are just the default setting, and
--- a/drivers/input/serio/i8042.c	Tue Jan 21 22:49:36 2003
+++ b/drivers/input/serio/i8042.c	Wed Jan 22 09:29:51 2003
@@ -25,19 +25,19 @@
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(i8042_noaux, "1i");
-MODULE_PARM(i8042_nomux, "1i");
-MODULE_PARM(i8042_unlock, "1i");
-MODULE_PARM(i8042_reset, "1i");
-MODULE_PARM(i8042_direct, "1i");
-MODULE_PARM(i8042_dumbkbd, "1i");
-
 static int i8042_reset;
 static int i8042_noaux;
 static int i8042_nomux;
 static int i8042_unlock;
 static int i8042_direct;
 static int i8042_dumbkbd;
+
+MODULE_PARM(i8042_noaux, "1i");
+MODULE_PARM(i8042_nomux, "1i");
+MODULE_PARM(i8042_unlock, "1i");
+MODULE_PARM(i8042_reset, "1i");
+MODULE_PARM(i8042_direct, "1i");
+MODULE_PARM(i8042_dumbkbd, "1i");
 
 #undef DEBUG
 #include "i8042.h"
--- a/drivers/input/mouse/psmouse.c	Tue Jan 21 22:51:23 2003
+++ b/drivers/input/mouse/psmouse.c	Wed Jan 22 09:36:58 2003
@@ -18,12 +18,12 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+static int psmouse_noext;
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
 MODULE_PARM(psmouse_noext, "1i");
 MODULE_LICENSE("GPL");
-
-static int psmouse_noext;
 
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETRES	0x10e8
