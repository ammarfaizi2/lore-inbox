Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVBKJLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVBKJLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVBKJLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:11:36 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:57 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262045AbVBKJJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:09:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=MeUCiajYwMID5Q4WmQQZs4wmxQebKSj1Qbia+STRyy+6CrQ5cAWK0cEH/8NM4TPJwdikC8iGXke2131WkkqGZ4CrbTcxHfxOs/tqQxR2UjgV2N982ENSGHmid2TAbnD9TI/CxJEgd5t/f8QxzuQEmkUJz7gfHNlmmzTU8tIG3+g=
Message-ID: <25349aa4050211010930333ae3@mail.gmail.com>
Date: Fri, 11 Feb 2005 02:09:10 -0700
From: Tipp Moseley <tipp.moseley@gmail.com>
Reply-To: Tipp Moseley <tipp.moseley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Potential timer bug
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_219_19283938.1108112950229"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_219_19283938.1108112950229
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am running on a uniprocessor x86 with CONFIG_SMP disabled and
CONFIG_PREEMPT enabled.

The problem I have encountered is when using a timer in a module.  The
timer is set to execute every 3 ticks, and does nothing but increment
a counter, and that works fine.  However, when the module is unloaded
sometimes the system hangs on module exit and barfs something like:

Unable to handle kernel paging request at virtual address e18861bc
 printing eip:
c0122a88
*pde = 015e5067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: yenta socket, rsrc_nonstatic sonypi
CPU: 0
...
Call Trace:
 __do_softirq+0x76/0x90
 do_softirq+0x41/0x50
...
<0>Kernel panic - not syncing: Fatal exception in interrupt


I am using del_timer_sync to delete the timer in the module_exit
routine, and sometimes it works correctly.  My theory is that since
with CONFIG_SMP disabled, del_timer_sync is the same as del_timer. 
This allows the timer to potentially execute after the module has
unloaded, causing the invalid paging request.

My solution to the problem (which works, but is probably not optimal)
is to change '#ifdef CONFIG_SMP' to '#if defined(CONFIG_SMP) ||
defined(CONFIG_PREEMPT)' around the code defining timer_del_sync.  A
patch is attached.  Let me know if there's any more information that I
can provide.

Thanks,

Tipp Moseley

------=_Part_219_19283938.1108112950229
Content-Type: application/octet-stream; name=linux-2.6.11-rc3-bk7-timer
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.6.11-rc3-bk7-timer"

diff -urN linux-2.6.11-rc3-bk7/include/linux/timer.h linux-2.6.11-rc3-bk7-patched/include/linux/timer.h
--- linux-2.6.11-rc3-bk7/include/linux/timer.h	2004-12-24 14:35:23.000000000 -0700
+++ linux-2.6.11-rc3-bk7-patched/include/linux/timer.h	2005-02-11 01:16:39.000000000 -0700
@@ -87,7 +87,7 @@
 	__mod_timer(timer, timer->expires);
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
   extern int del_timer_sync(struct timer_list *timer);
   extern int del_singleshot_timer_sync(struct timer_list *timer);
 #else
diff -urN linux-2.6.11-rc3-bk7/kernel/timer.c linux-2.6.11-rc3-bk7-patched/kernel/timer.c
--- linux-2.6.11-rc3-bk7/kernel/timer.c	2005-02-11 01:09:38.000000000 -0700
+++ linux-2.6.11-rc3-bk7-patched/kernel/timer.c	2005-02-11 01:16:53.000000000 -0700
@@ -318,7 +318,7 @@
 
 EXPORT_SYMBOL(del_timer);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 /***
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated

------=_Part_219_19283938.1108112950229--
