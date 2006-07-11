Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWGKNqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWGKNqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWGKNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:46:09 -0400
Received: from thunk.org ([69.25.196.29]:56250 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750777AbWGKNqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:46:08 -0400
Date: Tue, 11 Jul 2006 09:45:54 -0400
From: Theodore Tso <tytso@mit.edu>
To: Olaf Hering <olaf@aepfle.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
Message-ID: <20060711134554.GC24029@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Olaf Hering <olaf@aepfle.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	klibc@zytor.com, torvalds@osdl.org
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711044834.GA11694@suse.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:48:34AM +0200, Olaf Hering wrote:
> One is the kind that builds static kernels and uses no initrd of any kind.
> For those people, the code and interfaces behind prepare_namespace() has
> not changed in a long time.
> They will install that kinit binary once and it will continue to work with
> kernels from 2.6.6 and later, when "/init" support was merged. Or rather
> from 2.6.1x when CONFIG_INITRAMFS_SOURCE was introduced.
> 
> The other group is the one that uses some sort of initrd (loop mount or cpio),
> created with tools from their distribution.
> Again, they should install that kinit binary as well because kinit emulates
> the loop mount handling of /initrd.image. This is for older distributions
> that still create a loop mounted initrd.

Kinit SHOULD be merged into the kernel, and the responsibility of
creating the initrd/initramfs image should be moved from the
distribution into the kernel build process.  There can and should be a
way for distro's to add their own "value add specials" into the
initrd/initramfs image, but we have to take over creating the base
initial userspace environment.  It's not just uswsusp (still not
convinced it's a good idea, but if we're going to do it we have to
wrest control of the initramfs away from the distro's), but finding
and mounting iSCSI disks, LVM setup, etc.

> In earlier mails you stated that having kinit/klibc in the kernel sources
> would make it easier to keep up with interface changes.
> What interface changes did you have in mind, and can you name any relevant
> interface changes that were made after 2.6.0 which would break an external
> kinit?

When you load a SCSI driver (the one that bit me was the MPT Fusion
driver), it no longer waits for SCSI bus probe to finish before
returning.  So the RHEL4 initrd fails to find the root filesystem, and
bombs out.  This change was definitely made after 2.6.0, and is an
example of the sort of change which wouldn't have happened if kinit
was under the kernel sources and not supplied by the distro.

> As others have stated in this thread, the code behind prepare_namespace() is 
> very simple. It doesnt know anything abould lvm etc, nor about mount by
> filesystem UUID/LABEL nor does it know how to deal with properly with new
> technologies like iSCSI, evms, persistant storage device names, usb-storage,
> sbp2 or async device probing.
> Should all that knowledge end up in the kernel source on day?

Some of this will probably need to be farmed out into files provided
by external packages, but I **hope** that they are true upstream
external packages, and not distro-specific specials, which is one of
the reasons why the current initrd/initramfs situation is
so.... unsatisfactory.  Clearly some kernel-mandated interface for
other packages to insert scripts and binaries during the early-boot
process would be a good thing; but the core initramfs functionality
should IMHO belong to the kernel.

						- Ted
