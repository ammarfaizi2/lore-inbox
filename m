Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVJXCSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVJXCSw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 22:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVJXCSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 22:18:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48088 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750922AbVJXCSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 22:18:50 -0400
Date: Sun, 23 Oct 2005 19:19:32 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Matt_Domsch@dell.com
Subject: Re: [PATCH 1/9] ipmi: use refcount in message handler
Message-ID: <20051024021931.GA9696@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051021144909.GA19532@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051021144909.GA19532@i2.minyard.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 09:49:09AM -0500, Corey Minyard wrote:
> This patch is rather large, but it really can't be done in
> smaller chunks easily and I believe it is an important change.
> This has been out and tested for a while in the latest IPMI
> driver release.  There are no functional changes, just changes
> as necessary to convert the locking over (and a few minor style
> updates).
> 
> The IPMI driver uses read/write locks to ensure that things
> exist while they are in use.  This is bad from a number of
> points of view.  This patch removes the rwlocks and uses
> refcounts and RCU lists to manage what the locks did.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>

Interesting approach!  Seems like it is read-mostly, but you know SMIs
far better than I ever will.

Some questions and comments interspersed, search for empty lines to find
them quickly.  I have guessed at answers to some of the questions, and
if my guesses are wrong, so are many of the comments.

							Thanx, Paul

>  drivers/char/ipmi/ipmi_msghandler.c |  949 ++++++++++++++++++------------------
>  include/linux/ipmi.h                |    5 
>  2 files changed, 497 insertions(+), 457 deletions(-)
> 
> Index: linux-2.6.14-rc4/drivers/char/ipmi/ipmi_msghandler.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/drivers/char/ipmi/ipmi_msghandler.c
> +++ linux-2.6.14-rc4/drivers/char/ipmi/ipmi_msghandler.c
> @@ -38,13 +38,13 @@
>  #include <linux/sched.h>
>  #include <linux/poll.h>
>  #include <linux/spinlock.h>
> -#include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/ipmi.h>
>  #include <linux/ipmi_smi.h>
>  #include <linux/notifier.h>
>  #include <linux/init.h>
>  #include <linux/proc_fs.h>
> +#include <linux/rcupdate.h>
>  
>  #define PFX "IPMI message handler: "
>  
> @@ -65,10 +65,19 @@ struct proc_dir_entry *proc_ipmi_root = 
>     the max message timer.  This is in milliseconds. */
>  #define MAX_MSG_TIMEOUT		60000
>  
> +
> +/*
> + * The main "user" data structure.
> + */
>  struct ipmi_user
>  {
>  	struct list_head link;
>  
> +	/* Set to "0" when the user is destroyed. */
> +	int valid;
> +
> +	struct kref refcount;
> +
>  	/* The upper layer that handles receive messages. */
>  	struct ipmi_user_hndl *handler;
>  	void             *handler_data;
> @@ -87,6 +96,15 @@ struct cmd_rcvr
>  	ipmi_user_t   user;
>  	unsigned char netfn;
>  	unsigned char cmd;
> +
> +	/*
> +	 * This is used to form a linked lised during mass deletion.
> +	 * Since this is in an RCU list, we cannot use the link above
> +	 * or change any data until the RCU period completes.  So we
> +	 * use this next variable during mass deletion so we can have
> +	 * a list and don't have to wait and restart the search on
> +	 * every individual deletion of a command. */
> +	struct cmd_rcvr *next;
>  };
>  
>  struct seq_table
> @@ -150,13 +168,11 @@ struct ipmi_smi
>  	/* What interface number are we? */
>  	int intf_num;
>  
> -	/* The list of upper layers that are using me.  We read-lock
> -           this when delivering messages to the upper layer to keep
> -           the user from going away while we are processing the
> -           message.  This means that you cannot add or delete a user
> -           from the receive callback. */
> -	rwlock_t                users_lock;
> -	struct list_head        users;
> +	struct kref refcount;
> +
> +	/* The list of upper layers that are using me.  seq_lock
> +	 * protects this. */
> +	struct list_head users;

Updates are protected by seq_lock, seems like.

RCU seems to be used in traversing "users", the read side critical section
being in ipmi_smi_watchdog_pretimeout().  Which is in turn called from
handle_flags() (and potentially by external modules).  The handle_flags()
function is in turn called from handle_transaction_done().  This is in
turn called from smi_event_handler(), which appears to be callable from
several places -- I did not backtrack beyond this point.

My guess is that this read-side critical section can be invoked from and
SMI, and that SMIs can occur even if interrupts are disabled.  If my guess
is wrong, please enlighten me.  And feel free to ignore the next few
paragraphs in that case, along with a number of my suggested changes,
since they all depend critically on my guess being correct.

If this is indeed the case, then the update side should use
synchronize_sched() rather than synchronize_rcu(), as described in
Documentation/RCU/NMI-RCU.txt.  The reason for this is that realtime
implementations of rcu_read_lock() must execute atomically.

One pairs a synchronize_sched() with preempt_disable() and preempt_enable()
(as opposed to synchronize_rcu() with rcu_read_lock() and rcu_read_unlock()).
Of course, in an SMI handler, preemption is implicitly disabled, so you
would not need explicit preempt_disable() and preempt_enable(), unless
you also needed an RCU read-side critical section outside of an SMI
handler.

>  	/* Used for wake ups at startup. */
>  	wait_queue_head_t waitq;
> @@ -193,7 +209,7 @@ struct ipmi_smi
>  
>  	/* The list of command receivers that are registered for commands
>  	   on this interface. */
> -	rwlock_t	 cmd_rcvr_lock;
> +	spinlock_t       cmd_rcvrs_lock;
>  	struct list_head cmd_rcvrs;

RCU seems to be used in traversing cmd_rcvrs, but I cannot figure out
why.  It looks to me that all accesses are protected by cmd_rcvrs_lock,
so RCU should not be necessary.

None of the accesses are in SMI, since if they were, the spin_lock_irqsave()
calls would result in self-deadlock if the SMI happened to hit a CPU while
it was holding the cmd_rcvrs_lock.

So, unless I am missing something, the RCU stuff can be omitted from this
list.

>  	/* Events that were queues because no one was there to receive
> @@ -296,16 +312,17 @@ struct ipmi_smi
>  	unsigned int events;
>  };
>  
> +/* Used to mark an interface entry that cannot be used but is not a
> + * free entry, either, primarily used at creation and deletion time so
> + * a slot doesn't get reused too quickly. */
> +#define IPMI_INVALID_INTERFACE_ENTRY ((ipmi_smi_t) ((long) 1))
> +#define IPMI_INVALID_INTERFACE(i) (((i) == NULL) \
> +				   || (i == IPMI_INVALID_INTERFACE_ENTRY))
> +
>  #define MAX_IPMI_INTERFACES 4
>  static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
>  
> -/* Used to keep interfaces from going away while operations are
> -   operating on interfaces.  Grab read if you are not modifying the
> -   interfaces, write if you are. */
> -static DECLARE_RWSEM(interfaces_sem);
> -
> -/* Directly protects the ipmi_interfaces data structure.  This is
> -   claimed in the timer interrupt. */
> +/* Directly protects the ipmi_interfaces data structure. */
>  static DEFINE_SPINLOCK(interfaces_lock);
>  
>  /* List of watchers that want to know when smi's are added and
> @@ -313,20 +330,73 @@ static DEFINE_SPINLOCK(interfaces_lock);
>  static struct list_head smi_watchers = LIST_HEAD_INIT(smi_watchers);
>  static DECLARE_RWSEM(smi_watchers_sem);
>  
> +
> +static void free_recv_msg_list(struct list_head *q)
> +{
> +	struct ipmi_recv_msg *msg, *msg2;
> +
> +	list_for_each_entry_safe(msg, msg2, q, link) {
> +		list_del(&msg->link);
> +		ipmi_free_recv_msg(msg);
> +	}
> +}
> +
> +static void clean_up_interface_data(ipmi_smi_t intf)
> +{
> +	int              i;
> +	struct cmd_rcvr  *rcvr, *rcvr2;
> +	unsigned long    flags;
> +	struct list_head list;
> +
> +	free_recv_msg_list(&intf->waiting_msgs);
> +	free_recv_msg_list(&intf->waiting_events);
> +
> +	/* Wholesale remove all the entries from the list in the
> +	 * interface and wait for RCU to know that none are in use. */
> +	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
> +	list_add_rcu(&list, &intf->cmd_rcvrs);

