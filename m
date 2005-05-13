Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVEMTox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVEMTox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVEMTlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:41:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41994 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262474AbVEMThk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:37:40 -0400
Date: Fri, 13 May 2005 20:37:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050513203735.A28297@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Dave Jones <davej@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <1116011692.6694.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1116011692.6694.19.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Fri, May 13, 2005 at 09:14:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:14:52PM +0200, Arjan van de Ven wrote:
> On Fri, 2005-05-13 at 14:48 -0400, Dave Jones wrote:
> >  	if (up->port.flags & UPF_CONS_FLOW) {
> >  		tmout = 1000000;
> >  		while (--tmout &&
> > -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> > +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
> >  			udelay(1);
> > +			touch_nmi_watchdog();
> > +		}
> >  	}
> >  }
> >  
> > 
> > We *could* tickle it less often, but given we're busy waiting anyway
> > it probably doesnt make sense to not favour the more simple approach.
> > Hmm, maybe we want a cpu_relax() in there too. opinions?
> 
> udelay() includes cpu_relax() already so that is futile.
> 
> However.. this is a hack. Do we really need to do busy waiting here for
> this long??

Of course you do.  Think about CTS flow control where the other end
is also busy and has to drain its tty buffers before it can allow
the remote end to proceed.  (And who says its another Linux box
anyway?)

However, if people are using CTS flow control, they want reliable
logging.  Therefore, it's even questionable whether we should even
time out (but we do to keep the system "running".)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
