Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTI1TPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbTI1TPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:15:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12560 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262690AbTI1TPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:15:20 -0400
Date: Sun, 28 Sep 2003 20:15:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: CONFIG_I8042
Message-ID: <20030928201516.D1428@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Roman Zippel <zippel@linux-m68k.org>
References: <20030928194511.C1428@flint.arm.linux.org.uk> <Pine.LNX.4.44.0309281148350.15408-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309281148350.15408-100000@home.osdl.org>; from torvalds@osdl.org on Sun, Sep 28, 2003 at 11:49:45AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 11:49:45AM -0700, Linus Torvalds wrote:
> 
> On Sun, 28 Sep 2003, Russell King wrote:
> > 
> > It appears that "select" doesn't accept conditionals as the kconfig
> > language stands - jejb also ran into this issue, and tried various
> > ways around.  The only solution which seems to work is to remove this
> > select line entirely.
> 
> That is WRONG.

I don't think you've interpreted what I've said correctly.  I'm not
arguing at all about SERIO itself.  In fact, I completely agree that
selecting KEYBOARD_ATKBD should automatically select SERIO since
atkbd.c uses serio.c.

The information I received today from James Bottomley, who is also
seeing this issue, is that the following construct resulted in
I8042 being unconditionally selected:

config KEYBOARD_ATKBD
	...
	select SERIO
	select SERIO_I8042 if X86

However, I've just decided to try it myself, and it does indeed work
as expected.  Here's a (tested on non-x86) patch which fixes this issue
and gives us the correct behaviour for non-x86 platforms, and should
also give the desired behaviour for x86 and embedded platforms.

--- orig/drivers/input/keyboard/Kconfig	Sun Sep 28 09:54:29 2003
+++ linux/drivers/input/keyboard/Kconfig	Sun Sep 28 20:06:40 2003
@@ -15,7 +15,8 @@
 	tristate "AT keyboard support" if EMBEDDED || !X86 
 	default y
 	depends on INPUT && INPUT_KEYBOARD
-	select SERIO_I8042
+	select SERIO
+	select SERIO_I8042 if !EMBEDDED && X86
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
 	  you'll need this, unless you have a different type keyboard (USB, ADB


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
