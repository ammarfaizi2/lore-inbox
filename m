Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265103AbSJWRch>; Wed, 23 Oct 2002 13:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265104AbSJWRcg>; Wed, 23 Oct 2002 13:32:36 -0400
Received: from [202.88.156.6] ([202.88.156.6]:4523 "EHLO saraswati.hathway.com")
	by vger.kernel.org with ESMTP id <S265103AbSJWRce>;
	Wed, 23 Oct 2002 13:32:34 -0400
Date: Wed, 23 Oct 2002 23:03:27 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 3
Message-ID: <20021023230327.A27020@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB5C4F3.5030102@mvista.com>; from cminyard@mvista.com on Tue, Oct 22, 2002 at 04:36:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:36:51PM -0500, Corey Minyard wrote:

> +static struct nmi_handler *nmi_handler_list = NULL;
> +static spinlock_t         nmi_handler_lock = SPIN_LOCK_UNLOCKED;
> +static struct nmi_handler *nmi_to_free_list = NULL;
> +static spinlock_t         nmi_to_free_lock = SPIN_LOCK_UNLOCKED;
> +
> +struct rcu_head nmi_rcu;
> +
> +/*
> + * To free the list item, we use an rcu.  The rcu-function will not
> + * run until all processors have done a context switch, gone idle, or
> + * gone to a user process, so it's guaranteed that when this runs, any
> + * NMI handler running at release time has completed and the list item
> + * can be safely freed.
> + */
> +static void really_free_nmi_list(void *unused)
> +{
> +	unsigned long      flags;
> +	struct nmi_handler *item;
> +
> +	spin_lock_irqsave(&nmi_to_free_lock, flags);
> +	while (nmi_to_free_list) {
> +		item = nmi_to_free_list;
> +		nmi_to_free_list = item->link2;
> +		item->freed(item);
> +	}
> +	spin_unlock_irqrestore(&nmi_to_free_lock, flags);
> +}
> +static inline void free_nmi_handler(struct nmi_handler *item)
> +{
> +	unsigned long flags;
> +
> +	if (!item->freed)
> +		return;
> +
> +	spin_lock_irqsave(&nmi_to_free_lock, flags);
> +	/* We only have one copy of nmi_rcu, so we only want to add it
> +           once.  If there are items in the list, then it has already
> +           been added. */
> +	if (nmi_to_free_list == NULL)
> +		call_rcu(&nmi_rcu, really_free_nmi_list, NULL);
> +	item->link2 = nmi_to_free_list;
> +	nmi_to_free_list = item;
> +	spin_unlock_irqrestore(&nmi_to_free_lock, flags);
> +}

Hmm... I am not sure if this is correct. 

Your grace period starts from the moment you do a call_rcu(). So,
this example sequence might result in a problem here -

CPU#0		CPU#1		CPU#2		CPU#3
free_nmi_hanlder(X)
call_rcu

		cswitch	

				cswitch		cswitch

				nmi_handler(Y)

		free_nmi_handler(Y)
		[gets queued in the same free list as X]
					
cswitch	
				
reaally_free_nmi_list		[nmi_handler still executing]


Since context switch happened in all the CPUs since call_rcu(),
real update may happen and free the nmi_handler Y while it
is executing in CPU#2. IOW, once you start one RCU grace period
you cannot add to that list since the adding CPU may already
have participated in RCU and indicated that it doesn't have
any references. Once you hand over stuff to RCU, you must
use a new call_rcu() for that new batch.

I am wondering if we could do something like this -

static struct list_head nmi_handler_list = LIST_INIT_HEAD(nmi_handler_list);

struct nmi_handler
{
	struct list_head link;
	char *dev_name;
	void *dev_id;
	int  (*handler)(void *dev_id, struct pt_regs *regs);
	int  priority;
	void (*freed)(const void *arg);
	struct rcu_head rcu;
};

static void really_free_nmi_list(void *arg)
{
	struct nmi_handler *handler = arg;
	list_head_init(&handler->link);
	if (handler->freed)
		handler->freed(handler);
}

void release_nmi(struct nmi_handler *handler)
{
	if (handler == NULL)
		return;

	spin_lock(&nmi_handler_lock);
	list_del_rcu(&handler->link);
	spin_unlock(&nmi_handler_lock);
	call_rcu(&handler->rcu, really_free_nmi_handler, handler);
}

int request_nmi(struct nmi_handler *handler)
{
	struct list_head *head, *curr;
	struct nmi_handler *curr_h;

	/* Make sure the thing is not already in the list. */
	if (!list_empty(&handler->link))
		return EBUSY;

	spin_lock(&nmi_handler_lock);

	/* Add it into the list in priority order. */
	head = &nmi_handler_list;
	__list_for_each(curr, head) {
		curr_h = list_entry(curr, struct nmi_handler, link);
		if (curr_h->priority <= handler->priority)
			break;
	}
	/* list_add_rcu takes care of memory barrier */
	list_add_rcu(&handler->link, curr->link.prev);
	spin_unlock(&nmi_handler_lock);
	return 0;
}

static int call_nmi_handlers(struct pt_regs * regs)
{
	struct list_head *head, *curr;
	int                handled = 0;
	int                val;

	head = &nmi_handler_list;
	/* __list_for_each_rcu takes care of memory barriers */
	__list_for_each_rcu(curr, head) {
		curr_h = list_entry(curr, struct nmi_handler, link);
		val = curr_h->handler(curr_h->dev_id, regs);
		switch (val & ~NOTIFY_STOP_MASK) {
		case NOTIFY_OK:
			handled = 1;
			break;

		case NOTIFY_DONE:
		default:
		}
		if (val & NOTIFY_STOP_MASK)
			break;
	}
	return handled;
}

I probably have missed quite a few things here in these changes, but
would be interesting to see if they could be made to work. One clear
problem - someone does a release_nmi() and then a request_nmi() 
on the same handler while it is waiting for its RCU grace period
to be over. Oh well :-)

Thanks
Dipankar
