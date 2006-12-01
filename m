Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759233AbWLAGzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759233AbWLAGzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759243AbWLAGzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:55:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759233AbWLAGza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:55:30 -0500
Date: Thu, 30 Nov 2006 22:55:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [DLM] Add support for tcp communications [38/70]
Message-Id: <20061130225514.c050bd56.akpm@osdl.org>
In-Reply-To: <1164889148.3752.381.camel@quoit.chygwyn.com>
References: <1164889148.3752.381.camel@quoit.chygwyn.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 12:19:08 +0000
Steven Whitehouse <swhiteho@redhat.com> wrote:

> >From fdda387f73947e6ae511ec601f5b3c6fbb582aac Mon Sep 17 00:00:00 2001
> From: Patrick Caulfield <pcaulfie@redhat.com>
> Date: Thu, 2 Nov 2006 11:19:21 -0500
> Subject: [PATCH] [DLM] Add support for tcp communications
> 
> The following patch adds a TCP based communications layer
> to the DLM which is compile time selectable. The existing SCTP
> layer gives the advantage of allowing multihoming, whereas
> the TCP layer has been heavily tested in previous versions of
> the DLM and is known to be robust and therefore can be used as
> a baseline for performance testing.
> 

I don't think this code is ready.


> ...
>
> +static struct rw_semaphore	nodeinfo_lock;

This can be initialised at compile-time.

> ...
>
> +#define CBUF_ADD(cb, n) do { (cb)->len += n; } while(0)
> +#define CBUF_EMPTY(cb) ((cb)->len == 0)
> +#define CBUF_MAY_ADD(cb, n) (((cb)->len + (n)) < ((cb)->mask + 1))
> +#define CBUF_DATA(cb) (((cb)->base + (cb)->len) & (cb)->mask)
> +
> +#define CBUF_INIT(cb, size) \
> +do { \
> +	(cb)->base = (cb)->len = 0; \
> +	(cb)->mask = ((size)-1); \
> +} while(0)
> +
> +#define CBUF_EAT(cb, n) \
> +do { \
> +	(cb)->len  -= (n); \
> +	(cb)->base += (n); \
> +	(cb)->base &= (cb)->mask; \
> +} while(0)

Suggest that all of the above be converted to C: lower-case static-inline
functions.

> +
> +/* List of nodes which have writes pending */
> +static struct list_head write_nodes;

LIST_HEAD (maybe)

> +static spinlock_t write_nodes_lock;

DEFINE_SPINLOCK

> +
> +/* Maximum number of incoming messages to process before
> + * doing a schedule()
> + */
> +#define MAX_RX_MSG_COUNT 25
> +
> +/* Manage daemons */
> +static struct task_struct *recv_task;
> +static struct task_struct *send_task;
> +static wait_queue_head_t lowcomms_recv_wait;

DECLARE_WAIT_QUEUE_HEAD

> +static atomic_t accepting;

= ATOMIC_INIT(0)

Generally, initialising things at compile-time is better: smaller vmlinux,
certainty that the code got it right.

> +static struct nodeinfo *nodeid2nodeinfo(int nodeid, gfp_t alloc)
> +{
> +	struct nodeinfo *ni;
> +	int r;
> +	int n;
> +
> +	down_read(&nodeinfo_lock);

Given that this function can sleep, I wonder if `alloc' is useful.  

I see lots of callers passing in a literal "0" for `alloc'.  That's in fact
a secret (GFP_ATOMIC & ~__GFP_HIGH).  I doubt if that's what you really
meant.  Particularly as the code could at least have used __GFP_WAIT (aka
GFP_NOIO) which is much, much more reliable than "0".  In fact "0" is the
least reliable mode possible.

IOW, this is all bollixed up.

> +	ni = idr_find(&nodeinfo_idr, nodeid);
> +	up_read(&nodeinfo_lock);
> +
> +	if (!ni && alloc) {
> +		down_write(&nodeinfo_lock);
> +
> +		ni = idr_find(&nodeinfo_idr, nodeid);
> +		if (ni)
> +			goto out_up;
> +
> +		r = idr_pre_get(&nodeinfo_idr, alloc);
> +		if (!r)
> +			goto out_up;
> +
> +		ni = kmalloc(sizeof(struct nodeinfo), alloc);

kzalloc

> +		if (!ni)
> +			goto out_up;
> +
> +		r = idr_get_new_above(&nodeinfo_idr, ni, nodeid, &n);
> +		if (r) {
> +			kfree(ni);
> +			ni = NULL;
> +			goto out_up;
> +		}
> +		if (n != nodeid) {
> +			idr_remove(&nodeinfo_idr, n);
> +			kfree(ni);
> +			ni = NULL;
> +			goto out_up;
> +		}
> +		memset(ni, 0, sizeof(struct nodeinfo));

hence nuke

> +		spin_lock_init(&ni->lock);
> +		INIT_LIST_HEAD(&ni->writequeue);
> +		spin_lock_init(&ni->writequeue_lock);
> +		ni->nodeid = nodeid;
> +
> +		if (nodeid > max_nodeid)
> +			max_nodeid = nodeid;
> +	out_up:
> +		up_write(&nodeinfo_lock);
> +	}
> +
> +	return ni;
> +}
> +
> +/* Don't call this too often... */
> +static struct nodeinfo *assoc2nodeinfo(sctp_assoc_t assoc)
> +{
> +	int i;
> +	struct nodeinfo *ni;
> +
> +	for (i=1; i<=max_nodeid; i++) {
> +		ni = nodeid2nodeinfo(i, 0);

GFP_NOIO (at least) (lots of places)

> +		if (ni && ni->assoc_id == assoc)
> +			return ni;
> +	}
> +	return NULL;
> +}
> +
>
> ...
>
> +static void send_shutdown(sctp_assoc_t associd)
> +{
> +	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
> +	struct msghdr outmessage;
> +	struct cmsghdr *cmsg;
> +	struct sctp_sndrcvinfo *sinfo;
> +	int ret;
> +
> +	outmessage.msg_name = NULL;
> +	outmessage.msg_namelen = 0;
> +	outmessage.msg_control = outcmsg;
> +	outmessage.msg_controllen = sizeof(outcmsg);
> +	outmessage.msg_flags = MSG_EOR;
> +
> +	cmsg = CMSG_FIRSTHDR(&outmessage);
> +	cmsg->cmsg_level = IPPROTO_SCTP;
> +	cmsg->cmsg_type = SCTP_SNDRCV;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
> +	outmessage.msg_controllen = cmsg->cmsg_len;
> +	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);

