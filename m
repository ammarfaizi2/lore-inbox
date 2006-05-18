Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWERVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWERVBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWERVBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:01:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18617 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751106AbWERVBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:01:47 -0400
Date: Thu, 18 May 2006 23:01:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz, linux-kernel@vger.kernel.org, roubert@df.lth.se
Subject: Re: [patch] fix magic sysrq on strange keyboards
Message-ID: <20060518210102.GC2571@elf.ucw.cz>
References: <20060518102354.GA1715@elf.ucw.cz> <20060518121057.3d79779b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518121057.3d79779b.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry, probably sent patch to my own kernel... This one should be
better.
	
								Pavel

--- 

Magic sysrq fails to work on many keyboards, particulary most of
notebook keyboards. This should help...

The idea is quite simple: Discard the SysRq break code if Alt is still
being held down. This way the broken keyboard can send the break code
(or the user with a normal keyboard can release the SysRq key) and the
kernel waits until the next key is pressed or the Alt key is released.
 
From: Fredrik Roubert <roubert@df.lth.se>
Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 5755b7e..4602cf3 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -150,6 +150,7 @@ unsigned char kbd_sysrq_xlate[KEY_MAX + 
         "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
         "\r\000/";                                      /* 0x60 - 0x6f */
 static int sysrq_down;
+static int sysrq_alt_use;
 #endif
 static int sysrq_alt;
 
@@ -1142,7 +1143,7 @@ static void kbd_keycode(unsigned int key
 	kbd = kbd_table + fg_console;
 
 	if (keycode == KEY_LEFTALT || keycode == KEY_RIGHTALT)
-		sysrq_alt = down;
+		sysrq_alt = down ? keycode : 0;
 #ifdef CONFIG_SPARC
 	if (keycode == KEY_STOP)
 		sparc_l1_a_state = down;
@@ -1162,9 +1163,14 @@ static void kbd_keycode(unsigned int key
 
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


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
