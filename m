Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWHCJyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWHCJyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHCJyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:54:31 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:8082 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932362AbWHCJya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:54:30 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take3 3/4] kevent: Network AIO, socket notifications.
Date: Thu, 3 Aug 2006 11:54:26 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
References: <11545983601447@2ka.mipt.ru>
In-Reply-To: <11545983601447@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608031154.27152.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 11:46, Evgeniy Polyakov wrote:
> Network AIO, socket notifications.
>
> This patchset includes socket notifications and network asynchronous IO.
> Network AIO is based on kevent and works as usual kevent storage on top
> of inode.
>  						          (3 * TCP_RTO_MIN) / 4,
> diff --git a/kernel/kevent/kevent_naio.c b/kernel/kevent/kevent_naio.c
+
> +static int kevent_naio_enqueue(struct kevent *k)
> +{
> +	int err, i;
> +	struct page **page;
> +	void *addr;
> +	unsigned int size = k->event.id.raw[1];
> +	int num = size/PAGE_SIZE;
> +	struct file *file;
> +	struct sock *sk = NULL;
> +	int fput_needed;
> +
> +	file = fget_light(k->event.id.raw[0], &fput_needed);
> +	if (!file)
> +		return -ENODEV;
> +
> +	err = -EINVAL;
> +	if (!file->f_dentry || !file->f_dentry->d_inode)
> +		goto err_out_fput;

How can you be 100% sure this file is actually a socket here ?
(Another thread could close the fd and this fd can now point to another file)

You should do
if (file->f_op != &socket_file_ops)
	goto err_out_fput;
sk = file->private_data;  /* set in sock_map_fd */ 

> +
> +	sk = SOCKET_I(file->f_dentry->d_inode)->sk;
> +


Eric
