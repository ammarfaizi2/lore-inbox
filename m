Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270441AbTGRIt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 04:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270727AbTGRIt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 04:49:26 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:13830 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S270441AbTGRItY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 04:49:24 -0400
Date: Fri, 18 Jul 2003 11:05:01 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Duncan Sands <baldrick@wanadoo.fr>
cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       <schlicht@uni-mannheim.de>, <ricardo.b@zmail.pt>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SET_MODULE_OWNER
In-Reply-To: <200307180931.39177.baldrick@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0307181045520.14014-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Duncan Sands wrote:

> On Thursday 17 July 2003 22:22, Jeff Garzik wrote:
> > David S. Miller wrote:
> > > On Thu, 17 Jul 2003 12:00:58 -0400
> > >
> > > Jeff Garzik <jgarzik@pobox.com> wrote:
> > >>David?  Does Rusty have a plan here or something?
> > >
> > > It just works how it works and that's it.
> > >
> > > Net devices are reference counted, anything more is superfluous.
> > > They may be yanked out of the kernel whenever you want.
> >
> > (I'm obviously just realizing the implications of this... missed it
> > completely during the earlier discussions)
> >
> > Object lifetime is just part of the story.
> >
> > This change is a major behavior change.  The whole point of removing a
> > module is knowing its gone ;-)  And that is completely changed now.
> > Modules are very often used by developers in a "modprobe ; test ; rmmod"
> > cycle, and that's now impossible (you don't know when the net device,
> > and thus your code, is really gone).  It's already breaking userland,
> > which does sweeps for zero-refcount modules among other things.
> 
> Most USB drivers can be unloaded at any time, so this problem already
> existed elsewhere.

Most? Since when?

For me neither usb-storage nor usbserial (pl2303 f.e.) can be unloaded 
when in use (storage being mounted or /dev/usb/ttyUSBX opened).

True, irda-usb (and probably usbnet) can be unloaded when the interface is 
up since a few weeks - but this is due to the networking not bumping 
the module use counter anymore, nothing todo with usb.

Doing something comparable to network with usb in general one would need 
to change usb-storage reporting use-count==0 while the disk is mounted!
Only then one could rmmod and the fs would (hopefully) get synced and 
unmounted (or staled) automagically.

Personally I believe it all comes down to the semantics of the module use 
counter. If it's taken to indicate the module cannot be unloaded while 
!=0, it might (or should) stay ==0 if the underlaying subsystem can handle 
module removal at any time safe - like it is done for network now.

In contrast, if the module use count is taken to indicate a module is in 
use (interface up, fs mounted, chardev open, ...) I'd expect it to be >0.
Being unable to rmmod in this situation is just a consequence of the fact 
it's being used then, regardless whether we could rmmod anyway.

OTOH David has a point as the current situation with network helps to 
identify bugs there - YMMV.

Martin

