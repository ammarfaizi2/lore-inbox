Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSLCAJG>; Mon, 2 Dec 2002 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSLCAJG>; Mon, 2 Dec 2002 19:09:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:4841 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265754AbSLCAJA>;
	Mon, 2 Dec 2002 19:09:00 -0500
Message-ID: <3DEBF793.90600@us.ibm.com>
Date: Mon, 02 Dec 2002 16:15:15 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: David Woodhouse <dwmw2@redhat.com>
Subject: Re: [PATCH] (3/3)  early printk for 386
References: <3DEBF6BB.7000901@us.ibm.com>
In-Reply-To: <3DEBF6BB.7000901@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050301000004020605000805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050301000004020605000805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Finally, do early printk for i386.  Only serial is supported for now, 
but there is nothing to stop other console types from being added.

  arch/i386/kernel/setup.c |   14 ++++++++++++++
  drivers/serial/8250.c    |    3 +++
  kernel/printk.c          |    2 +-
  3 files changed, 18 insertions(+), 1 deletion(-)

-- 
Dave Hansen
haveblue@us.ibm.com

--------------050301000004020605000805
Content-Type: text/plain;
 name="C-early-printk-i386-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="C-early-printk-i386-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.970   -> 1.971  
#	drivers/serial/8250.c	1.24    -> 1.25   
#	arch/i386/kernel/setup.c	1.64    -> 1.65   
#	     kernel/printk.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/02	haveblue@elm3b96.(none)	1.971
# 2-3
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Dec  2 16:00:27 2002
+++ b/arch/i386/kernel/setup.c	Mon Dec  2 16:00:27 2002
@@ -554,6 +554,20 @@
 	return 1;
 }
 
+static int __init early_printk_setup(char* arg) 
+{
+	/* early printk only works for serial ports now */
+	if (strncmp(arg,"ttyS",4) && strncmp(arg,"/dev/ttyS",9))
+		return 0;
+	
+	console_setup(arg);
+	serial8250_console_init();
+	
+	printk( "early printk enabled \n" );
+	return 1;
+}
+
+__ordered_setup(SETUP_ARCH_BEGIN,"console=",early_printk_setup);
 __ordered_setup(SETUP_ARCH_LATE, "mem=nopentium", arch_setup_mem_nopentium);
 __ordered_setup(SETUP_ARCH_LATE, "mem=exactmap", arch_setup_mem_exactmap);
 __ordered_setup(SETUP_ARCH_LATE, "mem=", arch_setup_mem);
diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	Mon Dec  2 16:00:27 2002
+++ b/drivers/serial/8250.c	Mon Dec  2 16:00:27 2002
@@ -1910,6 +1910,9 @@
 
 void __init serial8250_console_init(void)
 {
+	if (serial8250_console.flags & CON_ENABLED)
+		return;
+	
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 }
diff -Nru a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	Mon Dec  2 16:00:27 2002
+++ b/kernel/printk.c	Mon Dec  2 16:00:27 2002
@@ -99,7 +99,7 @@
 /*
  *	Setup a list of consoles. Called from init/main.c
  */
-static int __init console_setup(char *str)
+int __init console_setup(char *str)
 {
 	struct console_cmdline *c;
 	char name[sizeof(c->name)];

--------------050301000004020605000805--

