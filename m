Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTLEIPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 03:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTLEIPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 03:15:35 -0500
Received: from [211.167.76.68] ([211.167.76.68]:58501 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262327AbTLEIPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 03:15:34 -0500
Date: Fri, 5 Dec 2003 16:14:51 +0800
From: Hugang <hugang@soulinfo.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-Id: <20031205161451.790ae1ea.hugang@soulinfo.com>
In-Reply-To: <20031204200120.GL19856@holomorphy.com>
References: <20031204200120.GL19856@holomorphy.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.6claws57 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 12:01:20 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> Successfully tested on a Thinkpad T21. Any feedback regarding
> performance would be very helpful. Desktop users should notice top(1)
> is faster, kernel hackers that kernel compiles are faster, and highmem
> users should see much less per-process lowmem overhead.

I got this in ppc.
fs/built-in.o: In function `proc_task_readdir':
fs/built-in.o(.text+0x2ff44): undefined reference to `__cmpdi2'
fs/built-in.o(.text+0x2ff44): relocation truncated to fit: R_PPC_REL24 __cmpdi2
fs/built-in.o(.text+0x2ff6c): undefined reference to `__cmpdi2'
fs/built-in.o(.text+0x2ff6c): relocation truncated to fit: R_PPC_REL24 __cmpdi2
make: *** [.tmp_vmlinux1] Error 1

apply the patch should fix it.

Index: fs/proc/base.c
===================================================================
--- fs/proc/base.c	(revision 3)
+++ fs/proc/base.c	(working copy)
@@ -1673,12 +1673,13 @@
 	struct inode *inode = dentry->d_inode;
 	int retval = -ENOENT;
 	ino_t ino;
+	unsigned long pos = filp->f_pos;  /* avoiding "long long" filp->f_pos */
 
 	if (!pid_alive(proc_task(inode)))
 		goto out;
 	retval = 0;
 
-	switch (filp->f_pos) {
+	switch (pos) {
 	case 0:
 		ino = inode->i_ino;
 		if (filldir(dirent, ".", 1, filp->f_pos, ino, DT_DIR) < 0)


-- 
Hu Gang / Steve
Email         : hugang@soulinfo.com, steve@soulinfo.com
GPG FinePrint : 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
MSN#          : huganglinux@hotmail.com [9:00AM - 5:30PM +8:00]
RLU#          : 204016 [1999] (Register Linux User)
