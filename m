Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWIMAm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWIMAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWIMAm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:42:26 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:50873 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030286AbWIMAmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:42:24 -0400
Message-ID: <450753C1.2080308@oracle.com>
Date: Tue, 12 Sep 2006 17:41:37 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org, drepper@redhat.com,
       suparna@in.ibm.com, pbadari@us.ibm.com, hch@infradead.org,
       johnpol@2ka.mipt.ru, davem@davemloft.net
Subject: Re: [PATCH AIO 2/2] Add listio support
References: <20060911114152.4f67e59f@frecb000686>
In-Reply-To: <20060911114152.4f67e59f@frecb000686>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   As io_submit already accepts an array of iocbs, as part of listio submission,
> the user process prepends to a list of requests an empty special aiocb with
> an aio_lio_opcode of IOCB_CMD_GROUP, filling only the aio_sigevent fields.

Hmm, overloading an iocb as the _GROUP indication doesn't make much
sense to me, other than being an expedient way to shoe-horn the
semantics into the existing API.  That we have to worry about multiple
_GROUP iocbs in the array (ignoring them currently) seems like
complexity that we shouldn't even have to consider.

Am I just missing the discussion that lead us to avoid a syscall?  It
seems like we're getting a pretty funky API in return.

I guess I could also see an iocb command whose buf/bytes pointed to an
array of iocb pointers that it should issue and wait for completion on.
 You could call it, uh, IOCB_CMD_IO_SUBMIT :).  I'm only sort of kidding
here :).  With a sys_io_wait_for_one_iocb() that might not be entirely
ridiculous.  Then you could get an io_getevents() completion of a group
instead of only being able to get a signal or waiting on sync
completion.  It makes it less of a special case.

In any case, this current approach doesn't seem complete.  It doesn't
deal with the case where canceled iocbs don't come through
aio_complete() and so don't drop their lio_users count.

Also, it seems that the lio_submit() interface allows NULL iocb pointers
by skipping them.  sys_io_submit() looks like it'd fault on them.  It
sounds unpleasant to have an app allow nulls in the array and have the
library copy and compress the members, or something.  Maybe we could fix
up that mismatch in an API that explicitly took the sigevent struct?  Am
I making up this problem?

more inline..

> +static void lio_wait(struct kioctx *ctx, struct lio_event *lio)
> +{
> +       struct task_struct *tsk = current;
> +       DECLARE_WAITQUEUE(wait, tsk);
> +
> +       add_wait_queue(&ctx->wait, &wait);
> +       set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> +
> +       while ( atomic_read(&lio->lio_users) ) {
> +               schedule();
> +               set_task_state(tsk, TASK_UNINTERRUPTIBLE);
> +       }
> +       __set_task_state(tsk, TASK_RUNNING);
> +       remove_wait_queue(&ctx->wait, &wait);

wait_event(ctx->wait, atomic_read(&lio->lio_users));

> +static inline void lio_check(struct lio_event *lio)
> +{
> +	int ret;
> +
> +	ret = atomic_dec_and_test(&(lio->lio_users));
> +
> +	if (unlikely(ret) && lio->lio_notify.notify != SIGEV_NONE) {
> +		/* last one -> notify process */
> +		aio_send_signal(&lio->lio_notify);
> +		kfree(lio);

Since io_submit() doesn't hold a ref on lio_users this can race during
submission to send the signal and free the lio before all the operations
have been submitted.

> +	if (*lio) {
> +               printk (KERN_DEBUG "lio_create: already have an lio\n");

We should get rid of the printk so that the user doesn't have a trivial
way to flood the kernel message log.

> +	*lio = kmalloc(sizeof(*lio), GFP_KERNEL);
> +
> +	if (!*lio)
> +		return -EAGAIN;
> +
> +	memset (*lio, 0, sizeof(struct lio_event));

kzalloc(), and I imagine it would be a lot cleaner to return the lio or
ERR_PTR() instead of passing in the pointer to the struct and filling it in.

And is it legal to memset(&atomic_t, 0, )?  I would have expected a
atomic_set(&lio->lio_users, 0).  Maybe I'm stuck in the bad old days of
24 bit atomic_t and embedded locks :).

> +		if (lio && ((tmp.aio_lio_opcode == IOCB_CMD_PREAD) ||
> +			    (tmp.aio_lio_opcode == IOCB_CMD_PWRITE))) {

It doesn't make sense to me to restrict which ops are allowed to be in a
list or not.  Why not PREADV?  An iocb is an iocb, I think.

> +	IOCB_CMD_GROUP = 7,

7 is already taken in -mm by IOCB_CMD_PREADV .

> +struct lio_event {
> +	atomic_t		lio_users;
> +	int			lio_wait;
> +	struct aio_notify	lio_notify;

I'm pretty sure you don't need lio_wait here, given that it's only
tested in the submission path.

- z
