Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVAYUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVAYUzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVAYUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:55:22 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41705 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262118AbVAYUwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:52:07 -0500
Date: Wed, 26 Jan 2005 00:14:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d5000501250811295c298e@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050125125323.GA19055@infradead.org>
	<1106662284.5257.53.camel@uganda>
	<20050125142356.GA20206@infradead.org>
	<1106666690.5257.97.camel@uganda>
	<d120d5000501250811295c298e@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 11:11:42 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, 25 Jan 2005 18:24:50 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 2005-01-25 at 14:23 +0000, Christoph Hellwig wrote:
> > > > > +static void pc8736x_fini(void)
> > > > > +{
> > > > > + sc_del_sc_dev(&pc8736x_dev);
> > > > > +
> > > > > + while (atomic_read(&pc8736x_dev.refcnt)) {
> > > > > +         printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
> > > > > +                         pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
> > > > > +
> > > > > +         set_current_state(TASK_INTERRUPTIBLE);
> > > > > +         schedule_timeout(HZ);
> > > > > +
> > > > > +         if (current->flags & PF_FREEZE)
> > > > > +                 refrigerator(PF_FREEZE);
> > > > > +
> > > > > +         if (signal_pending(current))
> > > > > +                 flush_signals(current);
> > > > > + }
> > > > > +}
> > > > >
> > > > > And who gurantess this won't deadlock?  Please use a dynamically allocated
> > > > > driver model device and it's refcounting, thanks.
> > > >
> > > > Sigh.
> > > >
> > > > Christoph, please read the code before doing such comments.
> > > > I very respect your review and opinion, but only until you respect
> > > > others.
> > >
> > > The code above pretty much means you can keep rmmod stalled forever.
> > 
> > Yes, and it is better than removing module whose structures are in use.
> > SuperIO core is asynchronous in it's nature, one can use logical device
> > through superio core and remove it's module on other CPU, above loop
> > will wait untill all reference counters are dropped.
> 
> I have a slightly different concern - the superio is a completely new
> subsystem and it should be integtrated with the driver model
> ("superio" bus?). Right now it looks like it is reimplementing most of
> the abstractions (device lists, driver lists, matching, probing).
> Moving to driver model significatntly affects lifetime rules for the
> objects, etc. etc. and will definitely not allow code such as above.
> 
> It would be nice it we get things right from the start.

bus model is not good here - we need bus in each logical device and
bus in each superio chip(or at least second case).
Each bus bus have some crosslinking to devices in other buses, 
and each new device
must be checked in each bus and probably added to each device...

It is not like I see it.

Consider folowing example: 
each device from set A belongs to each device from set B.
n <-> n, it is not the case when one bus can handle all features.

That is why I did not use driver model there.
It is specific design feature, which is proven to work.
 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
