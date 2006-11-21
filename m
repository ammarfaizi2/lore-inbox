Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030835AbWKUKcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030835AbWKUKcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030837AbWKUKcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:32:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7871 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030835AbWKUKcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:32:08 -0500
Date: Tue, 21 Nov 2006 16:05:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9_=3Csebastien=2Edugue=40bull=2Enet?=.=?iso-8859-1?Q?=3E?=@qubit.in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 4/4][AIO] - Listio support
Message-ID: <20061121103513.GA20644@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061120151700.4a4f9407@frecb000686> <20061120152307.46dbf409@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061120152307.46dbf409@frecb000686>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebestian,

Thanks for taking this forward ! I assume that you have addressed all the
comments (including missing counts in cancel path etc), except for the
interface debate (current vs syscall vs sys_io_wait_for_kiocb), is
that correct ?

Zach,
You had suggested a couple of alternative interfaces. 
If we go the separate syscall way, there are a couple of things to figure
out/decide:
(1) Do we want to keep the LIO_WAIT semantics in the kernel, or
    should we try to expose the lio to user-space for an explicit wait to
    be issued ?
(2) We would have to address compat alternatives for the new syscall as well,
    hopefully it should be possible to structure the code to reuse most of
    the logic.
If we go the way of associating the array of iocbs as a parameter to
IOCB_CMD_GROUP, and make LIO_WAIT happen through a sys_io_wait for one iocb
on the group iocb, then
(1) Compat handling could get a little more complicated
(2) We have to think through the semantics of the completion path in various
    situations. Will it be possible to cancel the whole group in one go ?

Regards
Suparna

