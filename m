Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTKDQad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTKDQad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:30:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22998 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262352AbTKDQac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:30:32 -0500
Date: Tue, 4 Nov 2003 17:30:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Fix alt- -> console switching
Message-ID: <20031104163031.GB220@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Take vesafb, do cat /etc/termcap, while it is printing press alt and
right arrow twice. Oops, it only goes one console to the right.

Problem is that if console is already being switched and you press
alt- ->, fg_console is still old one and second alt- -> is basically
lost. Here's a fix.
								Pavel


--- tmp/linux/drivers/char/keyboard.c	2003-11-04 17:13:00.000000000 +0100
+++ linux/drivers/char/keyboard.c	2003-11-04 17:08:57.000000000 +0100
@@ -528,8 +528,12 @@
 static void fn_inc_console(struct vc_data *vc, struct pt_regs *regs)
 {
 	int i;
+	int cur = fg_console;
 
-	for (i = fg_console+1; i != fg_console; i++) {
+	if (want_console != -1)
+		cur = want_console;
+
+	for (i = cur+1; i != cur; i++) {
 		if (i == MAX_NR_CONSOLES)
 			i = 0;
 		if (vc_cons_allocated(i))

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
