Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbUDQURP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbUDQURP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:17:15 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:48823 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264038AbUDQURN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:17:13 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Sat, 17 Apr 2004 22:17:10 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr>
In-Reply-To: <200404141229.26677.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404172217.10994.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 12:29, Duncan Sands wrote:
> Hi Greg, this is the first of a series of patches that replace the
> per-file semaphore ps->devsem with the per-device semaphore
> ps->dev->serialize.  The role of devsem was to protect against
> device disconnection.  This can be done equally well using
> ps->dev->serialize.  On the other hand, ps->dev->serialize
> protects against configuration and other changes, and has
> already been introduced into usbfs in several places.  Using
> just one semaphore simplifies the code and removes some
> remaining race conditions.  It should also fix the oopses some
> people have been seeing.  In this first patch, a reference is
> taken to the usb device as long as the usbfs file is open.  That
> way we can use ps->dev->serialize for as long as ps exists.

Perhaps I should explain why something like this is needed.
Take a random subroutine in devio.c.  I just made a random
choice (yes, really) and got proc_submiturb.  It starts like
this:

        if (copy_from_user(&uurb, arg, sizeof(uurb)))
                return -EFAULT;
        if (uurb.flags & ~(USBDEVFS_URB_ISO_ASAP|USBDEVFS_URB_SHORT_NOT_OK|
                           URB_NO_FSBR|URB_ZERO_PACKET))
                return -EINVAL;
        if (!uurb.buffer)
                return -EINVAL;
        if (uurb.signr != 0 && (uurb.signr < SIGRTMIN || uurb.signr > SIGRTMAX))
                return -EINVAL;
        if (!(uurb.type == USBDEVFS_URB_TYPE_CONTROL && (uurb.endpoint & ~USB_EN
DPOINT_DIR_MASK) == 0)) {
                if ((intf = findintfep(ps->dev, uurb.endpoint)) < 0)
                        return intf;
                if ((ret = checkintf(ps, intf)))
                        return ret;
        }

Notice the calls to findintfep and to checkintf?  The first scans through interfaces to
find which one we want, the second looks up the interface and claims it.  What is to
stop the interfaces changing while we are doing that (due to a configuration change
for example)?  Answer: nothing.  Almost all subroutines in devio.c have calls like
these.  The ps->dev->serialize semaphore needs to be taken to protect against
changes, but this simply isn't down right now.  Normal USB drivers don't suffer from
this problem: they claim interfaces via their probe method (during which dev->serialize
is held for them by the core), and get disconnected by the core before any configuration
changes are performed. But usbfs is different: it goes around claiming interfaces all
over the place.  For example, proc_submiturb like most other routines can be called
on an interface that hasn't been claimed - it will "helpfully" claim it (checkintf does it).
This means mapping an interface number to struct usb_interface - so we need to take
dev->serialize.  If we removed this autoclaiming of interfaces (which would be a good
thing to do IMHO) then things would already be a lot better - but that would break
at least one user space program I know of, so surely others too.  Anyway, checkintf
isn't the only problem here - devio.c is riddled with races of this kind.  The simplest
solution is to systematically take ps->dev->serialize when entering the usbfs
routines, which is what my patches do.  This should be regarded as a first step: it
gives correctness, but at the cost of a probable performance hit.  In later steps we can
(1) turn dev->serialize into a rwsem
(2) push the acquisition of dev->serialize down to the lower levels as they are fixed up.

All the best,

Duncan.
