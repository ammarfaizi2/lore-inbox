Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSHPAbk>; Thu, 15 Aug 2002 20:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSHPAbk>; Thu, 15 Aug 2002 20:31:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34456 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317648AbSHPAbj>; Thu, 15 Aug 2002 20:31:39 -0400
Message-ID: <3D5C48D1.5090606@us.ibm.com>
Date: Thu, 15 Aug 2002 17:35:29 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Keith Mannthey <kmannth@us.ibm.com>
Subject: [RFC] reduce concurrent panic garbage
Content-Type: multipart/mixed;
 boundary="------------010501070308050605020000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010501070308050605020000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

When one CPU panics, another usually isn't far behind.  This patch 
makes sure that we don't get concurrent panics that write to the 
console at the same time.  Keith Mannthey wrote this a long time ago 
and has been using it for a while, but I'm starting to wonder about 
correctness, particularly holding a spinlock across sys_sync().  It 
looks like printk has some magic so that it doesn't deadlock.

Instead of the way that Keith did it, are there any problems with this?

spin_lock(&panic_lock);
printk(KERN_EMERG "Kernel panic: %s\n",buf);
if (in_interrupt()) {
	printk(KERN_EMERG "In interrupt handler - not syncing\n");
	spin_unlock(&panic_lock);
}
else if (!current->pid) {
	printk(KERN_EMERG "In idle task - not syncing\n");
	spin_unlock(&panic_lock);
}
else {
	spin_unlock(&panic_lock);
	sys_sync();
}

An examble of munged panics:
kernel BUG at softirq.c:229!
invalid operand: 0000
CPU:    4
EIP:    0060:[<8011c8bd>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 80374f40   ecx: f7f98000   edx: 802f650c
esi: 00000000   edi: f7f98000   ebp: 80357560   esp: f7f99fb0
ds: 0068   es: 0068   ss: 0068
Process ksoftirqd_CPU4 (pid: 11, threadinfo=f7f98000 task=f7f9ccc0)
Stack: 00000001 80353960 fffffffe 00000080 8011c60a 80353960 f7f98000 
00000080
        f7f98000 80374b40 00000246 8011cb66 8011caa8 00000000 00000000 
00000000
        80105691 00000004 00000000 00000000
Call Trace: [<8011c60a>] [<8011cb66>] [<8011caa8>] [<80105691>]

Code: 0f 0b e5 00 f3 73 27 80 8b 43 10 50 8b 43 0c ff d0 83 c4 04
  <e0e>,Ke kr2n2e9l !p
0>iKnvearlnield  poapneiracn:d 2:9 0!0
0A                                    0
C<P4U>: C PU : 2
  E2I
: E IP  : 00  6 00:0[6< 0:n[o<t 8s01yn1cci8bndg>
      Not tainted                                ]
EFLAGS: 00010246
eax: 00000000   ebx: 80374f54   ecx: 8038f50c   edx: 8038f50c
esi: 00000000   edi: f7fbe000   ebp: 80357560   esp: f7fbff38
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=f7fbe000 task=f7fc6cc0)
Stack: 00000001 80353960 fffffffe 00000040 8011c60a 80353960 00000000 
8033b800
        00000000 f7fbff78 00000046 801092e1 f7fbe000 80105334 00000000 
802de368
        00000000 80107d28 f7fbe000 00000180 f7fbe000 80105334 00000000 
00000000
Call Trace: [<8011c60a>] [<801092e1>] [<80105334>] [<80107d28>] 
[<80105334>]
    [<8010535d>] [<801053b3>] [<801180dd>]

Code: 0f 0b e5 00 f3 73 27 80 8b 43 10 50 8b 43 0c ff d0 83 c4 04
-- 
Dave Hansen
haveblue@us.ibm.com

--------------010501070308050605020000
Content-Type: text/plain;
 name="panic-lock-2.5.31+bk-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="panic-lock-2.5.31+bk-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.524   -> 1.525  
#	      kernel/panic.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/15	haveblue@elm3b96.(none)	1.525
# keep panics from mixing with each other.
# --------------------------------------------
#
diff -Nru a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	Thu Aug 15 17:03:05 2002
+++ b/kernel/panic.c	Thu Aug 15 17:03:05 2002
@@ -20,6 +20,7 @@
 asmlinkage void sys_sync(void);	/* it's really int */
 
 int panic_timeout;
+static spinlock_t panic_lock = SPIN_LOCK_UNLOCKED;
 
 struct notifier_block *panic_notifier_list;
 
@@ -48,7 +49,8 @@
 #if defined(CONFIG_ARCH_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
-
+	
+	spin_lock(&panic_lock);
 	bust_spinlocks(1);
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
@@ -61,6 +63,7 @@
 	else
 		sys_sync();
 	bust_spinlocks(0);
+	spin_unlock(&panic_lock);
 
 #ifdef CONFIG_SMP
 	smp_send_stop();

--------------010501070308050605020000--

