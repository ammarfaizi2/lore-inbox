Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUIQXPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUIQXPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 19:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUIQXPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 19:15:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:35546 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269001AbUIQXPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 19:15:33 -0400
Date: Fri, 17 Sep 2004 16:19:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Shaohua <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: hotplug e1000 failed after 32 times
Message-Id: <20040917161920.16d18333.akpm@osdl.org>
In-Reply-To: <1095411933.10407.29.camel@sli10-desk.sh.intel.com>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
	<20040916221406.1f3764e0.akpm@osdl.org>
	<1095411933.10407.29.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua <shaohua.li@intel.com> wrote:
>
> On Fri, 2004-09-17 at 13:14, Andrew Morton wrote:
> > Li Shaohua <shaohua.li@intel.com> wrote:
> > >
> > > I'm testing a hotplug driver. In my test, I will hot add/remove an e1000
> > >  NIC frequently. The result is my hot add failed after 32 times hotadd.
> > >  After looking at the code of e1000 driver, I found
> > >  e1000_adapter->bd_number has maxium limitation of 32, and it increased
> > >  one every hot add. Looks like the remove driver routine didn't free the
> > >  'bd_number', so hot add failed after 32 times. Below patch fixes this
> > >  issue.
> > 
> > Yeah.  I think you'll find that damn near every net driver in the kernel
> > has this problem.  I think it would be better to create a little suite of
> > library functions in net/core/dev.c to handle this situation.
> <snip>
> Here is the patch adding the API as you suggested.

Looks pretty sane here.  Your email client did wordwrap the patch, so
please fix that up henceforth.

> ===== lib/idr.c 1.10 vs edited =====
> --- 1.10/lib/idr.c	2004-08-23 16:14:51 +08:00
> +++ edited/lib/idr.c	2004-09-17 15:53:47 +08:00
> @@ -39,8 +39,10 @@ static struct idr_layer *alloc_layer(str
>  	struct idr_layer *p;
>  
>  	spin_lock(&idp->lock);
> -	if (!(p = idp->id_free))
> +	if (!(p = idp->id_free)) {
> +		spin_unlock(&idp->lock);
>  		return NULL;
> +	}
>  	idp->id_free = p->ary[0];
>  	idp->id_free_cnt--;
>  	p->ary[0] = NULL;

ow.  I've split this fix into a separate patch.  Please leave this hunk out
of future patches.


> +struct net_boards {
> +	struct idr idr;
> +	int max_boards;
> +	spinlock_t lock;
> +};

It would be more convenient if we had a compile-time constructor for this
structure.  So device drivers can do:

static struct net_boards my_net_boards = NET_BOARDS_INIT(my_net_boards);

or

static DEFINE_NET_BOARDS(my_net_boards);

We may not need to retain net_boards_init() if we have NET_BOARDS_INIT().

> +void net_boards_init(struct net_boards *board, int max_boards)
> +{
> +	if (!board || (max_boards < 0))
> +		return;
> +	idr_init(&board->idr);
> +	board->max_boards = max_boards;
> +	spin_lock_init(&board->lock);
> +}

Even though nothing here can actually fail, it's probably best to make this
return an integer error code, in case we add something new in the future.

You can remove that initial check - if someone passes in a null pointer or
a negative max_boards then they'll work out that something went wrong soon
enough.

I'd suggest that max_boards be made unsigned throughout the whole patch.

> +/*
> + * return -1 on error, >= 0 on success
> + */
> +int net_boards_alloc(struct net_boards *board)
> +{
> +	int ret, error;
> +
> +	if (!board)
> +		return -1;
> +retry:
> +	if (idr_pre_get(&board->idr, GFP_KERNEL) == 0)
> +		return -1;

-ENOMEM

> +	spin_lock(&board->lock);
> +	error = idr_get_new(&board->idr, NULL, &ret);
> +	spin_unlock(&board->lock);
> +	if (error == -EAGAIN)
> +		goto retry;
> +	else if (error)
> +		return -1;

propagate `error' back to the caller

> +	if (ret > board->max_boards) {
> +		spin_lock(&board->lock);
> +		idr_remove(&board->idr, ret);
> +		spin_unlock(&board->lock);
> +		return -1;

-ENOSPC, maybe?

> +int net_boards_free(struct net_boards *board, int board_no)
> +{
> +	if ((board_no < 0) || (board_no > board->max_boards))
> +		return -1;

remove this check.