CMSG_DATA() returns void* - unneeded cast

> +	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
> +
> +	sinfo->sinfo_flags |= MSG_EOF;
> +	sinfo->sinfo_assoc_id = associd;
> +
> +	ret = kernel_sendmsg(sctp_con.sock, &outmessage, NULL, 0, 0);
> +
> +	if (ret != 0)
> +		log_print("send EOF to node failed: %d", ret);
> +}
>
> ...
>
> +			ni = nodeid2nodeinfo(nodeid, GFP_KERNEL);
> +			if (!ni)
> +				return;
> +
> +			/* Save the assoc ID */
> +			spin_lock(&ni->lock);
> +			ni->assoc_id = sn->sn_assoc_change.sac_assoc_id;
> +			spin_unlock(&ni->lock);

A bare assignment inside a lock like this is quite unusual.  It is often an
indication that something is wrong.

> +/* Data received from remote end */
> +static int receive_from_sock(void)
> +{
> +	int ret = 0;
> +	struct msghdr msg;
> +	struct kvec iov[2];
> +	unsigned len;
> +	int r;
> +	struct sctp_sndrcvinfo *sinfo;
> +	struct cmsghdr *cmsg;
> +	struct nodeinfo *ni;
> +
> +	/* These two are marginally too big for stack allocation, but this
> +	 * function is (currently) only called by dlm_recvd so static should be
> +	 * OK.
> +	 */
> +	static struct sockaddr_storage msgname;
> +	static char incmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];

whoa.  This is globally singly-threaded code??


> +	if (sctp_con.sock == NULL)
> +		goto out;
> +
> +	if (sctp_con.rx_page == NULL) {
> +		/*
> +		 * This doesn't need to be atomic, but I think it should
> +		 * improve performance if it is.
> +		 */
> +		sctp_con.rx_page = alloc_page(GFP_ATOMIC);
> +		if (sctp_con.rx_page == NULL)
> +			goto out_resched;
> +		CBUF_INIT(&sctp_con.cb, PAGE_CACHE_SIZE);
> +	}
> +
> +	memset(&incmsg, 0, sizeof(incmsg));
> +	memset(&msgname, 0, sizeof(msgname));
> +
> +	memset(incmsg, 0, sizeof(incmsg));

You just zeroed it twice.

