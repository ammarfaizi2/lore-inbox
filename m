Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTD3MQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTD3MQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:16:28 -0400
Received: from holomorphy.com ([66.224.33.161]:21714 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262144AbTD3MQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:16:27 -0400
Date: Wed, 30 Apr 2003 05:28:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: NUMA-Q sys_ioperm()/sys_iopl()
Message-ID: <20030430122825.GL8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA-Q cannot support these operations without significant
infrastructure to emulate a global port io space for userspace to
manipulate, possibly even with hooks into the scheduler.

Not only are the applications depending on this particular form of
privilege elevation generally inappropriate uses of these machines
(they are large "server-class" machines, typically shipped and run
headless), but the devices typically managed with these interfaces
are already explicitly unsupported in UNIX configurations.

This patch removes sys_iopl() and sys_ioperm() support conditional on
#ifdef CONFIG_X86_NUMAQ to prevent the device register corruption
condition without significant impact on core i386 support.


diff -urpN linux-2.5.68/arch/i386/kernel/ioport.c ioperm-2.5.68-1/arch/i386/kernel/ioport.c
--- linux-2.5.68/arch/i386/kernel/ioport.c	2003-04-19 19:49:26.000000000 -0700
+++ ioperm-2.5.68-1/arch/i386/kernel/ioport.c	2003-04-30 05:01:09.000000000 -0700
@@ -53,6 +53,12 @@ static void set_bitmap(unsigned long *bi
 /*
  * this changes the io permissions bitmap in the current task.
  */
+#ifdef CONFIG_X86_NUMAQ
+asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
+{
+	return -ENOSYS;
+}
+#else
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
 	struct thread_struct * t = &current->thread;
@@ -97,6 +103,7 @@ asmlinkage int sys_ioperm(unsigned long 
 out:
 	return ret;
 }
+#endif
 
 /*
  * sys_iopl has to be used when you want to access the IO ports
@@ -109,6 +116,12 @@ out:
  * code.
  */
 
+#ifdef CONFIG_X86_NUMAQ
+asmlinkage int sys_iopl(unsigned long unused)
+{
+	return -ENOSYS;
+}
+#else
 asmlinkage int sys_iopl(unsigned long unused)
 {
 	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
@@ -127,3 +140,4 @@ asmlinkage int sys_iopl(unsigned long un
 	set_thread_flag(TIF_IRET);
 	return 0;
 }
+#endif
