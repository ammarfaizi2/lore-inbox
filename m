Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVA0RHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVA0RHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVA0RG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:06:56 -0500
Received: from lists.us.dell.com ([143.166.224.162]:45219 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262665AbVA0RES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:04:18 -0500
Date: Thu, 27 Jan 2005 11:03:41 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
Message-ID: <20050127170341.GA10491@lists.us.dell.com>
References: <20050119171357.GA16136@lst.de> <20050119234219.GA6294@kroah.com> <20050126060541.GA16017@lists.us.dell.com> <200501261022.30292.agruen@suse.de> <20050126140935.GA27641@lists.us.dell.com> <1106757530.13004.220.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106757530.13004.220.camel@winden.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 05:38:51PM +0100, Andreas Gruenbacher wrote:
> > The autoinstaller feature,
> > for example, which determines if your system has a "good" version of a
> > driver (i.e. if the one provided by DKMS has a newer verson than that
> > provided by the kernel package installed), and to automatically
> > compile and install a newer version if DKMS has it but your kernel
> > doesn't yet have that version.
> 
> I find the autoinstaller feature quite scary.

The autoinstaller itself is mechanism.  When it's invoked is a policy
decision.  I described the policies that Dell employs with it in my
OLS paper last summer.  For non-distribution-provided drivers
(ppp_mppe, ALSA in some cases, 3rd party video), the autoinstaller is
enabled, and it rebuilds and installs those drivers at new kernel boot
time.

For distribution-provided drivers, we default the autoinstaller
off.  But, this has bitten us.  RHEL3 Update 2 and Update 3 both
shipped with an aacraid (boot storage) driver that crashed the kernel
on insmod.  As fate would have it, Dell provided an updated driver
source package in DKMS format to solve this.  An intelligent
autoinstaller could have looked at the version fields and determined
that what was in the "newest" Update kernel was in fact older than
what DKMS had available to it, and used that instead.  Which is why
we've been pushing for MODULE_VERSION() fields in all the drivers, and
why the srcversion field can exist for all drivers now.

 
> > b) Because tools like DKMS can switch out modules, you can't count on
> > 'modinfo foo.ko', which looks at
> > /lib/modules/${kernelver}/... actually matching what is loaded into
> > the kernel already.  Hence asking sysfs for this.
> 
> DKMS doesn't manage loading modules, does it? If it does, then at least
> it shouldn't; that's even more scary than the autoinstaller. From the
> point of view of the kernel, the modules relevant for the running kernel
> are those below /lib/modules/$(uname -r)/. If DKMS replaces things
> there, it'd better keep proper track of what it did.

It does keep track, quite well.
 
> I never want to see DKMS try to remove a module from the running kernel
> or insmod a new one.

Ahh, but that's a policy decision to be made.  I don't have a
production example of needing to do this yet, so it doesn't.  But I
wouldn't rule out the future need for such.  (i.e. wanting to
automate upgrading a NIC driver without rebooting the server).


> > c) as the unbind-driver-from-device work takes shape, it will be
> > possible to rebind a driver that's built-in (no .ko to modinfo for the
> > version) to a newly loaded module.  sysfs will have the
> > currently-built-in version info, for comparison.

As it happens, right now built-in modules don't have modinfo sections,
so this piece doesn't work.  There's no way to ask the kernel for the
version of built-in modules then, it doesn't know.  But with unbind
happening, that will be useful information to have, I'll have to look
into building parts of that section in.  Thanks for pointing this
deficiency out.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
