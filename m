Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269249AbTGOToI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269569AbTGOToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:44:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269249AbTGOToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:44:05 -0400
Date: Tue, 15 Jul 2003 12:51:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: jmorris@intercode.com.au, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk,
       rddunlap@osdl.org, kuznet@ms2.inr.ac.ru, jkenisto@us.ibm.com
Subject: Re: [PATCH] [1/2] kernel error reporting (revised)
Message-Id: <20030715125121.315920a2.akpm@osdl.org>
In-Reply-To: <3F143D0A.A052F0B6@us.ibm.com>
References: <Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au>
	<3F143D0A.A052F0B6@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston <jkenisto@us.ibm.com> wrote:
>
> +int kernel_error_event_iov(const struct iovec *iov, unsigned int nseg,
> +	u32 groups)
> +{
> ...
> +
> +	return netlink_broadcast(kerror_nl, skb, 0, ~0, GFP_ATOMIC);

This appears to be deadlocky when called from interrupt handlers.

netlink_broadcast() does read_lock(&nl_table_lock).  But nl_table_lock is
not an irq-safe lock.

Possibly netlink_broadcast() can be made callable from hardirq context, but
it looks to be non trivial.  The various error and delivery handlers need
to be reviewed, the kfree_skb() calls should be thought about, etc.

