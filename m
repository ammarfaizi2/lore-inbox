Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDKKh3>; Wed, 11 Apr 2001 06:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbRDKKhT>; Wed, 11 Apr 2001 06:37:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12815 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132550AbRDKKhB>;
	Wed, 11 Apr 2001 06:37:01 -0400
Date: Wed, 11 Apr 2001 07:34:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: george anzinger <george@mvista.com>
Cc: SodaPop <soda@xirr.com>, alexey@datafoundation.com,
        linux-kernel@vger.kernel.org
Subject: [test-PATCH] Re: [QUESTION] 2.4.x nice level
In-Reply-To: <Pine.LNX.4.21.0104101308320.11038-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0104110726210.25737-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Rik van Riel wrote:

> I'll try to come up with a recalculation change that will make
> this thing behave better, while still retaining the short time
> slices for multiple normal-priority tasks and the cache footprint
> schedule() and friends currently have...

OK, here it is. It's nothing like montavista's singing-dancing
scheduler patch that does all, just a really minimal change that
should stretch the nice levels to yield the following CPU usage:

Nice    0    5   10   15   19
%CPU  100   56   25    6    1

Note that the code doesn't change the actual scheduling code,
just the recalculation. Care has also been taken to not increase
the cache footprint of the scheduling and recalculation code.

I'd love to hear some test results from people who are interested
in wider nice levels. How does this run on your system?  Can you
trigger bad behaviour in any way?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/



--- linux-2.4.3-ac4/kernel/sched.c.orig	Tue Apr 10 21:04:06 2001
+++ linux-2.4.3-ac4/kernel/sched.c	Wed Apr 11 06:18:46 2001
@@ -686,8 +686,26 @@
 		struct task_struct *p;
 		spin_unlock_irq(&runqueue_lock);
 		read_lock(&tasklist_lock);
-		for_each_task(p)
+		for_each_task(p) {
+		    if (p->nice <= 0) {
+			/* The normal case... */
 			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+		    } else {
+			/*
+			 * Niced tasks get less CPU less often, leading to
+			 * the following distribution of CPU time:
+			 *
+			 * Nice    0    5   10   15   19
+			 * %CPU  100   56   25    6    1	
+			 */
+			short prio = 20 - p->nice;
+			p->nice_calc += prio;
+			if (p->nice_calc >= 20) {
+			    p->nice_calc -= 20;
+			    p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+			}
+		    }
+		}
 		read_unlock(&tasklist_lock);
 		spin_lock_irq(&runqueue_lock);
 	}
--- linux-2.4.3-ac4/include/linux/sched.h.orig	Tue Apr 10 21:04:13 2001
+++ linux-2.4.3-ac4/include/linux/sched.h	Wed Apr 11 06:26:47 2001
@@ -303,7 +303,8 @@
  * the goodness() loop in schedule().
  */
 	long counter;
-	long nice;
+	short nice_calc;
+	short nice;
 	unsigned long policy;
 	struct mm_struct *mm;
 	int has_cpu, processor;

