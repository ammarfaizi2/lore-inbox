Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbSKVJHC>; Fri, 22 Nov 2002 04:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbSKVJHB>; Fri, 22 Nov 2002 04:07:01 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:65298
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267018AbSKVJHA>; Fri, 22 Nov 2002 04:07:00 -0500
Subject: Re: calling schedule() from interupt context
From: Robert Love <rml@tech9.net>
To: dan carpenter <error27@email.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021122085441.2127.qmail@email.com>
References: <20021122085441.2127.qmail@email.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037956446.1254.3890.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 22 Nov 2002 04:14:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 03:54, dan carpenter wrote:

(Next time trim your CC list: none of those poor guys needed this
email..)

> In drivers/net/tokenring/3c359.c xl_interrupt() calls schedule().
> The path from xl_interupt to schedule is:
> xl_rx ==> netif_rx ==> 
> kfree_skb ==> __kfree_skb ==> 
> secpath_put ==> __secpath_destroy ==> 
> xfrm_state_put ==> __xfrm_state_destroy ==> xfrm_put_type ==> 
> module_put ==> put_cpu ==> preempt_schedule ==> schedule

Are you actually seeing this code path or is this just what your script
is showing you?

preempt_schedule() will not call schedule() if the preempt_count is
non-zero.  Inside an interrupt handler, it is always at least one.  So
nothing will drop it to zero, and we will never preempt.

> The third thing I was wondering is:  xl_interupt is holding a 
> spin_lock(&xl_priv->xl_lock).   I know that you're not supposed to call shedule()
> while holding a spin lock, but is it ok to call preempt_schedule()?

Same as above.  preempt_schedule() only calls schedule when
preempt_count is zero.  It is not if you hold a lock, and it is not
inside an interrupt handler.

	Robert Love

