Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAYXBC>; Thu, 25 Jan 2001 18:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131138AbRAYXAx>; Thu, 25 Jan 2001 18:00:53 -0500
Received: from expanse.dds.nl ([194.109.10.118]:16644 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129737AbRAYXAp>;
	Thu, 25 Jan 2001 18:00:45 -0500
Date: Fri, 26 Jan 2001 00:00:07 +0100
From: Ookhoi <ookhoi@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: pcmcia delay causes bootp not to work
Message-ID: <20010126000007.U21704@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
X-Uptime: 5:14pm  up 56 days,  6:26, 24 users,  load average: 0.00, 0.04, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few days ago I mailed that I can't get nfsroot to work because bootp
tries to do its job before the cardbus card gets initialized. I got a
message from somebody who said that the pcmcia devices are a bit delayed
at boottime, which is also mentioned in the source. Unfortunately I'm
too stupid to be able to change the source code, and get rid of the
delay. And unfortunately, the guy who mailed me didn't respond at my cry
for help, so now I try the list again. :-)

Btw, I use lilo to load the kernel, and also tried:
append="rootnfs=192.168.0.1:/usr/remote ip=192.168.0.4:192.168.0.1:192.168.0.1:255.255.255.0:vaio::"

Why doesn't the network card gets configured with ip-address
192.168.0.4 ? Can it also be due to the delay? It lookes like the light
on the nic lights up at the same time as the error message about nfs
server not found. I don't see any traffic at all at the lan.

(I'm now almost four weeks fighting my vaio to get linux on it. It is no
problem to boot from the usb floppy drive, but then nfsroot doesn't work
due to the pcmcia delay, and a root image on floppy doesn't work due to
some usb problems. The kernels seemes to find and accept the usb floppy
drive just fine, but then I can't make it to load the root image. It
seemes as if /dev/sda doesn't get 'connected' with the fdd. I appreciate
any help with this of course :-)

		Ookhoi


Subject: Re: bootp starts before network device?

> ookhoi@dds.nl said:
> > It says: IP-Config: No network devices available.
> > a few lines below that the nic (3com 575) is detected.  Of course it
> > fails to do the nfs mount. 
> 
> The kernel delays the initialisation of CardBus sockets to prevent it
> from dying in an IRQ storm as soon as it registers the interrupt. The
> CardBus sockets don't actually get initialised until later (from
> keventd).
> 
> Can you try changing the end of yenta_open() to call yenta_open_bh()
> directly instead of queueing via schedule_task().

Thank you for your response. Unfortunately I'm no C expert at all, and I
don't understand what to do with this piece of code:

drivers/pcmcia/yenta.c:854

        /* Get the PCMCIA kernel thread to complete the
           initialisation later. We can't do this here,
           because, er, because Linus says so :)
        */
        socket->tq_task.routine = yenta_open_bh;
        socket->tq_task.data = socket;

        MOD_INC_USE_COUNT;
        schedule_task(&socket->tq_task);

        return 0;

It makes perfect sense to what you said about the delay, and the delay
makes perfect sense in bootp's complaining. :-)  But now this is way
over my head.. :-(

Can you please help me with what to change? Thanks again!

		Ookhoi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
