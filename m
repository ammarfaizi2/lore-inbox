Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTEUJQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTEUJQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:16:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19214 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261852AbTEUJQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:16:24 -0400
Date: Wed, 21 May 2003 10:29:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vladimir Serov <vserov@infratel.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
Message-ID: <20030521102923.B17709@flint.arm.linux.org.uk>
Mail-Followup-To: Vladimir Serov <vserov@infratel.com>,
	trond.myklebust@fys.uio.no,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <15993.60520.439204.267818@charged.uio.no> <3E7ADBFD.4060202@infratel.com> <shsof45nf58.fsf@charged.uio.no> <3E7B0051.8060603@infratel.com> <15995.578.341176.325238@charged.uio.no> <3E7B10DF.5070005@infratel.com> <15995.5996.446164.746224@charged.uio.no> <3E7B1DF9.2090401@infratel.com> <15995.10797.983569.410234@charged.uio.no> <3EC8DA1B.50304@infratel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EC8DA1B.50304@infratel.com>; from vserov@infratel.com on Mon, May 19, 2003 at 05:20:27PM +0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 05:20:27PM +0400, Vladimir Serov wrote:
> My current kernel is 2.4.21-pre6 based with patches from 2.4.19-rmk7 
> applied (well partially, except ide and pci cause i don't have them, 
> board is mostly brutus). I'm using HARD mounted nfs
> volume now !!! The tail of dmesg is following.

Looking back on stuff which happened a long time ago, there's a
possibility that there's an ordering issue with set_current_state.

Please note that this is affects _all_ 2.4 architectures.

I think this was discussed about 6 months ago, so I'm surprised this
hasn't made it into the 2.4.2x kernel (or no one else has seen the
problem.)

Please note that since I don't track 2.4 kernels currently, I've no
idea whether 2.4.21-pre/rc has this fix.  (This means if Marcelo
drops or ignores the fix, it won't get re-sent.)  Certainly gcc 3
requires this patch.  I've not heard of gcc 2.95.x tripping over
this problem though.

The problem area is:

#define __set_task_state(tsk, state_value)              \
        do { (tsk)->state = (state_value); } while (0)
#ifdef CONFIG_SMP
#define set_task_state(tsk, state_value)                \
        set_mb((tsk)->state, (state_value))
#else
#define set_task_state(tsk, state_value)                \
        __set_task_state((tsk), (state_value))
#endif

#define __set_current_state(state_value)                        \
        do { current->state = (state_value); } while (0)
#ifdef CONFIG_SMP
#define set_current_state(state_value)          \
        set_mb(current->state, (state_value))
#else
#define set_current_state(state_value)          \
        __set_current_state(state_value)
#endif

As they currently stand, there is no guarantee that the assignment to
"->state" occurs before the condition in wait_event is processed.

The attached patch should fix your problem.  It should be applied to
2.4.2x.  All architectures which do not provide set_mb() need to be
fixed.

--- ref/include/linux/sched.h	Wed Mar 19 15:54:45 2003
+++ linux/include/linux/sched.h	Wed May 14 09:45:31 2003
@@ -94,23 +94,13 @@
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
-#ifdef CONFIG_SMP
 #define set_task_state(tsk, state_value)		\
 	set_mb((tsk)->state, (state_value))
-#else
-#define set_task_state(tsk, state_value)		\
-	__set_task_state((tsk), (state_value))
-#endif
 
 #define __set_current_state(state_value)			\
 	do { current->state = (state_value); } while (0)
-#ifdef CONFIG_SMP
 #define set_current_state(state_value)		\
 	set_mb(current->state, (state_value))
-#else
-#define set_current_state(state_value)		\
-	__set_current_state(state_value)
-#endif
 
 /*
  * Scheduling policies
--- ref/include/asm-arm/system.h	Wed Sep 11 17:30:52 2002
+++ linux/include/asm-arm/system.h	Wed May 14 09:46:20 2003
@@ -46,6 +46,8 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define set_mb(var, value)  do { var = value; mb(); } while (0)
+#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 #define prepare_to_switch()    do { } while(0)


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
