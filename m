Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJQUcS>; Thu, 17 Oct 2002 16:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbSJQUcS>; Thu, 17 Oct 2002 16:32:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27918 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262137AbSJQUcP>; Thu, 17 Oct 2002 16:32:15 -0400
Date: Thu, 17 Oct 2002 21:38:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: PATCH: fix task state reporting
Message-ID: <20021017213812.D3326@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While running a test here, I noticed that some threads kept entering
"T" state according to ps aux.  However, rather than stop, they'd
disappear on the next process listing, as though they weren't stopped.

Further investigation revealed the following when suspending processes:

root      1497  3.8  1.7  1472  544 ttyp1    Z    00:05   0:21 find / -name pro

Yes, 'Z' for suspended, 'T' for zombie.  Something smells fishy here.

#define TASK_RUNNING		0
#define TASK_INTERRUPTIBLE	1
#define TASK_UNINTERRUPTIBLE	2
#define TASK_STOPPED		4
#define TASK_ZOMBIE		8
#define TASK_DEAD		16

So that's R S D T Z W, but sched.c contains R S D Z T W (Z and T
reversed).  This patch corrects sched.c.  (Should we correct
the order of bits in sched.h instead?)

--- orig/kernel/sched.c	Wed Oct 16 09:17:13 2002
+++ linux/kernel/sched.c	Thu Oct 17 21:32:42 2002
@@ -1798,7 +1798,7 @@
 	unsigned long free = 0;
 	task_t *relative;
 	int state;
-	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
+	static const char * stat_nam[] = { "R", "S", "D", "T", "Z", "W" };
 
 	printk("%-13.13s ", p->comm);
 	state = p->state ? __ffs(p->state) + 1 : 0;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

