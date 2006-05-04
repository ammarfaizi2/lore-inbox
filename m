Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWEDVS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWEDVS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWEDVS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:18:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:8589 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751357AbWEDVS5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:18:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MMaF1f1nCeYokMTj4mVY7tanTmX3W600vAOFWx0Jm2++LdyJ7CSqt0ZP6oiuJGeFXuEb1D7Mv6kJ8BvQGVr0zRkI6tO13Em/ynA5hc5IDn51Ewk8D70LWPlpV0G4nWcg4Z7VJsI8NDu2jq1CVnmPZOiQYlXcSXOnZE9PFuGrrag=
Message-ID: <9e4733910605041418n2105e50bs8803cd6ac8407c48@mail.gmail.com>
Date: Thu, 4 May 2006 17:18:54 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Peter Jones" <pjones@redhat.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Dave Airlie" <airlied@linux.ie>,
       "Andrew Morton" <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <1146776736.27727.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Peter Jones <pjones@redhat.com> wrote:
> On Thu, 2006-05-04 at 16:40 -0400, Jon Smirl wrote:
> > On 5/4/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> > > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > >
> > > > There's already a "rom" file in sysfs.  Could vbetool and friends
> > > > use that?
> > >
> > > Not if you have multiple graphics cards.
> >
> > Not true, the rom attribute maps the ROM into PCI space where ever the
> > kernel tells it to and reads it from there. It is the PCI VGA
> > emulation feature that forces the ROM to appear at C000:0. You can
> > have the ROM mapped and VGA emulation turned off.
>
> It doesn't matter -- you can accomplish the same thing with e.g.
> libx86emu and simply mapping the option rom to 0xc0000.  But you want to
> do that in userland, not in the kernel.

It is much more complicated than than you describe. Go look at the ROM
code already checked in. Laptop video ROMs are not simple PCI devices
that can be mapped around. They are stored in compressed form inside
the system ROM and expanded at boot. If you lose the shadow copy in
RAM there is no API for getting it back. These compressed ROMs are the
source of a lot of laptop user's problems with suspend/resume on
Linux.

VGA support for multiple cards is a very complicated problem. It
really needs to be comprehenisvely designed (but not necessarily
implemented all at once). What we have now is twenty years worth of
hacks that work 95% of the time. But there are many, many holes in the
current scheme.

>
> > This brings up another major point. X changes the PCI VGA emulation
> > routing from user space, another thing that it should not be doing. I
> > have posted patches before providing a sysfs VGA attribute on class
> > VGA devices. By setting the attribute to 1 you can control the active
> > VGA emulation device.
> >
> > This is yet another way that user space can mess up the kernel. If VGA
> > routing is changes under fbdev (my attribute notifies fbdev, the fbdev
> > code for processing the notification did get checked in) then the
> > console will screw up.
>
> And this change allows userland to avoid doing that.
>
> > The usual screw up is that the console goes
> > blank because hardware fonts are not setup correctly on the new
> > console.
>
> And that's completely unrelated to this problem.
>
> --
>   Peter
>
>


--
Jon Smirl
jonsmirl@gmail.com
