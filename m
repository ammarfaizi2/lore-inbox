Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUIFMlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUIFMlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUIFMlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:41:12 -0400
Received: from mail.renesas.com ([202.234.163.13]:32700 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267746AbUIFMlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:41:04 -0400
Date: Mon, 06 Sep 2004 21:40:51 +0900 (JST)
Message-Id: <20040906.214051.336469534.takata.hirokazu@renesas.com>
To: akpm@osdl.org, hch@infradead.org
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless
 iBCS2 support code
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20040903105423.A3179@infradead.org>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<20040903105423.A3179@infradead.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 3 Sep 2004 10:54:23 +0100
> On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
> > 
> > - Added the m32r architecture.  Haven't looked at it yet.
> 
> More comments.
Thank you for your sending comments.

>  - please don't implement ancient backward-compat syscalls in a new
>    port (that's why we made those conditional on __ARCH_WANT_* in unistd.h,
>    but see also old_ in your arch code and the totally useless iBCS2
>    hack in the sysv ipc code)
>  - your probably want to run all this code through sparse and fix warnings
> 

The useless iBCS2 supporting code is removed.

However, according to old_ syscalls, I would like to keep backward-
compatibility for a while, due to some old deb packages and 
executables for m32r.  
I'm struggling to rebuild and replace old packages to new ones.
http://debian.linux-m32r.org/


Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>

 sys_m32r.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)


--- linux-2.6.9-rc1-mm3.orig/arch/m32r/kernel/sys_m32r.c	2004-09-03 20:46:13.000000000 +0900
+++ linux-2.6.9-rc1-mm3/arch/m32r/kernel/sys_m32r.c	2004-09-06 18:48:33.000000000 +0900
@@ -227,21 +227,16 @@ asmlinkage int sys_ipc(uint call, int fi
 	case MSGCTL:
 		return sys_msgctl (first, second,
 				   (struct msqid_ds __user *) ptr);
-	case SHMAT:
-		switch (version) {
-		default: {
-			ulong raddr;
-			ret = do_shmat (first, (char __user *) ptr,
-					 second, &raddr);
-			if (ret)
-				return ret;
-			return put_user (raddr, (ulong __user *) third);
-		}
-		case 1:	/* iBCS2 emulator entry point */
-			if (!segment_eq(get_fs(), get_ds()))
-				return -EINVAL;
-			return do_shmat (first, (char __user *) ptr,
-					  second, (ulong *) third);
+	case SHMAT: {
+		ulong raddr;
+
+		if ((ret = verify_area(VERIFY_WRITE, (ulong __user *) third, 
+				      sizeof(ulong))))
+			return ret;
+		ret = do_shmat (first, (char __user *) ptr, second, &raddr);
+		if (ret)
+			return ret;
+		return put_user (raddr, (ulong __user *) third);
 		}
 	case SHMDT:
 		return sys_shmdt ((char __user *)ptr);


