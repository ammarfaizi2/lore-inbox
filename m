Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313205AbSC1S0V>; Thu, 28 Mar 2002 13:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313206AbSC1S0N>; Thu, 28 Mar 2002 13:26:13 -0500
Received: from air-2.osdl.org ([65.201.151.6]:4480 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S313205AbSC1S0A>;
	Thu, 28 Mar 2002 13:26:00 -0500
Date: Thu, 28 Mar 2002 10:25:45 -0800
From: Bob Miller <rem@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5.7-dj2] Compile Error
Message-ID: <20020328102545.A15972@doc.pdx.osdl.net>
In-Reply-To: <200203281216.32590@xsebbi.de> <00c801c1d655$d8e75cd0$02c8a8c0@kroptech.com> <20020328095352.A6291@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 09:53:52AM -0800, Bob Miller wrote:
>
> Stuff deleted...
> 
> In looking at kernel/acct.c it looks like someone tried to change acct.c
> to no longer conditionally compile based on CONFIG_BSD_PROCESS_ACCT.
> The problem is that other files that conditionally compile with
> CONFIG_BSD_PROCESS_ACCT (include/linux/acct.h and others) where not changed.
> 
> So if you build with CONFIG_BSD_PROCESS_ACCT not set you're build will
> break.  I'm in the process of generating a patch that will make acct.c
> again conditionally compile based on CONFIG_BSD_PROCESS_ACCT.  This
> should be done in a little bit and I'll post.
> 
> Dave, where did you get the patch for acct.c?
> 

Below is a patch that should fix this build breakage.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -ur linux-2.5.7-dj2-orig/kernel/acct.c linux-2.5.7-dj2/kernel/acct.c
--- linux-2.5.7-dj2-orig/kernel/acct.c	Thu Mar 28 09:10:42 2002
+++ linux-2.5.7-dj2/kernel/acct.c	Thu Mar 28 09:41:04 2002
@@ -44,11 +44,17 @@
  */
 
 #include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+#ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acct.h>
+#include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/tty.h>
+
 #include <asm/uaccess.h>
 
 /*
@@ -389,3 +395,15 @@
 		spin_unlock(&acct_globals.lock);
 	return 0;
 }
+
+#else
+/*
+ * Dummy system call when BSD process accounting is not configured
+ * into the kernel.
+ */
+
+asmlinkage long sys_acct(const char * filename)
+{
+	return -ENOSYS;
+}
+#endif
