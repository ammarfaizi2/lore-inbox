Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVCIGRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVCIGRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVCIGRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:17:37 -0500
Received: from waste.org ([216.27.176.166]:60089 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261869AbVCIGPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:15:14 -0500
Date: Tue, 8 Mar 2005 22:15:06 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alex Aizman <itn780@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 1/6] Open-iSCSI High-Performance Initiator for Linux
Message-ID: <20050309061505.GU3163@waste.org>
References: <422BFD13.1060908@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BFD13.1060908@yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 11:04:51PM -0800, Alex Aizman wrote:
>          SCSI LLDD consists of 3 files:
>         - iscsi_if.c (iSCSI open interface over netlink);
>         - iscsi_tcp.[ch] (iSCSI transport over TCP/IP).
> 
>         Signed-off-by: Alex Aizman <itn780@yahoo.com>
>         Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>

Some minor comments..

> +int
> +iscsi_control_recv_pdu(iscsi_cnx_h cp_cnx, struct iscsi_hdr *hdr,
> +				char *data, uint32_t data_size)

Return value on the same line as the function name, please.

> +{
> +	struct nlmsghdr	*nlh;
> +	struct sk_buff	*skb;

Tabs except at the beginning of the line are a nuisance. 

> +	if (!skb) {
> +		return -ENOMEM;
> +	}

Drop the braces around single statements.

> +EXPORT_SYMBOL_GPL(iscsi_control_recv_pdu);

Is this more than one module?

> +iscsi_control_cnx_error(iscsi_cnx_h cp_cnx, iscsi_err_e error)

Your type-naming scheme is a little unusual for the kernel. err_e
appears redundant. And _h for handle could simply be _t for (opaque)
type.

> +static void
> +iscsi_if_rx(struct sock *sk, int len)
> +{
> +	struct sk_buff *skb;
> +	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {

Assignments in tests are somewhat discouraged and !f is preferred to f
!= NULL.

> +#ifndef DEBUG_ASSERT
> +#ifdef BUG_ON
> +#undef BUG_ON
> +#endif
> +#define BUG_ON(expr)
> +#endif

Don't do that, please. An assertion that's not enabled is worse than
no assertion at all.

> +static inline void
> +iscsi_buf_init_hdr(struct iscsi_conn *conn, struct iscsi_buf *ibuf,
> +		   char *vbuf, u8 *crc)
> +{
> +	iscsi_buf_init_virt(ibuf, vbuf, sizeof(struct iscsi_hdr));
> +	if (conn->hdrdgst_en) {
> +		crypto_digest_init(conn->tx_tfm);
> +		crypto_digest_update(conn->tx_tfm, &ibuf->sg, 1);
> +		crypto_digest_final(conn->tx_tfm, crc);

I believe you'll find that crypto_digest_digest does that all for you.

> +#define iscsi_conn_get(rdd) (struct iscsi_conn*)(rdd)->arg.data
> +#define iscsi_conn_set(rdd, conn) (rdd)->arg.data = conn

Inlines, please. The second one is slightly broken without parens.

> +		 * PDU header scattered accross SKB's,

"across"

> +		switch(conn->in.opcode) {
> +		case ISCSI_OP_SCSI_CMD_RSP:

This switch looks like it could happily be in another function. The
indentation is making it cramped.

> +/*
> + * iscsi_ctask_copy - copy skb bits to the destanation cmd task
> + *
> + * The function calls skb_copy_bits() and updates per-connection and
> + * per-cmd byte counters.
> + */
> +static inline int
> +iscsi_ctask_copy(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
> +		void *buf, int buf_size)
> +{

Almost kerneldoc style, but not quite.

> +	    BUG_ON(ctask != (void*)sc->SCp.ptr);

Strange cast here.

> +	    if (sc->use_sg) {
> +		int i;

Mixed tabs and spaces.

> +	default:
> +		BUG_ON(1);

BUG()?

> +static void
> +iscsi_tcp_data_ready(struct sock *sk, int flag)
> +{
> +	struct iscsi_conn *conn = (struct iscsi_conn*)sk->sk_user_data;

Redundant cast here.

> +static void
> +iscsi_write_space(struct sock *sk)
> +{
> +	struct iscsi_conn *conn = (struct iscsi_conn*)sk->sk_user_data;
> +	conn->old_write_space(sk);
> +	debug_tcp("iscsi_write_space: cid %d\n", conn->id);
> +	conn->suspend = 0; wmb();

Sneaky. Separate line, please, and maybe a comment as to why the
barrier is needed.

> +	debug_tcp("sendhdr %lx %d bytes at offset %d sent %d res %d\n",
> +		(long)page_address(buf->sg.page), size, offset, buf->sent, res);

%p for page_address?

> +static inline int
> +iscsi_sendpage(struct iscsi_conn *conn, struct iscsi_buf *buf,
> +	       int *count, int *sent)
> +{
> +	ssize_t (*sendpage)(struct socket *, struct page *, int, size_t, int);
[...]
> +	sendpage = sk->ops->sendpage ? : sock_no_sendpage;
> +
> +	res = sendpage(sk, buf->sg.page, offset, size, flags);

Can't we just do an if (a) a() else b() here? The ? <empty> : syntax
is nonstandard.

> +iscsi_solicit_data_cont(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask,
> +			struct iscsi_r2t_info *r2t, int left)
> +{
> +	struct iscsi_data *hdr;
> +	struct iscsi_data_task *dtask;
> +	struct scsi_cmnd *sc = ctask->sc;
> +	int new_offset;
> +
> +	dtask = mempool_alloc(ctask->datapool, GFP_ATOMIC);
> +	hdr = &dtask->hdr;
> +	hdr->flags = 0;
> +	hdr->rsvd2[0] = hdr->rsvd2[1] = hdr->rsvd3 =
> +		hdr->rsvd4 = hdr->rsvd5 = hdr->rsvd6 = 0;

That looks odd, memset?

> +static void
> +iscsi_unsolicit_data_init(struct iscsi_conn *conn, struct iscsi_cmd_task *ctask)
> +{
> +	struct iscsi_data *hdr;
> +	struct iscsi_data_task *dtask;
> +
> +	dtask = mempool_alloc(ctask->datapool, GFP_ATOMIC);
> +	hdr = &dtask->hdr;
> +	hdr->rsvd2[0] = hdr->rsvd2[1] = hdr->rsvd3 =
> +		hdr->rsvd4 = hdr->rsvd5 = hdr->rsvd6 = 0;

And that looks familiar..

...

Boy howdy, this patch goes on for ever. Giving up at 9%.

-- 
Mathematics is the supreme nostalgia of our time.
