Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWEBPNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWEBPNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWEBPNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:13:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30995 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964873AbWEBPNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:13:09 -0400
Date: Tue, 2 May 2006 16:13:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH (RFC): Rework the 8250 console fix
Message-ID: <20060502151303.GB1736@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1146578983.3519.49.camel@localhost.localdomain> <1146578702.17934.3.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146578702.17934.3.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 03:05:02PM +0100, David Woodhouse wrote:
> On Tue, 2006-05-02 at 15:09 +0100, Alan Cox wrote:
> > There are two questions that I think make this an RFC not a final
> > patch
> > 
> > 1.      Should this be pushed up into serial/serial_core.c for all chips. 
> 
> Yes, I think it probably should. It's icky enough that we want one copy
> of it only.

That'd mean we have to add extra methods:

void uart_console_write(struct uart_port *port, const char *s,
                        unsigned int count,
                        void (*putchar)(struct uart_port *, int),
			void *(*pre_write)(struct uart_port *),
			void (*post_write)(struct uart_port *, void *));

where the pre-write places data into some kind of driver specific
structure which is allocated by some weird method, and post_write
restores this information.

Why are these driver specific?  Review all the users of uart_console_write
and you'll find that there's many different requirements for what is
done both before and after the uart_console_write method, most of
which should arguably fall under such a lock.

And I think that calling kmalloc() from within an oops (to allocate the
memory to pass the current state between pre and post write methods)
would be very bad news.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
