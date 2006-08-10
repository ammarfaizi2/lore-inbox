Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWHJAcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWHJAcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWHJAcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:32:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15001 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932449AbWHJAca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:32:30 -0400
Date: Wed, 9 Aug 2006 17:33:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: stelian@popies.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@au1.ibm.com,
       anton@au1.ibm.com, open-iscsi@googlegroups.com, pradeep@us.ibm.com,
       mashirle@us.ibm.com, michaelc@cs.wisc.edu
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810003310.GA3071@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060810001823.GA3026@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20060810001823.GA3026@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OK, it appears that we are even.  I forgot to attach the promised
analysis of the callers to __kfifo_put() and __kfifo_get(), and
the open-iscsi@googlegroups.com email address listed as maintainer
in drivers/scsi/libiscsi.c bounces complaining that, as a non-member,
I am not allowed to send it email.  ;-)

Anyway, this time the analysis really is attached, sorry for my confusion!

Could someone please let the guys on open-iscsi@googlegroups.com know
that they should take a look at this?

						Thanx, Paul

On Wed, Aug 09, 2006 at 05:18:23PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Both __kfifo_put() and __kfifo_get() have header comments stating
> that if there is but one concurrent reader and one concurrent writer,
> locking is not necessary.  This is almost the case, but a couple of
> memory barriers are needed.  Another option would be to change the
> header comments to remove the bit about locking not being needed, and
> to change the those callers who currently don't use locking to add
> the required locking.  The attachment analyzes this approach, but the
> patch below seems simpler.
> 
> Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
> ---
> 
>  kfifo.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> diff -urpNa -X dontdiff linux-2.6.18-rc2/kernel/kfifo.c linux-2.6.18-rc2-kfifo/kernel/kfifo.c
> --- linux-2.6.18-rc2/kernel/kfifo.c	2006-07-15 14:53:08.000000000 -0700
> +++ linux-2.6.18-rc2-kfifo/kernel/kfifo.c	2006-08-09 14:01:53.000000000 -0700
> @@ -129,6 +129,8 @@ unsigned int __kfifo_put(struct kfifo *f
>  	/* then put the rest (if any) at the beginning of the buffer */
>  	memcpy(fifo->buffer, buffer + l, len - l);
>  
> +	smp_wmb();
> +
>  	fifo->in += len;
>  
>  	return len;
> @@ -161,6 +163,8 @@ unsigned int __kfifo_get(struct kfifo *f
>  	/* then get the rest (if any) from the beginning of the buffer */
>  	memcpy(buffer + l, fifo->buffer, len - l);
>  
> +	smp_mb();
> +
>  	fifo->out += len;
>  
>  	return len;

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kfifo.txt"

drivers/scsi/iscsi_tcp.c iscsi_r2t_rsp 377 rc = __kfifo_get(tcp_ctask->r2tpool.queue, (void *)&r2t, sizeof(void *));

	Covered by session->lock.

drivers/scsi/iscsi_tcp.c handle_xmstate_sol_data 1718 if (__kfifo_get(tcp_ctask->r2tqueue, (void *)&r2t, sizeof(void *))) {

	Not covered by session->lock.

drivers/scsi/iscsi_tcp.c iscsi_tcp_ctask_xmit 1839 __kfifo_get(tcp_ctask->r2tqueue, (void *)&tcp_ctask->r2t,

	Covered by session->lock.

drivers/scsi/iscsi_tcp.c iscsi_tcp_cleanup_ctask 2011 while (__kfifo_get(tcp_ctask->r2tqueue, (void *)&r2t, sizeof(void *)))

	Covered by session->lock, at least according to the comments.
	(called by iscsi_tcp_cleanup_ctask(), which is called by
	things invoking the cleanup_cmd_task function pointer, which
	is invoked by fail_command(), which has a header comment
	demanding that session->lock be held by callers.

drivers/scsi/libiscsi.c iscsi_data_xmit 556 while (__kfifo_get(conn->immqueue, (void *)&conn->mtask,

	Not covered by session->lock.

drivers/scsi/libiscsi.c iscsi_data_xmit 571 while (__kfifo_get(conn->xmitqueue, (void *)&conn->ctask,

	Not covered by session->lock.

drivers/scsi/libiscsi.c iscsi_data_xmit 590 while (__kfifo_get(conn->mgmtqueue, (void *)&conn->mtask,

	Not covered by session->lock.

drivers/scsi/libiscsi.c iscsi_data_xmit 690 __kfifo_get(session->cmdpool.queue, (void *)&ctask, sizeof(void *));

	Covered by session->lock.

drivers/scsi/libiscsi.c iscsi_conn_send_generic 766 if (!__kfifo_get(session->mgmtpool.queue,

	Covered by session->lock.

drivers/scsi/libiscsi.c iscsi_remove_task 990 __kfifo_get(fifo, (void *)&task, sizeof(void *)); \

	Macro that expands to iscsi_remove_mgmt_task() and
	iscsi_remove_cmd_task()

	o	iscsi_remove_mgmt_task called from iscsi_ctask_mtask_cleanup,
		which in turn is called from fail_command() and 
		iscsi_eh_abort().

		o	fail_command() comment indicates that session
			lock must be held.

		o	iscsi_eh_abort() has the session lock held.

	o	iscsi_remove_cmd_task() called from iscsi_eh_abort(),
		which again has the session lock held.

drivers/scsi/libiscsi.c iscsi_conn_setup 1386 if (!__kfifo_get(session->mgmtpool.queue,

	Covered by session->lock.

drivers/scsi/libiscsi.c flush_control_queues 1546 while (__kfifo_get(conn->immqueue, (void *)&mtask, sizeof(void *)) ||

	Covered by session->lock.  (Held by caller
	iscsi_start_session_recovery().)

drivers/scsi/libiscsi.c flush_control_queues 1547 __kfifo_get(conn->mgmtqueue, (void *)&mtask, sizeof(void *))) {

	Covered by session->lock.  (Held by caller
	iscsi_start_session_recovery().)

drivers/scsi/libiscsi.c fail_all_commands 1575 while (__kfifo_get(conn->xmitqueue, (void *)&ctask, sizeof(void *))) {

	Covered by session->lock.

include/linux/kfifo.h kfifo_get 113 ret = __kfifo_get(fifo, buffer, len);

	Covered by fifo->lock.

kernel/kfifo.c __kfifo_get 150 unsigned int __kfifo_get(struct kfifo *fifo,

	Covered by fifo->lock.

drivers/infiniband/ulp/iser/iser_initiator.c iser_snd_completion 674 __kfifo_put(session->mgmtpool.queue, (void *)&mtask,

	Covered by conn->session->lock.  But I have no idea what
	consumes the resulting message -- my guess is that it is
	actually going down to iscsi, based on the
	"conn = iser_conn->iscsi_conn" earlier in this function.

drivers/scsi/iscsi_tcp.c iscsi_r2t_rsp 401 __kfifo_put(tcp_ctask->r2tqueue, (void *)&r2t, sizeof(void *));

	Covered by session->lock.

drivers/scsi/iscsi_tcp.c iscsi_r2t_rsp 402 __kfifo_put(conn->xmitqueue, (void *)&ctask, sizeof(void *));

	Covered by session->lock.

drivers/scsi/iscsi_tcp.c iscsi_tcp_mtask_xmit 1388 __kfifo_put(session->mgmtpool.queue, (void *)&conn->mtask,

	Covered by session->lock.

drivers/scsi/iscsi_tcp.c handle_xmstate_sol_data 1716 __kfifo_put(tcp_ctask->r2tpool.queue, (void *)&r2t, sizeof(void *));

	Covered by session->lock.

drivers/scsi/iscsi_tcp.c iscsi_tcp_cleanup_ctask 2012 __kfifo_put(tcp_ctask->r2tpool.queue, (void *)&r2t,

	Covered by session->lock, at least according to the comments.
	(called by iscsi_tcp_cleanup_ctask(), which is called by
	things invoking the cleanup_cmd_task function pointer, which
	is invoked by fail_command(), which has a header comment
	demanding that session->lock be held by callers.

drivers/scsi/libiscsi.c iscsi_complete_command 194 __kfifo_put(session->cmdpool.queue, (void *)&ctask, sizeof(void *));

	Covered by session->lock, or at least the header comment claims
	that it should be called under this lock.

drivers/scsi/libiscsi.c __iscsi_complete_pdu 354 __kfifo_put(session->mgmtpool.queue,

	Covered by session->lock by all in-tree calls, but is an
	exported symbol.

drivers/scsi/libiscsi.c __iscsi_complete_pdu 384 __kfifo_put(session->mgmtpool.queue,

	Covered by session->lock by all in-tree calls, but is an
	exported symbol.

drivers/scsi/libiscsi.c __iscsi_complete_pdu 703 __kfifo_put(conn->xmitqueue, (void *)&ctask, sizeof(void *));

	Covered by session->lock by all in-tree calls, but is an
	exported symbol.

drivers/scsi/libiscsi.c iscsi_conn_send_generic 808 __kfifo_put(conn->immqueue, (void *)&mtask, sizeof(void *));

	Not covered by session->lock.

drivers/scsi/libiscsi.c iscsi_conn_send_generic 810 __kfifo_put(conn->mgmtqueue, (void *)&mtask, sizeof(void *));

	Not covered by session->lock.

drivers/scsi/libiscsi.c iscsi_remove_task 998 __kfifo_put(fifo, (void *)&task, sizeof(void *)); \

	Covered by session->lock, analysis is the same as for the
	earlier occurrence of iscsi_remove_task().

drivers/scsi/libiscsi.c iscsi_ctask_mtask_cleanup 1016 __kfifo_put(session->mgmtpool.queue, (void *)&ctask->mtask,

	Called from fail_command(), which has a header comment claiming
	that session->lock must be held, and from iscsi_eh_abort(),
	which has session->lock held.

drivers/scsi/libiscsi.c iscsi_eh_abort 1082 __kfifo_put(conn->xmitqueue, (void *)&pending_ctask,

	Covered by session->lock.

drivers/scsi/libiscsi.c iscsi_pool_init 1175 __kfifo_put(q->queue, (void *)&q->pool[i], sizeof(void *));

	Looks like initialization code, where no-one else would have
	a reference to the kfifo, so should be OK.

drivers/scsi/libiscsi.c iscsi_conn_setup 1406 __kfifo_put(session->mgmtpool.queue, (void *)&conn->login_mtask,

	Not covered by session->lock, despite other __kfifo operations
	being covered by this lock elsewhere in this function.

drivers/scsi/libiscsi.c iscsi_conn_teardown 1478 __kfifo_put(session->mgmtpool.queue, (void *)&conn->login_mtask,

	Covered by session->lock.

drivers/scsi/libiscsi.c flush_control_queues 1551 __kfifo_put(session->mgmtpool.queue, (void *)&mtask,

	Covered by session->lock.  (Held by caller
	iscsi_start_session_recovery().)

drivers/scsi/libiscsi.c flush_control_queues 1562 __kfifo_put(session->mgmtpool.queue, (void *)&mtask,

	Covered by session->lock.  (Held by caller
	iscsi_start_session_recovery().)

include/linux/kfifo.h kfifo_put 89 ret = __kfifo_put(fifo, buffer, len);

	Covered by fifo->lock.


--UugvWAfsgieZRqgk--
