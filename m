Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWIAQD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWIAQD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWIAQD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:03:59 -0400
Received: from pat.uio.no ([129.240.10.4]:44987 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932281AbWIAQD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:03:57 -0400
Subject: Re: [NFS] [PATCH 016 of 19] knfsd: match GRANTED_RES replies using
	cookies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1060901043932.27641@suse.de>
References: <20060901141639.27206.patches@notabene>
	 <1060901043932.27641@suse.de>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 12:03:38 -0400
Message-Id: <1157126618.5632.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.214, required 12,
	autolearn=disabled, AWL 1.79, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 14:39 +1000, NeilBrown wrote:
> From: Olaf Kirch <okir@suse.de>
> 
>  When we send a GRANTED_MSG call, we current copy the NLM cookie
>  provided in the original LOCK call - because in 1996, some broken
>  clients seemed to rely on this bug. However, this means the cookies
>  are not unique, so that when the client's GRANTED_RES message comes
>  back, we cannot simply match it based on the cookie, but have to
>  use the client's IP address in addition. Which breaks when you have
>  a multi-homed NFS client.
>  
>  The X/Open spec explicitly mentions that clients should not expect the
>  same cookie; so one may hope that any clients that were broken in 1996
>  have either been fixed or rendered obsolete.

Vetoed. The reason why we need the client's IP address as an argument
for nlmsvc_find_block() is 'cos the cookie value is unique to the
_client_ only.

IOW: when we go searching a global list of blocks for a given cookie
value that was sent to us by a given client, then we want to know that
we're only searching through that particular client's blocks.

A better way, BTW, would be to get rid of the global list nlm_blocked,
and just move the list of blocks into a field in the nlm_host for each
client.

> Signed-off-by: Olaf Kirch <okir@suse.de>
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/lockd/svc4proc.c         |    2 +-
>  ./fs/lockd/svclock.c          |   24 +++++++++++++-----------
>  ./fs/lockd/svcproc.c          |    2 +-
>  ./include/linux/lockd/lockd.h |    2 +-
>  4 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
> --- .prev/fs/lockd/svc4proc.c	2006-09-01 12:11:01.000000000 +1000
> +++ ./fs/lockd/svc4proc.c	2006-09-01 12:17:21.000000000 +1000
> @@ -455,7 +455,7 @@ nlm4svc_proc_granted_res(struct svc_rqst
>  
>          dprintk("lockd: GRANTED_RES   called\n");
>  
> -        nlmsvc_grant_reply(rqstp, &argp->cookie, argp->status);
> +        nlmsvc_grant_reply(&argp->cookie, argp->status);
>          return rpc_success;
>  }
>  
> 
> diff .prev/fs/lockd/svclock.c ./fs/lockd/svclock.c
> --- .prev/fs/lockd/svclock.c	2006-09-01 12:11:01.000000000 +1000
> +++ ./fs/lockd/svclock.c	2006-09-01 12:17:21.000000000 +1000
> @@ -139,19 +139,19 @@ static inline int nlm_cookie_match(struc
>   * Find a block with a given NLM cookie.
>   */
>  static inline struct nlm_block *
> -nlmsvc_find_block(struct nlm_cookie *cookie,  struct sockaddr_in *sin)
> +nlmsvc_find_block(struct nlm_cookie *cookie)
>  {
>  	struct nlm_block *block;
>  
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
> -		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie)
> -				&& nlm_cmp_addr(sin, &block->b_host->h_addr))
> +		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie))
>  			goto found;
>  	}
>  
>  	return NULL;
>  
>  found:
> +	dprintk("nlmsvc_find_block(%s): block=%p\n", nlmdbg_cookie2a(cookie), block);
>  	kref_get(&block->b_count);
>  	return block;
>  }
> @@ -165,6 +165,11 @@ found:
>   * request, but (as I found out later) that's because some implementations
>   * do just this. Never mind the standards comittees, they support our
>   * logging industries.
> + *
> + * 10 years later: I hope we can safely ignore these old and broken
> + * clients by now. Let's fix this so we can uniquely identify an incoming
> + * GRANTED_RES message by cookie, without having to rely on the client's IP
> + * address. --okir
>   */
>  static inline struct nlm_block *
>  nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_file *file,
> @@ -197,7 +202,7 @@ nlmsvc_create_block(struct svc_rqst *rqs
>  	/* Set notifier function for VFS, and init args */
>  	call->a_args.lock.fl.fl_flags |= FL_SLEEP;
>  	call->a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
> -	call->a_args.cookie = *cookie;	/* see above */
> +	nlmclnt_next_cookie(&call->a_args.cookie);
>  
>  	dprintk("lockd: created block %p...\n", block);
>  
> @@ -640,17 +645,14 @@ static const struct rpc_call_ops nlmsvc_
>   * block.
>   */
>  void
> -nlmsvc_grant_reply(struct svc_rqst *rqstp, struct nlm_cookie *cookie, u32 status)
> +nlmsvc_grant_reply(struct nlm_cookie *cookie, u32 status)
>  {
>  	struct nlm_block	*block;
> -	struct nlm_file		*file;
>  
> -	dprintk("grant_reply: looking for cookie %x, host (%08x), s=%d \n", 
> -		*(unsigned int *)(cookie->data), 
> -		ntohl(rqstp->rq_addr.sin_addr.s_addr), status);
> -	if (!(block = nlmsvc_find_block(cookie, &rqstp->rq_addr)))
> +	dprintk("grant_reply: looking for cookie %x, s=%d \n",
> +		*(unsigned int *)(cookie->data), status);
> +	if (!(block = nlmsvc_find_block(cookie)))
>  		return;
> -	file = block->b_file;
>  
>  	if (block) {
>  		if (status == NLM_LCK_DENIED_GRACE_PERIOD) {
> 
> diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
> --- .prev/fs/lockd/svcproc.c	2006-09-01 12:11:01.000000000 +1000
> +++ ./fs/lockd/svcproc.c	2006-09-01 12:17:21.000000000 +1000
> @@ -484,7 +484,7 @@ nlmsvc_proc_granted_res(struct svc_rqst 
>  
>  	dprintk("lockd: GRANTED_RES   called\n");
>  
> -	nlmsvc_grant_reply(rqstp, &argp->cookie, argp->status);
> +	nlmsvc_grant_reply(&argp->cookie, argp->status);
>  	return rpc_success;
>  }
>  
> 
> diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
> --- .prev/include/linux/lockd/lockd.h	2006-09-01 12:17:03.000000000 +1000
> +++ ./include/linux/lockd/lockd.h	2006-09-01 12:17:21.000000000 +1000
> @@ -193,7 +193,7 @@ u32		  nlmsvc_cancel_blocked(struct nlm_
>  unsigned long	  nlmsvc_retry_blocked(void);
>  void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
>  					nlm_host_match_fn_t match);
> -void	  nlmsvc_grant_reply(struct svc_rqst *, struct nlm_cookie *, u32);
> +void		  nlmsvc_grant_reply(struct nlm_cookie *, u32);
>  
>  /*
>   * File handling for the server personality
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs

