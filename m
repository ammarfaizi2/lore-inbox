Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTIJTfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265523AbTIJTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:33:25 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:17587 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S265525AbTIJTcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:32:00 -0400
Date: Wed, 10 Sep 2003 12:31:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de> <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net> <20030910170610.GH27368@fs.tum.de> <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net> <20030910191038.GK27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910191038.GK27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:10:39PM +0200, Adrian Bunk wrote:
> On Wed, Sep 10, 2003 at 11:59:02AM -0700, Tom Rini wrote:
> > > 
> > > That wouldn't be needed. AFAIK there are _no_ problems if SERIO=y, the 
> > > select you suggest is already implemented the other way round.
> > 
> > The problem is that SERIO==y means that SERIO_I8042 must be Y, as you
> > ran into.  If you have SERIO only asked on EMBEDDED || !X86, and on
> > similar conditions you then select SERIO_I8042, it just works.
> 
> No the problems occur when SERIO=m.

Ah, right, that got fixed for test4.  Now I recall, I think.

> > > If SERIO is always y if !EMBEDDED || X86 my patch wouldn't be needed.
> > 
> > Correct.  I was suggesting that you do:
> > tristate "Serial i/o support (needed for keyboard and mouse)" if
> > !EMBEDDED || !X86  (or so)
> > select SERIO_I8042 if X86 && !EMBEDDED
> > 
> > and then remove the conditions on SERIO_I8042, which puts all of the
> > auto-select-this magic in one spot.
> 
> I can't see how this should work in all cases.
> Could you send how you'd like to formulate this?

This is done in the patch I sent to break EMBEDDED into STANDARD and
NONSTD_ABI.  There it looks like (just the keyboard bits):
===== drivers/input/Kconfig 1.5 vs edited =====
--- 1.5/drivers/input/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/input/Kconfig	Fri Sep  5 14:45:36 2003
@@ -5,7 +5,9 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Input devices (needed for keyboard, mouse, ...)"
+	select INPUT_MOUSEDEV if STANDARD
+	select INPUT_KEYBOARD if STANDARD && X86
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
[snip]
===== drivers/input/keyboard/Kconfig 1.6 vs edited =====
--- 1.6/drivers/input/keyboard/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/input/keyboard/Kconfig	Fri Sep  5 14:45:36 2003
@@ -2,8 +2,9 @@
 # Input core configuration
 #
 config INPUT_KEYBOARD
-	bool "Keyboards" if EMBEDDED || !X86
+	bool "Keyboards"
 	default y
+	select KEYBOARD_ATKBD if STANDARD && X86
 	depends on INPUT
 	help
 	  Say Y here, and a list of supported keyboards will be displayed.
@@ -12,7 +13,7 @@
 	  If unsure, say Y.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard support" if EMBEDDED || !X86 
+	tristate "AT keyboard support"
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
===== drivers/input/serio/Kconfig 1.9 vs edited =====
--- 1.9/drivers/input/serio/Kconfig	Wed Jul 16 10:39:32 2003
+++ edited/drivers/input/serio/Kconfig	Fri Sep  5 14:45:36 2003
@@ -2,7 +2,8 @@
 # Input core configuration
 #
 config SERIO
-	tristate "Serial i/o support (needed for keyboard and mouse)"
+	tristate "Serial i/o support (needed for keyboard and mouse)" if !(STANDARD && X86)
+	select SERIO_I8042 if STANDARD && X86
 	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
@@ -19,7 +20,7 @@
 	  as a module, say M here and read <file:Documentation/modules.txt>.
 
 config SERIO_I8042
-	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
+	tristate "i8042 PC Keyboard controller"
 	default y
 	depends on SERIO
 	---help---


Where STANDARD is normally Y and NONSTD_ABI is normally N.  This groups
all of the "Well, we're standard so we want a keyboard" logic into 3
places.  Really what could be done is in the question for STANDARD,
selecting all of the things at once.  But I'm not sure if that really
helps or hurts, so I didn't do it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
