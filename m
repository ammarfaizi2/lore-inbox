Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUAIVFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUAIVFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:05:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:61126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264398AbUAIVFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:05:06 -0500
Date: Fri, 9 Jan 2004 13:06:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 2/7 Add netif controls
Message-Id: <20040109130613.711b34a6.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0401091009440.21309@thoron.boston.redhat.com>
	<Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> +static void sel_netif_destroy(struct sel_netif *netif)
> +{
> +	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
> +	
> +	spin_lock_bh(&sel_netif_lock);
> +	list_del_rcu(&netif->list);
> +	sel_netif_total--;
> +	spin_unlock_bh(&sel_netif_lock);
> +
> +	call_rcu(&netif->rcu_head, sel_netif_free, netif);
> +}
> +
> +void sel_netif_put(struct sel_netif *netif)
> +{
> +	if (atomic_dec_and_test(&netif->users))
> +		sel_netif_destroy(netif);
> +}

This seems racy.  If the netif is still eligible for lookup on entry to
sel_netif_put(), another CPU can come in and find the netif while it is
hashed but while it has a zero refcount.  Only to have the netif destroyed
under its feet?

If so, you need to invent atomic_dec_and_lock_bh().
