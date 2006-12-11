Return-Path: <linux-kernel-owner+w=401wt.eu-S1750728AbWLKXwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWLKXwu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWLKXwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:52:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:46340 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbWLKXwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:52:49 -0500
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
From: Matt Helsley <matthltc@us.ibm.com>
To: Erik Jacobson <erikj@sgi.com>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net
In-Reply-To: <20061207232213.GA29340@sgi.com>
References: <20061207232213.GA29340@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Mon, 11 Dec 2006 15:52:46 -0800
Message-Id: <1165881166.24721.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 17:22 -0600, Erik Jacobson wrote:
> On ia64, the various functions that make up cn_proc.c cause kernel
> unaligned access errors.
> 
> If you are using these, for example, to get notification about
> all tasks forking and exiting, you get multiple unaligned access errors
> per process.
> 
> Here, we just adjust how the variables are declared and use memcopy to
> avoid the error messages.
> 
> Signed-off-by: Erik Jacobson <erikj@sgi.com>

Acked-by: Matt Helsley <matthltc@us.ibm.com>

> ---
> 
>  cn_proc.c |   94 +++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
> --- linux.orig/drivers/connector/cn_proc.c	2006-11-29 15:57:37.000000000 -0600
> +++ linux/drivers/connector/cn_proc.c	2006-12-07 16:50:03.195035791 -0600
> @@ -49,7 +49,7 @@
>  void proc_fork_connector(struct task_struct *task)
>  {
>  	struct cn_msg *msg;
> -	struct proc_event *ev;
> +	struct proc_event ev;
>  	__u8 buffer[CN_PROC_MSG_SIZE];
>  	struct timespec ts;
> 
> @@ -57,19 +57,19 @@
>  		return;
> 
>  	msg = (struct cn_msg*)buffer;
> -	ev = (struct proc_event*)msg->data;
> -	get_seq(&msg->seq, &ev->cpu);
> +	get_seq(&msg->seq, &ev.cpu);
>  	ktime_get_ts(&ts); /* get high res monotonic timestamp */
> -	ev->timestamp_ns = timespec_to_ns(&ts);
> -	ev->what = PROC_EVENT_FORK;
> -	ev->event_data.fork.parent_pid = task->real_parent->pid;
> -	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
> -	ev->event_data.fork.child_pid = task->pid;
> -	ev->event_data.fork.child_tgid = task->tgid;
> +	ev.timestamp_ns = timespec_to_ns(&ts);
> +	ev.what = PROC_EVENT_FORK;
> +	ev.event_data.fork.parent_pid = task->real_parent->pid;
> +	ev.event_data.fork.parent_tgid = task->real_parent->tgid;
> +	ev.event_data.fork.child_pid = task->pid;
> +	ev.event_data.fork.child_tgid = task->tgid;
> 
>  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>  	msg->ack = 0; /* not used */
> -	msg->len = sizeof(*ev);
> +	msg->len = sizeof(ev);
> +	memcpy(msg->data, &ev, sizeof(ev));
>  	/*  If cn_netlink_send() failed, the data is not sent */
>  	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
>  }
> @@ -77,7 +77,7 @@
>  void proc_exec_connector(struct task_struct *task)
>  {
>  	struct cn_msg *msg;
> -	struct proc_event *ev;
> +	struct proc_event ev;
>  	struct timespec ts;
>  	__u8 buffer[CN_PROC_MSG_SIZE];
> 
> @@ -85,24 +85,24 @@
>  		return;
> 
>  	msg = (struct cn_msg*)buffer;
> -	ev = (struct proc_event*)msg->data;
> -	get_seq(&msg->seq, &ev->cpu);
> +	get_seq(&msg->seq, &ev.cpu);
>  	ktime_get_ts(&ts); /* get high res monotonic timestamp */
> -	ev->timestamp_ns = timespec_to_ns(&ts);
> -	ev->what = PROC_EVENT_EXEC;
> -	ev->event_data.exec.process_pid = task->pid;
> -	ev->event_data.exec.process_tgid = task->tgid;
> +	ev.timestamp_ns = timespec_to_ns(&ts);
> +	ev.what = PROC_EVENT_EXEC;
> +	ev.event_data.exec.process_pid = task->pid;
> +	ev.event_data.exec.process_tgid = task->tgid;
> 
>  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>  	msg->ack = 0; /* not used */
> -	msg->len = sizeof(*ev);
> +	msg->len = sizeof(ev);
> +	memcpy(msg->data, &ev, sizeof(ev));
>  	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
>  }
> 
>  void proc_id_connector(struct task_struct *task, int which_id)
>  {
>  	struct cn_msg *msg;
> -	struct proc_event *ev;
> +	struct proc_event ev;
>  	__u8 buffer[CN_PROC_MSG_SIZE];
>  	struct timespec ts;
> 
> @@ -110,32 +110,32 @@
>  		return;
> 
>  	msg = (struct cn_msg*)buffer;
> -	ev = (struct proc_event*)msg->data;
> -	ev->what = which_id;
> -	ev->event_data.id.process_pid = task->pid;
> -	ev->event_data.id.process_tgid = task->tgid;
> +	ev.what = which_id;
> +	ev.event_data.id.process_pid = task->pid;
> +	ev.event_data.id.process_tgid = task->tgid;
>  	if (which_id == PROC_EVENT_UID) {
> -	 	ev->event_data.id.r.ruid = task->uid;
> -	 	ev->event_data.id.e.euid = task->euid;
> +	 	ev.event_data.id.r.ruid = task->uid;
> +	 	ev.event_data.id.e.euid = task->euid;
>  	} else if (which_id == PROC_EVENT_GID) {
> -	   	ev->event_data.id.r.rgid = task->gid;
> -	   	ev->event_data.id.e.egid = task->egid;
> +	   	ev.event_data.id.r.rgid = task->gid;
> +	   	ev.event_data.id.e.egid = task->egid;
>  	} else
>  	     	return;
> -	get_seq(&msg->seq, &ev->cpu);
> +	get_seq(&msg->seq, &ev.cpu);
>  	ktime_get_ts(&ts); /* get high res monotonic timestamp */
> -	ev->timestamp_ns = timespec_to_ns(&ts);
> +	ev.timestamp_ns = timespec_to_ns(&ts);
> 
>  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>  	msg->ack = 0; /* not used */
> -	msg->len = sizeof(*ev);
> +	msg->len = sizeof(ev);
> +	memcpy(msg->data, &ev, sizeof(ev));
>  	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
>  }
> 
>  void proc_exit_connector(struct task_struct *task)
>  {
>  	struct cn_msg *msg;
> -	struct proc_event *ev;
> +	struct proc_event ev;
>  	__u8 buffer[CN_PROC_MSG_SIZE];
>  	struct timespec ts;
> 
> @@ -143,19 +143,19 @@
>  		return;
> 
>  	msg = (struct cn_msg*)buffer;
> -	ev = (struct proc_event*)msg->data;
> -	get_seq(&msg->seq, &ev->cpu);
> +	get_seq(&msg->seq, &ev.cpu);
>  	ktime_get_ts(&ts); /* get high res monotonic timestamp */
> -	ev->timestamp_ns = timespec_to_ns(&ts);
> -	ev->what = PROC_EVENT_EXIT;
> -	ev->event_data.exit.process_pid = task->pid;
> -	ev->event_data.exit.process_tgid = task->tgid;
> -	ev->event_data.exit.exit_code = task->exit_code;
> -	ev->event_data.exit.exit_signal = task->exit_signal;
> +	ev.timestamp_ns = timespec_to_ns(&ts);
> +	ev.what = PROC_EVENT_EXIT;
> +	ev.event_data.exit.process_pid = task->pid;
> +	ev.event_data.exit.process_tgid = task->tgid;
> +	ev.event_data.exit.exit_code = task->exit_code;
> +	ev.event_data.exit.exit_signal = task->exit_signal;
> 
>  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>  	msg->ack = 0; /* not used */
> -	msg->len = sizeof(*ev);
> +	msg->len = sizeof(ev);
> +	memcpy(msg->data, &ev, sizeof(ev));
>  	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
>  }
> 
> @@ -170,7 +170,7 @@
>  static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
>  {
>  	struct cn_msg *msg;
> -	struct proc_event *ev;
> +	struct proc_event ev;
>  	__u8 buffer[CN_PROC_MSG_SIZE];
>  	struct timespec ts;
> 
> @@ -178,16 +178,16 @@
>  		return;
> 
>  	msg = (struct cn_msg*)buffer;
> -	ev = (struct proc_event*)msg->data;
>  	msg->seq = rcvd_seq;
>  	ktime_get_ts(&ts); /* get high res monotonic timestamp */
> -	ev->timestamp_ns = timespec_to_ns(&ts);
> -	ev->cpu = -1;
> -	ev->what = PROC_EVENT_NONE;
> -	ev->event_data.ack.err = err;
> +	ev.timestamp_ns = timespec_to_ns(&ts);
> +	ev.cpu = -1;
> +	ev.what = PROC_EVENT_NONE;
> +	ev.event_data.ack.err = err;
>  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>  	msg->ack = rcvd_ack + 1;
> -	msg->len = sizeof(*ev);
> +	msg->len = sizeof(ev);
> +	memcpy(msg->data, &ev, sizeof(ev));
>  	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
>  }
> 

