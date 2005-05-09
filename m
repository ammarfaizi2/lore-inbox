Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVEIVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVEIVKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVEIVKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:10:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:4038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261521AbVEIVI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:08:59 -0400
Date: Mon, 9 May 2005 14:08:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: guillaume.thouvenin@bull.net, alexn@dsv.su.se,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, aquynh@gmail.com,
       elsa-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
Message-Id: <20050509140836.066008e0.akpm@osdl.org>
In-Reply-To: <20050509154809.19076fe0@zanzibar.2ka.mipt.ru>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	<1115631107.936.25.camel@localhost.localdomain>
	<1115638724.8540.59.camel@frecb000711.frec.bull.fr>
	<20050509154809.19076fe0@zanzibar.2ka.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > In the previous connector, cn_netlink_send(struct cn_msg *msg, u32
> > __groups) called alloc_skb(size, GFP_ATOMIC). Now a third parameter is
> > used with cn_netlink_send() in order to call alloc_skb(size, gfp_mask)
> > with a specific gfp_mask. So, I'm using GFP_ATOMIC as the third argument
> > to keep the same behavior.
> 
> It was atomic there to allow non process context usage.
> Since do_fork() is executed in process context you can use GFP_KERNEL with 
> __GFP_NOFAIL  - it will guarantee memory allocation.

Please avoid using __GFP_NOFAIL.

__GFP_NOFAIL was introduced because we had lots of places in the kernel
which were doing:

try_again:
	p = allocate_something();
	if (!p) {
		/* A am too lame to handle this */
		delay_in_some_manner();
		goto try_again;
	}

__GFP_NOFAIL simply takes the above bad code and centralises it so it's
always done in the same way and so that it's easily greppable for.  But
it's still bad (ie: deadlocky) code.

Well-behaved code should notice the allocation failure and should back out
gracefully.

