Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWI0IN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWI0IN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWI0IN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:13:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932232AbWI0INz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:13:55 -0400
Date: Wed, 27 Sep 2006 01:13:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Devera <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stat of /proc fails after CPU hot-unplug with EOVERFLOW in
 2.6.18
Message-Id: <20060927011348.36818f83.akpm@osdl.org>
In-Reply-To: <451A2E83.5000806@cdi.cz>
References: <451A2E83.5000806@cdi.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 09:55:47 +0200
Martin Devera <devik@cdi.cz> wrote:

> Hello,
> 
> I have 2way Opteron machine. I've done this:
> echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> and then strace stat /proc:
> 
> [snip]
> personality(PER_LINUX)                  = 4194304
> getpid()                                = 14926
> brk(0)                                  = 0x804b000
> brk(0x804b1a0)                          = 0x804b1a0
> brk(0x804c000)                          = 0x804c000
> stat("/proc", 0xbf8e7490)               = -1 EOVERFLOW
> 
> When I do echo 1 > ... to start cpu again then the stat starts
> to work again ... Weird.
> 

boggle.

Can you add this patch, see where it's going bad?


 fs/stat.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff -puN fs/stat.c~a fs/stat.c
--- a/fs/stat.c~a
+++ a/fs/stat.c
@@ -18,6 +18,8 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+#define D() printk("%s:%d\n", __FILE__, __LINE__)
+
 void generic_fillattr(struct inode *inode, struct kstat *stat)
 {
 	stat->dev = inode->i_sb->s_dev;
@@ -141,14 +143,18 @@ static int cp_old_stat(struct kstat *sta
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
-	if (tmp.st_nlink != stat->nlink)
+	if (tmp.st_nlink != stat->nlink) {
+		D();
 		return -EOVERFLOW;
+	}
 	SET_UID(tmp.st_uid, stat->uid);
 	SET_GID(tmp.st_gid, stat->gid);
 	tmp.st_rdev = old_encode_dev(stat->rdev);
 #if BITS_PER_LONG == 32
-	if (stat->size > MAX_NON_LFS)
+	if (stat->size > MAX_NON_LFS) {
+		D();
 		return -EOVERFLOW;
+	}
 #endif	
 	tmp.st_size = stat->size;
 	tmp.st_atime = stat->atime.tv_sec;
@@ -195,11 +201,15 @@ static int cp_new_stat(struct kstat *sta
 	struct stat tmp;
 
 #if BITS_PER_LONG == 32
-	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev))
+	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev)) {
+		D();
 		return -EOVERFLOW;
+	}
 #else
-	if (!new_valid_dev(stat->dev) || !new_valid_dev(stat->rdev))
+	if (!new_valid_dev(stat->dev) || !new_valid_dev(stat->rdev)) {
+		D();
 		return -EOVERFLOW;
+	}
 #endif
 
 	memset(&tmp, 0, sizeof(tmp));
@@ -211,8 +221,10 @@ static int cp_new_stat(struct kstat *sta
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
-	if (tmp.st_nlink != stat->nlink)
+	if (tmp.st_nlink != stat->nlink) {
+		D();
 		return -EOVERFLOW;
+	}
 	SET_UID(tmp.st_uid, stat->uid);
 	SET_GID(tmp.st_gid, stat->gid);
 #if BITS_PER_LONG == 32
@@ -221,8 +233,10 @@ static int cp_new_stat(struct kstat *sta
 	tmp.st_rdev = new_encode_dev(stat->rdev);
 #endif
 #if BITS_PER_LONG == 32
-	if (stat->size > MAX_NON_LFS)
+	if (stat->size > MAX_NON_LFS) {
+		D();
 		return -EOVERFLOW;
+	}
 #endif	
 	tmp.st_size = stat->size;
 	tmp.st_atime = stat->atime.tv_sec;
@@ -337,8 +351,10 @@ static long cp_new_stat64(struct kstat *
 	memset(&tmp, 0, sizeof(struct stat64));
 #ifdef CONFIG_MIPS
 	/* mips has weird padding, so we don't get 64 bits there */
-	if (!new_valid_dev(stat->dev) || !new_valid_dev(stat->rdev))
+	if (!new_valid_dev(stat->dev) || !new_valid_dev(stat->rdev)) {
+		D();
 		return -EOVERFLOW;
+	}
 	tmp.st_dev = new_encode_dev(stat->dev);
 	tmp.st_rdev = new_encode_dev(stat->rdev);
 #else
_

