Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHaRqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHaRqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUHaRmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:42:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32192 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265978AbUHaRlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:41:09 -0400
Date: Tue, 31 Aug 2004 19:41:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, digilnux@dgii.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.9-rc1-mm2: char/pcxx.c doesn't compile
Message-ID: <20040831174102.GF3466@fs.tum.de>
References: <20040830235426.441f5b51.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error might not be specific to -mm:

<--  snip  -->

...
  CC      drivers/char/pcxx.o
drivers/char/pcxx.c: In function `pcxe_cleanup':
drivers/char/pcxx.c:209: warning: unused variable `e2'
drivers/char/pcxx.c: At top level:
drivers/char/pcxx.c:229: `pcxe_init' undeclared here (not in a function)
drivers/char/pcxx.c:230: warning: type defaults to `int' in declaration of `module_cleanup'
drivers/char/pcxx.c:230: warning: parameter names (without types) in function declaration
drivers/char/pcxx.c:230: warning: data definition has no type or storage class
drivers/char/pcxx.c:1016: redefinition of `__initcall_pcxe_init'
drivers/char/pcxx.c:229: `__initcall_pcxe_init' previously defined here
drivers/char/pcxx.c:1016: `pcxe_init' undeclared here (not in a function)
drivers/char/pcxx.c:1017: `pcxe_exit' undeclared here (not in a function)
drivers/char/pcxx.c: In function `pcxe_tiocmget':
drivers/char/pcxx.c:2009: `mstat' undeclared (first use in this function)
drivers/char/pcxx.c:2009: (Each undeclared identifier is reported only once
drivers/char/pcxx.c:2009: for each function it appears in.)
drivers/char/pcxx.c: In function `pcxe_tiocmset':
drivers/char/pcxx.c:2072: warning: control reaches end of non-void function
drivers/char/pcxx.c: At top level:
drivers/char/pcxx.c:1044: warning: `pcxe_init' defined but not used
make[2]: *** [drivers/char/pcxx.o] Error 1

<--  snip  -->


The patch below (only compilation tested) fixes all errors and warnings.


diffstat output:
 drivers/char/pcxx.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm2-full/drivers/char/pcxx.c.old	2004-08-31 13:30:28.000000000 +0200
+++ linux-2.6.9-rc1-mm2-full/drivers/char/pcxx.c	2004-08-31 14:06:28.000000000 +0200
@@ -206,7 +200,7 @@
 {
 
 	unsigned long	flags;
-	int e1, e2;
+	int e1;
 
 	printk(KERN_NOTICE "Unloading PC/Xx version %s\n", VERSION);
 
@@ -223,12 +217,6 @@
 	restore_flags(flags);
 }
 
-/*
- * pcxe_init() is our init_module():
- */
-module_init(pcxe_init);
-module_cleanup(pcxe_cleanup);
-
 static inline struct channel *chan(register struct tty_struct *tty)
 {
 	if (tty) {
@@ -1013,9 +1001,6 @@
 }
 #endif
 
-module_init(pcxe_init)
-module_exit(pcxe_exit)
-
 static struct tty_operations pcxe_ops = {
 	.open = pcxe_open,
 	.close = pcxe_close,
@@ -1561,6 +1546,8 @@
 	return ret;
 }
 
+module_init(pcxe_init)
+module_exit(pcxe_cleanup)
 
 static void pcxxpoll(unsigned long dummy)
 {
@@ -1995,6 +1982,7 @@
 	volatile struct board_chan *bc;
 	unsigned long flags;
 	int mflag = 0;
+	int mstat;
 
 	if(ch)
 		bc = ch->brdchan;
@@ -2069,6 +2057,7 @@
 	pcxxparam(tty,ch);
 	memoff(ch);
 	restore_flags(flags);
+	return 0;
 }
 
 

