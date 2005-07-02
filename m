Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVGBLyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVGBLyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 07:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVGBLyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 07:54:11 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:27540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261157AbVGBLyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 07:54:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qkeAPROD8hLikNfLX5QWX5RoEvDlKJ3M1BjogsX17naIX0MZ9lK2qEOOpD3EuwfSp2w/g/Z/sb0GZ5I5odNv+jvysJm1rPN5aWRXiUtjZCc3L2CMfQZUWIv5Dm/NBkt6A5ktzvmlKUoF0MzfOhK9EqiKzwNq+o0RTLXhaF4x08o=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Subject: Re: coverity-sunrpc-xprt-task-null-check.patch added to -mm tree
Date: Sat, 2 Jul 2005 16:00:25 +0400
User-Agent: KMail/1.7.2
Cc: kambarov@berkeley.edu, neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no,
       zkambarov@coverity.com, linux-kernel@vger.kernel.org
References: <200507010616.j616GHFJ023637@shell0.pdx.osdl.net>
In-Reply-To: <200507010616.j616GHFJ023637@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507021600.25546.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 July 2005 10:15, akpm@osdl.org wrote:
> --- devel/net/sunrpc/xprt.c~coverity-sunrpc-xprt-task-null-check
> +++ devel-akpm/net/sunrpc/xprt.c
> @@ -140,7 +140,10 @@ xprt_from_sock(struct sock *sk)
>  static int
>  __xprt_lock_write(struct rpc_xprt *xprt, struct rpc_task *task)
>  {
> -	struct rpc_rqst *req = task->tk_rqstp;
> +        struct rpc_rqst *req = NULL;
> +
> +	if (task)
> +                req = task->tk_rqstp;

2 callers of __xprt_lock_write():
----------------------------------------------------------------------------
static inline int xprt_lock_write(struct rpc_xprt *xprt, struct rpc_task *task)
{
        int retval;

        spin_lock_bh(&xprt->sock_lock);
===>    retval = __xprt_lock_write(xprt, task);	<===
        spin_unlock_bh(&xprt->sock_lock);
        return retval;
}
----+-----------------------------------------------------------------------
    |1 caller for xprt_lock_write():
    |
    |void xprt_connect(struct rpc_task *task)
    |{
    |===>    struct rpc_xprt *xprt = task->tk_xprt;	<===
    |
    |        dprintk("RPC: %4d xprt_connect xprt %p %s connected\n", task->tk_pid,
    |                        xprt, (xprt_connected(xprt) ? "is" : "is not"));
    |
    |        if (xprt->shutdown) {
    |                task->tk_status = -EIO;
    |                return;
    |        }
    |        if (!xprt->addr.sin_port) {
    |                task->tk_status = -EIO;
    |                return;
    |        }
    |        if (!xprt_lock_write(xprt, task))
    |
    |task was already dereferenced.
----+-----------------------------------------------------------------------
int xprt_prepare_transmit(struct rpc_task *task)
{
===>    struct rpc_rqst *req = task->tk_rqstp;	<===
        struct rpc_xprt *xprt = req->rq_xprt;
        int err = 0;

        dprintk("RPC: %4d xprt_prepare_transmit\n", task->tk_pid);

        if (xprt->shutdown)
                return -EIO;

        spin_lock_bh(&xprt->sock_lock);
        if (req->rq_received && !req->rq_bytes_sent) {
                err = req->rq_received;
                goto out_unlock;
        }
        if (!__xprt_lock_write(xprt, task)) {

task was already dereferenced.
----------------------------------------------------------------------------
