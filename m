Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRB0BTX>; Mon, 26 Feb 2001 20:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRB0BTD>; Mon, 26 Feb 2001 20:19:03 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:49572 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129397AbRB0BS4>; Mon, 26 Feb 2001 20:18:56 -0500
Message-ID: <3A9B0075.A46E7755@uow.edu.au>
Date: Tue, 27 Feb 2001 01:18:45 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vibol Hou <vhou@khmer.cc>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHMEPAEPAA.vhou@khmer.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vibol Hou wrote:
> 
> > Are you still getting the "hordes" of Tx timeouts with the
> > 3c905B which you reported a week ago?
> 
> Yes, but they happen a few hours after the system starts up and continue
> until the server is restarted.  It seems like a separate issue.  I haven't
> tried taking down the interface and putting it back up since the interface
> never dies link others have reported with their NICs.  The NIC continues to
> work fine, though the logs get flooded with those messages.
> 
> > If so, do they only start coming out when the slowdown occurs?
> 
> That's a negative.
> 
> > You are probably a victim of the APIC bug.  A
> > workaround for this is present in 2.4.2-ac5.  Alternatively,
> > boot the kernel with the `noapic' LILO option.
> 
> I'll compile 2.4.2-ac5 and we'll see in another 5 days if this happens
> again.  Till then, any suggestions on what to look for/at and/or what to do
> when it happens will help.

OK.  The 'Interrupt posted but not delivered' message
means that the Ethernet controller thinks that it is driving
the physical interrupt line, but the CPUs aren't being interrupted.

Check /proc/interrupts, see if the NIC's IRQ is shared with
something else.   If it isn't, or if it is shared with
something reputable then, given that the machine works OK
with 2.2 kernels then it's probably the APIC.

But it's unusual that the system "continues to work fine".
Ususally, a busted APIC slows networking to a crawl.  We
generate an artificial interrupt once per 400 milliseconds
via the Tx timeout handler.  This can process 16 outgoing
packets and 32 incoming packets.  This `polled mode' is
present in many Linux network drivers - it's there so you
can still telnet into the machine and whack it when it's
being silly.

-
