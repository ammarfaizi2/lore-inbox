Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758602AbWK0Xcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602AbWK0Xcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758613AbWK0Xcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:32:42 -0500
Received: from nacho.alt.net ([207.14.113.18]:8910 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1758602AbWK0Xcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:32:41 -0500
Date: Mon, 27 Nov 2006 23:32:39 +0000 (GMT)
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sched: cleanup output of show_state/show_task
In-Reply-To: <20061127143813.a9f4f696.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611272307530.24703@nacho.alt.net>
References: <Pine.LNX.4.64.0611250416240.10489@nacho.alt.net>
	<20061127143813.a9f4f696.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Andrew Morton wrote:
> On Sat, 25 Nov 2006 04:48:15 +0000 (GMT)
> Chris Caputo <ccaputo@alt.net> wrote:
> > This patch cleans up the output of show_state/task() (aka magic-sysrq-t) 
> > so that free stack space is printed as appropriate based on 
> > CONFIG_DEBUG_STACK_USAGE.
> > 
> > Also, without this patch the header is not aligned with the data and is 
> > thus confusing.  Free stack is labeled as pid, pid is labeled as father, 
> > and so on.
> > 
> > Signed-off-by: Chris Caputo <ccaputo@alt.net>
> > ---
> > 
> > diff -uprN a/kernel/sched.c b/kernel/sched.c
> > --- a/kernel/sched.c	2006-11-25 04:11:12.000000000 +0000
> > +++ b/kernel/sched.c	2006-11-25 04:13:07.000000000 +0000
> > @@ -4757,7 +4757,6 @@ static const char stat_nam[] = "RSDTtZX"
> >  static void show_task(struct task_struct *p)
> >  {
> >  	struct task_struct *relative;
> > -	unsigned long free = 0;
> >  	unsigned state;
> >  
> >  	state = p->state ? __ffs(p->state) + 1 : 0;
> > @@ -4779,10 +4778,10 @@ static void show_task(struct task_struct
> >  		unsigned long *n = end_of_stack(p);
> >  		while (!*n)
> >  			n++;
> > -		free = (unsigned long)n - (unsigned long)end_of_stack(p);
> > +		printk("%5lu ", (unsigned long)n - (unsigned long)end_of_stack(p));
> >  	}
> >  #endif
> > -	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
> > +	printk("%5d %6d ", p->pid, p->parent->pid);
> 
> This will cause the output format to be dependent upon the setting of
> CONFIG_DEBUG_STACK_USAGE.  So any code which attempts to parse the output
> of this function will somehow need to work out whether or not the `free'
> field is present.
> 
> Which is why we still print out a zero if CONFIG_DEBUG_STACK_USAGE=n.

Ahh!

Should we make it so the header printed by show_state is aligned properly 
with the data?  If yes, please consider the below patch.

Chris

---
From: Chris Caputo <ccaputo@alt.net>
[PATCH 2.6.19-rc6] sched: correct output of show_state

At present show_state prints a header the does not match the output of 
show_task, as follows:

-
                                               sibling
  task             PC      pid father child younger older
init          S 00000000     0     1      0     2               (NOTLB)
-

This patch corrects the output of show_state so that the header is 
aligned with the data, ala:

-
                         free                        sibling
  task             PC    stack   pid father child younger older
init          S 00000000     0     1      0     2               (NOTLB)
-

Signed-off-by: Chris Caputo <ccaputo@alt.net>
---

--- a/kernel/sched.c	2006-11-27 08:40:56.000000000 +0000
+++ b/kernel/sched.c	2006-11-27 23:23:49.000000000 +0000
@@ -4810,12 +4810,12 @@ void show_state(void)
 
 #if (BITS_PER_LONG == 32)
 	printk("\n"
-	       "                                               sibling\n");
-	printk("  task             PC      pid father child younger older\n");
+	       "                         free                        sibling\n");
+	printk("  task             PC    stack   pid father child younger older\n");
 #else
 	printk("\n"
-	       "                                                       sibling\n");
-	printk("  task                 PC          pid father child younger older\n");
+	       "                                 free                        sibling\n");
+	printk("  task                 PC        stack   pid father child younger older\n");
 #endif
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