> +	msg.msg_name = &msgname;
> +	msg.msg_namelen = sizeof(msgname);
> +	msg.msg_flags = 0;
> +	msg.msg_control = incmsg;
> +	msg.msg_controllen = sizeof(incmsg);
> +	msg.msg_iovlen = 1;
> +
> +	/* I don't see why this circular buffer stuff is necessary for SCTP
> +	 * which is a packet-based protocol, but the whole thing breaks under
> +	 * load without it! The overhead is minimal (and is in the TCP lowcomms
> +	 * anyway, of course) so I'll leave it in until I can figure out what's
> +	 * really happening.
> +	 */
> +
> +	/*
> +	 * iov[0] is the bit of the circular buffer between the current end
> +	 * point (cb.base + cb.len) and the end of the buffer.
> +	 */
> +	iov[0].iov_len = sctp_con.cb.base - CBUF_DATA(&sctp_con.cb);
> +	iov[0].iov_base = page_address(sctp_con.rx_page) +
> +			  CBUF_DATA(&sctp_con.cb);
> +	iov[1].iov_len = 0;
> +
> +	/*
> +	 * iov[1] is the bit of the circular buffer between the start of the
> +	 * buffer and the start of the currently used section (cb.base)
> +	 */
> +	if (CBUF_DATA(&sctp_con.cb) >= sctp_con.cb.base) {
> +		iov[0].iov_len = PAGE_CACHE_SIZE - CBUF_DATA(&sctp_con.cb);
> +		iov[1].iov_len = sctp_con.cb.base;
> +		iov[1].iov_base = page_address(sctp_con.rx_page);
> +		msg.msg_iovlen = 2;
> +	}
> +	len = iov[0].iov_len + iov[1].iov_len;
> +
> +	r = ret = kernel_recvmsg(sctp_con.sock, &msg, iov, msg.msg_iovlen, len,
> +				 MSG_NOSIGNAL | MSG_DONTWAIT);
> +	if (ret <= 0)
> +		goto out_close;
> +
> +	msg.msg_control = incmsg;
> +	msg.msg_controllen = sizeof(incmsg);
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
> +
> +	if (msg.msg_flags & MSG_NOTIFICATION) {
> +		process_sctp_notification(&msg, page_address(sctp_con.rx_page));
> +		return 0;
> +	}
> +
> +	/* Is this a new association ? */
> +	ni = nodeid2nodeinfo(le32_to_cpu(sinfo->sinfo_ppid), GFP_KERNEL);
> +	if (ni) {
> +		ni->assoc_id = sinfo->sinfo_assoc_id;
> +		if (test_and_clear_bit(NI_INIT_PENDING, &ni->flags)) {
> +
> +			if (!test_and_set_bit(NI_WRITE_PENDING, &ni->flags)) {
> +				spin_lock_bh(&write_nodes_lock);
> +				list_add_tail(&ni->write_list, &write_nodes);
> +				spin_unlock_bh(&write_nodes_lock);
> +			}
> +			wake_up_process(send_task);
> +		}
> +	}
> +
> +	/* INIT sends a message with length of 1 - ignore it */
> +	if (r == 1)
> +		return 0;
> +
> +	CBUF_ADD(&sctp_con.cb, ret);
> +	ret = dlm_process_incoming_buffer(cpu_to_le32(sinfo->sinfo_ppid),
> +					  page_address(sctp_con.rx_page),
> +					  sctp_con.cb.base, sctp_con.cb.len,
> +					  PAGE_CACHE_SIZE);
> +	if (ret < 0)
> +		goto out_close;
> +	CBUF_EAT(&sctp_con.cb, ret);
> +
> +      out:

Labels go in column 0 or 1

> +	ret = 0;
> +	goto out_ret;
> +
> +      out_resched:
> +	lowcomms_data_ready(sctp_con.sock->sk, 0);
> +	ret = 0;
> +	schedule();

What's the random schedule() for?  If !need_reached() it's just a waste of
cycles.

