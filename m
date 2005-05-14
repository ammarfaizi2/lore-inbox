Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVENKxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVENKxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVENKxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:53:16 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:3977 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262715AbVENKxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 06:53:10 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: tickle nmi watchdog whilst doing serial writes.
From: Alexander Nyberg <alexn@dsv.su.se>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200505140631.59336.tomlins@cam.org>
References: <20050513184806.GA24166@redhat.com>
	 <20050514065753.GA28213@redhat.com> <20050514000723.73bd6e5a.akpm@osdl.org>
	 <200505140631.59336.tomlins@cam.org>
Content-Type: text/plain
Date: Sat, 14 May 2005 12:53:07 +0200
Message-Id: <1116067987.1183.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> Suspect this can be triggered using alt+sysreq+T on a busy system with a slow 
> serial console.  Might be a easy way to see if this patch fixes the issue?
> 

Sysrq-t already tickles the watchdog between the printing of each task
so you'll have to remove the nmi tickling in show_state() if you want to
use it as a test case.

But uhm, it should take at least 5 seconds of no-interrupts before the
NMI watchdog decides the box is dead so this is kind of weird.


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

