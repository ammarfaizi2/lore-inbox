Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTJFGlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTJFGlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 02:41:19 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:61962 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263009AbTJFGlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 02:41:17 -0400
Date: Mon, 6 Oct 2003 08:16:40 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Patrick McHardy <kaber@trash.net>
cc: Jean Tourrilhes <jt@hpl.hp.com>, Mikko Korhonen <mjkorhon@aeropc5.hut.fi>,
       <linux-kernel@vger.kernel.org>
Subject: Re: irda weirdness
In-Reply-To: <Pine.LNX.4.58.0310060046410.30384@gw.localnet>
Message-ID: <Pine.LNX.4.44.0310060124590.1388-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Patrick McHardy wrote:

> Not sure about this but I think the problem might lie in ircomm_tty_write:
> 
>         spin_lock_irqsave(&self->spinlock, flags);
> ...
>                 /* Copy data */
>                 if (from_user)
>                         copy_from_user(skb_put(skb,size), buf+len, size);
>                 else
>                         memcpy(skb_put(skb,size), buf+len, size);
> ...
>         spin_unlock_irqrestore(&self->spinlock, flags);
> 
> asm/uaccess.h:498 is might_sleep() in copy_from_user() in my tree so this
> might be it. No fix though, I just noticed this bug some time ago and
> completly forgot about it until now.

Good catch, that's definitedly a bug and probably at least one trigger in 
Mikko's case.

Jean, I'm not familiar with ircomm so I'm not sure how to fix this. Do you 
know what the spinlock is expected to protect here? If it's only to avoid 
self->tx_skb getting changed below us I think it might be sufficient to 
drop the spinlock during copy_from_user?

Martin

