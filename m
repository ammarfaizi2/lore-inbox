Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSJQU4Y>; Thu, 17 Oct 2002 16:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbSJQU4Y>; Thu, 17 Oct 2002 16:56:24 -0400
Received: from crack.them.org ([65.125.64.184]:54282 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262076AbSJQU4X>;
	Thu, 17 Oct 2002 16:56:23 -0400
Date: Thu, 17 Oct 2002 17:02:21 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: fix task state reporting
Message-ID: <20021017210221.GA18872@nevyn.them.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021017213812.D3326@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017213812.D3326@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 09:38:12PM +0100, Russell King wrote:
> Hi,
> 
> While running a test here, I noticed that some threads kept entering
> "T" state according to ps aux.  However, rather than stop, they'd
> disappear on the next process listing, as though they weren't stopped.
> 
> Further investigation revealed the following when suspending processes:
> 
> root      1497  3.8  1.7  1472  544 ttyp1    Z    00:05   0:21 find / -name pro
> 
> Yes, 'Z' for suspended, 'T' for zombie.  Something smells fishy here.
> 
> #define TASK_RUNNING		0
> #define TASK_INTERRUPTIBLE	1
> #define TASK_UNINTERRUPTIBLE	2
> #define TASK_STOPPED		4
> #define TASK_ZOMBIE		8
> #define TASK_DEAD		16
> 
> So that's R S D T Z W, but sched.c contains R S D Z T W (Z and T
> reversed).  This patch corrects sched.c.  (Should we correct
> the order of bits in sched.h instead?)

fs/proc/array.c needs the same fix.  I sent this to Ingo but he must
have lost my mail....

===== fs/proc/array.c 1.30 vs edited =====
--- 1.30/fs/proc/array.c	Mon Sep 30 05:06:43 2002
+++ edited/fs/proc/array.c	Tue Oct  1 13:45:13 2002
@@ -125,9 +125,9 @@
 	"R (running)",		/*  0 */
 	"S (sleeping)",		/*  1 */
 	"D (disk sleep)",	/*  2 */
-	"Z (zombie)",		/*  4 */
-	"T (stopped)",		/*  8 */
-	"W (paging)"		/* 16 */
+	"T (stopped)",		/*  4 */
+	"Z (zombie)",		/*  8 */
+	"X (dead)"		/* 16 */
 };
 
 static inline const char * get_task_state(struct task_struct *tsk)
@@ -135,8 +135,9 @@
 	unsigned int state = tsk->state & (TASK_RUNNING |
 					   TASK_INTERRUPTIBLE |
 					   TASK_UNINTERRUPTIBLE |
+					   TASK_STOPPED |
 					   TASK_ZOMBIE |
-					   TASK_STOPPED);
+					   TASK_DEAD);
 	const char **p = &task_state_array[0];
 
 	while (state) {

> 
> --- orig/kernel/sched.c	Wed Oct 16 09:17:13 2002
> +++ linux/kernel/sched.c	Thu Oct 17 21:32:42 2002
> @@ -1798,7 +1798,7 @@
>  	unsigned long free = 0;
>  	task_t *relative;
>  	int state;
> -	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
> +	static const char * stat_nam[] = { "R", "S", "D", "T", "Z", "W" };
>  
>  	printk("%-13.13s ", p->comm);
>  	state = p->state ? __ffs(p->state) + 1 : 0;
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
