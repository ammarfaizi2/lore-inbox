Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUJLRaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUJLRaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUJLR2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:28:36 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:64675 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S266481AbUJLR1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:27:11 -0400
From: David Brownell <david-b@pacbell.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Totally broken PCI PM calls
Date: Tue, 12 Oct 2004 09:56:07 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410112000.53814.david-b@pacbell.net> <200410112309.27904.dtor_core@ameritech.net>
In-Reply-To: <200410112309.27904.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120956.07450.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 9:09 pm, Dmitry Torokhov wrote:
> On Monday 11 October 2004 10:00 pm, David Brownell wrote:

> > OHCI has to do this when the controller loses power during suspend;
> > which includes many suspend-to-disk cases.  It marks the devices dead,
> > kills the I/O queues, and then makes khubd do all the work.
> >
> 
> Yes, I see that. But so far every bus implements it in its own way - USB,
> IEEE1394, serio, pcmcia... It would be nice if there was a standard
> mechanism to deal with that situation. And actually a standard way of
> pruning part of the device tree which is useful for other things as well.

Certainly.  It _shouldn't_ be too tricky adding that to the PM core,
but there are issues including how to get the locking right when
tasks are concurrently walking the device tree.  The issue comes
up with PCI/Cardbus hotplugging too, so it's not really offtopic ... ;) 


> > USB decided against the extra argument; drivers don't much care
> > at that point.  And anyway, they can tell the device is gone by looking
> > at status codes returned by URB completion or submission.
> > 
> 
> It really depends on the bus I think... I do not know USB well enough but
> does status code gives you enough information to determine that the device
> is gone or it's just not responding for mose reason?

There's a window between "unplug" and "khubd notices unplug"
where requests give controller-specific status reports, some of which
translate directly to "not responding".  The driver's fault recovery
mechanism will eventually start seeing "device gone", once khubd
notices.  Other than network drivers, most drivers usually see the
"gone" status first, or disconnect() if they had no pending URBs.

That's much the same as PCMCIA/Cardbus:  register reads will
return ~0 for a while before disconnect notification.

- Dave
