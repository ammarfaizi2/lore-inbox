Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVEJLZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVEJLZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVEJLZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:25:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56468 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261613AbVEJLZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:25:01 -0400
Date: Tue, 10 May 2005 15:24:10 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: aq <aquynh@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, guillaume.thouvenin@bull.net,
       alexn@dsv.su.se, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
Message-ID: <20050510152410.46185b5e@zanzibar.2ka.mipt.ru>
In-Reply-To: <9cde8bff0505100413422104a6@mail.gmail.com>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	<1115631107.936.25.camel@localhost.localdomain>
	<1115638724.8540.59.camel@frecb000711.frec.bull.fr>
	<20050509154809.19076fe0@zanzibar.2ka.mipt.ru>
	<20050509140836.066008e0.akpm@osdl.org>
	<20050510014359.074109d8@zanzibar.2ka.mipt.ru>
	<9cde8bff0505100413422104a6@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 10 May 2005 15:24:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 20:13:43 +0900
aq <aquynh@gmail.com> wrote:

> > If system under so bad conditions that even process context allocation
> > fails, then connector may drop message and will return error,
> > probably in such conditions one may not even trust accounting data,
> > so, Guillaume, feel free to drop it and just do not send data -
> > it's only a matter of information importance.
> > 
> 
> what i find most troublesome of this solution is that information
> collected by ELSA is not reliable. The reason is that it uses netlink,
> which is connectionless. So under heavy pressure, we can lose some
> critical accounting data.
> 
> At least it would be nice if we can know when and why there are
> problems of losing data with netlink. Any solution?

1. Netlink message may be lost only under strong memory pressure, when
	allocation (in this case it is process allocation) fails.
	cn_netlink_send() returns error code for that.
2. Userspace application do not read it's queue for a long time,
	so it was overflowed. Do not blame netlink here.

All netlink messages being sent using connector have 
two special fields in it's header - seq and ack, 
which should be used by caller to provide information about
number of messages and their's order.
By properly using such fields [fork connector uses per-cpu 
variables with processor id in each message] userspace can
detect that messages were lost.

Other info can be found in connector's documentation
and all previous discussions.
 
> thank you,
> aq

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
