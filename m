Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269456AbUJLEKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269456AbUJLEKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269454AbUJLEJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:09:59 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:41368 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269453AbUJLEJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:09:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 23:09:27 -0500
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <1097536131.13795.40.camel@gaston> <200410112000.53814.david-b@pacbell.net>
In-Reply-To: <200410112000.53814.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410112309.27904.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 10:00 pm, David Brownell wrote:
> On Monday 11 October 2004 4:08 pm, Benjamin Herrenschmidt wrote:
> > On Tue, 2004-10-12 at 08:58, Dmitry Torokhov wrote:
> > 
> > > Yes, I think that devices that failed to resume (and all their children)
> > > have to be moved by the core resume function into a separate list and
> > > then destroyed (again by the driver core). 
> 
> OHCI has to do this when the controller loses power during suspend;
> which includes many suspend-to-disk cases.  It marks the devices dead,
> kills the I/O queues, and then makes khubd do all the work.
>

Yes, I see that. But so far every bus implements it in its own way - USB,
IEEE1394, serio, pcmcia... It would be nice if there was a standard
mechanism to deal with that situation. And actually a standard way of
pruning part of the device tree which is useful for other things as well.

> 
> > > For that we might need to add 
> > > bus_type->remove_device() handler as it seems that all buses do alot
> > > of work outside of driver->remove handlers. The remove_device should
> > > accept additional argument - something like dead_device that would
> > > suggest that driver should not be alarmed by any errors during unbind/
> > > removal process as the device (or rather usually its parent) is simply
> > > not there anynore.
> > 
> > They already do... think USB...
> 
> USB decided against the extra argument; drivers don't much care
> at that point.  And anyway, they can tell the device is gone by looking
> at status codes returned by URB completion or submission.
> 

It really depends on the bus I think... I do not know USB well enough but
does status code gives you enough information to determine that the device
is gone or it's just not responding for mose reason? I probably would not
want to log errors when device is really gone, but when I fail to talk to
it becuase its stuck I would complain.

-- 
Dmitry
