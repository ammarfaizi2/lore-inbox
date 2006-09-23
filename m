Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWIWRU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWIWRU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 13:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWIWRU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 13:20:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23944 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751332AbWIWRU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 13:20:59 -0400
Date: Sat, 23 Sep 2006 18:20:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, karsten@jeppesens.getmyip.com
Subject: [PATCH] briq_panel: read() and write() get __user pointers, damnit
Message-ID: <20060923172056.GK29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

annotated, fixed a roothole in ->write().  Dereferencing user-supplied pointer
is a Bad Idea(tm)...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/briq_panel.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/briq_panel.c b/drivers/char/briq_panel.c
index caae795..b8c2225 100644
--- a/drivers/char/briq_panel.c
+++ b/drivers/char/briq_panel.c
@@ -87,7 +87,7 @@ static int briq_panel_release(struct ino
 	return 0;
 }
 
-static ssize_t briq_panel_read(struct file *file, char *buf, size_t count,
+static ssize_t briq_panel_read(struct file *file, char __user *buf, size_t count,
 			 loff_t *ppos)
 {
 	unsigned short c;
@@ -135,7 +135,7 @@ static void scroll_vfd( void )
 	vfd_cursor = 20;
 }
 
-static ssize_t briq_panel_write(struct file *file, const char *buf, size_t len,
+static ssize_t briq_panel_write(struct file *file, const char __user *buf, size_t len,
 			  loff_t *ppos)
 {
 	size_t indx = len;
@@ -150,19 +150,22 @@ #endif
 		return -EBUSY;
 
 	for (;;) {
+		char c;
 		if (!indx)
 			break;
+		if (get_user(c, buf))
+			return -EFAULT;
 		if (esc) {
-			set_led(*buf);
+			set_led(c);
 			esc = 0;
-		} else if (*buf == 27) {
+		} else if (c == 27) {
 			esc = 1;
-		} else if (*buf == 12) {
+		} else if (c == 12) {
 			/* do a form feed */
 			for (i=0; i<40; i++)
 				vfd[i] = ' ';
 			vfd_cursor = 0;
-		} else if (*buf == 10) {
+		} else if (c == 10) {
 			if (vfd_cursor < 20)
 				vfd_cursor = 20;
 			else if (vfd_cursor < 40)
@@ -175,7 +178,7 @@ #endif
 			/* just a character */
 			if (vfd_cursor > 39)
 				scroll_vfd();
-			vfd[vfd_cursor++] = *buf;
+			vfd[vfd_cursor++] = c;
 		}
 		indx--;
 		buf++;
-- 
1.4.2.GIT

