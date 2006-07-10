Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161274AbWGJAWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbWGJAWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWGJAWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:22:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161274AbWGJAWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:22:38 -0400
Date: Sun, 9 Jul 2006 17:22:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Fredrik Roubert <roubert@df.lth.se>
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-Id: <20060709172222.d8c275fd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 17:06:57 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> Dmitry:
> 
> Are you the right person to handle changes in the behavior of Alt-SysRq?
> 
> Before 2.6.18-rc1, I used to be able to use it as follows:
> 
> 	Press and hold an Alt key,
> 	Press and hold the SysRq key,
> 	Release the Alt key,
> 	Press and release some hot key like S or T or 7,
> 	Repeat the previous step as many times as desired,
> 	Release the SysRq key.
> 
> This scheme doesn't work any more, or if it does, the timing requirements
> are now much stricter.  In practice I have to hold down all three keys at
> the same time; I can't release the Alt key before pressing the hot key.
> 
> This makes thinks very awkward on my laptop machine.  Its keyboard
> controller doesn't seem to like having three keys pressed simultaneously.  
> Instead of the expected hotkey behavior, I usually got an error message
> from atkbd warning about too many keys being pressed.  Getting it to work
> as desired is hit-and-miss.
> 
> I would really appreciate going back to the old behavior, where only two 
> keys needed to be held down at any time.
> 

I assume reverting the below will fix it?


From: Fredrik Roubert <roubert@df.lth.se>

Magic sysrq fails to work on many keyboards, particulary most of notebook
keyboards.  This patch fixes it.

The idea is quite simple: Discard the SysRq break code if Alt is still being
held down.  This way the broken keyboard can send the break code (or the user
with a normal keyboard can release the SysRq key) and the kernel waits until
the next key is pressed or the Alt key is released.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/char/keyboard.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff -puN drivers/char/keyboard.c~fix-magic-sysrq-on-strange-keyboards drivers/char/keyboard.c
--- a/drivers/char/keyboard.c~fix-magic-sysrq-on-strange-keyboards
+++ a/drivers/char/keyboard.c
@@ -151,6 +151,7 @@ unsigned char kbd_sysrq_xlate[KEY_MAX + 
         "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
         "\r\000/";                                      /* 0x60 - 0x6f */
 static int sysrq_down;
+static int sysrq_alt_use;
 #endif
 static int sysrq_alt;
 
@@ -1143,7 +1144,7 @@ static void kbd_keycode(unsigned int key
 	kbd = kbd_table + fg_console;
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
-		sysrq_alt = down;
+		sysrq_alt = down ? keycode : 0;
 #ifdef CONFIG_SPARC
 	if (keycode == KEY_STOP)
 		sparc_l1_a_state = down;
@@ -1163,9 +1164,14 @@ static void kbd_keycode(unsigned int key
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
 	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
-		sysrq_down = down;
+		if (!sysrq_down) {
+			sysrq_down = down;
+			sysrq_alt_use = sysrq_alt;
+		}
 		return;
 	}
+	if (sysrq_down && !down && keycode == sysrq_alt_use)
+		sysrq_down = 0;
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 		return;
_

