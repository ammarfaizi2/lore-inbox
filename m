Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275749AbRJBBE4>; Mon, 1 Oct 2001 21:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275750AbRJBBEr>; Mon, 1 Oct 2001 21:04:47 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17778 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275749AbRJBBEj>; Mon, 1 Oct 2001 21:04:39 -0400
Date: Mon, 1 Oct 2001 21:04:45 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        Robert Olsson <Robert.Olsson@data.slu.se>, Ingo Molnar <mingo@elte.hu>,
        netdev@oss.sgi.com
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011001210445.D15341@redhat.com>
In-Reply-To: <Pine.GSO.4.30.0110012018430.27922-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0110012018430.27922-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Mon, Oct 01, 2001 at 08:41:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 08:41:20PM -0400, jamal wrote:
> 
> >The new mechanizm:
> >
> >- the irq handling code has been extended to support 'soft mitigation',
> >  ie. to mitigate the rate of hardware interrupts, without support from
> >  the actual hardware. There is a reasonable default, but the value can
> >  also be decreased/increased on a per-irq basis via
> > /proc/irq/NR/max_rate.
> 
> I am sorry, but this is bogus. There is no _reasonable value_. Reasonable
> value is dependent on system load and has never been and never
> will be measured by interupt rates. Even in non-work conserving schemes

It is not dependant on system load, but rather on the performance of the 
CPU and the number of interrupt sources in the system.

> There is already a feedback system that is built into 2.4 that
> measures system load by the rate at which the system processes the backlog
> queue. Look at netif_rx return values. The only driver that utilizes this
> is currently the tulip. Look at the tulip code.
> This in conjuction with h/ware flow control should give you sustainable
> system.

Not quite.  You're still ignoring the effect of interrupts on the users' 
ability to execute instructions during their timeslice.

> [Granted that mitigation is a hardware specific solution; the scheme we
> presented at the kernel summit is the next level to this and will be
> non-dependednt on h/ware.]
> 
> >(note that in case of shared interrupts, another 'innocent' device might
> >stay disabled for some short amount of time as well - but this is not an
> >issue because this mitigation does not make that device inoperable, it
> >just delays its interrupt by up to 10 msecs. Plus, modern systems have
> >properly distributed interrupts.)
> 
> This is a _really bad_ idea. not just because you are punishing other
> devices.

I'm afraid I have to disagree with you on this statement.  What I will 
agree with is that 10msec is too much.

> Lets take network devices as examples: we dont want to disable interupts;
> we want to disable offending actions within the device. For example, it is
> ok to disable/mitigate receive interupts because they are overloading the
> system but not transmit completion because that will add to the overall
> latency.

Wrong.  Let me introduce you to my 486DX/33.  It has PCI.  I'm putting my 
gige card into the poor beast.  transmitting full out, it can receive a 
sufficiently high number of tx done interrupts that it has no CPU cycles left 
to run, say, gated in userspace.

Falling back to polled operation is a well known technique in realtime and 
reliable systems.  By limiting the interrupt rate to a known safe limit, 
the system will remain responsive to non-interrupt tasks even under heavy 
interrupt loads.  This is the point at which a thruput graph on a slow 
machine shows a complete breakdown in performance, which is always possible 
on a slow enough CPU with a high performance device that takes input from 
a remotely controlled user.  This is *required*, and is not optional, and 
there is no way that a system can avoid it without making every interrupt 
a task, but that's a mess nobody wants to see in Linux.

		-ben

