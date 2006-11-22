Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934424AbWKVLUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934424AbWKVLUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162057AbWKVLUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:20:36 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:36792 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S934421AbWKVLUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:20:35 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take25 6/6] kevent: Pipe notifications.
Date: Wed, 22 Nov 2006 12:20:50 +0100
User-Agent: KMail/1.9.5
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
References: <11641265981515@2ka.mipt.ru>
In-Reply-To: <11641265981515@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221220.50245.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 17:29, Evgeniy Polyakov wrote:
> Pipe notifications.

> +int kevent_pipe_enqueue(struct kevent *k)
> +{
> +	struct file *pipe;
> +	int err = -EBADF;
> +	struct inode *inode;
> +
> +	pipe = fget(k->event.id.raw[0]);
> +	if (!pipe)
> +		goto err_out_exit;
> +
> +	inode = igrab(pipe->f_dentry->d_inode);
> +	if (!inode)
> +		goto err_out_fput;
> +

Well...

How can you be sure 'pipe/inode' really refers to a pipe/fifo here ?

Hint : i_pipe <> NULL is not sufficient because i_pipe, i_bdev, i_cdev share 
the same location. (check pipe_info() in fs/splice.c)

So I guess you need :

err = -EINVAL;
if  (!S_ISFIFO(inode->i_mode))
	goto err_out_iput;



Eric
