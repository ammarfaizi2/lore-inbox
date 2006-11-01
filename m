Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946390AbWKACHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946390AbWKACHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946389AbWKACHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:07:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34450 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946390AbWKACHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:07:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=nWrDGUbWaDJpdCqzUoP22+glm7bVjHmBy8rHRalZ8ejeMRqPUO5I+1tYZycvgdX4Wyt8AgAz8pIDWqL6zaLIQK4xEXxClKnivrOLY1PTfsTSarwIXdf3keP7UTacZA433nFYspTvPf5eF2GzI3X30BScd1/9a5ZT48qZ7bqOCyk=
Date: Wed, 1 Nov 2006 05:05:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hpfs: bring hpfs_error() into shape
Message-ID: <20061101020518.GB5014@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*) switch to error message buffer in .bss
*) missing va_end() (htf it worked before?)
*) use vsnprintf()
*) rename variables to understandable "fmt", "args".
*) "const char *fmt", yes.
*) add __attribute__((format ...

Still, put that coffee down before reading more.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/hpfs/hpfs_fn.h |    3 ++-
 fs/hpfs/super.c   |   23 +++++++++--------------
 2 files changed, 11 insertions(+), 15 deletions(-)

--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -317,7 +317,8 @@ static inline struct hpfs_sb_info *hpfs_
 
 /* super.c */
 
-void hpfs_error(struct super_block *, char *, ...);
+void hpfs_error(struct super_block *, const char *, ...)
+	__attribute__((format (printf, 2, 3)));
 int hpfs_stop_cycles(struct super_block *, int, int *, int *, char *);
 unsigned hpfs_count_one_bitmap(struct super_block *, secno);
 
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -46,21 +46,17 @@ static void unmark_dirty(struct super_bl
 }
 
 /* Filesystem error... */
+static char err_buf[1024];
 
-#define ERR_BUF_SIZE 1024
-
-void hpfs_error(struct super_block *s, char *m,...)
+void hpfs_error(struct super_block *s, const char *fmt, ...)
 {
-	char *buf;
-	va_list l;
-	va_start(l, m);
-	if (!(buf = kmalloc(ERR_BUF_SIZE, GFP_KERNEL)))
-		printk("HPFS: No memory for error message '%s'\n",m);
-	else if (vsprintf(buf, m, l) >= ERR_BUF_SIZE)
-		printk("HPFS: Grrrr... Kernel memory corrupted ... going on, but it'll crash very soon :-(\n");
-	printk("HPFS: filesystem error: ");
-	if (buf) printk("%s", buf);
-	else printk("%s\n",m);
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(err_buf, sizeof(err_buf), fmt, args);
+	va_end(args);
+
+	printk("HPFS: filesystem error: %s", err_buf);
 	if (!hpfs_sb(s)->sb_was_error) {
 		if (hpfs_sb(s)->sb_err == 2) {
 			printk("; crashing the system because you wanted it\n");
@@ -76,7 +72,6 @@ void hpfs_error(struct super_block *s, c
 		} else if (s->s_flags & MS_RDONLY) printk("; going on - but anything won't be destroyed because it's read-only\n");
 		else printk("; corrupted filesystem mounted read/write - your computer will explode within 20 seconds ... but you wanted it so!\n");
 	} else printk("\n");
-	kfree(buf);
 	hpfs_sb(s)->sb_was_error = 1;
 }
 

