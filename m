Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRBTURv>; Tue, 20 Feb 2001 15:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130618AbRBTURb>; Tue, 20 Feb 2001 15:17:31 -0500
Received: from [199.239.160.155] ([199.239.160.155]:8453 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130600AbRBTUR3>; Tue, 20 Feb 2001 15:17:29 -0500
Date: Tue, 20 Feb 2001 12:17:27 -0800
From: Robert Read <rread@datarithm.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: kernel/printk.c: increasing the buffer size to capture devfsd debug messages.
Message-ID: <20010220121727.B4106@tenchi.datarithm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp> <20010220111542.A4106@tenchi.datarithm.net> <3A92C76C.6519DF1A@cypress.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A92C76C.6519DF1A@cypress.com>; from ted@cypress.com on Tue, Feb 20, 2001 at 01:37:16PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2001 at 01:37:16PM -0600, Thomas Dodd wrote:
> Robert Read wrote:
> > 
> > On Wed, Feb 21, 2001 at 02:30:08AM +0900, Ishikawa wrote:
> > >
> > > Has anyone tried 128K buffer size in kernel/printk.c
> > > and still have the kernel boot (without
> > > hard to notice memory corruption problems  and other subtle bugs)?
> > > Any hints and tips will be appreciated.
> > 
> > I have used 128k and larger buffer sizes, and I just noticed this
> > fragment in the RedHat Tux Webserver patch.  It creates a 2MB buffer:
> 
> I think this should be a config option.

Ok, here is a simple patch to add a config option, I'm compiling it
now, so it's not tested yet.  One question: what is the best way to
force this option to be a power of 2?

robert
--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="printk-buflen.patch"

diff -ru linux-2.4.2-pre4/arch/i386/config.in linux-2.4.2-pre4-logbuf/arch/i386/config.in
--- linux-2.4.2-pre4/arch/i386/config.in	Mon Jan  8 13:27:56 2001
+++ linux-2.4.2-pre4-logbuf/arch/i386/config.in	Tue Feb 20 12:10:19 2001
@@ -366,4 +366,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (must be power of 2)' CONFIG_PRINTK_BUF_LEN 16384
 endmenu
Only in linux-2.4.2-pre4-logbuf/arch/i386: config.in~
Only in linux-2.4.2-pre4-logbuf/include: asm
Only in linux-2.4.2-pre4-logbuf/include/linux: autoconf.h
Only in linux-2.4.2-pre4-logbuf/include/linux: modules
diff -ru linux-2.4.2-pre4/kernel/printk.c linux-2.4.2-pre4-logbuf/kernel/printk.c
--- linux-2.4.2-pre4/kernel/printk.c	Tue Feb 20 11:56:31 2001
+++ linux-2.4.2-pre4-logbuf/kernel/printk.c	Tue Feb 20 11:59:35 2001
@@ -23,7 +23,11 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)
+#ifdef CONFIG_PRINTK_BUF_LEN
+# define LOG_BUF_LEN   (CONFIG_PRINTK_BUF_LEN)
+#else
+# define LOG_BUF_LEN   (16384)
+#endif   
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 static char buf[1024];

--FL5UXtIhxfXey3p5--
