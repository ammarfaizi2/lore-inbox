Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313151AbSC1Nc7>; Thu, 28 Mar 2002 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313156AbSC1Ncu>; Thu, 28 Mar 2002 08:32:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:37763 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313151AbSC1Nco>; Thu, 28 Mar 2002 08:32:44 -0500
Date: Thu, 28 Mar 2002 08:31:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Samium Gromoff <root@ibe.miee.ru>
cc: pwaechtler@loewe-komp.de, linux-kernel@vger.kernel.org
Subject: Re: Networking with slow CPUs
In-Reply-To: <200203281538.g2SFcUl06361@ibe.miee.ru>
Message-ID: <Pine.LNX.3.95.1020328082056.19734A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Samium Gromoff wrote:

> > > Is there a possibility to "harden" a small machine (33 MHz embedded
> > > device) against e.g. flood pings from the outside world?
> > >
> > 
> > AFAIK, there is a mechanism to switch off the interrupts generated
> > by the network card, if the load is getting too high. This way the
> > packets get overwritten on the nic buffers and do not even reach
> > the CPU.
> 	this is a whole new strategy: ie you switch from interrupt-driven handling
> to periodicall polls of the NIC.
> 	last time i`ve heard of it it was the bleeding edge Jamal`s model
> of the lowlevel network engine.
> 
> regards, Samium Gromoff

You can also get rid of any polling in the driver ISR. This is used
for "interrupt mitigation" and has the bad effects that you describe.

Instead of:
           while(some_bits_are_set)
                service_those_bits();
           return;

Modify to:
	if(some_bits_are_set)
              service_those_bits();
        return;

This will allow other stuff to happen before the ISR gets called
again. Yes, you lose packets when stormed, but so-what? For normal
communication, the NIC runs fine, maybe a few percent loss in
performance.

FYI, every driver that I have used that suffers 'lock-up' like
the eepro100, 3c59x, etc., can be permanently fixed by removing the
poll. Something to think about.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

