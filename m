Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUFTFIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUFTFIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 01:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUFTFIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 01:08:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:1224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262837AbUFTFH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 01:07:57 -0400
Date: Sat, 19 Jun 2004 22:07:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, vojtech@ucw.cz
Subject: Re: [PATCH 6/11] serio dynamic allocation
Message-Id: <20040619220700.08425715.akpm@osdl.org>
In-Reply-To: <200406180340.55615.dtor_core@ameritech.net>
References: <200406180335.52843.dtor_core@ameritech.net>
	<200406180339.17699.dtor_core@ameritech.net>
	<200406180339.49607.dtor_core@ameritech.net>
	<200406180340.55615.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
>   Input: switch to dynamic (heap) serio port allocation in preparation
>           to sysfs integration. By having all data structures dynamically
>           allocated serio driver modules can be unloaded without waiting
>           for the last reference to the port to be dropped.

This patch causes problems on sparc64:

drivers/input/serio/i8042-sparcio.h: In function `i8042_platform_init':
drivers/input/serio/i8042-sparcio.h:103: error: `i8042_reset' undeclared (first use in this function)
drivers/input/serio/i8042-sparcio.h:103: error: (Each undeclared identifier is reported only once
drivers/input/serio/i8042-sparcio.h:103: error: for each function it appears in.)
drivers/input/serio/i8042.c: At top level:
drivers/input/serio/i8042.c:46: error: `i8042_reset' used prior to declaration

Which will be fixed by this patch:

--- 25-sparc64/drivers/input/serio/i8042.c~input-serio-dynamic-allocation-fix	2004-06-19 21:56:11.972974984 -0700
+++ 25-sparc64-akpm/drivers/input/serio/i8042.c	2004-06-19 21:57:15.454324352 -0700
@@ -25,7 +25,6 @@
 #include <asm/io.h>
 
 #undef DEBUG
-#include "i8042.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
@@ -55,6 +54,8 @@ static unsigned int i8042_dumbkbd;
 module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
+#include "i8042.h"
+
 extern unsigned int i8042_dmi_noloop;
 static unsigned int i8042_noloop;
 extern unsigned int i8042_dmi_noloop;
_


However we still have this:

drivers/input/serio/i8042.c:81: error: initializer element is not constant
drivers/input/serio/i8042.c:81: error: (near initialization for `i8042_kbd_values.irq')
drivers/input/serio/i8042.c:89: error: initializer element is not constant
drivers/input/serio/i8042.c:89: error: (near initialization for `i8042_aux_values.irq')

due to:

static struct i8042_values i8042_kbd_values = {
	.irq 		= I8042_KBD_IRQ,


I8042_KBD_IRQ is not a constant on sparc64.

It seems that simply removing that static initialiser will fix
it up, but I assume it was added for some reason, so I'll leave
you to ponder that.

