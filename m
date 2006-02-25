Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWBYAJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWBYAJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWBYAJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:09:58 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:6792 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964815AbWBYAJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:09:58 -0500
Date: Fri, 24 Feb 2006 19:07:00 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86: clean up early_printk output
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200602241909_MC3-1-B93E-25B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

early_printk() starts output on the second screen line and doesn't
clear the rest of the line when it hits a newline char.  When there
is already a BIOS message there, it becomes hard to read.  Change
this so it starts on the first line and clears to EOL upon hitting
newline.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc4-64.orig/arch/x86_64/kernel/early_printk.c
+++ 2.6.16-rc4-64/arch/x86_64/kernel/early_printk.c
@@ -21,7 +21,15 @@
 #define MAX_XPOS	max_xpos
 
 static int max_ypos = 25, max_xpos = 80;
-static int current_ypos = 1, current_xpos = 0; 
+static int current_ypos, current_xpos; /* 0,0 */
+
+static noinline void clear_to_eol(int xpos, int ypos)
+{
+	int i;
+
+	for (i = xpos; i < MAX_XPOS; i++)
+		writew(0x720, VGABASE + 2*(MAX_XPOS*ypos + i));
+}
 
 static void early_vga_write(struct console *con, const char *str, unsigned n)
 {
@@ -37,11 +45,11 @@ static void early_vga_write(struct conso
 					       VGABASE + 2*(MAX_XPOS*j + i));
 				}
 			}
-			for (i = 0; i < MAX_XPOS; i++)
-				writew(0x720, VGABASE + 2*(MAX_XPOS*j + i));
+			clear_to_eol(0, j);
 			current_ypos = MAX_YPOS-1;
 		}
 		if (c == '\n') {
+			clear_to_eol(current_xpos, current_ypos);
 			current_xpos = 0;
 			current_ypos++;
 		} else if (c != '\r')  {
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
