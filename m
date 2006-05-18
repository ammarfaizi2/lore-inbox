Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWERKYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWERKYh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 06:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWERKYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 06:24:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28347 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750710AbWERKYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 06:24:37 -0400
Date: Thu, 18 May 2006 12:23:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] fix magic sysrq on strange keyboards
Message-ID: <20060518102354.GA1715@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magic sysrq fails to work on many keyboards, particulary most of
notebook keyboards. This should help...

The idea is quite simple: Discard the SysRq break code if Alt is still
being held down. This way the broken keyboard can send the break code
(or the user with a normal keyboard can release the SysRq key) and the
kernel waits until the next key is pressed or the Alt key is released.

From: Fredrik Roubert <roubert@df.lth.se>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 81a95636a6fa97678b744785ddb33f987d934d99
tree 41bde7eb3767e087bbcda90430b5a1777aa3c3c8
parent 103baf40aa229f40933f1eab736158875bf01484
author <pavel@amd.ucw.cz> Thu, 18 May 2006 12:21:43 +0200
committer <pavel@amd.ucw.cz> Thu, 18 May 2006 12:21:43 +0200

 drivers/char/keyboard.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 5d84839..4602cf3 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -149,7 +149,8 @@ unsigned char kbd_sysrq_xlate[KEY_MAX + 
         "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
         "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
         "\r\000/";                                      /* 0x60 - 0x6f */
-static int was_sysrq;
+static int sysrq_down;
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
@@ -1161,13 +1162,17 @@ static void kbd_keycode(unsigned int key
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if ((keycode == KEY_SYSRQ) && down) {
-		printk(KERN_CRIT "Sysrq: press a key to do something\n");
-		was_sysrq = 1;
+	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+		if (!sysrq_down) {
+			sysrq_down = down;
+			sysrq_alt_use = sysrq_alt;
+		}
+		return;
 	}
-	if (was_sysrq && down && !rep) {
+	if (sysrq_down && !down && keycode == sysrq_alt_use)
+		sysrq_down = 0;
+	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
-		was_sysrq = 0;
 		return;
 	}
 #endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
