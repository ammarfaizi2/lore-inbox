Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbVI0XKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVI0XKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbVI0XKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:10:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31473 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965233AbVI0XK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:10:29 -0400
Subject: Re: 2.6.14-rc2-rt2
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, emann@mrv.com,
       yang.yi@bmrtech.com, mingo@elte.hu
In-Reply-To: <1127840377.27319.11.camel@cmn3.stanford.edu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
	 <1127840377.27319.11.camel@cmn3.stanford.edu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 27 Sep 2005 16:10:19 -0700
Message-Id: <1127862619.4004.48.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 09:59 -0700, Fernando Lopez-Lezcano wrote:
>  UPD     include/linux/compile.h
> {standard input}: Assembler messages:
> {standard input}:164: Error: can't resolve `.sched.text' {.sched.text
> section} - `.Ltext0' {.text section}
> {standard input}:165: Error: can't resolve `.sched.text' {.sched.text
> section} - `.Ltext0' {.text section}
> make[1]: *** [arch/i386/kernel/semaphore.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/i386/kernel] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Failing .config attached. 
> -- Fernando
> 

Here's the fix.

Index: linux-2.6.13/lib/semaphore-sleepers.c
===================================================================
--- linux-2.6.13.orig/lib/semaphore-sleepers.c
+++ linux-2.6.13/lib/semaphore-sleepers.c
@@ -176,3 +176,10 @@ fastcall int __compat_down_trylock(struc
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
 	return 1;
 }
+
+int fastcall compat_sem_is_locked(struct compat_semaphore *sem)
+{
+	return (int) atomic_read(&sem->count) < 0;
+}
+
+EXPORT_SYMBOL(compat_sem_is_locked);
Index: linux-2.6.13/arch/i386/kernel/semaphore.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/semaphore.c
+++ linux-2.6.13/arch/i386/kernel/semaphore.c
@@ -102,10 +102,3 @@ asm(
 	"ret"
 );
 
-int fastcall compat_sem_is_locked(struct compat_semaphore *sem)
-{
-	return (int) atomic_read(&sem->count) < 0;
-}
-
-EXPORT_SYMBOL(compat_sem_is_locked);
-


