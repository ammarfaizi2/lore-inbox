Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVAZE5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVAZE5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 23:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVAZE5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 23:57:22 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:38535 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262254AbVAZE5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 23:57:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Date: Tue, 25 Jan 2005 23:57:08 -0500
User-Agent: KMail/1.7.2
Cc: dmitry.torokhov@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <d120d5000501250811295c298e@mail.gmail.com> <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252357.08946.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 16:14, Evgeniy Polyakov wrote:
> On Tue, 25 Jan 2005 11:11:42 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Tue, 25 Jan 2005 18:24:50 +0300, Evgeniy Polyakov
> > <johnpol@2ka.mipt.ru> wrote:
> > > On Tue, 2005-01-25 at 14:23 +0000, Christoph Hellwig wrote:
> > > > > > +static void pc8736x_fini(void)
> > > > > > +{
> > > > > > + sc_del_sc_dev(&pc8736x_dev);
> > > > > > +
> > > > > > + while (atomic_read(&pc8736x_dev.refcnt)) {
> > > > > > +         printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
> > > > > > +                         pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
> > > > > > +
> > > > > > +         set_current_state(TASK_INTERRUPTIBLE);
> > > > > > +         schedule_timeout(HZ);
> > > > > > +
> > > > > > +         if (current->flags & PF_FREEZE)
> > > > > > +                 refrigerator(PF_FREEZE);
> > > > > > +
> > > > > > +         if (signal_pending(current))
> > > > > > +                 flush_signals(current);
> > > > > > + }
> > > > > > +}
> > > > > >
> > > > > > And who gurantess this won't deadlock?  Please use a dynamically allocated
> > > > > > driver model device and it's refcounting, thanks.
> > > > >
> > > > > Sigh.
> > > > >
> > > > > Christoph, please read the code before doing such comments.
> > > > > I very respect your review and opinion, but only until you respect
> > > > > others.
> > > >
> > > > The code above pretty much means you can keep rmmod stalled forever.
> > > 
> > > Yes, and it is better than removing module whose structures are in use.
> > > SuperIO core is asynchronous in it's nature, one can use logical device
> > > through superio core and remove it's module on other CPU, above loop
> > > will wait untill all reference counters are dropped.
> > 
> > I have a slightly different concern - the superio is a completely new
> > subsystem and it should be integtrated with the driver model
> > ("superio" bus?). Right now it looks like it is reimplementing most of
> > the abstractions (device lists, driver lists, matching, probing).
> > Moving to driver model significatntly affects lifetime rules for the
> > objects, etc. etc. and will definitely not allow code such as above.
> > 
> > It would be nice it we get things right from the start.
> 
> bus model is not good here - we need bus in each logical device and
> bus in each superio chip(or at least second case).
> Each bus bus have some crosslinking to devices in other buses, 
> and each new device
> must be checked in each bus and probably added to each device...
> 
> It is not like I see it.
> 
> Consider folowing example: 
> each device from set A belongs to each device from set B.
> n <-> n, it is not the case when one bus can handle all features.
> 
> That is why I did not use driver model there.
> It is specific design feature, which is proven to work.
>

Ok, I briefly looked over the patches and that is what I understand
(please correct me where I am wrong):

- you have superio chips which are containers providing set of interfaces;
- you have superio chip driver that detects superio chip and manages
  (enables/disables) individual interfaces.
- you have set of interface drivers (gpio, acb) that bind to individual
  superio interfaces and provide unified userspace interface that allows
  reading, writing and analog of ioctl.

So the question is why you can't have superio bus where superio chips
register their individual interfaces as individual devices. gpio, acb, etc
are drivers that bind to superio devices and create class devices gpio.

You could have:

sys
|-bus
| |-superio
| | |-devices
| | | |-sio0 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio0
| | | |-sio1 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio1
| | | |-sio2 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.0/sio2
| | |-drivers
| | | |-gpio
| | | | |-sio1 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio1
| | | | |-sio2 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.0/sio2
| | | |-acb
| | | | |-sio0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio0
|
|-class
| |-gpio
| | |-gpio0
| | |-gpio1

gpioX have control and data attributes that allow reading and writing...

Am I missing something?

-- 
Dmitry
