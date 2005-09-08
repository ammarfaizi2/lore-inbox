Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVIHUWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVIHUWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVIHUWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:22:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964981AbVIHUWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:22:41 -0400
Date: Thu, 8 Sep 2005 21:22:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
Message-ID: <20050908212236.A19542@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
References: <20050908165256.D5661@flint.arm.linux.org.uk> <1126197523.19834.49.camel@localhost.localdomain> <Pine.LNX.4.58.0509080922230.3208@g5.osdl.org> <20050908.131358.93602687.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050908.131358.93602687.davem@davemloft.net>; from davem@davemloft.net on Thu, Sep 08, 2005 at 01:13:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 01:13:58PM -0700, David S. Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Thu, 8 Sep 2005 09:27:56 -0700 (PDT)
> 
> > Mistakes happen, and the way you fix them is not to pull a tantrum, but 
> > tell people that they are idiots and they broke something, and get them to 
> > fix it instead.
> 
> In all this noise I still haven't seen what is wrong with
> the build warning fix I made.
> 
> Even as networking maintainer, other people put changes into the
> networking as build or warning fixes, and I have to live with that.
> If I don't like what happened, I call it out and send in a more
> appropriate fix.  This is never something worth peeing my pants in
> public about.
> 
> Anyways, let's discuss the concrete problem here.
> 
> The previous definition of uart_handle_sysrq_char(), when
> SUPPORT_SYSRQ was disabled, was a plain macro define to "(0)" but this
> makes gcc emit empty statement warnings (and rightly so) in cases such
> as:
> 
> 		if (tty == NULL) {
> 			uart_handle_sysrq_char(&up->port, ch, regs);
> 			continue;
> 		}

Actually, it turns out this is a valid warning but not in the way
you're thinking.

In order to handle a sysrq char, you first need to see a break
condition.  You detect break conditions further down in this
function after the above check.

Hence, if tty is NULL, you don't check for any break conditions.
This means that you're never set up to handle a sysrq character,
which in turn means that the above code has no effect and can
actually be removed... which also removes the warning.

> (that example is from drivers/sun/sunsab.c)
> 
> So I changed it so that it was an inline function, borrowing the
> existing code, so that we get the warning erased _and_ we get type
> checking even when SUPPORT_SYSRQ is disabled.  So we end up with:
> 
> static inline int
> uart_handle_sysrq_char(struct uart_port *port, unsigned int ch,
> 		       struct pt_regs *regs)
> {
> #ifdef SUPPORT_SYSRQ
> 	if (port->sysrq) {
> 		if (ch && time_before(jiffies, port->sysrq)) {
> 			handle_sysrq(ch, regs, NULL);
> 			port->sysrq = 0;
> 			return 1;
> 		}
> 		port->sysrq = 0;
> 	}
> #endif
> 	return 0;
> }
> 
> which is what is there now.  I can't see what's so wrong with that.

the "regs" argument may not exist in the parent context in the
!SUPPORT_SYSRQ case.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
