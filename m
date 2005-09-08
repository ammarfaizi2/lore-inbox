Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVIHUON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVIHUON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVIHUON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:14:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56963
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964975AbVIHUON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:14:13 -0400
Date: Thu, 08 Sep 2005 13:13:58 -0700 (PDT)
Message-Id: <20050908.131358.93602687.davem@davemloft.net>
To: torvalds@osdl.org
Cc: alan@lxorguk.ukuu.org.uk, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0509080922230.3208@g5.osdl.org>
References: <20050908165256.D5661@flint.arm.linux.org.uk>
	<1126197523.19834.49.camel@localhost.localdomain>
	<Pine.LNX.4.58.0509080922230.3208@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 8 Sep 2005 09:27:56 -0700 (PDT)

> Mistakes happen, and the way you fix them is not to pull a tantrum, but 
> tell people that they are idiots and they broke something, and get them to 
> fix it instead.

In all this noise I still haven't seen what is wrong with
the build warning fix I made.

Even as networking maintainer, other people put changes into the
networking as build or warning fixes, and I have to live with that.
If I don't like what happened, I call it out and send in a more
appropriate fix.  This is never something worth peeing my pants in
public about.

Anyways, let's discuss the concrete problem here.

The previous definition of uart_handle_sysrq_char(), when
SUPPORT_SYSRQ was disabled, was a plain macro define to "(0)" but this
makes gcc emit empty statement warnings (and rightly so) in cases such
as:

		if (tty == NULL) {
			uart_handle_sysrq_char(&up->port, ch, regs);
			continue;
		}

(that example is from drivers/sun/sunsab.c)

So I changed it so that it was an inline function, borrowing the
existing code, so that we get the warning erased _and_ we get type
checking even when SUPPORT_SYSRQ is disabled.  So we end up with:

static inline int
uart_handle_sysrq_char(struct uart_port *port, unsigned int ch,
		       struct pt_regs *regs)
{
#ifdef SUPPORT_SYSRQ
	if (port->sysrq) {
		if (ch && time_before(jiffies, port->sysrq)) {
			handle_sysrq(ch, regs, NULL);
			port->sysrq = 0;
			return 1;
		}
		port->sysrq = 0;
	}
#endif
	return 0;
}

which is what is there now.  I can't see what's so wrong with that.
