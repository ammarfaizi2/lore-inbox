Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSJMMkv>; Sun, 13 Oct 2002 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSJMMkv>; Sun, 13 Oct 2002 08:40:51 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:63903 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261523AbSJMMkv>; Sun, 13 Oct 2002 08:40:51 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sun, 13 Oct 2002 14:46:28 +0200
Message-ID: <87smza1p7f.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/char/mem.c there's open_port(), which is used as open_mem()
and open_kmem() as well. I don't see the benefit of this, since
/dev/mem and /dev/kmem are already protected by filesystem
permissions.

mem.c, line 526:
static int open_port(struct inode * inode, struct file * filp)
{
	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
}

If anyone knows, why this is done this way, please let me
know. Otherwise, I suggest the patch below.

Regards, Olaf.

--- a/drivers/char/mem.c	Sat Oct  5 18:44:55 2002
+++ b/drivers/char/mem.c	Sun Oct 13 13:59:25 2002
@@ -533,15 +533,12 @@
 #define full_lseek      null_lseek
 #define write_zero	write_null
 #define read_full       read_zero
-#define open_mem	open_port
-#define open_kmem	open_mem
 
 static struct file_operations mem_fops = {
 	llseek:		memory_lseek,
 	read:		read_mem,
 	write:		write_mem,
 	mmap:		mmap_mem,
-	open:		open_mem,
 };
 
 static struct file_operations kmem_fops = {
@@ -549,7 +546,6 @@
 	read:		read_kmem,
 	write:		write_kmem,
 	mmap:		mmap_kmem,
-	open:		open_kmem,
 };
 
 static struct file_operations null_fops = {
