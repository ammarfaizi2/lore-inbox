Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVCNLLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVCNLLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVCNLLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:11:03 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:34215 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261449AbVCNLKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:10:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=p2rGNCBvptR/bx/JYr9EM3dWJQVI36W3jxOw8txSrdOJ3hL9DwQnzU7BtTiwwQdJLcO2chUCQWLTWOasP01UDSBQkctksGSIB/5OnIlXcugE9sfL+0GFIeOreW/vDGgjjXey6JrMNjVt4MAjgDfQi1HKqXapHNVdk7A0iRX2Zrc=
Message-ID: <84144f0205031403105351abf5@mail.gmail.com>
Date: Mon, 14 Mar 2005 13:10:46 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: A new 10GB Ethernet Driver by Chelsio Communications
Cc: Christoph Lameter <christoph@graphe.net>, linux-kernel@vger.kernel.org,
       mark@chelsio.com, netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>,
       penberg@cs.helsinki.fi
In-Reply-To: <20050311112132.6a3a3b49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net>
	 <20050311112132.6a3a3b49.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of my usual coding style comments...

On Fri, 11 Mar 2005 11:21:32 -0800, Andrew Morton <akpm@osdl.org> wrote:
> diff -puN /dev/null drivers/net/chelsio/osdep.h
> --- /dev/null	2003-09-15 06:40:47.000000000 -0700
> +++ 25-akpm/drivers/net/chelsio/osdep.h	2005-03-11 11:13:06.000000000 -0800
> +static inline void *t1_malloc(size_t len)
> +{
> +	void *m = kmalloc(len, GFP_KERNEL);
> +	if (m)
> +		memset(m, 0, len);
> +	return m;
> +}
> +
> +static inline void t1_free(void *v, size_t len)
> +{
> +	kfree(v);
> +}

Please do not introduce subsystem specific wrappers to kmalloc and kfree.

> +/*
> + * Allocates basic RX resources, consisting of memory mapped freelist Qs and a
> + * response Q.
> + */
> +static int alloc_rx_resources(struct sge *sge, struct sge_params *p)
> +{
> +	struct pci_dev *pdev = sge->adapter->pdev;
> +	unsigned int size, i;
> +
> +	for (i = 0; i < SGE_FREELQ_N; i++) {
> +		struct freelQ *Q = &sge->freelQ[i];
> +
> +		Q->genbit = 1;
> +		Q->entries_n = p->freelQ_size[i];
> +		Q->dma_offset = SGE_RX_OFFSET - sge->rx_pkt_pad;
> +		size = sizeof(struct freelQ_e) * Q->entries_n;
> +		Q->entries = (struct freelQ_e *)
> +			      pci_alloc_consistent(pdev, size, &Q->dma_addr);
> +		if (!Q->entries)
> +			goto err_no_mem;
> +		memset(Q->entries, 0, size);
> +		size = sizeof(struct freelQ_ce) * Q->entries_n;
> +		Q->centries = (struct freelQ_ce *) kmalloc(size, GFP_KERNEL);
> +		if (!Q->centries)
> +			goto err_no_mem;
> +		memset(Q->centries, 0, size);

Please drop the redundant casts and use kcalloc() here and in various
other places as
well.

Also, the patch has some whitespace damage (spaces instead of tabs).

				Pekka