On Mon, Nov 20, 2006 at 03:23:07PM +0100, S�bastien Dugu� wrote:
> 
>                         POSIX listio support
> 
>   This patch adds POSIX listio completion notification support. It builds
> on support provided by the aio signal notification patch and adds an
> IOCB_CMD_GROUP command to io_submit().
> 
>   The purpose of IOCB_CMD_GROUP is to group together the following requests in
> the list up to the end of the list sumbitted to io_submit.
> 
>   As io_submit already accepts an array of iocbs, as part of listio submission,
> the user process prepends to a list of requests an empty special aiocb with
> an aio_lio_opcode of IOCB_CMD_GROUP, filling only the aio_sigevent fields.
> 
> 
>   An IOCB_CMD_GROUP is added to the IOCB_CMD enum in include/linux/aio_abi.h
> 
>   A struct lio_event is added in include/linux/aio.h
> 
>   A struct lio_event *ki_lio is added to struct iocb in include/linux/aio.h
> 
>   In io_submit(), upon detecting such an IOCB_CMD_GROUP marker iocb, an
> lio_event is created in lio_create() which contains the necessary information
> for signaling a thread (signal number, pid, notify type and value) along with
> a count of requests attached to this event.
> 
>         The following depicts the lio_event structure:
> 
>         struct lio_event {
>                 atomic_t        	lio_users;
>                 struct aio_notify	lio_notify;
>         };
> 
>   lio_users holds an atomic counter of the number of requests attached to this
> lio. It is incremented with each request submitted and decremented at each
> request completion. When the counter reaches 0, we send the notification.
> 
>   Each subsequent submitted request is attached to this lio_event by setting
> the request kiocb->ki_lio to that lio_event (in io_submit_one()) and
> incrementing the lio_users count.
> 
>   In aio_complete(), if the request is attached to an lio (ki_lio <> 0),
> then lio_check() is called to decrement the lio_users count and eventually
> signal the user process when all the requests in the group have completed.
> 
> 
>   The IOCB_CMD_GROUP semantic is as follows:
> 
>        - if the associated sigevent is NULL then we want to group
>          requests for the purpose of blocking on the group completion
>          (LIO_WAIT sync behavior).
> 
>        - if the associated sigevent is valid (not NULL) then we want to
>          group requests for the purpose of being notified upon that
>          group of requests completion (LIO_NOWAIT async behaviour).
> 
> 
> 
> 
>  fs/aio.c                |  123 ++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/aio.h     |   13 ++++-
>  include/linux/aio_abi.h |    1
>  3 files changed, 131 insertions(+), 6 deletions(-)
> 
> 
> Signed-off-by: S�bastien Dugu� <sebastien.dugue@bull.net>
> Signed-off-by: Laurent Vivier <laurent.vivier@bull.net>
> 
> Index: linux-2.6.19-rc5-mm2/fs/aio.c
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/fs/aio.c	2006-11-17 11:20:32.000000000
> +0100 +++ linux-2.6.19-rc5-mm2/fs/aio.c	2006-11-17 16:22:00.000000000
> +0100 @@ -414,6 +414,7 @@ static struct kiocb fastcall *__aio_get_
>  	req->ki_cancel = NULL;
>  	req->ki_retry = NULL;
>  	req->ki_dtor = NULL;
> +	req->ki_lio = NULL;
>  	req->private = NULL;
>  	req->ki_iovec = NULL;
>  	req->ki_notify.sigq = NULL;
> @@ -1010,6 +1011,53 @@ out_unlock:
>  	return -EINVAL;
>  }
>  
> +static inline void lio_check(struct lio_event *lio)
> +{
> +	int ret;
> +
> +	ret = atomic_dec_and_test(&lio->lio_users);
> +
> +	if (unlikely(ret) && lio->lio_notify.notify != SIGEV_NONE) {
> +		/* last one -> notify process */
> +		aio_send_signal(&lio->lio_notify);
> +		kfree(lio);
> +	}
> +}
> +
> +static struct lio_event *lio_create(struct sigevent __user *user_event)
> +{
> +	int ret = 0;
> +	struct lio_event *lio = NULL;
> +
> +	lio = kzalloc(sizeof(*lio), GFP_KERNEL);
> +
> +	if (!lio)
> +		return ERR_PTR(-EAGAIN);
> +
> +	/*
> +	 * Grab an initial ref on the lio to avoid races between
> +	 * submission and completion.
> +	 */
> +	atomic_set(&lio->lio_users, 1);
> +
> +	lio->lio_notify.notify = SIGEV_NONE;
> +
> +	if (user_event) {
> +		/*
> +		 * User specified an event for this lio,
> +		 * he wants to be notified upon lio completion.
> +		 */
> +		ret = aio_setup_sigevent(&lio->lio_notify, user_event);
> +
> +		if (ret) {
> +			kfree(lio);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	return lio;
> +}
> +
>  /* aio_complete
>   *	Called when the io request on the given iocb is complete.
>   *	Returns true if this is the last user of the request.  The 
> @@ -1058,8 +1106,12 @@ int fastcall aio_complete(struct kiocb *
>  	 * when the event got cancelled.
>  	 */
>  	if (kiocbIsCancelled(iocb)) {
> +		if (iocb->ki_lio)
> +			lio_check(iocb->ki_lio);
> +
>  		if (iocb->ki_notify.sigq)
>  			sigqueue_free(iocb->ki_notify.sigq);
> +
>  		goto put_rq;
>  	}
>  
> @@ -1100,6 +1152,9 @@ int fastcall aio_complete(struct kiocb *
>  			sigqueue_free(iocb->ki_notify.sigq);
>  	}
>  
> +	if (iocb->ki_lio)
> +		lio_check(iocb->ki_lio);
> +
>  	pr_debug("%ld retries: %zd of %zd\n", iocb->ki_retried,
>  		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
>  put_rq:
> @@ -1634,7 +1689,7 @@ static int aio_wake_function(wait_queue_
>  }
>  
>  int fastcall io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
> -			 struct iocb *iocb)
> +			   struct iocb *iocb, struct lio_event *lio)
>  {
>  	struct kiocb *req;
>  	struct file *file;
> @@ -1696,6 +1751,9 @@ int fastcall io_submit_one(struct kioctx
>  			goto out_put_req;
>  	}
>  
> +	/* Attach this iocb to its lio */
> +	req->ki_lio = lio;
> +
>  	ret = aio_setup_iocb(req);
>  
>  	if (ret)
> @@ -1739,6 +1797,8 @@ asmlinkage long sys_io_submit(aio_contex
>  			      struct iocb __user * __user *iocbpp)
>  {
>  	struct kioctx *ctx;
> +	struct lio_event *lio = NULL;
> +	int lio_wait = 0;
>  	long ret = 0;
>  	int i;
>  
> @@ -1772,11 +1832,66 @@ asmlinkage long sys_io_submit(aio_contex
>  			break;
>  		}
>  
> -		ret = io_submit_one(ctx, user_iocb, &tmp);
> -		if (ret)
> -			break;
> +		if (tmp.aio_lio_opcode == IOCB_CMD_GROUP) {
> +
> +			/* this command means that all following IO commands
> +			 * are in the same group.
> +			 *
> +			 * Userspace either wants to be notified upon or block
> until
> +			 * completion of all the requests in the group.
> +			 */
> +			/*
> +			 * Ignore an IOCB_CMD_GROUP request if we are already
> +			 * processing one. This means only one listio per
> +			 * io_submit call.
> +			 */
> +			if (lio)
> +				continue;
> +
> +			lio = lio_create((struct sigevent __user *)(unsigned
> long)
> +					 tmp.aio_sigeventp);
> +
> +			ret = PTR_ERR(lio);
> +
> +			if (IS_ERR(lio))
> +				goto out_put_ctx;
> +
> +			if (!tmp.aio_sigeventp)
> +				lio_wait = 1;
> +		} else {
> +			if (lio)
> +				atomic_inc(&lio->lio_users);
> +
> +			ret = io_submit_one(ctx, user_iocb, &tmp, lio);
> +
> +			if (ret) {
> +				if (lio) {
> +					/*
> +					 * If a request failed, just decrement
> +					 * the users count, but go on
> submitting
> +					 * subsequent requests.
> +					 */
> +					atomic_dec(&lio->lio_users);
> +				} else
> +					break;
> +			}
> +		}
> +	}
> +
> +	if (lio) {
> +		/*
> +		 * Drop extra ref on the lio now that we're done submitting
> +		 * requests
> +		 */
> +		lio_check(lio);
> +
> +		if (lio_wait) {
> +			wait_event(ctx->wait, atomic_read(&lio->lio_users)==0);
> +			kfree(lio);
> +		}
>  	}
>  
> +out_put_ctx:
>  	put_ioctx(ctx);
>  	return i ? i : ret;
>  }
> Index: linux-2.6.19-rc5-mm2/include/linux/aio_abi.h
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/include/linux/aio_abi.h	2006-11-17
> 11:20:32.000000000 +0100 +++
> linux-2.6.19-rc5-mm2/include/linux/aio_abi.h	2006-11-17
> 11:21:31.000000000 +0100 @@ -43,6 +43,7 @@ enum { IOCB_CMD_NOOP = 6,
>  	IOCB_CMD_PREADV = 7,
>  	IOCB_CMD_PWRITEV = 8,
> +	IOCB_CMD_GROUP = 9,
>  };
>  
>  /* read() from /dev/aio returns these structures. */
> Index: linux-2.6.19-rc5-mm2/include/linux/aio.h
> ===================================================================
> --- linux-2.6.19-rc5-mm2.orig/include/linux/aio.h	2006-11-17
> 11:20:32.000000000 +0100 +++ linux-2.6.19-rc5-mm2/include/linux/aio.h
> 2006-11-17 11:21:31.000000000 +0100 @@ -58,6 +58,11 @@ struct aio_notify {
>  	struct sigqueue		*sigq;
>  };
>  
> +struct lio_event {
> +	atomic_t		lio_users;
> +	struct aio_notify	lio_notify;
> +};
> +
>  /* is there a better place to document function pointer methods? */
>  /**
>   * ki_retry	-	iocb forward progress callback
> @@ -113,6 +118,9 @@ struct kiocb {
>  	wait_queue_t		ki_wait;
>  	loff_t			ki_pos;
>  
> +	/* lio this iocb might be attached to */
> +	struct lio_event	*ki_lio;
> +
>  	void			*private;
>  	/* State that we remember to be able to restart/retry  */
>  	unsigned short		ki_opcode;
> @@ -220,12 +228,13 @@ struct mm_struct;
>  extern void FASTCALL(exit_aio(struct mm_struct *mm));
>  extern struct kioctx *lookup_ioctx(unsigned long ctx_id);
>  extern int FASTCALL(io_submit_one(struct kioctx *ctx,
> -			struct iocb __user *user_iocb, struct iocb *iocb));
> +				  struct iocb __user *user_iocb, struct iocb
> *iocb,
> +				  struct lio_event *lio));
>  
>  /* semi private, but used by the 32bit emulations: */
>  struct kioctx *lookup_ioctx(unsigned long ctx_id);
>  int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
> -				  struct iocb *iocb));
> +			   struct iocb *iocb, struct lio_event *lio));
>  
>  #define get_ioctx(kioctx) do {						\
>  	BUG_ON(atomic_read(&(kioctx)->users) <= 0);			\

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

