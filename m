Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVHASJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVHASJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVHASJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:09:51 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:15810 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261333AbVHASJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:09:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=tDKoUo7L/rw2w6tLaTge1RwTGiQEI+S1YoPC7ulFtT5tbSsc6u3xIBXKmehcX7nIwmxxqLUrFZsbJpIk0h9UohzOQoop1SG/cawLUeBs2J3b9BIdjc38SDjB+gJe6YwO4DtdYf44IeBOG+jmd89PCjX54Qsc0chcefMwiKjwml4=
Message-ID: <42EE4D27.8060500@gmail.com>
Date: Mon, 01 Aug 2005 16:26:15 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED declaration
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes broken rt_init_MUTEX_LOCKED declaration using rt_sema_init()
macro. This way we fix a potential compile bug: rt_init_MUTEX_LOCKED calls
there_is_no_init_MUTEX_LOCKED_for_RT_semaphores, which is not referenced.
(e.g. drivers/char/watchdog/cpu5wdt.c: "cpu5wdt: Unknown symbol
there_is_no_init_MUTEX_LOCKED_for_RT_semaphores")



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- realtime-preempt-2.6.13-rc4-RT-V0.7.52-07.orig	2005-07-31 23:35:18.000000000
+0000
+++ realtime-preempt-2.6.13-rc4-RT-V0.7.52-07		2005-08-01 15:59:31.000000000 +0000
@@ -8342,16 +8342,6 @@ Index: linux/drivers/cpufreq/cpufreq.c
 ===================================================================
 --- linux.orig/drivers/cpufreq/cpufreq.c
 +++ linux/drivers/cpufreq/cpufreq.c
-@@ -605,7 +605,8 @@ static int cpufreq_add_dev (struct sys_d
- 	policy->cpu = cpu;
- 	policy->cpus = cpumask_of_cpu(cpu);
-
--	init_MUTEX_LOCKED(&policy->lock);
-+	init_MUTEX(&policy->lock);
-+	down(&policy->lock);
- 	init_completion(&policy->kobj_unregister);
- 	INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);
-
 @@ -614,6 +615,7 @@ static int cpufreq_add_dev (struct sys_d
  	 */
  	ret = cpufreq_driver->init(policy);
@@ -14350,7 +14340,7 @@ Index: linux/include/linux/rt_lock.h
 ===================================================================
 --- /dev/null
 +++ linux/include/linux/rt_lock.h
-@@ -0,0 +1,391 @@
+@@ -0,0 +1,385 @@
 +#ifndef __LINUX_RT_LOCK_H
 +#define __LINUX_RT_LOCK_H
 +
@@ -14589,14 +14579,8 @@ Index: linux/include/linux/rt_lock.h
 +extern void FASTCALL(__init_MUTEX(struct semaphore *sem, char *name, char
*file, int line));
 +#define rt_init_MUTEX(sem) \
 +		__init_MUTEX(sem, #sem, __FILE__, __LINE__)
-+
-+extern void there_is_no_init_MUTEX_LOCKED_for_RT_semaphores(void);
-+
-+/*
-+ * No locked initialization for RT semaphores
-+ */
 +#define rt_init_MUTEX_LOCKED(sem) \
-+		there_is_no_init_MUTEX_LOCKED_for_RT_semaphores()
++		rt_sema_init(sem, 0)
 +extern void FASTCALL(rt_down(struct semaphore *sem));
 +extern int FASTCALL(rt_down_interruptible(struct semaphore *sem));
 +extern int FASTCALL(rt_down_trylock(struct semaphore *sem));




Regards,
-- 
					Luca

