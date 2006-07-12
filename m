Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWGLN0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWGLN0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWGLN0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:26:41 -0400
Received: from [195.23.16.24] ([195.23.16.24]:27538 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751065AbWGLN0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:26:40 -0400
Message-ID: <44B4F88D.3060301@grupopie.com>
Date: Wed, 12 Jul 2006 14:26:37 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, roubert@df.lth.se,
       stern@rowland.harvard.edu, dmitry.torokhov@gmail.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org> <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home> <20060711124105.GA2474@elf.ucw.cz> <Pine.LNX.4.64.0607120016490.12900@scrub.home> <20060711224225.GC1732@elf.ucw.cz> <Pine.LNX.4.64.0607120132440.12900@scrub.home> <20060711165003.25265bb7.akpm@osdl.org> <Pine.LNX.4.64.0607120213060.12900@scrub.home> <20060711173735.43e9af94.akpm@osdl.org> <Pine.LNX.4.64.0607120248050.12900@scrub.home> <20060711183647.5c5c0204.akpm@osdl.org> <Pine.LNX.4.64.0607121056170.12900@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0607121056170.12900@scrub.home>
Content-Type: multipart/mixed;
 boundary="------------020000020606070608060405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000020606070608060405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Roman Zippel wrote:
> On Tue, 11 Jul 2006, Andrew Morton wrote:
> [...]
>> What, actually, is the problem?
> 
> It changes the behaviour, it will annoy the hell out of people like me who 
> have to deal with different kernels and expect this to just work. :-(
> Since then has it been acceptable to just go ahead and break stuff? This 
> problem doesn't really look unsolvable, so why is my request to fix the 
> damn thing so unreasonable?

Ok, what about this one?

I don't have time to test it (it compiles, at least), but it seems the 
logic is pretty clear: once you have pressed both "Alt" and "SysRq" 
sysrq mode becomes active until you release *both* keys. In this mode 
any regular key press triggers handle_sysrq.

This allows for all the combinations mentioned before in this thread and 
makes the logic simpler, IMHO.

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

--------------020000020606070608060405
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Subject: allow the old behavior of Alt+SysRq+<key>

This should allow any order of Alt + SysRq press followed by any key
while still holding one of SysRq or Alt.

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

--- ./drivers/char/keyboard.c.orig	2006-07-12 13:03:32.000000000 +0100
+++ ./drivers/char/keyboard.c	2006-07-12 14:18:52.000000000 +0100
@@ -150,7 +150,7 @@ unsigned char kbd_sysrq_xlate[KEY_MAX +
         "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
         "\r\000/";                                      /* 0x60 - 0x6f */
 static int sysrq_down;
-static int sysrq_alt_use;
+static int sysrq_active;
 #endif
 static int sysrq_alt;

@@ -1164,16 +1164,17 @@ static void kbd_keycode(unsigned int key
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);

 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
-		if (!sysrq_down) {
-			sysrq_down = down;
-			sysrq_alt_use = sysrq_alt;
-		}
+	if (keycode == KEY_SYSRQ) {
+		sysrq_down = down;
 		return;
 	}
-	if (sysrq_down && !down && keycode == sysrq_alt_use)
-		sysrq_down = 0;
-	if (sysrq_down && down && !rep) {
+
+	if (sysrq_down && sysrq_alt)
+		sysrq_active = 1;
+	else if (!sysrq_down && !sysrq_alt)
+		sysrq_active = 0;
+
+	if (sysrq_active && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 		return;
 	}

--------------020000020606070608060405--
