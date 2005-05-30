Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVE3Jw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVE3Jw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVE3Jw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:52:26 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:32448 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261584AbVE3JwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:52:04 -0400
Message-ID: <429AE21C.2020309@stud.feec.vutbr.cz>
Date: Mon, 30 May 2005 11:51:24 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <42978730.4040205@stud.feec.vutbr.cz> <20050528055322.GA14867@elte.hu>
In-Reply-To: <20050528055322.GA14867@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000005010807060101020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005010807060101020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> RT semaphores have stricter semantics than Linux semaphores. One 
> property is that there always needs to be an owner of a semaphore. If a 
> semaphore gets initialized as init_MUTEX_LOCKED, it is a fair indication
> that the semaphore is really used as a completion object - with no
> stable owner.  (e.g. at insmod time when the init_MUTEX_LOCKED is done,
> the insmod thread will go away after some time, leaving the semaphore
> 'orphaned')

Thanks for the explanation. In that case calling init_MUTEX_LOCKED on an 
RT semaphore is obviously wrong.
However, it only produces a warning during the compilation and is 
guaranteed to BUG when run. It would be better if it obviously failed to 
compile. How about the attached patch?
That makes the compilation fail like this:

drivers/cpufreq/cpufreq.c: In function `cpufreq_add_dev':
drivers/cpufreq/cpufreq.c:608: error: 
`there_is_no_init_MUTEX_LOCKED_for_RT_semaphores' undeclared (first use 
in this function)
drivers/cpufreq/cpufreq.c:608: error: (Each undeclared identifier is 
reported only once
drivers/cpufreq/cpufreq.c:608: error: for each function it appears in.)
make[2]: *** [drivers/cpufreq/cpufreq.o] Error 1
make[1]: *** [drivers/cpufreq] Error 2
make: *** [drivers] Error 2

Michal

--------------000005010807060101020808
Content-Type: text/plain;
 name="rt_init_MUTEX_LOCKED.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_init_MUTEX_LOCKED.diff"

diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/include/linux/rt_lock.h linux-RT.mich/include/linux/rt_lock.h
--- linux-RT/include/linux/rt_lock.h	2005-05-30 10:42:47.000000000 +0200
+++ linux-RT.mich/include/linux/rt_lock.h	2005-05-30 11:32:12.000000000 +0200
@@ -201,11 +201,13 @@ extern void FASTCALL(__sema_init(struct 
 		__sema_init(sem, val, #sem, __FILE__, __LINE__)
 	
 extern void FASTCALL(__init_MUTEX(struct semaphore *sem, char *name, char *file, int line));
-extern void FASTCALL(__init_MUTEX_LOCKED(struct semaphore *sem, char *name, char *file, int line));
 #define rt_init_MUTEX(sem) \
 		__init_MUTEX(sem, #sem, __FILE__, __LINE__)
+/*
+ * No locked initialization for RT semaphores
+ */
 #define rt_init_MUTEX_LOCKED(sem) \
-		__init_MUTEX_LOCKED(sem, #sem, __FILE__, __LINE__)
+		there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
 extern void FASTCALL(rt_down(struct semaphore *sem));
 extern int FASTCALL(rt_down_interruptible(struct semaphore *sem));
 extern int FASTCALL(rt_down_trylock(struct semaphore *sem));
@@ -259,6 +261,10 @@ do {									\
 	PICK_FUNC_1ARG(struct compat_semaphore, struct semaphore, \
 		compat_init_MUTEX, rt_init_MUTEX, sem)
 
+#define init_MUTEX_LOCKED(sem) \
+	PICK_FUNC_1ARG(struct compat_semaphore, struct semaphore, \
+		compat_init_MUTEX_LOCKED, rt_init_MUTEX_LOCKED, sem)
+
 #define down(sem) \
 	PICK_FUNC_1ARG(struct compat_semaphore, struct semaphore, \
 		compat_down, rt_down, sem)
@@ -284,11 +290,6 @@ do {									\
 		compat_sema_count, rt_sema_count, sem)
 
 /*
- * No locked initialization for RT semaphores:
- */
-#define init_MUTEX_LOCKED(sem) compat_init_MUTEX_LOCKED(sem)
-
-/*
  * rwsems:
  */
 

--------------000005010807060101020808--
