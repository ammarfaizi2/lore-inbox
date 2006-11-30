Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031263AbWK3TiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031263AbWK3TiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031264AbWK3TiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:38:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65215 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1031263AbWK3TiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:38:16 -0500
Date: Thu, 30 Nov 2006 20:38:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [DLM] Add support for tcp communications [38/70]
Message-ID: <20061130193806.GA3631@elf.ucw.cz>
References: <1164889148.3752.381.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164889148.3752.381.camel@quoit.chygwyn.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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
> Signed-off-by: Patrick Caulfield <pcaulfie@redhat.com>
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>

Some comments from coding-style-police...

> +struct cbuf {
> +	unsigned		base;
> +	unsigned		len;
> +	unsigned		mask;
> +};

I'd prefer unsigned int here.

> +struct connection {
> +	struct socket          *sock;
> +	unsigned long		flags;
> +	struct page            *rx_page;
> +	atomic_t		waiting_requests;
> +	struct cbuf		cb;
> +	int                     eagain_flag;
> +};

Quite unusual indentiation style w.r.t. pointers...

> +static struct nodeinfo *nodeid2nodeinfo(int nodeid, gfp_t alloc)
> +{
> +	struct nodeinfo *ni;
> +	int r;
> +	int n;
> +
> +	down_read(&nodeinfo_lock);
> +	ni = idr_find(&nodeinfo_idr, nodeid);
> +	up_read(&nodeinfo_lock);
> +
> +	if (!ni && alloc) {
> +		down_write(&nodeinfo_lock);
> +
> +		ni = idr_find(&nodeinfo_idr, nodeid);
> +		if (ni)
> +			goto out_up;
...
> +		if (nodeid > max_nodeid)
> +			max_nodeid = nodeid;
> +	out_up:
> +		up_write(&nodeinfo_lock);
> +	}
> +
> +	return ni;

Can we do if (ni || !alloc) return ni, and avoid gotos inside of
block?


> +/* Something happened to an association */
> +static void process_sctp_notification(struct msghdr *msg, char *buf)
> +{
> +	union sctp_notification *sn = (union sctp_notification *)buf;
> +
> +	if (sn->sn_header.sn_type == SCTP_ASSOC_CHANGE) {
> +		switch (sn->sn_assoc_change.sac_state) {
> +
> +		case SCTP_COMM_UP:
> +		case SCTP_RESTART:
> +		{
...
> +				/* Retry INIT later */
> +				ni = > assoc2nodeinfo(sn->sn_assoc_change.sac_assoc_id);

Too long lines, and rgetting rid of outer if should be really easy.

> +
> +/* Initiate an SCTP association. In theory we could just use sendmsg() on
> +   the first IP address and it should work, but this allows us to set up the
> +   association before sending any valuable data that we can't afford to lose.
> +   It also keeps the send path clean as it can now always use the association ID */

Too long lines.

> +static void lowcomms_state_change(struct sock *sk)
> +{
> +/*	struct connection *con = sock2con(sk); */

Can we get commented code removed?

> +
> +	switch (sk->sk_state) {
> +	case TCP_ESTABLISHED:
> +		lowcomms_write_space(sk);
> +		break;
> +
> +	case TCP_FIN_WAIT1:
> +	case TCP_FIN_WAIT2:
> +	case TCP_TIME_WAIT:
> +	case TCP_CLOSE:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_LAST_ACK:
> +	case TCP_CLOSING:
> +		/* FIXME: I think this causes more trouble than it solves.
> +		   lowcomms wil reconnect anyway when there is something to
> +		   send. This just attempts reconnection if a node goes down!
> +		*/
> +		/* lowcomms_connect_sock(con); */

Here too? Is the fixme still applicable?

> +{
> +        saddr->ss_family =  dlm_local_addr.ss_family;
> +        if (saddr->ss_family == AF_INET) {
> +		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
> +		in4_addr->sin_port = cpu_to_be16(port);
> +		*addr_len = sizeof(struct sockaddr_in);
> +	}
> +	else {

} else { on one line, please.

...
> +	if (ret < 0)
> +		goto out_close;
> +	CBUF_EAT(&con->cb, ret);
> +
> +	if (CBUF_EMPTY(&con->cb) && !call_again_soon) {
> +		__free_page(con->rx_page);
> +		con->rx_page = NULL;
> +	}
> +
> +      out:
> +	if (call_again_soon)
> +		goto out_resched;
> +	up_read(&con->sock_sem);
> +	ret = 0;
> +	goto out_ret;

Could we just return 0 here?

> +      out_resched:
> +	lowcomms_data_ready(con->sock->sk, 0);
> +	up_read(&con->sock_sem);
> +	ret = 0;
> +	schedule();
> +	goto out_ret;

And here?

> +      out_close:
> +	up_read(&con->sock_sem);
> +	if (ret != -EAGAIN && !test_bit(CF_IS_OTHERCON, &con->flags)) {
> +		close_connection(con, FALSE);
> +		/* Reconnect when there is something to send */
> +	}
> +
> +      out_ret:
> +	return ret;

> +static struct socket *create_listen_sock(struct connection *con, struct sockaddr_storage *saddr)
> +{
> +        struct socket *sock = NULL;
> +	mm_segment_t fs;
> +	int result = 0;
> +	int one = 1;
> +	int addr_len;

Tabs vs spaces?

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

I seriously think you are overdoing the gotos.


> +/* Called from recovery when it knows that a node has
> +   left the cluster */
> +int dlm_lowcomms_close(int nodeid)
> +{
> +	struct connection *con;
> +
> +	if (!connections)
> +		goto out;
> +
> +	log_print("closing connection to node %d", nodeid);
> +	con = nodeid2con(nodeid, 0);
> +	if (con) {
> +		clean_one_writequeue(con);
> +		close_connection(con, TRUE);
> +		atomic_set(&con->waiting_requests, 0);
> +	}
> +	return 0;
> +
> +      out:
> +	return -1;
> +}

Could we just return -1 directly? Should it follow 0/-errno convention
other functions here use? Can we get rid of TRUE/FALSE macros?

> +/*
> + * Return the largest buffer size we can cope with.
> + */
> +int lowcomms_max_buffer_size(void)
> +{
> +	return PAGE_CACHE_SIZE;
> +}

Uhuh.

> +/* This is quite likely to sleep... */
> +int dlm_lowcomms_start(void)
> +{
> +	int error = 0;
> +
> +	error = -ENOTCONN;

One statement?

> +	connections = kmalloc(sizeof(struct connection *) *
> +			      NODE_INCREMENT, GFP_KERNEL);
> +	if (!connections)
> +		goto out;
> +
> +	memset(connections, 0,
> +	       sizeof(struct connection *) * NODE_INCREMENT);

kzalloc?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
