Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWJUWcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWJUWcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 18:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWJUWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 18:32:22 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:18407 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161143AbWJUWcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 18:32:21 -0400
Subject: Re: [PATCH] Quieten freezer if !CONFIG_PM_DEBUG.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
In-Reply-To: <200610211601.35277.rjw@sisk.pl>
References: <1161433364.7644.9.camel@nigel.suspend2.net>
	 <200610211601.35277.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 08:32:17 +1000
Message-Id: <1161469938.17061.24.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2006-10-21 at 16:01 +0200, Rafael J. Wysocki wrote:
> On Saturday, 21 October 2006 14:22, Nigel Cunningham wrote:
> > The freezing of processes is currently very noisy. This patch makes the
> > noise dependant upon CONFIG_PM_DEBUG.
> 
> Well, I don't think it's _that_ noisy.  It only printks one character per
> frozen task.

Yeah, but it should just work. The only reason for it to printk should
be for information or if there's a possibility of deadlocking or failure
that isn't handled. Doing printks here is akin to doing a printk for
every page you write in the image, and I'm reasonably sure you're not
about to start doing that.

> In fact I think it at least should print "Freezing processes" and "done"
> messages.

That sounds better.
 
> > Prepared against current git.
> >     
> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > 
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index 29be608..6829612 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -15,6 +15,12 @@ #include <linux/module.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/freezer.h>
> >  
> > +#ifdef CONFIG_PM_DEBUG
> > +#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
> > +#else
> > +#define freezer_message(msg, a...) do { } while(0)
> > +#endif
> > +
> >  /* 
> >   * Timeout for stopping processes
> >   */
> > @@ -40,7 +46,7 @@ void refrigerator(void)
> >  	long save;
> >  	save = current->state;
> >  	pr_debug("%s entered refrigerator\n", current->comm);
> > -	printk("=");
> > +	freezer_message("=");
> 
> I'd prefer to treat the pr_debug thing in a similar way, like
> freezer_debug_message("%s entered refrigerator\n" ...).
> 
> Or better yet, I'd leave just one message like
> 
> freezer_print_task(current->comm);
> 
> instead of the two that will be defined to either printk the entire
> "%s entered refrigerator\n", ... message or printk the "=" character or do
> nothing, depending on a predefined verbosity level.

Ah, yeah. Didn't notice the pr_debug thing. Will look at it.

> >  
> >  	frozen_process(current);
> >  	spin_lock_irq(&current->sighand->siglock);
> > @@ -87,7 +93,7 @@ int freeze_processes(void)
> >  	unsigned long start_time;
> >  	struct task_struct *g, *p;
> >  
> > -	printk( "Stopping tasks: " );
> > +	freezer_message( "Stopping tasks: " );
> 
> I wouldn't change this.
> 
> >  	start_time = jiffies;
> >  	user_frozen = 0;
> >  	do {
> > @@ -135,7 +141,7 @@ int freeze_processes(void)
> >  	 * but it cleans up leftover PF_FREEZE requests.
> >  	 */
> >  	if (todo) {
> > -		printk( "\n" );
> > +		freezer_message( "\n" );
> 
> Ditto.
> 
> >  		printk(KERN_ERR " stopping tasks timed out "
> >  			"after %d seconds (%d tasks remaining):\n",
> >  			TIMEOUT / HZ, todo);
> > @@ -149,7 +155,7 @@ int freeze_processes(void)
> >  		return todo;
> >  	}
> >  
> > -	printk( "|\n" );
> > +	freezer_message( "|\n" );
> 
> I'd call it freezer_print_finish(); and define to printk the "|\n" or do
> nothing like for freezer_print_task().
> 
> >  	BUG_ON(in_atomic());
> >  	return 0;
> >  }
> > @@ -158,18 +164,18 @@ void thaw_processes(void)
> >  {
> >  	struct task_struct *g, *p;
> >  
> > -	printk( "Restarting tasks..." );
> 
> I wouldn't change this.
> 
> > +	freezer_message( "Restarting tasks..." );
> >  	read_lock(&tasklist_lock);
> >  	do_each_thread(g, p) {
> >  		if (!freezeable(p))
> >  			continue;
> >  		if (!thaw_process(p))
> > -			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
> > +			freezer_message(KERN_INFO " Strange, %s not stopped\n", p->comm );
> >  	} while_each_thread(g, p);
> >  
> >  	read_unlock(&tasklist_lock);
> >  	schedule();
> > -	printk( " done\n" );
> > +	freezer_message( " done\n" );
> 
> Ditto.
> 
> >  }
> >  
> >  EXPORT_SYMBOL(refrigerator);

Will reconsider and resend tomorrow.

Regards,

Nigel

