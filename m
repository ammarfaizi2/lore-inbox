Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSLBWS6>; Mon, 2 Dec 2002 17:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSLBWS6>; Mon, 2 Dec 2002 17:18:58 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:16402
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265093AbSLBWS5>; Mon, 2 Dec 2002 17:18:57 -0500
Subject: Re: [PATCH] deprecate use of bdflush()
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DEBDA8D.CBB4B6D0@digeo.com>
References: <1038864066.1221.43.camel@phantasy>
	 <3DEBDA8D.CBB4B6D0@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038867991.1221.56.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 17:26:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 17:11, Andrew Morton wrote:

> Ho-hum.  I was going to do this months ago but general exhaustion
> and sluggishness won out.
> 
> We should tell the user which process called sys_bdflush() to aid
> their expunging efforts.

Good idea.

I could do without the rate limiting, though - the print is after the
CAP_SYS_ADMIN check.  Root has plenty of other ways to print crap to the
screen and it saves 32-bits from bss.  But, uh, not a big deal at all
either way.

	Robert Love

 fs/buffer.c |    7 +++++++
 1 files changed, 7 insertions(+)


diff -urN linux-2.5.49-mm2/fs/buffer.c linux/fs/buffer.c
--- linux-2.5.49-mm2/fs/buffer.c	2002-12-02 16:07:53.000000000 -0500
+++ linux/fs/buffer.c	2002-12-02 17:24:57.000000000 -0500
@@ -2757,11 +2757,18 @@
 /*
  * There are no bdflush tunables left.  But distributions are
  * still running obsolete flush daemons, so we terminate them here.
+ *
+ * Use of bdflush() is deprecated and will be removed in a future kernel.
+ * The `pdflush' kernel threads fully replace bdflush daemons and this call.
  */
 asmlinkage long sys_bdflush(int func, long data)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
+
+	printk(KERN_WARNING "warning: process `%s' used the deprecated bdflush"
+			    " system call. Fix your initscripts?\n",
+			    current->comm);
 	if (func == 1)
 		do_exit(0);
 	return 0;



