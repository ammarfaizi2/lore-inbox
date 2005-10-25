Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbVJYBvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbVJYBvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVJYBvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:51:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751409AbVJYBvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:51:54 -0400
Date: Mon, 24 Oct 2005 18:51:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.14-rc5-mm1 build fails for non SMP systems
Message-Id: <20051024185110.2ee04f4c.akpm@osdl.org>
In-Reply-To: <435D8DA9.4030200@bigpond.net.au>
References: <435D8675.3080303@bigpond.net.au>
	<435D8DA9.4030200@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> Further investigation reveals a number of similar warnings for 
>  __raw_write_unlock() and the following failure in the ipv4 code:

yup.  Please use this:


From: Miklos Szeredi <miklos@szeredi.hu>

The "inline spin_unlock..." patches don't compile on:

CONFIG_PREEMPT=n
CONFIG_DEBUG_SPINLOCK=n
CONFIG_SMP=n

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/spinlock.h~x86-inline-spin_unlock-if-not-config_debug_spinlock-and-not-config_preempt-fix include/linux/spinlock.h
--- 25/include/linux/spinlock.h~x86-inline-spin_unlock-if-not-config_debug_spinlock-and-not-config_preempt-fix	Mon Oct 24 15:44:38 2005
+++ 25-akpm/include/linux/spinlock.h	Mon Oct 24 15:44:38 2005
@@ -174,7 +174,7 @@ extern int __lockfunc generic__raw_read_
 /*
  * We inline the unlock functions in the nondebug case:
  */
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 # define spin_unlock(lock)		_spin_unlock(lock)
 # define read_unlock(lock)		_read_unlock(lock)
 # define write_unlock(lock)		_write_unlock(lock)
@@ -184,7 +184,7 @@ extern int __lockfunc generic__raw_read_
 # define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
 #endif
 
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 # define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 # define read_unlock_irq(lock)		_read_unlock_irq(lock)
 # define write_unlock_irq(lock)		_write_unlock_irq(lock)
_