What prevents a reader from being fatally confused if it encounters
"list" during a traversal?  Call this point in the code "Point A".

> +	list_del_rcu(&intf->cmd_rcvrs);
> +	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
> +	synchronize_rcu();
> +
> +	list_for_each_entry_safe(rcvr, rcvr2, &list, link)
> +		kfree(rcvr);
> +
> +	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
> +		if ((intf->seq_table[i].inuse)
> +		    && (intf->seq_table[i].recv_msg))
> +		{
> +			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
> +		}
> +	}
> +}
> +
> +static void intf_free(struct kref *ref)
> +{
> +	ipmi_smi_t intf = container_of(ref, struct ipmi_smi, refcount);
> +
> +	clean_up_interface_data(intf);
> +	kfree(intf);
> +}
> +
>  int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
>  {
> -	int i;
> +	int           i;
> +	unsigned long flags;
>  
> -	down_read(&interfaces_sem);
>  	down_write(&smi_watchers_sem);
>  	list_add(&(watcher->link), &smi_watchers);
> +	up_write(&smi_watchers_sem);
> +	spin_lock_irqsave(&interfaces_lock, flags);
>  	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
> -		if (ipmi_interfaces[i] != NULL) {
> -			watcher->new_smi(i);
> -		}
> +		ipmi_smi_t intf = ipmi_interfaces[i];
> +		if (IPMI_INVALID_INTERFACE(intf))
> +			continue;
> +		spin_unlock_irqrestore(&interfaces_lock, flags);
> +		watcher->new_smi(i);
> +		spin_lock_irqsave(&interfaces_lock, flags);
>  	}
> -	up_write(&smi_watchers_sem);
> -	up_read(&interfaces_sem);
> +	spin_unlock_irqrestore(&interfaces_lock, flags);
>  	return 0;
>  }
>  
> @@ -471,8 +541,8 @@ static void deliver_response(struct ipmi
>  		}
>  		ipmi_free_recv_msg(msg);
>  	} else {
> -		msg->user->handler->ipmi_recv_hndl(msg,
> -						   msg->user->handler_data);
> +		ipmi_user_t user = msg->user;
> +		user->handler->ipmi_recv_hndl(msg, user->handler_data);
>  	}
>  }
>  
> @@ -662,15 +732,18 @@ int ipmi_create_user(unsigned int       
>  	if (! new_user)
>  		return -ENOMEM;
>  
> -	down_read(&interfaces_sem);
> -	if ((if_num >= MAX_IPMI_INTERFACES) || ipmi_interfaces[if_num] == NULL)
> -	{
> -		rv = -EINVAL;
> -		goto out_unlock;
> +	spin_lock_irqsave(&interfaces_lock, flags);
> +	intf = ipmi_interfaces[if_num];
> +	if ((if_num >= MAX_IPMI_INTERFACES) || IPMI_INVALID_INTERFACE(intf)) {
> +		spin_unlock_irqrestore(&interfaces_lock, flags);
> +		return -EINVAL;
>  	}
>  
> -	intf = ipmi_interfaces[if_num];
> +	/* Note that each existing user holds a refcount to the interface. */
> +	kref_get(&intf->refcount);
> +	spin_unlock_irqrestore(&interfaces_lock, flags);
>  
> +	kref_init(&new_user->refcount);
>  	new_user->handler = handler;
>  	new_user->handler_data = handler_data;
>  	new_user->intf = intf;
> @@ -678,98 +751,92 @@ int ipmi_create_user(unsigned int       
>  
>  	if (!try_module_get(intf->handlers->owner)) {
>  		rv = -ENODEV;
> -		goto out_unlock;
> +		goto out_err;
>  	}
>  
>  	if (intf->handlers->inc_usecount) {
>  		rv = intf->handlers->inc_usecount(intf->send_info);
>  		if (rv) {
>  			module_put(intf->handlers->owner);
> -			goto out_unlock;
> +			goto out_err;
>  		}
>  	}
>  
> -	write_lock_irqsave(&intf->users_lock, flags);
> -	list_add_tail(&new_user->link, &intf->users);
> -	write_unlock_irqrestore(&intf->users_lock, flags);
> -
> - out_unlock:	
> -	if (rv) {
> -		kfree(new_user);
> -	} else {
> -		*user = new_user;
> -	}
> +	new_user->valid = 1;
> +	spin_lock_irqsave(&intf->seq_lock, flags);
> +	list_add_rcu(&new_user->link, &intf->users);
> +	spin_unlock_irqrestore(&intf->seq_lock, flags);
> +	*user = new_user;
> +	return 0;
>  
> -	up_read(&interfaces_sem);
> + out_err:
> +	kfree(new_user);
> +	kref_put(&intf->refcount, intf_free);
>  	return rv;
>  }
>  
> -static int ipmi_destroy_user_nolock(ipmi_user_t user)
> +static void free_user(struct kref *ref)
> +{
> +	ipmi_user_t user = container_of(ref, struct ipmi_user, refcount);
> +	kfree(user);
> +}
> +
> +int ipmi_destroy_user(ipmi_user_t user)
>  {
>  	int              rv = -ENODEV;
> -	ipmi_user_t      t_user;
> -	struct cmd_rcvr  *rcvr, *rcvr2;
> +	ipmi_smi_t       intf = user->intf;
>  	int              i;
>  	unsigned long    flags;
> +	struct cmd_rcvr  *rcvr;
> +	struct list_head *entry1, *entry2;
> +	struct cmd_rcvr  *rcvrs = NULL;
>  
> -	/* Find the user and delete them from the list. */
> -	list_for_each_entry(t_user, &(user->intf->users), link) {
> -		if (t_user == user) {
> -			list_del(&t_user->link);
> -			rv = 0;
> -			break;
> -		}
> -	}
> +	user->valid = 1;
>  
> -	if (rv) {
> -		goto out_unlock;
> -	}
> +	/* Remove the user from the interface's sequence table. */
> +	spin_lock_irqsave(&intf->seq_lock, flags);
> +	list_del_rcu(&user->link);
>  
> -	/* Remove the user from the interfaces sequence table. */
> -	spin_lock_irqsave(&(user->intf->seq_lock), flags);
>  	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
> -		if (user->intf->seq_table[i].inuse
> -		    && (user->intf->seq_table[i].recv_msg->user == user))
> +		if (intf->seq_table[i].inuse
> +		    && (intf->seq_table[i].recv_msg->user == user))
>  		{
> -			user->intf->seq_table[i].inuse = 0;
> +			intf->seq_table[i].inuse = 0;
>  		}
>  	}
> -	spin_unlock_irqrestore(&(user->intf->seq_lock), flags);
> +	spin_unlock_irqrestore(&intf->seq_lock, flags);
>  
> -	/* Remove the user from the command receiver's table. */
> -	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
> -	list_for_each_entry_safe(rcvr, rcvr2, &(user->intf->cmd_rcvrs), link) {
> +	/*
> +	 * Remove the user from the command receiver's table.  First
> +	 * we build a list of everything (not using the standard link,
> +	 * since other things may be using it till we do
> +	 * synchronize_rcu()) then free everything in that list.
> +	 */
> +	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
> +	list_for_each_safe_rcu(entry1, entry2, &intf->cmd_rcvrs) {
> +		rcvr = list_entry(entry1, struct cmd_rcvr, link);

OK, the reason that this RCU read-side critical section is safe from
running concurrently with "Point A" is that both hold cmd_rcvrs_lock...

In which case the _rcu() on the list_for_each_safe_rcu() is redundant
in principle, but in practice is good documentation.  So this one is OK.

But every other access to cmd_rcvrs seems also to be protected by
cmd_rcvrs_lock.  Unless I am missing something, as noted earlier, there
should be no need for _rcu on the cmd_rcvrs traversal.  And we are
holding seq_lock, so the user list cannot wiggle out from under us,
right?

So why does this loop need to be _rcu()?  I don't see it.

>  		if (rcvr->user == user) {
> -			list_del(&rcvr->link);
> -			kfree(rcvr);
> +			list_del_rcu(&rcvr->link);
> +			rcvr->next = rcvrs;
> +			rcvrs = rcvr;
>  		}
>  	}
> -	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
> +	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
> +	synchronize_rcu();

I believe that this needs to be synchronize_sched(), again assuming that
ipmi_smi_watchdog_pretimeout() is invoked from SMI and that SMIs can
happen on a given CPU even when that CPU's interrupts are disabled.

> +	while (rcvrs) {
> +		rcvr = rcvrs;
> +		rcvrs = rcvr->next;
> +		kfree(rcvr);
> +	}

The above "while" loop does not need to be after the synchronize_sched(),
unless I am missing the reason that cmd_rcvrs must be protected by RCU.

> -	kfree(user);
> +	module_put(intf->handlers->owner);
> +	if (intf->handlers->dec_usecount)
> +		intf->handlers->dec_usecount(intf->send_info);
>  
> - out_unlock:
> +	kref_put(&intf->refcount, intf_free);
>  
> -	return rv;
> -}
> +	kref_put(&user->refcount, free_user);
>  
> -int ipmi_destroy_user(ipmi_user_t user)
> -{
> -	int           rv;
> -	ipmi_smi_t    intf = user->intf;
> -	unsigned long flags;
> -
> -	down_read(&interfaces_sem);
> -	write_lock_irqsave(&intf->users_lock, flags);
> -	rv = ipmi_destroy_user_nolock(user);
> -	if (!rv) {
> -		module_put(intf->handlers->owner);
> -		if (intf->handlers->dec_usecount)
> -			intf->handlers->dec_usecount(intf->send_info);
> -	}
> -		
> -	write_unlock_irqrestore(&intf->users_lock, flags);
> -	up_read(&interfaces_sem);
>  	return rv;
>  }
>  
> @@ -823,62 +890,78 @@ int ipmi_get_my_LUN(ipmi_user_t   user,
>  
>  int ipmi_set_gets_events(ipmi_user_t user, int val)
>  {
> -	unsigned long         flags;
> -	struct ipmi_recv_msg  *msg, *msg2;
> +	unsigned long        flags;
> +	ipmi_smi_t           intf = user->intf;
> +	struct ipmi_recv_msg *msg, *msg2;
> +	struct list_head     msgs;
> +
> +	INIT_LIST_HEAD(&msgs);
>  
> -	read_lock(&(user->intf->users_lock));
> -	spin_lock_irqsave(&(user->intf->events_lock), flags);
> +	spin_lock_irqsave(&intf->events_lock, flags);
>  	user->gets_events = val;
>  
>  	if (val) {
>  		/* Deliver any queued events. */
> -		list_for_each_entry_safe(msg, msg2, &(user->intf->waiting_events), link) {
> +		list_for_each_entry_safe(msg, msg2, &intf->waiting_events, link) {
>  			list_del(&msg->link);
> -			msg->user = user;
> -			deliver_response(msg);
> +			list_add_tail(&msg->link, &msgs);
>  		}
>  	}
> -	
> -	spin_unlock_irqrestore(&(user->intf->events_lock), flags);
> -	read_unlock(&(user->intf->users_lock));
> +
> +	/* Hold the events lock while doing this to preserve order. */
> +	list_for_each_entry_safe(msg, msg2, &msgs, link) {
> +		msg->user = user;
> +		kref_get(&user->refcount);
> +		deliver_response(msg);
> +	}
> +
> +	spin_unlock_irqrestore(&intf->events_lock, flags);
>  
>  	return 0;
>  }
>  
> +static struct cmd_rcvr *find_cmd_rcvr(ipmi_smi_t    intf,
> +				      unsigned char netfn,
> +				      unsigned char cmd)
> +{
> +	struct cmd_rcvr *rcvr;
> +
> +	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {

Sometimes (always?) called from update side, so _rcu above not strictly
necessary.  OK to leave it in.

> +		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd))
> +			return rcvr;
> +	}
> +	return NULL;
> +}
> +
>  int ipmi_register_for_cmd(ipmi_user_t   user,
>  			  unsigned char netfn,
>  			  unsigned char cmd)
>  {
> -	struct cmd_rcvr  *cmp;
> -	unsigned long    flags;
> -	struct cmd_rcvr  *rcvr;
> -	int              rv = 0;
> +	ipmi_smi_t      intf = user->intf;
> +	struct cmd_rcvr *rcvr;
> +	struct cmd_rcvr *entry;
> +	int             rv = 0;
>  
>  
>  	rcvr = kmalloc(sizeof(*rcvr), GFP_KERNEL);
>  	if (! rcvr)
>  		return -ENOMEM;
> +	rcvr->cmd = cmd;
> +	rcvr->netfn = netfn;
> +	rcvr->user = user;
>  
> -	read_lock(&(user->intf->users_lock));
> -	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
> +	spin_lock_irq(&intf->cmd_rcvrs_lock);
>  	/* Make sure the command/netfn is not already registered. */
> -	list_for_each_entry(cmp, &(user->intf->cmd_rcvrs), link) {
> -		if ((cmp->netfn == netfn) && (cmp->cmd == cmd)) {
> -			rv = -EBUSY;
> -			break;
> -		}
> -	}
> -
> -	if (! rv) {
> -		rcvr->cmd = cmd;
> -		rcvr->netfn = netfn;
> -		rcvr->user = user;
> -		list_add_tail(&(rcvr->link), &(user->intf->cmd_rcvrs));
> +	entry = find_cmd_rcvr(intf, netfn, cmd);
> +	if (entry) {
> +		rv = -EBUSY;
> +		goto out_unlock;
>  	}
>  
> -	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
> -	read_unlock(&(user->intf->users_lock));
> +	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
>  
> + out_unlock:
> +	spin_unlock_irq(&intf->cmd_rcvrs_lock);
>  	if (rv)
>  		kfree(rcvr);
>  
> @@ -889,31 +972,28 @@ int ipmi_unregister_for_cmd(ipmi_user_t 
>  			    unsigned char netfn,
>  			    unsigned char cmd)
>  {
> -	unsigned long    flags;
> -	struct cmd_rcvr  *rcvr;
> -	int              rv = -ENOENT;
> +	ipmi_smi_t      intf = user->intf;
> +	struct cmd_rcvr *rcvr;
>  
> -	read_lock(&(user->intf->users_lock));
> -	write_lock_irqsave(&(user->intf->cmd_rcvr_lock), flags);
> +	spin_lock_irq(&intf->cmd_rcvrs_lock);
>  	/* Make sure the command/netfn is not already registered. */
> -	list_for_each_entry(rcvr, &(user->intf->cmd_rcvrs), link) {
> -		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
> -			rv = 0;
> -			list_del(&rcvr->link);
> -			kfree(rcvr);
> -			break;
> -		}
> +	rcvr = find_cmd_rcvr(intf, netfn, cmd);
> +	if ((rcvr) && (rcvr->user == user)) {
> +		list_del_rcu(&rcvr->link);
> +		spin_unlock_irq(&intf->cmd_rcvrs_lock);
> +		synchronize_rcu();

I believe that the above synchronize_rcu() is unnecessary, given that
all accesses to cmd_rcvrs seem to be under the cmd_rcvrs_lock.

> +		kfree(rcvr);
> +		return 0;
> +	} else {
> +		spin_unlock_irq(&intf->cmd_rcvrs_lock);
> +		return -ENOENT;
>  	}
> -	write_unlock_irqrestore(&(user->intf->cmd_rcvr_lock), flags);
> -	read_unlock(&(user->intf->users_lock));
> -
> -	return rv;
>  }
>  
>  void ipmi_user_set_run_to_completion(ipmi_user_t user, int val)
>  {
> -	user->intf->handlers->set_run_to_completion(user->intf->send_info,
> -						    val);
> +	ipmi_smi_t intf = user->intf;
> +	intf->handlers->set_run_to_completion(intf->send_info, val);
>  }
>  
>  static unsigned char
> @@ -1010,19 +1090,19 @@ static inline void format_lan_msg(struct
>     supplied in certain circumstances (mainly at panic time).  If
>     messages are supplied, they will be freed, even if an error
>     occurs. */
> -static inline int i_ipmi_request(ipmi_user_t          user,
> -				 ipmi_smi_t           intf,
> -				 struct ipmi_addr     *addr,
> -				 long                 msgid,
> -				 struct kernel_ipmi_msg *msg,
> -				 void                 *user_msg_data,
> -				 void                 *supplied_smi,
> -				 struct ipmi_recv_msg *supplied_recv,
> -				 int                  priority,
> -				 unsigned char        source_address,
> -				 unsigned char        source_lun,
> -				 int                  retries,
> -				 unsigned int         retry_time_ms)
> +static int i_ipmi_request(ipmi_user_t          user,
> +			  ipmi_smi_t           intf,
> +			  struct ipmi_addr     *addr,
> +			  long                 msgid,
> +			  struct kernel_ipmi_msg *msg,
> +			  void                 *user_msg_data,
> +			  void                 *supplied_smi,
> +			  struct ipmi_recv_msg *supplied_recv,
> +			  int                  priority,
> +			  unsigned char        source_address,
> +			  unsigned char        source_lun,
> +			  int                  retries,
> +			  unsigned int         retry_time_ms)
>  {
>  	int                  rv = 0;
>  	struct ipmi_smi_msg  *smi_msg;
> @@ -1051,6 +1131,8 @@ static inline int i_ipmi_request(ipmi_us
>  	}
>  
>  	recv_msg->user = user;
> +	if (user)
> +		kref_get(&user->refcount);
>  	recv_msg->msgid = msgid;
>  	/* Store the message to send in the receive message so timeout
>  	   responses can get the proper response data. */
> @@ -1725,11 +1807,11 @@ int ipmi_register_smi(struct ipmi_smi_ha
>  		      unsigned char            version_major,
>  		      unsigned char            version_minor,
>  		      unsigned char            slave_addr,
> -		      ipmi_smi_t               *intf)
> +		      ipmi_smi_t               *new_intf)
>  {
>  	int              i, j;
>  	int              rv;
> -	ipmi_smi_t       new_intf;
> +	ipmi_smi_t       intf;
>  	unsigned long    flags;
>  
>  
> @@ -1745,189 +1827,142 @@ int ipmi_register_smi(struct ipmi_smi_ha
>  			return -ENODEV;
>  	}
>  
> -	new_intf = kmalloc(sizeof(*new_intf), GFP_KERNEL);
> -	if (!new_intf)
> +	intf = kmalloc(sizeof(*intf), GFP_KERNEL);
> +	if (!intf)
>  		return -ENOMEM;
> -	memset(new_intf, 0, sizeof(*new_intf));
> +	memset(intf, 0, sizeof(*intf));
> +	intf->intf_num = -1;
> +	kref_init(&intf->refcount);
> +	intf->version_major = version_major;
> +	intf->version_minor = version_minor;
> +	for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
> +		intf->channels[j].address = IPMI_BMC_SLAVE_ADDR;
> +		intf->channels[j].lun = 2;
> +	}
> +	if (slave_addr != 0)
> +		intf->channels[0].address = slave_addr;
> +	INIT_LIST_HEAD(&intf->users);
> +	intf->handlers = handlers;
> +	intf->send_info = send_info;
> +	spin_lock_init(&intf->seq_lock);
> +	for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
> +		intf->seq_table[j].inuse = 0;
> +		intf->seq_table[j].seqid = 0;
> +	}
> +	intf->curr_seq = 0;
> +#ifdef CONFIG_PROC_FS
> +	spin_lock_init(&intf->proc_entry_lock);
> +#endif
> +	spin_lock_init(&intf->waiting_msgs_lock);
> +	INIT_LIST_HEAD(&intf->waiting_msgs);
> +	spin_lock_init(&intf->events_lock);
> +	INIT_LIST_HEAD(&intf->waiting_events);
> +	intf->waiting_events_count = 0;
> +	spin_lock_init(&intf->cmd_rcvrs_lock);
> +	INIT_LIST_HEAD(&intf->cmd_rcvrs);
> +	init_waitqueue_head(&intf->waitq);
>  
> -	new_intf->proc_dir = NULL;
> +	spin_lock_init(&intf->counter_lock);
> +	intf->proc_dir = NULL;
>  
>  	rv = -ENOMEM;
> -
> -	down_write(&interfaces_sem);
> +	spin_lock_irqsave(&interfaces_lock, flags);
>  	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
>  		if (ipmi_interfaces[i] == NULL) {
> -			new_intf->intf_num = i;
> -			new_intf->version_major = version_major;
> -			new_intf->version_minor = version_minor;
> -			for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
> -				new_intf->channels[j].address
> -					= IPMI_BMC_SLAVE_ADDR;
> -				new_intf->channels[j].lun = 2;
> -			}
> -			if (slave_addr != 0)
> -				new_intf->channels[0].address = slave_addr;
> -			rwlock_init(&(new_intf->users_lock));
> -			INIT_LIST_HEAD(&(new_intf->users));
> -			new_intf->handlers = handlers;
> -			new_intf->send_info = send_info;
> -			spin_lock_init(&(new_intf->seq_lock));
> -			for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
> -				new_intf->seq_table[j].inuse = 0;
> -				new_intf->seq_table[j].seqid = 0;
> -			}
> -			new_intf->curr_seq = 0;
> -#ifdef CONFIG_PROC_FS
> -			spin_lock_init(&(new_intf->proc_entry_lock));
> -#endif
> -			spin_lock_init(&(new_intf->waiting_msgs_lock));
> -			INIT_LIST_HEAD(&(new_intf->waiting_msgs));
> -			spin_lock_init(&(new_intf->events_lock));
> -			INIT_LIST_HEAD(&(new_intf->waiting_events));
> -			new_intf->waiting_events_count = 0;
> -			rwlock_init(&(new_intf->cmd_rcvr_lock));
> -			init_waitqueue_head(&new_intf->waitq);
> -			INIT_LIST_HEAD(&(new_intf->cmd_rcvrs));
> -
> -			spin_lock_init(&(new_intf->counter_lock));
> -
> -			spin_lock_irqsave(&interfaces_lock, flags);
> -			ipmi_interfaces[i] = new_intf;
> -			spin_unlock_irqrestore(&interfaces_lock, flags);
> -
> +			intf->intf_num = i;
> +			/* Reserve the entry till we are done. */
> +			ipmi_interfaces[i] = IPMI_INVALID_INTERFACE_ENTRY;
>  			rv = 0;
> -			*intf = new_intf;
>  			break;
>  		}
>  	}
> +	spin_unlock_irqrestore(&interfaces_lock, flags);
> +	if (rv)
> +		goto out;
>  
> -	downgrade_write(&interfaces_sem);
> -
> -	if (rv == 0)
> -		rv = add_proc_entries(*intf, i);
> -
> -	if (rv == 0) {
> -		if ((version_major > 1)
> -		    || ((version_major == 1) && (version_minor >= 5)))
> -		{
> -			/* Start scanning the channels to see what is
> -			   available. */
> -			(*intf)->null_user_handler = channel_handler;
> -			(*intf)->curr_channel = 0;
> -			rv = send_channel_info_cmd(*intf, 0);
> -			if (rv)
> -				goto out;
> -
> -			/* Wait for the channel info to be read. */
> -			up_read(&interfaces_sem);
> -			wait_event((*intf)->waitq,
> -				   ((*intf)->curr_channel>=IPMI_MAX_CHANNELS));
> -			down_read(&interfaces_sem);
> -
> -			if (ipmi_interfaces[i] != new_intf)
> -				/* Well, it went away.  Just return. */
> -				goto out;
> -		} else {
> -			/* Assume a single IPMB channel at zero. */
> -			(*intf)->channels[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
> -			(*intf)->channels[0].protocol
> -				= IPMI_CHANNEL_PROTOCOL_IPMB;
> -  		}
> +	/* FIXME - this is an ugly kludge, this sets the intf for the
> +	   caller before sending any messages with it. */
> +	*new_intf = intf;
> +
> +	if ((version_major > 1)
> +	    || ((version_major == 1) && (version_minor >= 5)))
> +	{
> +		/* Start scanning the channels to see what is
> +		   available. */
> +		intf->null_user_handler = channel_handler;
> +		intf->curr_channel = 0;
> +		rv = send_channel_info_cmd(intf, 0);
> +		if (rv)
> +			goto out;
>  
> -		/* Call all the watcher interfaces to tell
> -		   them that a new interface is available. */
> -		call_smi_watchers(i);
> +		/* Wait for the channel info to be read. */
> +		wait_event(intf->waitq,
> +			   intf->curr_channel >= IPMI_MAX_CHANNELS);
> +	} else {
> +		/* Assume a single IPMB channel at zero. */
> +		intf->channels[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
> +		intf->channels[0].protocol = IPMI_CHANNEL_PROTOCOL_IPMB;
>  	}
>  
> - out:
> -	up_read(&interfaces_sem);
> +	if (rv == 0)
> +		rv = add_proc_entries(intf, i);
>  
> + out:
>  	if (rv) {
> -		if (new_intf->proc_dir)
> -			remove_proc_entries(new_intf);
> -		kfree(new_intf);
> +		if (intf->proc_dir)
> +			remove_proc_entries(intf);
> +		kref_put(&intf->refcount, intf_free);
> +		if (i < MAX_IPMI_INTERFACES) {
> +			spin_lock_irqsave(&interfaces_lock, flags);
> +			ipmi_interfaces[i] = NULL;
> +			spin_unlock_irqrestore(&interfaces_lock, flags);
> +		}
> +	} else {
> +		spin_lock_irqsave(&interfaces_lock, flags);
> +		ipmi_interfaces[i] = intf;
> +		spin_unlock_irqrestore(&interfaces_lock, flags);
> +		call_smi_watchers(i);
>  	}
>  
>  	return rv;
>  }
>  
> -static void free_recv_msg_list(struct list_head *q)
> -{
> -	struct ipmi_recv_msg *msg, *msg2;
> -
> -	list_for_each_entry_safe(msg, msg2, q, link) {
> -		list_del(&msg->link);
> -		ipmi_free_recv_msg(msg);
> -	}
> -}
> -
> -static void free_cmd_rcvr_list(struct list_head *q)
> -{
> -	struct cmd_rcvr  *rcvr, *rcvr2;
> -
> -	list_for_each_entry_safe(rcvr, rcvr2, q, link) {
> -		list_del(&rcvr->link);
> -		kfree(rcvr);
> -	}
> -}
> -
> -static void clean_up_interface_data(ipmi_smi_t intf)
> -{
> -	int i;
> -
> -	free_recv_msg_list(&(intf->waiting_msgs));
> -	free_recv_msg_list(&(intf->waiting_events));
> -	free_cmd_rcvr_list(&(intf->cmd_rcvrs));
> -
> -	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
> -		if ((intf->seq_table[i].inuse)
> -		    && (intf->seq_table[i].recv_msg))
> -		{
> -			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
> -		}	
> -	}
> -}
> -
>  int ipmi_unregister_smi(ipmi_smi_t intf)
>  {
> -	int                     rv = -ENODEV;
>  	int                     i;
>  	struct ipmi_smi_watcher *w;
>  	unsigned long           flags;
>  
> -	down_write(&interfaces_sem);
> -	if (list_empty(&(intf->users)))
> -	{
> -		for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
> -			if (ipmi_interfaces[i] == intf) {
> -				remove_proc_entries(intf);
> -				spin_lock_irqsave(&interfaces_lock, flags);
> -				ipmi_interfaces[i] = NULL;
> -				clean_up_interface_data(intf);
> -				spin_unlock_irqrestore(&interfaces_lock,flags);
> -				kfree(intf);
> -				rv = 0;
> -				goto out_call_watcher;
> -			}
> +	spin_lock_irqsave(&interfaces_lock, flags);
> +	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
> +		if (ipmi_interfaces[i] == intf) {
> +			/* Set the interface number reserved until we
> +			 * are done. */
> +			ipmi_interfaces[i] = IPMI_INVALID_INTERFACE_ENTRY;
> +			intf->intf_num = -1;
> +			break;
>  		}
> -	} else {
> -		rv = -EBUSY;
>  	}
> -	up_write(&interfaces_sem);
> +	spin_unlock_irqrestore(&interfaces_lock,flags);
>  
> -	return rv;
> +	if (i == MAX_IPMI_INTERFACES)
> +		return -ENODEV;
>  
> - out_call_watcher:
> -	downgrade_write(&interfaces_sem);
> +	remove_proc_entries(intf);
>  
>  	/* Call all the watcher interfaces to tell them that
>  	   an interface is gone. */
>  	down_read(&smi_watchers_sem);
> -	list_for_each_entry(w, &smi_watchers, link) {
> +	list_for_each_entry(w, &smi_watchers, link)
>  		w->smi_gone(i);
> -	}
>  	up_read(&smi_watchers_sem);
> -	up_read(&interfaces_sem);
> +
> +	/* Allow the entry to be reused now. */
> +	spin_lock_irqsave(&interfaces_lock, flags);
> +	ipmi_interfaces[i] = NULL;
> +	spin_unlock_irqrestore(&interfaces_lock,flags);
> +
> +	kref_put(&intf->refcount, intf_free);
>  	return 0;
>  }
>  
> @@ -1998,14 +2033,14 @@ static int handle_ipmb_get_msg_rsp(ipmi_
>  static int handle_ipmb_get_msg_cmd(ipmi_smi_t          intf,
>  				   struct ipmi_smi_msg *msg)
>  {
> -	struct cmd_rcvr       *rcvr;
> -	int                   rv = 0;
> -	unsigned char         netfn;
> -	unsigned char         cmd;
> -	ipmi_user_t           user = NULL;
> -	struct ipmi_ipmb_addr *ipmb_addr;
> -	struct ipmi_recv_msg  *recv_msg;
> -	unsigned long         flags;
> +	struct cmd_rcvr          *rcvr;
> +	int                      rv = 0;
> +	unsigned char            netfn;
> +	unsigned char            cmd;
> +	ipmi_user_t              user = NULL;
> +	struct ipmi_ipmb_addr    *ipmb_addr;
> +	struct ipmi_recv_msg     *recv_msg;
> +	unsigned long            flags;
>  
>  	if (msg->rsp_size < 10) {
>  		/* Message not big enough, just ignore it. */
> @@ -2023,16 +2058,14 @@ static int handle_ipmb_get_msg_cmd(ipmi_
>  	netfn = msg->rsp[4] >> 2;
>  	cmd = msg->rsp[8];
>  
> -	read_lock(&(intf->cmd_rcvr_lock));
> -	
> -	/* Find the command/netfn. */
> -	list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
> -		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
> -			user = rcvr->user;
> -			break;
> -		}
> -	}
> -	read_unlock(&(intf->cmd_rcvr_lock));
> +	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
> +	rcvr = find_cmd_rcvr(intf, netfn, cmd);
> +	if (rcvr) {
> +		user = rcvr->user;
> +		kref_get(&user->refcount);
> +	} else
> +		user = NULL;
> +	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
>  
>  	if (user == NULL) {
>  		/* We didn't find a user, deliver an error response. */
> @@ -2079,6 +2112,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
>                             message, so requeue it for handling
>                             later. */
>  			rv = 1;
> +			kref_put(&user->refcount, free_user);
>  		} else {
>  			/* Extract the source address from the data. */
>  			ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
> @@ -2179,14 +2213,14 @@ static int handle_lan_get_msg_rsp(ipmi_s
>  static int handle_lan_get_msg_cmd(ipmi_smi_t          intf,
>  				  struct ipmi_smi_msg *msg)
>  {
> -	struct cmd_rcvr       *rcvr;
> -	int                   rv = 0;
> -	unsigned char         netfn;
> -	unsigned char         cmd;
> -	ipmi_user_t           user = NULL;
> -	struct ipmi_lan_addr  *lan_addr;
> -	struct ipmi_recv_msg  *recv_msg;
> -	unsigned long         flags;
> +	struct cmd_rcvr          *rcvr;
> +	int                      rv = 0;
> +	unsigned char            netfn;
> +	unsigned char            cmd;
> +	ipmi_user_t              user = NULL;
> +	struct ipmi_lan_addr     *lan_addr;
> +	struct ipmi_recv_msg     *recv_msg;
> +	unsigned long            flags;
>  
>  	if (msg->rsp_size < 12) {
>  		/* Message not big enough, just ignore it. */
> @@ -2204,19 +2238,17 @@ static int handle_lan_get_msg_cmd(ipmi_s
>  	netfn = msg->rsp[6] >> 2;
>  	cmd = msg->rsp[10];
>  
> -	read_lock(&(intf->cmd_rcvr_lock));
> -
> -	/* Find the command/netfn. */
> -	list_for_each_entry(rcvr, &(intf->cmd_rcvrs), link) {
> -		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
> -			user = rcvr->user;
> -			break;
> -		}
> -	}
> -	read_unlock(&(intf->cmd_rcvr_lock));
> +	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
> +	rcvr = find_cmd_rcvr(intf, netfn, cmd);
> +	if (rcvr) {
> +		user = rcvr->user;
> +		kref_get(&user->refcount);
> +	} else
> +		user = NULL;
> +	spin_unlock_irqrestore(&intf->cmd_rcvrs_lock, flags);
>  
>  	if (user == NULL) {
> -		/* We didn't find a user, deliver an error response. */
> +		/* We didn't find a user, just give up. */
>  		spin_lock_irqsave(&intf->counter_lock, flags);
>  		intf->unhandled_commands++;
>  		spin_unlock_irqrestore(&intf->counter_lock, flags);
> @@ -2235,6 +2267,7 @@ static int handle_lan_get_msg_cmd(ipmi_s
>                             message, so requeue it for handling
>                             later. */
>  			rv = 1;
> +			kref_put(&user->refcount, free_user);
>  		} else {
>  			/* Extract the source address from the data. */
>  			lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
> @@ -2286,8 +2319,6 @@ static void copy_event_into_recv_msg(str
>  	recv_msg->msg.data_len = msg->rsp_size - 3;
>  }
>  
> -/* This will be called with the intf->users_lock read-locked, so no need
> -   to do that here. */
>  static int handle_read_event_rsp(ipmi_smi_t          intf,
>  				 struct ipmi_smi_msg *msg)
>  {
> @@ -2313,7 +2344,7 @@ static int handle_read_event_rsp(ipmi_sm
>  
>  	INIT_LIST_HEAD(&msgs);
>  
> -	spin_lock_irqsave(&(intf->events_lock), flags);
> +	spin_lock_irqsave(&intf->events_lock, flags);
>  
>  	spin_lock(&intf->counter_lock);
>  	intf->events++;
> @@ -2321,12 +2352,14 @@ static int handle_read_event_rsp(ipmi_sm
>  
>  	/* Allocate and fill in one message for every user that is getting
>  	   events. */
> -	list_for_each_entry(user, &(intf->users), link) {
> +	rcu_read_lock();

Took me awhile to figure out why RCU is needed here.  The thing is that
although events_lock is held, it is seq_lock that protects the list.
So we can run concurrently with updates, and we therefore do need
RCU protection.

But I believe that the rcu_read_lock() needs to instead be a preempt_disable().

> +	list_for_each_entry_rcu(user, &intf->users, link) {
>  		if (! user->gets_events)
>  			continue;
>  
>  		recv_msg = ipmi_alloc_recv_msg();
>  		if (! recv_msg) {
> +			rcu_read_unlock();
>  			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs, link) {
>  				list_del(&recv_msg->link);
>  				ipmi_free_recv_msg(recv_msg);
> @@ -2342,8 +2375,10 @@ static int handle_read_event_rsp(ipmi_sm
>  
>  		copy_event_into_recv_msg(recv_msg, msg);
>  		recv_msg->user = user;
> +		kref_get(&user->refcount);
>  		list_add_tail(&(recv_msg->link), &msgs);
>  	}
> +	rcu_read_unlock();

And that this rcu_read_unlock() needs to instead be a preempt_enable().

>  	if (deliver_count) {
>  		/* Now deliver all the messages. */
> @@ -2382,9 +2417,8 @@ static int handle_bmc_rsp(ipmi_smi_t    
>  			  struct ipmi_smi_msg *msg)
>  {
>  	struct ipmi_recv_msg *recv_msg;
> -	int                  found = 0;
> -	struct ipmi_user     *user;
>  	unsigned long        flags;
> +	struct ipmi_user     *user;
>  
>  	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
>  	if (recv_msg == NULL)
> @@ -2396,16 +2430,9 @@ static int handle_bmc_rsp(ipmi_smi_t    
>  		return 0;
>  	}
>  
> +	user = recv_msg->user;
>  	/* Make sure the user still exists. */
> -	list_for_each_entry(user, &(intf->users), link) {
> -		if (user == recv_msg->user) {
> -			/* Found it, so we can deliver it */
> -			found = 1;
> -			break;
> -		}
> -	}
> -
> -	if ((! found) && recv_msg->user) {
> +	if (user && !user->valid) {
>  		/* The user for the message went away, so give up. */
>  		spin_lock_irqsave(&intf->counter_lock, flags);
>  		intf->unhandled_local_responses++;
> @@ -2486,7 +2513,7 @@ static int handle_new_recv_msg(ipmi_smi_
>  	{
>  		/* It's a response to a response we sent.  For this we
>  		   deliver a send message response to the user. */
> -		struct ipmi_recv_msg *recv_msg = msg->user_data;
> +		struct ipmi_recv_msg     *recv_msg = msg->user_data;
>  
>  		requeue = 0;
>  		if (msg->rsp_size < 2)
> @@ -2498,13 +2525,18 @@ static int handle_new_recv_msg(ipmi_smi_
>  			/* Invalid channel number */
>  			goto out;
>  
> -		if (recv_msg) {
> -			recv_msg->recv_type = IPMI_RESPONSE_RESPONSE_TYPE;
> -			recv_msg->msg.data = recv_msg->msg_data;
> -			recv_msg->msg.data_len = 1;
> -			recv_msg->msg_data[0] = msg->rsp[2];
> -			deliver_response(recv_msg);
> -		}
> +		if (!recv_msg)
> +			goto out;
> +
> +		/* Make sure the user still exists. */
> +		if (!recv_msg->user || !recv_msg->user->valid)
> +			goto out;
> +
> +		recv_msg->recv_type = IPMI_RESPONSE_RESPONSE_TYPE;
> +		recv_msg->msg.data = recv_msg->msg_data;
> +		recv_msg->msg.data_len = 1;
> +		recv_msg->msg_data[0] = msg->rsp[2];
> +		deliver_response(recv_msg);
>  	} else if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
>  		   && (msg->rsp[1] == IPMI_GET_MSG_CMD))
>  	{
> @@ -2570,14 +2602,11 @@ void ipmi_smi_msg_received(ipmi_smi_t   
>  	int           rv;
>  
>  
> -	/* Lock the user lock so the user can't go away while we are
> -	   working on it. */
> -	read_lock(&(intf->users_lock));
> -
>  	if ((msg->data_size >= 2)
>  	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
>  	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
> -	    && (msg->user_data == NULL)) {
> +	    && (msg->user_data == NULL))
> +	{
>  		/* This is the local response to a command send, start
>                     the timer for these.  The user_data will not be
>                     NULL if this is a response send, and we will let
> @@ -2612,46 +2641,46 @@ void ipmi_smi_msg_received(ipmi_smi_t   
>  		}
>  
>  		ipmi_free_smi_msg(msg);
> -		goto out_unlock;
> +		goto out;
>  	}
>  
>  	/* To preserve message order, if the list is not empty, we
>             tack this message onto the end of the list. */
> -	spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
> -	if (!list_empty(&(intf->waiting_msgs))) {
> -		list_add_tail(&(msg->link), &(intf->waiting_msgs));
> -		spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
> -		goto out_unlock;
> +	spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
> +	if (!list_empty(&intf->waiting_msgs)) {
> +		list_add_tail(&msg->link, &intf->waiting_msgs);
> +		spin_unlock(&intf->waiting_msgs_lock);
> +		goto out;
>  	}
> -	spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
> +	spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);
>  		
>  	rv = handle_new_recv_msg(intf, msg);
>  	if (rv > 0) {
>  		/* Could not handle the message now, just add it to a
>                     list to handle later. */
> -		spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
> -		list_add_tail(&(msg->link), &(intf->waiting_msgs));
> -		spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
> +		spin_lock(&intf->waiting_msgs_lock);
> +		list_add_tail(&msg->link, &intf->waiting_msgs);
> +		spin_unlock(&intf->waiting_msgs_lock);
>  	} else if (rv == 0) {
>  		ipmi_free_smi_msg(msg);
>  	}
>  
> - out_unlock:
> -	read_unlock(&(intf->users_lock));
> + out:
> +	return;
>  }
>  
>  void ipmi_smi_watchdog_pretimeout(ipmi_smi_t intf)

What context is this called from?  In particular, can it be called
from an SMI that is processed on a given CPU while that CPU's interrupts
are disabled?  If so, this algorithm really needs to rely on the fact
that preemption is disabled during an SMI and change the corresponding
synchronize_rcu() calls to be synchronize_sched().

>  {
>  	ipmi_user_t user;
>  
> -	read_lock(&(intf->users_lock));
> -	list_for_each_entry(user, &(intf->users), link) {
> +	rcu_read_lock();

If ipmi_smi_watchdog_pretimeout() was -always- called from SMI, then
the above rcu_read_lock() could be omitted.  However, this function
seems to be callable from timeouts as well, in which case, it could
potentially be called from process context in some kernel configurations.

So I believe that it needs to change to preempt_disable().

> +	list_for_each_entry_rcu(user, &intf->users, link) {
>  		if (! user->handler->ipmi_watchdog_pretimeout)
>  			continue;
>  
>  		user->handler->ipmi_watchdog_pretimeout(user->handler_data);
>  	}
> -	read_unlock(&(intf->users_lock));
> +	rcu_read_unlock();

And this rcu_read_unlock() needs to become preempt_enable().

>  }
>  
>  static void
> @@ -2691,8 +2720,65 @@ smi_from_recv_msg(ipmi_smi_t intf, struc
>  	return smi_msg;
>  }
>  
> -static void
> -ipmi_timeout_handler(long timeout_period)
> +static void check_msg_timeout(ipmi_smi_t intf, struct seq_table *ent,
> +			      struct list_head *timeouts, long timeout_period,
> +			      int slot, unsigned long *flags)
> +{
> +	struct ipmi_recv_msg *msg;
> +
> +	if (!ent->inuse)
> +		return;
> +
> +	ent->timeout -= timeout_period;
> +	if (ent->timeout > 0)
> +		return;
> +
> +	if (ent->retries_left == 0) {
> +		/* The message has used all its retries. */
> +		ent->inuse = 0;
> +		msg = ent->recv_msg;
> +		list_add_tail(&msg->link, timeouts);
> +		spin_lock(&intf->counter_lock);
> +		if (ent->broadcast)
> +			intf->timed_out_ipmb_broadcasts++;
> +		else if (ent->recv_msg->addr.addr_type == IPMI_LAN_ADDR_TYPE)
> +			intf->timed_out_lan_commands++;
> +		else
> +			intf->timed_out_ipmb_commands++;
> +		spin_unlock(&intf->counter_lock);
> +	} else {
> +		struct ipmi_smi_msg *smi_msg;
> +		/* More retries, send again. */
> +
> +		/* Start with the max timer, set to normal
> +		   timer after the message is sent. */
> +		ent->timeout = MAX_MSG_TIMEOUT;
> +		ent->retries_left--;
> +		spin_lock(&intf->counter_lock);
> +		if (ent->recv_msg->addr.addr_type == IPMI_LAN_ADDR_TYPE)
> +			intf->retransmitted_lan_commands++;
> +		else
> +			intf->retransmitted_ipmb_commands++;
> +		spin_unlock(&intf->counter_lock);
> +
> +		smi_msg = smi_from_recv_msg(intf, ent->recv_msg, slot,
> +					    ent->seqid);
> +		if (! smi_msg)
> +			return;
> +
> +		spin_unlock_irqrestore(&intf->seq_lock, *flags);
> +		/* Send the new message.  We send with a zero
> +		 * priority.  It timed out, I doubt time is
> +		 * that critical now, and high priority
> +		 * messages are really only for messages to the
> +		 * local MC, which don't get resent. */
> +		intf->handlers->sender(intf->send_info,
> +				       smi_msg, 0);
> +		spin_lock_irqsave(&intf->seq_lock, *flags);
> +	}
> +}
> +
> +static void ipmi_timeout_handler(long timeout_period)
>  {
>  	ipmi_smi_t           intf;
>  	struct list_head     timeouts;
> @@ -2706,14 +2792,14 @@ ipmi_timeout_handler(long timeout_period
>  	spin_lock(&interfaces_lock);
>  	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
>  		intf = ipmi_interfaces[i];
> -		if (intf == NULL)
> +		if (IPMI_INVALID_INTERFACE(intf))
>  			continue;
> -
> -		read_lock(&(intf->users_lock));
> +		kref_get(&intf->refcount);
> +		spin_unlock(&interfaces_lock);
>  
>  		/* See if any waiting messages need to be processed. */
> -		spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
> -		list_for_each_entry_safe(smi_msg, smi_msg2, &(intf->waiting_msgs), link) {
> +		spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
> +		list_for_each_entry_safe(smi_msg, smi_msg2, &intf->waiting_msgs, link) {
>  			if (! handle_new_recv_msg(intf, smi_msg)) {
>  				list_del(&smi_msg->link);
>  				ipmi_free_smi_msg(smi_msg);
> @@ -2723,73 +2809,23 @@ ipmi_timeout_handler(long timeout_period
>  				break;
>  			}
>  		}
> -		spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
> +		spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);
>  
>  		/* Go through the seq table and find any messages that
>  		   have timed out, putting them in the timeouts
>  		   list. */
> -		spin_lock_irqsave(&(intf->seq_lock), flags);
> -		for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
> -			struct seq_table *ent = &(intf->seq_table[j]);
> -			if (!ent->inuse)
> -				continue;
> -
> -			ent->timeout -= timeout_period;
> -			if (ent->timeout > 0)
> -				continue;
> -
> -			if (ent->retries_left == 0) {
> -				/* The message has used all its retries. */
> -				ent->inuse = 0;
> -				msg = ent->recv_msg;
> -				list_add_tail(&(msg->link), &timeouts);
> -				spin_lock(&intf->counter_lock);
> -				if (ent->broadcast)
> -					intf->timed_out_ipmb_broadcasts++;
> -				else if (ent->recv_msg->addr.addr_type
> -					 == IPMI_LAN_ADDR_TYPE)
> -					intf->timed_out_lan_commands++;
> -				else
> -					intf->timed_out_ipmb_commands++;
> -				spin_unlock(&intf->counter_lock);
> -			} else {
> -				struct ipmi_smi_msg *smi_msg;
> -				/* More retries, send again. */
> -
> -				/* Start with the max timer, set to normal
> -				   timer after the message is sent. */
> -				ent->timeout = MAX_MSG_TIMEOUT;
> -				ent->retries_left--;
> -				spin_lock(&intf->counter_lock);
> -				if (ent->recv_msg->addr.addr_type
> -				    == IPMI_LAN_ADDR_TYPE)
> -					intf->retransmitted_lan_commands++;
> -				else
> -					intf->retransmitted_ipmb_commands++;
> -				spin_unlock(&intf->counter_lock);
> -				smi_msg = smi_from_recv_msg(intf,
> -						ent->recv_msg, j, ent->seqid);
> -				if (! smi_msg)
> -					continue;
> -
> -				spin_unlock_irqrestore(&(intf->seq_lock),flags);
> -				/* Send the new message.  We send with a zero
> -				 * priority.  It timed out, I doubt time is
> -				 * that critical now, and high priority
> -				 * messages are really only for messages to the
> -				 * local MC, which don't get resent. */
> -				intf->handlers->sender(intf->send_info,
> -							smi_msg, 0);
> -				spin_lock_irqsave(&(intf->seq_lock), flags);
> -			}
> -		}
> -		spin_unlock_irqrestore(&(intf->seq_lock), flags);
> +		spin_lock_irqsave(&intf->seq_lock, flags);
> +		for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++)
> +			check_msg_timeout(intf, &(intf->seq_table[j]),
> +					  &timeouts, timeout_period, j,
> +					  &flags);
> +		spin_unlock_irqrestore(&intf->seq_lock, flags);
>  
> -		list_for_each_entry_safe(msg, msg2, &timeouts, link) {
> +		list_for_each_entry_safe(msg, msg2, &timeouts, link)
>  			handle_msg_timeout(msg);
> -		}
>  
> -		read_unlock(&(intf->users_lock));
> +		kref_put(&intf->refcount, intf_free);
> +		spin_lock(&interfaces_lock);
>  	}
>  	spin_unlock(&interfaces_lock);
>  }
> @@ -2802,7 +2838,7 @@ static void ipmi_request_event(void)
>  	spin_lock(&interfaces_lock);
>  	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
>  		intf = ipmi_interfaces[i];
> -		if (intf == NULL)
> +		if (IPMI_INVALID_INTERFACE(intf))
>  			continue;
>  
>  		intf->handlers->request_events(intf->send_info);
> @@ -2884,6 +2920,13 @@ struct ipmi_recv_msg *ipmi_alloc_recv_ms
>  	return rv;
>  }
>  
> +void ipmi_free_recv_msg(struct ipmi_recv_msg *msg)
> +{
> +	if (msg->user)
> +		kref_put(&msg->user->refcount, free_user);
> +	msg->done(msg);
> +}
> +
>  #ifdef CONFIG_IPMI_PANIC_EVENT
>  
>  static void dummy_smi_done_handler(struct ipmi_smi_msg *msg)
> @@ -2964,7 +3007,7 @@ static void send_panic_events(char *str)
>  	/* For every registered interface, send the event. */
>  	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
>  		intf = ipmi_interfaces[i];
> -		if (intf == NULL)
> +		if (IPMI_INVALID_INTERFACE(intf))
>  			continue;
>  
>  		/* Send the event announcing the panic. */
> @@ -2995,7 +3038,7 @@ static void send_panic_events(char *str)
>  		int                   j;
>  
>  		intf = ipmi_interfaces[i];
> -		if (intf == NULL)
> +		if (IPMI_INVALID_INTERFACE(intf))
>  			continue;
>  
>  		/* First job here is to figure out where to send the
> @@ -3131,7 +3174,7 @@ static int panic_event(struct notifier_b
>  	/* For every registered interface, set it to run to completion. */
>  	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
>  		intf = ipmi_interfaces[i];
> -		if (intf == NULL)
> +		if (IPMI_INVALID_INTERFACE(intf))
>  			continue;
>  
>  		intf->handlers->set_run_to_completion(intf->send_info, 1);
> @@ -3160,9 +3203,8 @@ static int ipmi_init_msghandler(void)
>  	printk(KERN_INFO "ipmi message handler version "
>  	       IPMI_DRIVER_VERSION "\n");
>  
> -	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
> +	for (i = 0; i < MAX_IPMI_INTERFACES; i++)
>  		ipmi_interfaces[i] = NULL;
> -	}
>  
>  #ifdef CONFIG_PROC_FS
>  	proc_ipmi_root = proc_mkdir("ipmi", NULL);
> @@ -3258,3 +3300,4 @@ EXPORT_SYMBOL(ipmi_get_my_LUN);
>  EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
>  EXPORT_SYMBOL(proc_ipmi_root);
>  EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
> +EXPORT_SYMBOL(ipmi_free_recv_msg);
> Index: linux-2.6.14-rc4/include/linux/ipmi.h
> ===================================================================
> --- linux-2.6.14-rc4.orig/include/linux/ipmi.h
> +++ linux-2.6.14-rc4/include/linux/ipmi.h
> @@ -256,10 +256,7 @@ struct ipmi_recv_msg
>  };
>  
>  /* Allocate and free the receive message. */
> -static inline void ipmi_free_recv_msg(struct ipmi_recv_msg *msg)
> -{
> -	msg->done(msg);
> -}
> +void ipmi_free_recv_msg(struct ipmi_recv_msg *msg);
>  
>  struct ipmi_user_hndl
>  {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
