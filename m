Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVBWJJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVBWJJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 04:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVBWJJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 04:09:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:14738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261432AbVBWJJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 04:09:03 -0500
Date: Wed, 23 Feb 2005 01:07:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       elsa-devel@lists.sourceforge.net, gh@us.ibm.com, efocht@hpce.nec.com
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Message-Id: <20050223010747.0a572422.akpm@osdl.org>
In-Reply-To: <1109148752.1738.105.camel@frecb000711.frec.bull.fr>
References: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
	<1109148752.1738.105.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> Hello,
> 
>   This patch replaces the relay_fork module and it implements a fork
> connector in the kernel/fork.c:do_fork() routine. The connector sends
> information about parent PID and child PID over a netlink interface. It
> allows to several user space applications to be informed when a fork
> occurs in the kernel. The main drawback is that even if nobody listens,
> message is send. I don't know how to avoid that.

We really should find a way to fix that.  Especially if we want all the
distributors to enable the connector in their builds (we do).

What happened to the idea of sending an on/off message down the netlink
socket?

> +#ifdef CONFIG_FORK_CONNECTOR
> +#define FORK_CN_INFO_SIZE	64 
> +static inline void fork_connector(pid_t parent, pid_t child)
> +{
> +	struct cb_id fork_id = {CN_IDX_FORK, CN_VAL_FORK};

This can be static const, which will save some stack and cycles.

> +	static __u32 seq; /* used to test if we lost message */
> +	
> +	if (cn_already_initialized) {
> +		struct cn_msg *msg;
> +		size_t size;
> +
> +		size = sizeof(*msg) + FORK_CN_INFO_SIZE;
> +		msg = kmalloc(size, GFP_KERNEL);
> +		if (msg) {
> +			memset(msg, '\0', size);

Do we really need to memset the whole thing?

> +			memcpy(&msg->id, &fork_id, sizeof(msg->id));
> +			msg->seq = seq++;

`seq' needs a lock to protect it.  Or use atomic_add_return(), maybe.

> +			msg->ack = 0; /* not used */
> +			/* 
> +			 * size of data is the number of characters 
> +			 * printed plus one for the trailing '\0'
> +			 */
> +			msg->len = snprintf(msg->data, FORK_CN_INFO_SIZE-1, 
> +					    "%i %i", parent, child) + 1;

scnprintf() would be more appropriate here, even though it should be a "can't
happen".

> +			cn_netlink_send(msg, CN_IDX_FORK);
> +
> +			kfree(msg);

`msg' is only 84 bytes and do_fork() has a shallow call graph.  Make `msg'
a local?  

