Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVAZNrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVAZNrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 08:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVAZNru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 08:47:50 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:53537 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262299AbVAZNqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 08:46:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MGlfIqcnn2pLbE9s1nhoTY6eGCcmNW9vveTitx9mPfwKuyvomUoaU7kL9oK0PWCCa4AJD5b59xIPGswaymet/tNXeEoeqO66bfxWIMuAy+ZUg/ubtyRc3wDf/EsxoMyiG7dSYJxHck6CdZDhBzyifz8XpF8Ut4V5qIKlS4NP6S0=
Message-ID: <d120d5000501260546536647e7@mail.gmail.com>
Date: Wed, 26 Jan 2005 08:46:39 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <1106727902.5257.109.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <d120d5000501250811295c298e@mail.gmail.com>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
	 <1106727902.5257.109.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 11:25:02 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> On Tue, 2005-01-25 at 23:57 -0500, Dmitry Torokhov wrote:
> 
> > > > I have a slightly different concern - the superio is a completely new
> > > > subsystem and it should be integtrated with the driver model
> > > > ("superio" bus?). Right now it looks like it is reimplementing most of
> > > > the abstractions (device lists, driver lists, matching, probing).
> > > > Moving to driver model significatntly affects lifetime rules for the
> > > > objects, etc. etc. and will definitely not allow code such as above.
> > > >
> > > > It would be nice it we get things right from the start.
> > >
> > > bus model is not good here - we need bus in each logical device and
> > > bus in each superio chip(or at least second case).
> > > Each bus bus have some crosslinking to devices in other buses,
> > > and each new device
> > > must be checked in each bus and probably added to each device...
> > >
> > > It is not like I see it.
> > >
> > > Consider folowing example:
> > > each device from set A belongs to each device from set B.
> > > n <-> n, it is not the case when one bus can handle all features.
> > >
> > > That is why I did not use driver model there.
> > > It is specific design feature, which is proven to work.
> > >
> >
> > Ok, I briefly looked over the patches and that is what I understand
> > (please correct me where I am wrong):
> >
> > - you have superio chips which are containers providing set of interfaces;
> > - you have superio chip driver that detects superio chip and manages
> >   (enables/disables) individual interfaces.
> > - you have set of interface drivers (gpio, acb) that bind to individual
> >   superio interfaces and provide unified userspace interface that allows
> >   reading, writing and analog of ioctl.
> >
> > So the question is why you can't have superio bus where superio chips
> > register their individual interfaces as individual devices. gpio, acb, etc
> > are drivers that bind to superio devices and create class devices gpio.
> >
> > You could have:
> >
> > sys
> > |-bus
> > | |-superio
> > | | |-devices
> > | | | |-sio0 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio0
> > | | | |-sio1 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio1
> > | | | |-sio2 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.0/sio2
> > | | |-drivers
> > | | | |-gpio
> > | | | | |-sio1 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio1
> > | | | | |-sio2 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.0/sio2
> > | | | |-acb
> > | | | | |-sio0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio0
> > |
> > |-class
> > | |-gpio
> > | | |-gpio0
> > | | |-gpio1
> >
> > gpioX have control and data attributes that allow reading and writing...
> >
> > Am I missing something?
> 
> You try to create n <-> 1 relation, but superio by design supposed to be
> n <-> n.

What design? Hardware design or present implementation design?

> Above schema does not allow linking from each logical device to
> appropriate superio chips
> or vice versa - sc chips do not have link to it's logical devices.
>

sc chip does have a link to its logical devices - look at 0000:02:03.0
PCI device in the picture above - that your SuperIO chip with 2
interfaces. Interface, when bound to a superio driver creates gpio
class device which in turn has link to physical device (here one of
the SuperIO interfaces).


Yes, I am trying to do 1 - n relationship. I do not understand why
logical device has to span across several physical devices. With the
exception of device mapper/raid you don't have a logical device span
several physical devices, with everything else there is a parent that
has several children.

You have a PCI bus that has several PCI devices, one of them happens
to be a IDE host controller with 2 channels connected to it. The other
is your SuperIO chip with 2 GPIO pins and something else, and another
SuperIO chip with 3 GIPO pins. Let's say you 1st chip monitors
temperature in the case and the second interfaces wth some custom
equipment measuring some thersholds in some chemical process. Are you
saying that all 5 GPIO pins should be presented as one logical device
that provides 5 outputs not related to each other? No, you have 5
distinct devices with similar interfaces providing 5 distinct reads.
Userspace may chose to group them somehow, based on external
information that kernel does not have, but that's it. Kernel only
provides uniform interface.

-- 
Dmitry