> +	goto out_ret;
> +
> +      out_close:
> +	if (ret != -EAGAIN)
> +		log_print("error reading from sctp socket: %d", ret);
> +      out_ret:
> +	return ret;
> +}
> +
>
> ...
>
> +void *dlm_lowcomms_get_buffer(int nodeid, int len, gfp_t allocation, char **ppc)
> +{
> +	struct writequeue_entry *e;
> +	int offset = 0;
> +	int users = 0;
> +	struct nodeinfo *ni;
> +
> +	if (!atomic_read(&accepting))
> +		return NULL;

hm, this looks racy.  What happens if `accepting' goes to zero 50
nanoseconds later?

> +	ni = nodeid2nodeinfo(nodeid, allocation);
> +	if (!ni)
> +		return NULL;
> +
> +	spin_lock(&ni->writequeue_lock);
> +	e = list_entry(ni->writequeue.prev, struct writequeue_entry, list);
> +	if (((struct list_head *) e == &ni->writequeue) ||

That typecast looks fishy.  Perhaps a container_of() or something would be
clearer.

> +	    (PAGE_CACHE_SIZE - e->end < len)) {
> +		e = NULL;
> +	} else {
> +		offset = e->end;
> +		e->end += len;
> +		users = e->users++;
> +	}
> +	spin_unlock(&ni->writequeue_lock);
> +
> +	if (e) {
> +	      got_one:

whoa, how'd that label get all the way over there?

> +		if (users == 0)
> +			kmap(e->page);
> +		*ppc = page_address(e->page) + offset;
> +		return e;
> +	}
> +
> +	e = new_writequeue_entry(allocation);
> +	if (e) {
> +		spin_lock(&ni->writequeue_lock);
> +		offset = e->end;
> +		e->end += len;
> +		e->ni = ni;
> +		users = e->users++;
> +		list_add_tail(&e->list, &ni->writequeue);
> +		spin_unlock(&ni->writequeue_lock);
> +		goto got_one;
> +	}
> +	return NULL;
> +}
> +
>
> ...
>
> +static void initiate_association(int nodeid)
> +{
> +	struct sockaddr_storage rem_addr;
> +	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];

Another static buffer to worry about.  Globally singly-threaded code?

> +	struct msghdr outmessage;
> +	struct cmsghdr *cmsg;
> +	struct sctp_sndrcvinfo *sinfo;
> +	int ret;
> +	int addrlen;
> +	char buf[1];
> +	struct kvec iov[1];
> +	struct nodeinfo *ni;
> +
> +	log_print("Initiating association with node %d", nodeid);
> +
> +	ni = nodeid2nodeinfo(nodeid, GFP_KERNEL);
> +	if (!ni)
> +		return;
> +
> +	if (nodeid_to_addr(nodeid, (struct sockaddr *)&rem_addr)) {
> +		log_print("no address for nodeid %d", nodeid);
> +		return;

Am surprised that all these errors appear to be ignored.

> +	}
> +
> +	make_sockaddr(&rem_addr, dlm_config.tcp_port, &addrlen);
> +
> +	outmessage.msg_name = &rem_addr;
> +	outmessage.msg_namelen = addrlen;
> +	outmessage.msg_control = outcmsg;
> +	outmessage.msg_controllen = sizeof(outcmsg);
> +	outmessage.msg_flags = MSG_EOR;
> +
> +	iov[0].iov_base = buf;
> +	iov[0].iov_len = 1;
> +
> +	/* Real INIT messages seem to cause trouble. Just send a 1 byte message
> +	   we can afford to lose */
> +	cmsg = CMSG_FIRSTHDR(&outmessage);
> +	cmsg->cmsg_level = IPPROTO_SCTP;
> +	cmsg->cmsg_type = SCTP_SNDRCV;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
> +	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);
> +	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
> +	sinfo->sinfo_ppid = cpu_to_le32(dlm_local_nodeid);
> +
> +	outmessage.msg_controllen = cmsg->cmsg_len;
> +	ret = kernel_sendmsg(sctp_con.sock, &outmessage, iov, 1, 1);
> +	if (ret < 0) {
> +		log_print("send INIT to node failed: %d", ret);
> +		/* Try again later */
> +		clear_bit(NI_INIT_PENDING, &ni->flags);
> +	}
> +}
> +
> +/* Send a message */
> +static int send_to_sock(struct nodeinfo *ni)
> +{
> +	int ret = 0;
> +	struct writequeue_entry *e;
> +	int len, offset;
> +	struct msghdr outmsg;
> +	static char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];

Singly-threaded?

> +	struct cmsghdr *cmsg;
> +	struct sctp_sndrcvinfo *sinfo;
> +	struct kvec iov;
> +
> +        /* See if we need to init an association before we start
> +	   sending precious messages */

Please use tabs.

> +	spin_lock(&ni->lock);
> +	if (!ni->assoc_id && !test_and_set_bit(NI_INIT_PENDING, &ni->flags)) {
> +		spin_unlock(&ni->lock);
> +		initiate_association(ni->nodeid);
> +		return 0;
> +	}
> +	spin_unlock(&ni->lock);
> +
> +	outmsg.msg_name = NULL; /* We use assoc_id */
> +	outmsg.msg_namelen = 0;
> +	outmsg.msg_control = outcmsg;
> +	outmsg.msg_controllen = sizeof(outcmsg);
> +	outmsg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR;
> +
> +	cmsg = CMSG_FIRSTHDR(&outmsg);
> +	cmsg->cmsg_level = IPPROTO_SCTP;
> +	cmsg->cmsg_type = SCTP_SNDRCV;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(struct sctp_sndrcvinfo));
> +	sinfo = (struct sctp_sndrcvinfo *)CMSG_DATA(cmsg);

Unneeded cast

> +	memset(sinfo, 0x00, sizeof(struct sctp_sndrcvinfo));
> +	sinfo->sinfo_ppid = cpu_to_le32(dlm_local_nodeid);
> +	sinfo->sinfo_assoc_id = ni->assoc_id;
> +	outmsg.msg_controllen = cmsg->cmsg_len;
> +
> +	spin_lock(&ni->writequeue_lock);
> +	for (;;) {
> +		if (list_empty(&ni->writequeue))
> +			break;
> +		e = list_entry(ni->writequeue.next, struct writequeue_entry,
> +			       list);
> +		len = e->len;
> +		offset = e->offset;
> +		BUG_ON(len == 0 && e->users == 0);
> +		spin_unlock(&ni->writequeue_lock);
> +		kmap(e->page);

I think this kmap() gets leaked

> +		ret = 0;
> +		if (len) {
> +			iov.iov_base = page_address(e->page)+offset;
> +			iov.iov_len = len;
> +
> +			ret = kernel_sendmsg(sctp_con.sock, &outmsg, &iov, 1,
> +					     len);
> +			if (ret == -EAGAIN) {
> +				sctp_con.eagain_flag = 1;
> +				goto out;
> +			} else if (ret < 0)
> +				goto send_error;
> +		} else {
> +			/* Don't starve people filling buffers */
> +			schedule();
> +		}
> +
> +		spin_lock(&ni->writequeue_lock);
> +		e->offset += ret;
> +		e->len -= ret;
> +
> +		if (e->len == 0 && e->users == 0) {
> +			list_del(&e->list);
> +			free_entry(e);
> +			continue;
> +		}
> +	}
> +	spin_unlock(&ni->writequeue_lock);
> + out:
> +	return ret;
> +
> + send_error:
> +	log_print("Error sending to node %d %d", ni->nodeid, ret);
> +	spin_lock(&ni->lock);
> +	if (!test_and_set_bit(NI_INIT_PENDING, &ni->flags)) {
> +		ni->assoc_id = 0;
> +		spin_unlock(&ni->lock);
> +		initiate_association(ni->nodeid);
> +	} else
> +		spin_unlock(&ni->lock);
> +
> +	return ret;
> +}
>
> ...
>
> +static void dealloc_nodeinfo(void)
> +{
> +	int i;
> +
> +	for (i=1; i<=max_nodeid; i++) {
> +		struct nodeinfo *ni = nodeid2nodeinfo(i, 0);
> +		if (ni) {
> +			idr_remove(&nodeinfo_idr, i);

Didn't that need locking?

> +			kfree(ni);
> +		}
> +	}
> +}
> +
>
> ..
>
> +static int write_list_empty(void)
> +{
> +	int status;
> +
> +	spin_lock_bh(&write_nodes_lock);
> +	status = list_empty(&write_nodes);
> +	spin_unlock_bh(&write_nodes_lock);
> +
> +	return status;
> +}

This function's return value is meaningless.  As soon as the lock gets
dropped, the return value can get out of sync with reality.

Looking at the caller, this _might_ happen to be OK, but it's a nasty and
dangerous thing.  Really the locking should be moved into the caller.

> +static int dlm_recvd(void *data)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +
> +	while (!kthread_should_stop()) {
> +		int count = 0;
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		add_wait_queue(&lowcomms_recv_wait, &wait);
> +		if (!test_bit(CF_READ_PENDING, &sctp_con.flags))
> +			schedule();
> +		remove_wait_queue(&lowcomms_recv_wait, &wait);
> +		set_current_state(TASK_RUNNING);
> +
> +		if (test_and_clear_bit(CF_READ_PENDING, &sctp_con.flags)) {
> +			int ret;
> +
> +			do {
> +				ret = receive_from_sock();
> +
> +				/* Don't starve out everyone else */
> +				if (++count >= MAX_RX_MSG_COUNT) {
> +					schedule();

cond_resched() would be more efficient.  Potentially a lot more efficient. 
(several places).


> +					count = 0;
> +				}
> +			} while (!kthread_should_stop() && ret >=0);
> +		}
> +		schedule();
> +	}
> +
> +	return 0;
> +}
>
> ...
>
> +static int daemons_start(void)
> +{
> +	struct task_struct *p;
> +	int error;
> +
> +	p = kthread_run(dlm_recvd, NULL, "dlm_recvd");
> +	error = IS_ERR(p);
> +       	if (error) {
> +		log_print("can't start dlm_recvd %d", error);
> +		return error;
> +	}

whitespace broke

> +	recv_task = p;
> +
> +	p = kthread_run(dlm_sendd, NULL, "dlm_sendd");
> +	error = IS_ERR(p);
> +       	if (error) {
> +		log_print("can't start dlm_sendd %d", error);
> +		kthread_stop(recv_task);
> +		return error;
> +	}

ditto

> +	send_task = p;
> +
> +	return 0;
> +}
> +
>
> ...
>
> +#ifndef FALSE
> +#define FALSE 0
> +#define TRUE 1
> +#endif

No, we have a kernel-wide bool/true/false implementation.  Please use that.

>
> +#define CBUF_INIT(cb, size) do { (cb)->base = (cb)->len = 0; (cb)->mask = ((size)-1); } while(0)
> +#define CBUF_ADD(cb, n) do { (cb)->len += n; } while(0)
> +#define CBUF_EMPTY(cb) ((cb)->len == 0)
> +#define CBUF_MAY_ADD(cb, n) (((cb)->len + (n)) < ((cb)->mask + 1))
> +#define CBUF_EAT(cb, n) do { (cb)->len  -= (n); \
> +                             (cb)->base += (n); (cb)->base &= (cb)->mask; } while(0)
> +#define CBUF_DATA(cb) (((cb)->base + (cb)->len) & (cb)->mask)

This cbuf API seems to be part-implemented in two places.

Ditto previous comments about macro->inline conversion

> ...
> +static struct sockaddr_storage dlm_local_addr;
> +
> +/* Manage daemons */
> +static struct task_struct *recv_task;
> +static struct task_struct *send_task;
> +
> +static wait_queue_t lowcomms_send_waitq_head;
> +static wait_queue_head_t lowcomms_send_waitq;
> +static wait_queue_t lowcomms_recv_waitq_head;
> +static wait_queue_head_t lowcomms_recv_waitq;
> +
> +/* An array of pointers to connections, indexed by NODEID */
> +static struct connection **connections;
> +static struct semaphore connections_lock;
> +static kmem_cache_t *con_cache;
> +static int conn_array_size;
> +static atomic_t accepting;
> +
> +/* List of sockets that have reads pending */
> +static struct list_head read_sockets;
> +static spinlock_t read_sockets_lock;
> +
> +/* List of sockets which have writes pending */
> +static struct list_head write_sockets;
> +static spinlock_t write_sockets_lock;
> +
> +/* List of sockets which have connects pending */
> +static struct list_head state_sockets;
> +static spinlock_t state_sockets_lock;

See previous comments regarding static initialisation

> +static struct connection *nodeid2con(int nodeid, gfp_t allocation)
> +{
> +	struct connection *con = NULL;
> +
> +	down(&connections_lock);
> +	if (nodeid >= conn_array_size) {
> +		int new_size = nodeid + NODE_INCREMENT;
> +		struct connection **new_conns;
> +
> +		new_conns = kmalloc(sizeof(struct connection *) *
> +				    new_size, allocation);
> +		if (!new_conns)
> +			goto finish;
> +
> +		memset(new_conns, 0, sizeof(struct connection *) * new_size);

kzalloc()

> +		memcpy(new_conns, connections,  sizeof(struct connection *) * conn_array_size);
> +		conn_array_size = new_size;
> +		kfree(connections);
> +		connections = new_conns;
> +
> +	}
> +
> +	con = connections[nodeid];
> +	if (con == NULL && allocation) {
> +		con = kmem_cache_alloc(con_cache, allocation);
> +		if (!con)
> +			goto finish;
> +
> +		memset(con, 0, sizeof(*con));

kmem_cache_zalloc()

> +		con->nodeid = nodeid;
> +		init_rwsem(&con->sock_sem);
> +		INIT_LIST_HEAD(&con->writequeue);
> +		spin_lock_init(&con->writequeue_lock);
> +
> +		connections[nodeid] = con;
> +	}
> +
> + finish:
> +	up(&connections_lock);
> +	return con;
> +}
>
> ...
>
> +/* Add the port number to an IP6 or 4 sockaddr and return the address
> +   length */
> +static void make_sockaddr(struct sockaddr_storage *saddr, uint16_t port,
> +			  int *addr_len)
> +{
> +        saddr->ss_family =  dlm_local_addr.ss_family;
> +        if (saddr->ss_family == AF_INET) {
> +		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
> +		in4_addr->sin_port = cpu_to_be16(port);
> +		*addr_len = sizeof(struct sockaddr_in);
> +	}

whitespace broke

> +	else {

	} else {

> +		struct sockaddr_in6 *in6_addr = (struct sockaddr_in6 *)saddr;
> +		in6_addr->sin6_port = cpu_to_be16(port);
> +		*addr_len = sizeof(struct sockaddr_in6);
> +	}
> +}
> +
>
> ...
>
> +static struct socket *create_listen_sock(struct connection *con, struct sockaddr_storage *saddr)

Exceeds 80 cols  (lots of places)

> +{
> +        struct socket *sock = NULL;
> +	mm_segment_t fs;

whitespace broke

> +	int result = 0;
> +	int one = 1;
> +	int addr_len;
> +
> +	if (dlm_local_addr.ss_family == AF_INET)
> +		addr_len = sizeof(struct sockaddr_in);
> +	else
> +		addr_len = sizeof(struct sockaddr_in6);
> +
> +	/* Create a socket to communicate with */
> +	result = sock_create_kern(dlm_local_addr.ss_family, SOCK_STREAM, IPPROTO_TCP, &sock);
> +	if (result < 0) {
> +		printk("dlm: Can't create listening comms socket\n");
> +		goto create_out;
> +	}
> +
> +	fs = get_fs();
> +	set_fs(get_ds());
> +	result = sock_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, (char *)&one, sizeof(one));
> +	set_fs(fs);
> +	if (result < 0) {
> +		printk("dlm: Failed to set SO_REUSEADDR on socket: result=%d\n",result);
> +	}
> +	sock->sk->sk_user_data = con;
> +	con->rx_action = accept_from_sock;
> +	con->sock = sock;
> +
> +	/* Bind to our port */
> +	make_sockaddr(saddr, dlm_config.tcp_port, &addr_len);
> +	result = sock->ops->bind(sock, (struct sockaddr *) saddr, addr_len);
> +	if (result < 0) {
> +		printk("dlm: Can't bind to port %d\n", dlm_config.tcp_port);
> +		sock_release(sock);
> +		sock = NULL;
> +		con->sock = NULL;
> +		goto create_out;
> +	}
> +
> +	fs = get_fs();
> +	set_fs(get_ds());
> +
> +	result = sock_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, (char *)&one, sizeof(one));
> +	set_fs(fs);
> +	if (result < 0) {
> +		printk("dlm: Set keepalive failed: %d\n", result);
> +	}
> +
> +	result = sock->ops->listen(sock, 5);
> +	if (result < 0) {
> +		printk("dlm: Can't listen on port %d\n", dlm_config.tcp_port);
> +		sock_release(sock);
> +		sock = NULL;
> +		goto create_out;
> +	}
> +
> +      create_out:
> +	return sock;
> +}
> +
> +
> +/* Listen on all interfaces */
> +static int listen_for_all(void)
> +{
> +	struct socket *sock = NULL;
> +	struct connection *con = nodeid2con(0, GFP_KERNEL);
> +	int result = -EINVAL;
> +
> +	/* We don't support multi-homed hosts */
> +	memset(con, 0, sizeof(*con));

It would be more efficient to make nodeid2con() return a zeroed object.

> +	init_rwsem(&con->sock_sem);
> +	spin_lock_init(&con->writequeue_lock);
> +	INIT_LIST_HEAD(&con->writequeue);
> +	set_bit(CF_IS_OTHERCON, &con->flags);
> +
> +	sock = create_listen_sock(con, &dlm_local_addr);
> +	if (sock) {
> +		add_sock(sock, con);
> +		result = 0;
> +	}
> +	else {
> +		result = -EADDRINUSE;
> +	}
> +
> +	return result;
> +}
> +
> +}
> +
>
> ...
>
> +void *dlm_lowcomms_get_buffer(int nodeid, int len,
> +			      gfp_t allocation, char **ppc)
> +{
> +	struct connection *con;
> +	struct writequeue_entry *e;
> +	int offset = 0;
> +	int users = 0;
> +
> +	if (!atomic_read(&accepting))
> +		return NULL;
> +
> +	con = nodeid2con(nodeid, allocation);
> +	if (!con)
> +		return NULL;
> +
> +	spin_lock(&con->writequeue_lock);
> +	e = list_entry(con->writequeue.prev, struct writequeue_entry, list);
> +	if (((struct list_head *) e == &con->writequeue) ||

There's that cast again

> +	    (PAGE_CACHE_SIZE - e->end < len)) {
> +		e = NULL;
> +	} else {
> +		offset = e->end;
> +		e->end += len;
> +		users = e->users++;
> +	}
> +	spin_unlock(&con->writequeue_lock);
> +
> +	if (e) {
> +	      got_one:
> +		if (users == 0)
> +			kmap(e->page);

Please check that this kmap (and the others) don't get leaked.

> +		*ppc = page_address(e->page) + offset;
> +		return e;
> +	}
> +
> +	e = new_writequeue_entry(con, allocation);
> +	if (e) {
> +		spin_lock(&con->writequeue_lock);
> +		offset = e->end;
> +		e->end += len;
> +		users = e->users++;
> +		list_add_tail(&e->list, &con->writequeue);
> +		spin_unlock(&con->writequeue_lock);
> +		goto got_one;
> +	}
> +	return NULL;
> +}
> +
> +/* Send a message */
> +static int send_to_sock(struct connection *con)
> +{
> +	int ret = 0;
> +	ssize_t(*sendpage) (struct socket *, struct page *, int, size_t, int);
> +	const int msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
> +	struct writequeue_entry *e;
> +	int len, offset;
> +
> +	down_read(&con->sock_sem);
> +	if (con->sock == NULL)
> +		goto out_connect;
> +
> +	sendpage = con->sock->ops->sendpage;
> +
> +	spin_lock(&con->writequeue_lock);
> +	for (;;) {
> +		e = list_entry(con->writequeue.next, struct writequeue_entry,
> +			       list);
> +		if ((struct list_head *) e == &con->writequeue)
> +			break;
> +
> +		len = e->len;
> +		offset = e->offset;
> +		BUG_ON(len == 0 && e->users == 0);
> +		spin_unlock(&con->writequeue_lock);
> +
> +		ret = 0;
> +		if (len) {
> +			ret = sendpage(con->sock, e->page, offset, len,
> +				       msg_flags);
> +			if (ret == -EAGAIN || ret == 0)
> +				goto out;
> +			if (ret <= 0)
> +				goto send_error;
> +		}
> +		else {
> +			/* Don't starve people filling buffers */
> +			schedule();

cond_resched()

> +		}
> +
> +		spin_lock(&con->writequeue_lock);
> +		e->offset += ret;
> +		e->len -= ret;
> +
> +		if (e->len == 0 && e->users == 0) {
> +			list_del(&e->list);
> +			free_entry(e);
> +			continue;
> +		}
> +	}
> +	spin_unlock(&con->writequeue_lock);
> +      out:
> +	up_read(&con->sock_sem);
> +	return ret;
> +
> +      send_error:
> +	up_read(&con->sock_sem);
> +	close_connection(con, FALSE);
> +	lowcomms_connect_sock(con);
> +	return ret;
> +
> +      out_connect:
> +	up_read(&con->sock_sem);

More wayward labels there.

> +	lowcomms_connect_sock(con);
> +	return 0;
> +}
> +
>
> ...
>
> +/* Try to send any messages that are pending
> + */
> +static void process_output_queue(void)
> +{
> +	struct list_head *list;
> +	struct list_head *temp;
> +	int ret;
> +
> +	spin_lock_bh(&write_sockets_lock);
> +	list_for_each_safe(list, temp, &write_sockets) {
> +		struct connection *con =
> +		    list_entry(list, struct connection, write_list);
> +		clear_bit(CF_WRITE_PENDING, &con->flags);
> +		list_del(&con->write_list);
> +
> +		spin_unlock_bh(&write_sockets_lock);
> +
> +		ret = send_to_sock(con);
> +		if (ret < 0) {
> +		}

hmm.

> +		spin_lock_bh(&write_sockets_lock);
> +	}
> +	spin_unlock_bh(&write_sockets_lock);
> +}
> +
> +static void process_state_queue(void)
> +{
> +	struct list_head *list;
> +	struct list_head *temp;
> +	int ret;
> +
> +	spin_lock_bh(&state_sockets_lock);
> +	list_for_each_safe(list, temp, &state_sockets) {
> +		struct connection *con =
> +		    list_entry(list, struct connection, state_list);
> +		list_del(&con->state_list);
> +		clear_bit(CF_CONNECT_PENDING, &con->flags);
> +		spin_unlock_bh(&state_sockets_lock);
> +
> +		ret = connect_to_sock(con);
> +		if (ret < 0) {
> +		}

?

> +		spin_lock_bh(&state_sockets_lock);
> +	}
> +	spin_unlock_bh(&state_sockets_lock);
> +}
> +
> +
> +/* Discard all entries on the write queues */
> +static void clean_writequeues(void)
> +{
> +	int nodeid;
> +
> +	for (nodeid = 1; nodeid < conn_array_size; nodeid++) {
> +		struct connection *con = nodeid2con(nodeid, 0);
> +
> +		if (con)
> +			clean_one_writequeue(con);
> +	}
> +}
> +
> +static int read_list_empty(void)
> +{
> +	int status;
> +
> +	spin_lock_bh(&read_sockets_lock);
> +	status = list_empty(&read_sockets);
> +	spin_unlock_bh(&read_sockets_lock);
> +
> +	return status;
> +}

Again, unsafe.

> +static int daemons_start(void)
> +{
> +	struct task_struct *p;
> +	int error;
> +
> +	p = kthread_run(dlm_recvd, NULL, "dlm_recvd");
> +	error = IS_ERR(p);
> +       	if (error) {
> +		log_print("can't start dlm_recvd %d", error);
> +		return error;
> +	}
> +	recv_task = p;
> +
> +	p = kthread_run(dlm_sendd, NULL, "dlm_sendd");
> +	error = IS_ERR(p);
> +       	if (error) {
> +		log_print("can't start dlm_sendd %d", error);
> +		kthread_stop(recv_task);
> +		return error;

whitespace broke.

> +	}
> +	send_task = p;
> +
> +	return 0;
> +}
> +
>
> ...
>
> +/* This is quite likely to sleep... */
> +int dlm_lowcomms_start(void)
> +{
> +	int error = 0;
> +
> +	error = -ENOTCONN;
> +
> +	/*
> +	 * Temporarily initialise the waitq head so that lowcomms_send_message
> +	 * doesn't crash if it gets called before the thread is fully
> +	 * initialised
> +	 */
> +	init_waitqueue_head(&lowcomms_send_waitq);
> +
> +	error = -ENOMEM;
> +	connections = kmalloc(sizeof(struct connection *) *
> +			      NODE_INCREMENT, GFP_KERNEL);
> +	if (!connections)
> +		goto out;
> +
> +	memset(connections, 0,
> +	       sizeof(struct connection *) * NODE_INCREMENT);

more kzalloc()

> +	conn_array_size = NODE_INCREMENT;
> +
> +	if (dlm_our_addr(&dlm_local_addr, 0)) {
> +		log_print("no local IP address has been set");
> +		goto fail_free_conn;
> +	}
> +	if (!dlm_our_addr(&dlm_local_addr, 1)) {
> +		log_print("This dlm comms module does not support multi-homed clustering");
> +		goto fail_free_conn;
> +	}
> +
> +	con_cache = kmem_cache_create("dlm_conn", sizeof(struct connection),
> +				      __alignof__(struct connection), 0, NULL, NULL);
> +	if (!con_cache)
> +		goto fail_free_conn;
> +
> +
> +	/* Start listening */
> +	error = listen_for_all();
> +	if (error)
> +		goto fail_unlisten;
> +
> +	error = daemons_start();
> +	if (error)
> +		goto fail_unlisten;
> +
> +	atomic_set(&accepting, 1);
> +
> +	return 0;
> +
> +      fail_unlisten:
> +	close_connection(connections[0], 0);
> +	kmem_cache_free(con_cache, connections[0]);
> +	kmem_cache_destroy(con_cache);
> +
> +      fail_free_conn:
> +	kfree(connections);
> +
> +      out:
> +	return error;
> +}
> +

