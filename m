Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUHTPIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUHTPIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUHTPHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:07:45 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:25532 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268169AbUHTPGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:06:19 -0400
Date: Fri, 20 Aug 2004 17:05:43 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: includes cleanup.
In-Reply-To: <20040819143907.GA4236@redhat.com>
Message-ID: <Pine.LNX.4.53.0408201653110.1940@gockel.physik3.uni-rostock.de>
References: <20040819143907.GA4236@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Dave Jones wrote:

> I noticed that every file that could be built as a module was sucking
> in sched.h (and therefore, every other include file under the sun).
> 
> This patch
> - removes the sched.h from module.h
> - Moves the capable() definition from sched.h to capability.h
> - split out the wake_up_* stuff to linux/wakeup.h
> - Removed sched.h includes from a bunch of drivers that didn't
>   need it due to the above work.
> - Fixes up all the breakage I was able to find under x86.
>   Fixing other arch's is simple enough, they just need to include
>   sched.h explicity in a few places now (or jiffies.h, or capability.h or wakeup.h))
> 
> I've not done any measurements to see if this is noticable on a compile,
> as I'd expect it to be mostly in the noise anyway (though last time I
> did this in 2.5.early, it did shave off the best part of a minute off
> my worst-case-scenario build), but untangling the spaghetti of includes
> a little should at least mean gcc uses less memory during the build.
> 
> comments?


Hey, it's includes cleanup time again?
I've postponed my work in late 2.5 for 2.7, but with the new development 
model it seems we are asked to destabilize 2.6 instead ;-)

Patch looks good to me, I also had a patch waiting to move capable() to 
where it belongs. So I went to the attic and started my kludgy old scripts 
on your updated patch. I really should try to dust them of and understand 
them again...

Some driver fixups to it that look valid at a short first glance are 
below.

Tim


--- linux-2.6.8.1-sr1/drivers/char/efirtc.c	2004-04-04 05:37:37.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/char/efirtc.c	2004-08-20 16:28:26.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/rtc.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/capability.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>

--- linux-2.6.8.1-sr1/drivers/char/watchdog/shwdt.c	2004-08-17 21:38:52.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/char/watchdog/shwdt.c	2004-08-20 16:31:40.000000000 +0200
@@ -28,6 +28,8 @@
 #include <linux/notifier.h>
 #include <linux/ioport.h>
 #include <linux/fs.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>

--- linux-2.6.8.1-sr1/drivers/input/gameport/gameport.c	2004-08-17 00:13:33.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/input/gameport/gameport.c	2004-08-20 16:32:15.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Generic gameport layer");

--- linux-2.6.8.1-sr1/drivers/macintosh/ans-lcd.c	2004-08-17 21:38:52.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/macintosh/ans-lcd.c	2004-08-20 16:32:47.000000000 +0200
@@ -9,6 +9,7 @@
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 #include <asm/sections.h>
 #include <asm/prom.h>

--- linux-2.6.8.1-sr1/drivers/media/dvb/frontends/dst.c	2004-08-17 00:13:25.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/media/dvb/frontends/dst.c	2004-08-20 16:33:12.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"

--- linux-2.6.8.1-sr1/drivers/media/dvb/frontends/grundig_29504-491.c	2004-08-17 00:13:25.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/media/dvb/frontends/grundig_29504-491.c	2004-08-20 16:33:36.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"

--- linux-2.6.8.1-sr1/drivers/media/dvb/frontends/stv0299.c	2004-08-17 21:38:52.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/media/dvb/frontends/stv0299.c	2004-08-20 16:34:01.000000000 +0200
@@ -50,6 +50,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"

--- linux-2.6.8.1-sr1/drivers/media/dvb/frontends/tda1004x.c	2004-08-17 21:38:52.000000000 +0200
+++ linux-2.6.8.1-sr2/drivers/media/dvb/frontends/tda1004x.c	2004-08-20 16:34:29.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include <linux/syscalls.h>
+#include <linux/jiffies.h>
 
 #include "dvb_frontend.h"
 #include "dvb_functions.h"
