Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTJWVbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJWVbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:31:47 -0400
Received: from web14916.mail.yahoo.com ([216.136.225.229]:24719 "HELO
	web14916.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261820AbTJWVbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:31:45 -0400
Message-ID: <20031023213144.66685.qmail@web14916.mail.yahoo.com>
Date: Thu, 23 Oct 2003 14:31:44 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] DRM and pci_driver conversion
To: Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <1066943415.662.9.camel@leguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think DRM drivers are doing things correctly yet. DRM is missing the
code for marking PCI resources as being in use while DRM is using them. This
could lead to problems with hotplug.  XFree is also mapping PCI ROMs in without
informing the kernel and that can definitely cause problems. I'm looking at
adding the resource marking code right now.

I am not a fan of having two device drivers (DRM and FB) trying to control the
same piece of hardware, but if we are going to insist on doing it we need to do
it in a way where both drivers work and mark the resources in use independent
of the order in which they are loaded.

So I think we need to implement both the old and new PCI ID schemes and
fallback to the
old one if the other driver is present. DRM also needs to add code marking
resources in use which will also conflict with framebuffer. 

It would flow something like this:
new style probe
if (new probe has device)
   mark resources in use
else
   do old style probe (make sure card is really there)
   assume other driver has marked resources in use

The framebuffer drivers that have DRM parallels would need to implement the
same code. That way it won't matter what order things get loaded.

A second possibility would be to implement a tiny stub for just attaching to
the PCI ID and resources. Then framebuffer and DRM could both share the stub.

A third scheme would disallow mixing DRM and FB. A DRM-console module would be
written to replace FB console. Accelerated console could be written using DRM
since it already knows about the 3D hardware. This would fix the problem with
radeonfb mapping upto 256K of memory into the 1GB kernel space and pushing all
the page tables high. Everything would be coordinated in a single drive so
there is no state saving on VT switch problem either.

--- Eric Anholt <eta@lclark.edu> wrote:
> On Thu, 2003-10-23 at 12:04, Kronos wrote:
> > Il Mon, Oct 20, 2003 at 07:31:56PM -0700, Eric Anholt ha scritto: 
> > > I recently committed a change to the DRM for Linux in DRI CVS that
> > > converted it to use pci_driver and that probe system.  Unfortunately,
> > > we've found that there is a conflict between the DRM now and at least
> > > the radeon framebuffer.  Both want to attach to the same device, and
> > > with pci_driver, the second one to come along doesn't get probe called
> > > for that device.  Is there any way to mark things shared, or in some
> > > other way get the DRM to attach to a device that's already attached to,
> > > in the new model?
> > 
> > AFAIK no,  pci_dev only  stores one pointer  to the  driver. Two drivers
> > fiddling with the same hw can be dangerous. What will happen if radeonfb
> > starts using hw  accel, touching registers without  DRM knowing it? What
> > is (IMHO) needed is a common  layer that works with hardware and exposes
> > an interface to both radeonfb and DRM. I think that Jon Smirl is working
> > on something like this.
> 
> Apparently loading DRM after radeonfb is okay.  Loading radeonfb after
> DRM is okay as long as the DRM is not in use.  For some cards, the fb
> after the DRM would still be okay (sis, tdfx at the moment, for
> example), but it isn't the case on radeon, apparently.  Other than that
> there aren't any issues I know of.
> 
> I've moved the Linux DRM to old-style probing as pci.txt described,
> which hopefully restores the ability of fb and drm to coexist as well as
> they have in the past.  I hope some linux developers can get this all
> done right so that the two can coexist better.
> 
> -- 
> Eric Anholt                                eta@lclark.edu          
> http://people.freebsd.org/~anholt/         anholt@FreeBSD.org
> 
> 

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
