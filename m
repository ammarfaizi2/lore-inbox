Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031572AbWK3W2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031572AbWK3W2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031575AbWK3W2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:28:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:22412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031572AbWK3W2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:28:31 -0500
Date: Thu, 30 Nov 2006 14:27:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Ingo Molnar <mingo@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
Message-Id: <20061130142719.7474b4c0.akpm@osdl.org>
In-Reply-To: <20061130141140.a1b7d7cc.randy.dunlap@oracle.com>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
	<20061129174558.3dfd13df.akpm@osdl.org>
	<1164870000.11036.23.camel@earth>
	<20061130141140.a1b7d7cc.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 14:11:40 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Thu, 30 Nov 2006 08:00:00 +0100 Ingo Molnar wrote:
> 
> > On Wed, 2006-11-29 at 17:45 -0800, Andrew Morton wrote:
> > > No, I think this patch is right - the declaration of the CONFIG_SMP
> > > smp_call_function_single() is in linux/smp.h so the !CONFIG_SMP
> > > declaration
> > > or definition should be there too.
> > > 
> > > It's still buggy though.  It should disable local interrupts around
> > > the
> > > call to match the SMP version.  I'll fix that separately. 
> > 
> > hm, didnt i send an updated patch for that already? See the patch below,
> > from many days ago. I sent it after the tsc-sync-rewrite patch.
> 
> Hi Ingo,
> 
> Has there been a patch for this one?  (UP again, not SMP)
> 
> drivers/input/ff-memless.c:384: warning: implicit declaration of function 'local_bh_disable'
> drivers/input/ff-memless.c:393: warning: implicit declaration of function 'local_bh_enable'
> 
> Thanks,
> ---
> ~Randy
> config:  http://oss.oracle.com/~rdunlap/configs/config-input-up-header

eww..  I guess linux/spinlock.h should really include linux/interrupt.h. 
But interrupt.h includes stuff like sched.h which will want spinlock.h.

This, maybe?

 include/linux/bottom_half.h |    5 +++++
 include/linux/interrupt.h   |    7 +------
 include/linux/spinlock.h    |    1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

diff -puN /dev/null include/linux/bottom_half.h
--- /dev/null
+++ a/include/linux/bottom_half.h
@@ -0,0 +1,5 @@
+extern void local_bh_disable(void);
+extern void __local_bh_enable(void);
+extern void _local_bh_enable(void);
+extern void local_bh_enable(void);
+extern void local_bh_enable_ip(unsigned long ip);
diff -puN include/linux/interrupt.h~add-bottom_half.h include/linux/interrupt.h
--- a/include/linux/interrupt.h~add-bottom_half.h
+++ a/include/linux/interrupt.h
@@ -11,6 +11,7 @@
 #include <linux/hardirq.h>
 #include <linux/sched.h>
 #include <linux/irqflags.h>
+#include <linux/bottom_half.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -217,12 +218,6 @@ static inline void __deprecated save_and
 #define save_and_cli(x)	save_and_cli(&x)
 #endif /* CONFIG_SMP */
 
-extern void local_bh_disable(void);
-extern void __local_bh_enable(void);
-extern void _local_bh_enable(void);
-extern void local_bh_enable(void);
-extern void local_bh_enable_ip(unsigned long ip);
-
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
    frequency threaded job scheduling. For almost all the purposes
    tasklets are more than enough. F.e. all serial device BHs et
diff -puN include/linux/spinlock.h~add-bottom_half.h include/linux/spinlock.h
--- a/include/linux/spinlock.h~add-bottom_half.h
+++ a/include/linux/spinlock.h
@@ -52,6 +52,7 @@
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <linux/bottom_half.h>
 
 #include <asm/system.h>
 
_

