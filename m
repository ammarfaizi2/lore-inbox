Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVAQRs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVAQRs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVAQRqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:46:31 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:4873 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262820AbVAQRoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:44:18 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/13] FAT: use vprintk instead of snprintf with static
 buffer
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:44:04 +0900
In-Reply-To: <878y6sostl.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:42:46 +0900")
Message-ID: <874qhgosrf.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/misc.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff -puN fs/fat/misc.c~fat_sprintf-to-vprintk fs/fat/misc.c
--- linux-2.6.10/fs/fat/misc.c~fat_sprintf-to-vprintk	2005-01-08 09:08:05.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/misc.c	2005-01-08 09:08:05.000000000 +0900
@@ -15,26 +15,22 @@
  * fat_fs_panic reports a severe file system problem and sets the file system
  * read-only. The file system can be made writable again by remounting it.
  */
-
-static char panic_msg[512];
-
 void fat_fs_panic(struct super_block *s, const char *fmt, ...)
 {
-	int not_ro;
 	va_list args;
 
-	va_start (args, fmt);
-	vsnprintf (panic_msg, sizeof(panic_msg), fmt, args);
-	va_end (args);
+	printk(KERN_ERR "FAT: Filesystem panic (dev %s)\n", s->s_id);
 
-	not_ro = !(s->s_flags & MS_RDONLY);
-	if (not_ro)
-		s->s_flags |= MS_RDONLY;
+	printk(KERN_ERR "    ");
+	va_start(args, fmt);
+	vprintk(fmt, args);
+	va_end(args);
+	printk("\n");
 
-	printk(KERN_ERR "FAT: Filesystem panic (dev %s)\n"
-	       "    %s\n", s->s_id, panic_msg);
-	if (not_ro)
+	if (!(s->s_flags & MS_RDONLY)) {
+		s->s_flags |= MS_RDONLY;
 		printk(KERN_ERR "    File system has been set read-only\n");
+	}
 }
 
 void lock_fat(struct super_block *sb)
_
