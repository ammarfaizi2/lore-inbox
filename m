Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVFGLva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVFGLva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVFGLva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:51:30 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:39396 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261834AbVFGLvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:51:22 -0400
Message-ID: <42A58A3A.4080002@stud.feec.vutbr.cz>
Date: Tue, 07 Jun 2005 13:51:22 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
References: <20050607110409.GA14613@elte.hu>
In-Reply-To: <20050607110409.GA14613@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010600010606000305080608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600010606000305080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.47-20 Real-Time Preemption patch, which can be 
> downloaded from the usual place:

It doesn't build with CONFIG_RT_DEADLOCK_DETECT:
    CC      arch/i386/kernel/cpu/mtrr/main.o
arch/i386/kernel/cpu/mtrr/main.c:52: error: syntax error at '#' token
arch/i386/kernel/cpu/mtrr/main.c:52: error: `lockname' undeclared here 
(not in a function)
arch/i386/kernel/cpu/mtrr/main.c:52: error: initializer element is not
constant
arch/i386/kernel/cpu/mtrr/main.c:52: error: (near initialization for
`main_lock.lock.name')
arch/i386/kernel/cpu/mtrr/main.c:52: error: initializer element is not
constant
arch/i386/kernel/cpu/mtrr/main.c:52: error: (near initialization for
`main_lock.lock')
make[3]: *** [arch/i386/kernel/cpu/mtrr/main.o] Error 1


Patch attached.

Michal


--------------010600010606000305080608
Content-Type: text/plain;
 name="rt-lockname.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-lockname.diff"

--- linux-RT.mich/include/linux/rt_lock.h.orig	2005-06-07 13:45:18.000000000 +0200
+++ linux-RT.mich/include/linux/rt_lock.h	2005-06-07 13:44:02.000000000 +0200
@@ -97,10 +97,10 @@ struct rt_mutex_waiter {
 };
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
-# define __RT_MUTEX_DEADLOCK_DETECT_INITIALIZER \
+# define __RT_MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) \
 	, .name = #lockname, .file = __FILE__, .line = __LINE__
 #else
-# define __RT_MUTEX_DEADLOCK_DETECT_INITIALIZER
+# define __RT_MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname)
 #endif
 
 #ifdef CONFIG_DEBUG_RT_LOCKING_MODE
@@ -114,7 +114,7 @@ struct rt_mutex_waiter {
 #define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
 	.wait_list = PLIST_INIT((lockname).wait_list, MAX_PRIO)  \
-	__RT_MUTEX_DEADLOCK_DETECT_INITIALIZER \
+	__RT_MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) \
 	__RT_MUTEX_DEBUG_RT_LOCKING_MODE_INITIALIZER }
 
 /*


--------------010600010606000305080608--
