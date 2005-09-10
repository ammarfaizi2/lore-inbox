Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVIJV6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVIJV6r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVIJV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:58:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29590 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932261AbVIJV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:58:46 -0400
Message-ID: <43235707.7050909@pobox.com>
Date: Sat, 10 Sep 2005 17:58:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020004000003080803020203"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020004000003080803020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Case closed. 
> 
> Bogus warnings are a _bad_ thing. They cause people to write buggy code.
> 
> That drivers/pci/pci.c code should be simplified to not look at the error
> return from pci_set_power_state() at all. Special-casing EIO is just
> another bug waiting to happen.

As a tangent, the 'foo is deprecated' warnings for pm_register() and 
inter_module_register() annoy me, primarily because they never seem to 
go away.

The only user of inter_module_xxx is CONFIG_MTD -- thus the deprecated 
warning is useless to 90% of us, who will never use MTD.  As for 
pm_register(), there are tons of users remaining.  As such, for the 
forseeable future, we will continue to see pm_register() warnings and 
ignore them -- thus they are nothing but useless build noise.

I've attached a patch, just tested, which addresses inter_module_xxx by 
making its build conditional on the last remaining user.  This solves 
the deprecated warning problem for most of us, and makes the kernel 
smaller for most of us, at the same time.

	Jeff



--------------020004000003080803020203
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -6,7 +6,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
 obj-$(CONFIG_FUTEX) += futex.o
@@ -32,6 +32,13 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 
+ifeq ($(CONFIG_MTD),y)
+obj-y += intermodule.o
+endif
+ifeq ($(CONFIG_MTD),m)
+obj-y += intermodule.o
+endif
+
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond

--------------020004000003080803020203--
