Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVAGOw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVAGOw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVAGOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:52:27 -0500
Received: from alog0071.analogic.com ([208.224.220.86]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261447AbVAGOv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:51:29 -0500
Date: Fri, 7 Jan 2005 09:50:35 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Lukasz Kosewski <lkosewsk@nit.ca>
cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       vgoyal@in.ibm.com, Linux kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
In-Reply-To: <41DEA2E8.8030701@nit.ca>
Message-ID: <Pine.LNX.4.61.0501070945540.12958@chaos.analogic.com>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
 <1105013524.4468.3.camel@laptopd505.fenrus.org> <20050106195043.4b77c63e.akpm@osdl.org>
 <41DE15C7.6030102@nit.ca> <41DEA2E8.8030701@nit.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Lukasz Kosewski wrote:

> Lukasz Kosewski wrote:
>> Andrew Morton wrote:
>> 
>>>> looks like the following is happening:
>>>> the controller wants to send an irq (probably from previous life)
>>>> then suddenly the driver gets loaded
>>>> * which registers an irq handler
>>>> * which does pci_enable_device()
>>>> and .. the irq goes through. the irq handler just is not yet expecting 
>>>> this irq, so
>>>> returns "uh dunno not mine"
>>>> the kernel then decides to disable the irq on the apic level
>>>> and then the driver DOES need an irq during init
>>>> ... which never happens.
>>>> 
>>> 
>>> 
>>> yes, that's exactly what e100 was doing on my laptop last month.  Fixed
>>> that by arranging for the NIC to be reset before the call to
>>> pci_set_master().
>
> After reading this again when I /wasn't/ semi-comatose, I retract my 
> statement insofar as it wouldn't help you (but I think it's still rather 
> necessary) :)
>
> The system did exactly what I'm talking about (which it didn't do for me, 
> possibly because the board/processor didn't support APIC).  I guess my 
> question to you is:  do you have other devices sharing this interrupt?  In 
> other words, are you /sure/ that it's the adaptec controller which is setting 
> the interrupt line high?
>
> Luke Kosewski
> Human Cannonball
> Net Integration Technologies


Note that Linux-2.6.10 PCI code will report the __wrong__ IRQ
unless pci_enable_device() is executed first! Hopefully, there
may be an additional callable procedure in the future that
sets up the IRQ routing independent of actually enabling the
device. In the meantime, enable the device before you believe
dev->irq.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
