Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVENKyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVENKyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVENKyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:54:39 -0400
Received: from mail.aei.ca ([206.123.6.14]:22252 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262716AbVENKyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 06:54:15 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Date: Sat, 14 May 2005 06:53:57 -0400
User-Agent: KMail/1.7.2
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <20050514000723.73bd6e5a.akpm@osdl.org> <200505140631.59336.tomlins@cam.org>
In-Reply-To: <200505140631.59336.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505140653.57470.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The message from a+s+T on a serial console (x86_64) is:
BUG: soft lockup detected on cpu#0
Its not changed by this patch.  Probably would be a good idea to correct this?

Ed

On Saturday 14 May 2005 06:31, Ed Tomlinson wrote: 
> Suspect this can be triggered using alt+sysreq+T on a busy system with a slow 
> serial console.  Might be a easy way to see if this patch fixes the issue?
> 
> Ed Tomlinson
> 
> On Saturday 14 May 2005 03:07, Andrew Morton wrote:
> > Dave Jones <davej@redhat.com> wrote:
> > >
> > > On Fri, May 13, 2005 at 11:43:31PM -0700, Andrew Morton wrote:
> > >  > Dave Jones <davej@redhat.com> wrote:
> > >  > >
> > >  > > This was fun. I inserted a music CD with some obnoxious copy-protection
> > >  > >  on it into the drive, and lots of SCSI errors went zipping over to
> > >  > >  the serial console. Unfortunatly, the box was also compiling a kernel,
> > >  > >  playing oggs, and doing a number of other things at the same time,
> > >  > >  so this happened..
> > >  > > 
> > >  > >  NMI Watchdog detected LOCKUP on CPU2CPU 2
> > >  > 
> > >  > OK..  But calling touch_nmi_watchdog() at 1MHz seems a bit excessive, and
> > >  > might perturb the finely-tuned timing in there.
> > >  > 
> > >  > How's about this?
> > > 
> > > Umm..  Despite it being past my bedtime, I'm pretty sure I'm
> > > missing something here...
> > > 
> > >  > +		while (!(serial_in(up, UART_MSR) & UART_MSR_CTS) && --tmout)
> > >  >  			udelay(1);
> > > 
> > > I don't see how this is any better than the current code.
> > > We're doing 1000000 udelays. Whilst we're doing that,
> > > the nmi watchdog goes bonkers.
> > >  
> > >  > +		if (tmout < 1000000)
> > >  > +			touch_nmi_watchdog();
> > > 
> > > So by the time we do this, its already triggered.
> > 
> > But the NMI watchdog won't expire after one second - normally it's set to
> > fixe seconds.
> > 
> > > How about..
> > > 
> > > --- linux-2.6.11/drivers/serial/8250.c~	2005-05-14 02:49:02.000000000 -0400
> > > +++ linux-2.6.11/drivers/serial/8250.c	2005-05-14 02:54:30.000000000 -0400
> > > @@ -40,6 +40,7 @@
> > >  #include <linux/serial_core.h>
> > >  #include <linux/serial.h>
> > >  #include <linux/serial_8250.h>
> > > +#include <linux/nmi.h>
> > >  
> > >  #include <asm/io.h>
> > >  #include <asm/irq.h>
> > > @@ -2099,8 +2100,15 @@ static inline void wait_for_xmitr(struct
> > >  	if (up->port.flags & UPF_CONS_FLOW) {
> > >  		tmout = 1000000;
> > >  		while (--tmout &&
> > > -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> > > +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
> > > +			int cnt=0;
> > >  			udelay(1);
> > > +			cnt++;
> > > +			if (cnt==100) {
> > > +				touch_nmi_watchdog();
> > > +				cnt=0;
> > > +			}
> > > +		}
> > 
> > <obwhitespacewhine> spose so.
> > 
> > --- 25/drivers/serial/8250.c~tickle-nmi-watchdog-whilst-doing-serial-writes	2005-05-14 00:03:09.000000000 -0700
> > +++ 25-akpm/drivers/serial/8250.c	2005-05-14 00:06:53.000000000 -0700
> > @@ -40,6 +40,7 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/serial.h>
> >  #include <linux/serial_8250.h>
> > +#include <linux/nmi.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/irq.h>
> > @@ -2098,9 +2099,11 @@ static inline void wait_for_xmitr(struct
> >  	/* Wait up to 1s for flow control if necessary */
> >  	if (up->port.flags & UPF_CONS_FLOW) {
> >  		tmout = 1000000;
> > -		while (--tmout &&
> > -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> > +		while (!(serial_in(up, UART_MSR) & UART_MSR_CTS) && --tmout) {
> >  			udelay(1);
> > +			if ((tmout % 1000) == 0)
> > +				touch_nmi_watchdog();
> > +		}
> >  	}
> >  }
> >  
> > _
> > 
> > -
> 
