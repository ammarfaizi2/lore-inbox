Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUIIQ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUIIQ53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIIQmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:42:53 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:41349
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S265900AbUIIQil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:38:41 -0400
Date: Thu, 9 Sep 2004 09:38:18 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing the holes in the tty layer
Message-Id: <20040909093818.5a54094d.davem@davemloft.net>
In-Reply-To: <20040909162222.GA14563@devserv.devel.redhat.com>
References: <20040909162222.GA14563@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004 12:22:22 -0400
Alan Cox <alan@redhat.com> wrote:

> +void tty_ldisc_put(int disc)

That takes tty_ldisc_lock.

>  static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 ...
> +	spin_lock_irqsave(&tty_ldisc_lock, flags);
> +	if(tty->ldisc.refcount)
> +	{
> +		/* Free the new ldisc we grabbed */
> +		tty_ldisc_put(ldisc);
> +		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
> +		return -EBUSY;
> +	}

Therefore this call her deadlocks since we already hold
the lock.
