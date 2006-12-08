Return-Path: <linux-kernel-owner+w=401wt.eu-S1760787AbWLHR5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760787AbWLHR5R (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760788AbWLHR5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:57:17 -0500
Received: from pat.uio.no ([129.240.10.15]:44851 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760787AbWLHR5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:57:16 -0500
Subject: Re: [PATCH] lockd endianness annotations (rebased)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061208095146.GS4587@ftp.linux.org.uk>
References: <20061208095146.GS4587@ftp.linux.org.uk>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 12:57:02 -0500
Message-Id: <1165600622.5676.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.754, required 12,
	autolearn=disabled, AWL 1.25, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 09:51 +0000, Al Viro wrote:
> Rebased to current tree.  Trond, could you ACK that one?
> 
> annotated, all places switched to keeping status
> net-endian.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Trond Myklebust <Trond.Myklebust@netapp.com>

> ---
>  fs/lockd/clntlock.c            |   10 +++++-----
>  fs/lockd/clntproc.c            |   39 ++++++++++++++++++++-------------------
>  fs/lockd/svclock.c             |    4 ++--
>  fs/lockd/xdr.c                 |    8 ++++----
>  fs/lockd/xdr4.c                |    8 ++++----
>  fs/nfsd/lockd.c                |    2 +-
>  include/linux/lockd/bind.h     |    2 +-
>  include/linux/lockd/lockd.h    |    2 +-
>  include/linux/lockd/sm_inter.h |    2 +-
>  include/linux/lockd/xdr.h      |    8 ++++----
>  10 files changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
> index b85a0ad..0db028e 100644
> --- a/fs/lockd/clntlock.c
> +++ b/fs/lockd/clntlock.c
> @@ -36,7 +36,7 @@ struct nlm_wait {
>  	struct nlm_host *	b_host;
>  	struct file_lock *	b_lock;		/* local file lock */
>  	unsigned short		b_reclaim;	/* got to reclaim lock */
> -	u32			b_status;	/* grant callback status */
> +	__be32			b_status;	/* grant callback status */
>  };
>  
>  static LIST_HEAD(nlm_blocked);
> @@ -53,7 +53,7 @@ struct nlm_wait *nlmclnt_prepare_block(s
>  		block->b_host = host;
>  		block->b_lock = fl;
>  		init_waitqueue_head(&block->b_wait);
> -		block->b_status = NLM_LCK_BLOCKED;
> +		block->b_status = nlm_lck_blocked;
>  		list_add(&block->b_list, &nlm_blocked);
>  	}
>  	return block;
> @@ -89,7 +89,7 @@ int nlmclnt_block(struct nlm_wait *block
>  	 * nlmclnt_lock for an explanation.
>  	 */
>  	ret = wait_event_interruptible_timeout(block->b_wait,
> -			block->b_status != NLM_LCK_BLOCKED,
> +			block->b_status != nlm_lck_blocked,
>  			timeout);
>  	if (ret < 0)
>  		return -ERESTARTSYS;
> @@ -131,7 +131,7 @@ __be32 nlmclnt_grant(const struct sockad
>  		/* Alright, we found a lock. Set the return status
>  		 * and wake up the caller
>  		 */
> -		block->b_status = NLM_LCK_GRANTED;
> +		block->b_status = nlm_granted;
>  		wake_up(&block->b_wait);
>  		res = nlm_granted;
>  	}
> @@ -211,7 +211,7 @@ restart:
>  	/* Now, wake up all processes that sleep on a blocked lock */
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		if (block->b_host == host) {
> -			block->b_status = NLM_LCK_DENIED_GRACE_PERIOD;
> +			block->b_status = nlm_lck_denied_grace_period;
>  			wake_up(&block->b_wait);
>  		}
>  	}
> diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> index 50643b6..6eb01ae 100644
> --- a/fs/lockd/clntproc.c
> +++ b/fs/lockd/clntproc.c
> @@ -27,7 +27,7 @@ #define NLMCLNT_MAX_RETRIES	3
>  static int	nlmclnt_test(struct nlm_rqst *, struct file_lock *);
>  static int	nlmclnt_lock(struct nlm_rqst *, struct file_lock *);
>  static int	nlmclnt_unlock(struct nlm_rqst *, struct file_lock *);
> -static int	nlm_stat_to_errno(u32 stat);
> +static int	nlm_stat_to_errno(__be32 stat);
>  static void	nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host);
>  static int	nlmclnt_cancel(struct nlm_host *, int , struct file_lock *);
>  
> @@ -325,7 +325,7 @@ nlmclnt_call(struct nlm_rqst *req, u32 p
>  			}
>  			break;
>  		} else
> -		if (resp->status == NLM_LCK_DENIED_GRACE_PERIOD) {
> +		if (resp->status == nlm_lck_denied_grace_period) {
>  			dprintk("lockd: server in grace period\n");
>  			if (argp->reclaim) {
>  				printk(KERN_WARNING
> @@ -411,10 +411,10 @@ nlmclnt_test(struct nlm_rqst *req, struc
>  		goto out;
>  
>  	switch (req->a_res.status) {
> -		case NLM_LCK_GRANTED:
> +		case nlm_granted:
>  			fl->fl_type = F_UNLCK;
>  			break;
> -		case NLM_LCK_DENIED:
> +		case nlm_lck_denied:
>  			/*
>  			 * Report the conflicting lock back to the application.
>  			 */
> @@ -524,9 +524,9 @@ again:
>  		if (!req->a_args.block)
>  			break;
>  		/* Did a reclaimer thread notify us of a server reboot? */
> -		if (resp->status ==  NLM_LCK_DENIED_GRACE_PERIOD)
> +		if (resp->status ==  nlm_lck_denied_grace_period)
>  			continue;
> -		if (resp->status != NLM_LCK_BLOCKED)
> +		if (resp->status != nlm_lck_blocked)
>  			break;
>  		/* Wait on an NLM blocking lock */
>  		status = nlmclnt_block(block, req, NLMCLNT_POLL_TIMEOUT);
> @@ -535,11 +535,11 @@ again:
>  		 */
>  		if (status < 0)
>  			goto out_unblock;
> -		if (resp->status != NLM_LCK_BLOCKED)
> +		if (resp->status != nlm_lck_blocked)
>  			break;
>  	}
>  
> -	if (resp->status == NLM_LCK_GRANTED) {
> +	if (resp->status == nlm_granted) {
>  		down_read(&host->h_rwsem);
>  		/* Check whether or not the server has rebooted */
>  		if (fl->fl_u.nfs_fl.state != host->h_state) {
> @@ -556,7 +556,7 @@ again:
>  out_unblock:
>  	nlmclnt_finish_block(block);
>  	/* Cancel the blocked request if it is still pending */
> -	if (resp->status == NLM_LCK_BLOCKED)
> +	if (resp->status == nlm_lck_blocked)
>  		nlmclnt_cancel(host, req->a_args.block, fl);
>  out:
>  	nlm_release_call(req);
> @@ -585,12 +585,12 @@ nlmclnt_reclaim(struct nlm_host *host, s
>  	req->a_args.reclaim = 1;
>  
>  	if ((status = nlmclnt_call(req, NLMPROC_LOCK)) >= 0
> -	 && req->a_res.status == NLM_LCK_GRANTED)
> +	 && req->a_res.status == nlm_granted)
>  		return 0;
>  
>  	printk(KERN_WARNING "lockd: failed to reclaim lock for pid %d "
>  				"(errno %d, status %d)\n", fl->fl_pid,
> -				status, req->a_res.status);
> +				status, ntohl(req->a_res.status));
>  
>  	/*
>  	 * FIXME: This is a serious failure. We can
> @@ -637,10 +637,10 @@ nlmclnt_unlock(struct nlm_rqst *req, str
>  	if (status < 0)
>  		goto out;
>  
> -	if (resp->status == NLM_LCK_GRANTED)
> +	if (resp->status == nlm_granted)
>  		goto out;
>  
> -	if (resp->status != NLM_LCK_DENIED_NOLOCKS)
> +	if (resp->status != nlm_lck_denied_nolocks)
>  		printk("lockd: unexpected unlock status: %d\n", resp->status);
>  	/* What to do now? I'm out of my depth... */
>  	status = -ENOLCK;
> @@ -652,7 +652,7 @@ out:
>  static void nlmclnt_unlock_callback(struct rpc_task *task, void *data)
>  {
>  	struct nlm_rqst	*req = data;
> -	int		status = req->a_res.status;
> +	u32 status = ntohl(req->a_res.status);
>  
>  	if (RPC_ASSASSINATED(task))
>  		goto die;
> @@ -720,6 +720,7 @@ static int nlmclnt_cancel(struct nlm_hos
>  static void nlmclnt_cancel_callback(struct rpc_task *task, void *data)
>  {
>  	struct nlm_rqst	*req = data;
> +	u32 status = ntohl(req->a_res.status);
>  
>  	if (RPC_ASSASSINATED(task))
>  		goto die;
> @@ -731,9 +732,9 @@ static void nlmclnt_cancel_callback(stru
>  	}
>  
>  	dprintk("lockd: cancel status %d (task %d)\n",
> -			req->a_res.status, task->tk_pid);
> +			status, task->tk_pid);
>  
> -	switch (req->a_res.status) {
> +	switch (status) {
>  	case NLM_LCK_GRANTED:
>  	case NLM_LCK_DENIED_GRACE_PERIOD:
>  	case NLM_LCK_DENIED:
> @@ -744,7 +745,7 @@ static void nlmclnt_cancel_callback(stru
>  		goto retry_cancel;
>  	default:
>  		printk(KERN_NOTICE "lockd: weird return %d for CANCEL call\n",
> -			req->a_res.status);
> +			status);
>  	}
>  
>  die:
> @@ -768,9 +769,9 @@ static const struct rpc_call_ops nlmclnt
>   * Convert an NLM status code to a generic kernel errno
>   */
>  static int
> -nlm_stat_to_errno(u32 status)
> +nlm_stat_to_errno(__be32 status)
>  {
> -	switch(status) {
> +	switch(ntohl(status)) {
>  	case NLM_LCK_GRANTED:
>  		return 0;
>  	case NLM_LCK_DENIED:
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 7e219b9..2e6600a 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -645,7 +645,7 @@ static const struct rpc_call_ops nlmsvc_
>   * block.
>   */
>  void
> -nlmsvc_grant_reply(struct nlm_cookie *cookie, u32 status)
> +nlmsvc_grant_reply(struct nlm_cookie *cookie, __be32 status)
>  {
>  	struct nlm_block	*block;
>  
> @@ -655,7 +655,7 @@ nlmsvc_grant_reply(struct nlm_cookie *co
>  		return;
>  
>  	if (block) {
> -		if (status == NLM_LCK_DENIED_GRACE_PERIOD) {
> +		if (status == nlm_lck_denied_grace_period) {
>  			/* Try again in a couple of seconds */
>  			nlmsvc_insert_block(block, 10 * HZ);
>  		} else {
> diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
> index b7c9492..34dae5d 100644
> --- a/fs/lockd/xdr.c
> +++ b/fs/lockd/xdr.c
> @@ -361,7 +361,7 @@ nlmsvc_decode_res(struct svc_rqst *rqstp
>  {
>  	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
>  		return 0;
> -	resp->status = ntohl(*p++);
> +	resp->status = *p++;
>  	return xdr_argsize_check(rqstp, p);
>  }
>  
> @@ -407,8 +407,8 @@ nlmclt_decode_testres(struct rpc_rqst *r
>  {
>  	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
>  		return -EIO;
> -	resp->status = ntohl(*p++);
> -	if (resp->status == NLM_LCK_DENIED) {
> +	resp->status = *p++;
> +	if (resp->status == nlm_lck_denied) {
>  		struct file_lock	*fl = &resp->lock.fl;
>  		u32			excl;
>  		s32			start, len, end;
> @@ -506,7 +506,7 @@ nlmclt_decode_res(struct rpc_rqst *req, 
>  {
>  	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
>  		return -EIO;
> -	resp->status = ntohl(*p++);
> +	resp->status = *p++;
>  	return 0;
>  }
>  
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index f4c0b2b..a782405 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -367,7 +367,7 @@ nlm4svc_decode_res(struct svc_rqst *rqst
>  {
>  	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
>  		return 0;
> -	resp->status = ntohl(*p++);
> +	resp->status = *p++;
>  	return xdr_argsize_check(rqstp, p);
>  }
>  
> @@ -413,8 +413,8 @@ nlm4clt_decode_testres(struct rpc_rqst *
>  {
>  	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
>  		return -EIO;
> -	resp->status = ntohl(*p++);
> -	if (resp->status == NLM_LCK_DENIED) {
> +	resp->status = *p++;
> +	if (resp->status == nlm_lck_denied) {
>  		struct file_lock	*fl = &resp->lock.fl;
>  		u32			excl;
>  		s64			start, end, len;
> @@ -512,7 +512,7 @@ nlm4clt_decode_res(struct rpc_rqst *req,
>  {
>  	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
>  		return -EIO;
> -	resp->status = ntohl(*p++);
> +	resp->status = *p++;
>  	return 0;
>  }
>  
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 11fdaf7..221acd1 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -22,7 +22,7 @@ #define NFSDDBG_FACILITY		NFSDDBG_LOCKD
>  /*
>   * Note: we hold the dentry use count while the file is open.
>   */
> -static u32
> +static __be32
>  nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
>  {
>  	__be32		nfserr;
> diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
> index aa50d89..246de1d 100644
> --- a/include/linux/lockd/bind.h
> +++ b/include/linux/lockd/bind.h
> @@ -23,7 +23,7 @@ struct svc_rqst;
>   * This is the set of functions for lockd->nfsd communication
>   */
>  struct nlmsvc_binding {
> -	u32			(*fopen)(struct svc_rqst *,
> +	__be32			(*fopen)(struct svc_rqst *,
>  						struct nfs_fh *,
>  						struct file **);
>  	void			(*fclose)(struct file *);
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index 8c39654..46e8edb 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -191,7 +191,7 @@ __be32		  nlmsvc_cancel_blocked(struct n
>  unsigned long	  nlmsvc_retry_blocked(void);
>  void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
>  					nlm_host_match_fn_t match);
> -void		  nlmsvc_grant_reply(struct nlm_cookie *, u32);
> +void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
>  
>  /*
>   * File handling for the server personality
> diff --git a/include/linux/lockd/sm_inter.h b/include/linux/lockd/sm_inter.h
> index fc61d40..22a6458 100644
> --- a/include/linux/lockd/sm_inter.h
> +++ b/include/linux/lockd/sm_inter.h
> @@ -24,7 +24,7 @@ #define SM_MAXSTRLEN	1024
>   * Arguments for all calls to statd
>   */
>  struct nsm_args {
> -	u32		addr;		/* remote address */
> +	__be32		addr;		/* remote address */
>  	u32		prog;		/* RPC callback info */
>  	u32		vers;
>  	u32		proc;
> diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
> index 29e7d9f..83a1f9f 100644
> --- a/include/linux/lockd/xdr.h
> +++ b/include/linux/lockd/xdr.h
> @@ -69,7 +69,7 @@ typedef struct nlm_args nlm_args;
>   */
>  struct nlm_res {
>  	struct nlm_cookie	cookie;
> -	u32			status;
> +	__be32			status;
>  	struct nlm_lock		lock;
>  };
>  
> @@ -80,9 +80,9 @@ struct nlm_reboot {
>  	char *		mon;
>  	int		len;
>  	u32		state;
> -	u32		addr;
> -	u32		vers;
> -	u32		proto;
> +	__be32		addr;
> +	__be32		vers;
> +	__be32		proto;
>  };
>  
>  /*

