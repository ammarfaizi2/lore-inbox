Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTJEWzc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTJEWzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:55:32 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:47037
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263876AbTJEWza
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:55:30 -0400
Date: Mon, 6 Oct 2003 00:51:28 +0200 (CEST)
From: Patrick McHardy <kaber@trash.net>
X-X-Sender: kaber@gw.localnet
To: Mikko Korhonen <mjkorhon@aeropc5.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: irda weirdness
In-Reply-To: <3F8008E1.1080200@aeropc5.hut.fi>
Message-ID: <Pine.LNX.4.58.0310060046410.30384@gw.localnet>
References: <3F8008E1.1080200@aeropc5.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure about this but I think the problem might lie in ircomm_tty_write:

        spin_lock_irqsave(&self->spinlock, flags);
...
                /* Copy data */
                if (from_user)
                        copy_from_user(skb_put(skb,size), buf+len, size);
                else
                        memcpy(skb_put(skb,size), buf+len, size);
...
        spin_unlock_irqrestore(&self->spinlock, flags);

asm/uaccess.h:498 is might_sleep() in copy_from_user() in my tree so this
might be it. No fix though, I just noticed this bug some time ago and
completly forgot about it until now.

Regards,
Patrick

On Sun, 5 Oct 2003, Mikko Korhonen wrote:

>     Hi,
>
> I'm getting
> Debug: sleeping function called from invalid context at
> include/asm/uaccess.h:498
> and
> Badness in local_bh_enable at kernel/softirq.c:119
>  (look below) with plain 2.6.0-test6 and sir_dev ircomm_tty (as well as
> with other 2.6.0-tests).
>
> Mikko
>
>
