Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVAXCJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVAXCJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 21:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVAXCJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 21:09:13 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:980 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261418AbVAXCIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 21:08:41 -0500
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usbmon, usb core, ARM
Date: Sun, 23 Jan 2005 18:08:22 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
References: <20050118212033.26e1b6f0@localhost.localdomain> <200501231534.23583.david-b@pacbell.net> <20050123171706.68a6d717@localhost.localdomain>
In-Reply-To: <20050123171706.68a6d717@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501231808.22323.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 5:17 pm, Pete Zaitcev wrote:
> On Sun, 23 Jan 2005 15:34:23 -0800, David Brownell <david-b@pacbell.net> wrote:
> 
> ...
> > > and this is what usbmon intercepts. 
> > > For one thing, dev is down-counted in usb_unlink_urb().
                                            ^^^^^^^^^^^^^^
> > 
> > I don't see any refcounting calls in that routine.  It couldn't change
> > the refcounts, in any case ... the HCD owns the URB until giveback(),
> > and all unlinking does is accelerate getting to that giveback().
> 
> I am talking about this code (in 2.6.11-rc2):
> 
> static void urb_unlink (struct urb *urb)
              ^^^^^^^^^^

See what I mean?  That's not usb_unlink_urb()!  And if you look at that
function, you'll see I was correct.

If you're concerned about that little helper function then just call the
URB tracing hooks earlier, or move the call to urb_unlink() later.  That
sequencing in giveback() obviously doesn't matter ... the sketches for
hcd_monitor_hook() were probably correct when added, but that was a very
LONG time ago, before things like urb_unlink() was added.


> ...
> 
> void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs)
> ...
> 
> Even if urb->dev was possible to dereference in the completion callback,
> the hcd was not available.

I'm not following your logic still.  I see it as a parameter right there;
how could it suddenly become unavailable????  And remember the hooking is
done BEFORE the callback, not IN it.


> > For example, how does userspace provide a filter to say what URBs
> > it's interested in, and what level of information to report?
> 
> I do not have plans to do that. In the network space, it's the difference
> between BPF (and its spawn LPF), and, say DLPI tap or /dev/nit on SunOS.

So you plan to spit EVERY urb up into userspace?  Copy EVERY byte of
data?  I could understand that as an initial prototype, but as a
long term plan it seems troublesome.  It would certainly affect the
protocol timings, and we know that USB peripherals can be sensitive
to such things.  And for applications like watching video captures,
copying a 24 Mbyte/sec stream does make a noticeable performance hit.
(Especially when it's done during IRQ processing...)

Note that I didn't say any particular networking filter model should
be applied, that was your implication.  If one of those models works
well for USB, so be it.  But I wouldn't necessarily expect any of them
to do that, even though one can argue that USB is a little network
based on parallels of addressing.



> However, nothing prevents you from adding another reader type to usbmon,
> the one which does filtering. Heck, an ability to replace whole usbmon
> is a design parameter.

Indeed, that's exactly why I'd like to split out discussion of the
hooks (currently living only as comments) from what's done with them
(such as usbmon).  The comments about an hcd_monitor_hook() were
done with expectation that someone would someday want to plug in
such components ... and have the ability to experiment with them.

If we could agree on reusable monitor hooks, sufficient for your
current work, that'd be a good step.

- Dave

