Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVAYQMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVAYQMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVAYQMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:12:21 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:62445 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261996AbVAYQLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:11:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UPxi9DTwO1kuq+mJqN5bf0Gem+GAzlbRHh2zKlkd7oeBRScfPVr7wVWcPmq77u9SdXmLRCdRBHYJvdMByNrurzywDfXsTRR3+RCEqzCKxNs1CQn5jg/lZ+zsWF8ULfEN9ERDraoC/Ny+ZEJOPo8ePT/ptXbzztRxDXT8jEl3VBM=
Message-ID: <d120d5000501250811295c298e@mail.gmail.com>
Date: Tue, 25 Jan 2005 11:11:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <1106666690.5257.97.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org>
	 <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org>
	 <1106666690.5257.97.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 18:24:50 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> On Tue, 2005-01-25 at 14:23 +0000, Christoph Hellwig wrote:
> > > > +static void pc8736x_fini(void)
> > > > +{
> > > > + sc_del_sc_dev(&pc8736x_dev);
> > > > +
> > > > + while (atomic_read(&pc8736x_dev.refcnt)) {
> > > > +         printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
> > > > +                         pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
> > > > +
> > > > +         set_current_state(TASK_INTERRUPTIBLE);
> > > > +         schedule_timeout(HZ);
> > > > +
> > > > +         if (current->flags & PF_FREEZE)
> > > > +                 refrigerator(PF_FREEZE);
> > > > +
> > > > +         if (signal_pending(current))
> > > > +                 flush_signals(current);
> > > > + }
> > > > +}
> > > >
> > > > And who gurantess this won't deadlock?  Please use a dynamically allocated
> > > > driver model device and it's refcounting, thanks.
> > >
> > > Sigh.
> > >
> > > Christoph, please read the code before doing such comments.
> > > I very respect your review and opinion, but only until you respect
> > > others.
> >
> > The code above pretty much means you can keep rmmod stalled forever.
> 
> Yes, and it is better than removing module whose structures are in use.
> SuperIO core is asynchronous in it's nature, one can use logical device
> through superio core and remove it's module on other CPU, above loop
> will wait untill all reference counters are dropped.

I have a slightly different concern - the superio is a completely new
subsystem and it should be integtrated with the driver model
("superio" bus?). Right now it looks like it is reimplementing most of
the abstractions (device lists, driver lists, matching, probing).
Moving to driver model significatntly affects lifetime rules for the
objects, etc. etc. and will definitely not allow code such as above.

It would be nice it we get things right from the start.

-- 
Dmitry
