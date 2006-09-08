Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWIHUVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWIHUVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIHUVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:21:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:23111 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751203AbWIHUVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:21:41 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="127747643:sNHT252606711"
Date: Fri, 8 Sep 2006 13:21:23 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Message-Id: <20060908132123.16137ea3.kristen.c.accardi@intel.com>
In-Reply-To: <20060908195842.GA17220@srcf.ucam.org>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com>
	<20060908195842.GA17220@srcf.ucam.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 20:58:42 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, Sep 07, 2006 at 04:13:05PM -0700, Kristen Carlson Accardi wrote:
> 
> Firstly, thanks for this - I wrote some related code a while ago. A 
> couple of questions...
> 
> > can then be used by udev to unmount or rescan depending on the event.  It will
> > create a proc entry under /proc/acpi/bay for "eject" and for "status".  Writing 
> 
> Do we really want it under /proc? It would seem to make more sense for 
> it to be under /sys.

I agree - this is under proc because this is an acpi driver, and the acpi
subsystem is still using the /proc fs for driver/user space interface. I
thought I would just conform to their standard.

> 
> > a 1 to the eject call will cause the drive bays acpi eject method to be called, 
> > and should be done prior to removing the device.  Reading the "status" entry
> > will tell you either "present" or "removed" depending on the state of the
> > device.  User space scripts can use the status entry to determine if a device
> > has been either inserted or removed in the case of some laptops who generate
> > the exact same event for either insertion or removal (i.e. the Dell M65 for
> > example).  Same scripts for using these events and udev can be found on the
> > thinkwiki website:
> 
> What gets generated if I rip a drive out without notifying the system 
> beforehand? Dell hardware doesn't appear to send any event when poking 
> the eject lever.

I tested the Dell M65 with this patch, and you are right - it does not
send an event when you press the eject button, but rather when you do the
actual remove.  I sent a mail to their BIOS people informing them that we
would find it helpful to have the eject request as well as the removal event,
but, I am not holding my breath.  The remove event seems to be "good enough",
although I can definitely forsee issues.

> 
> The way I originally implemented this was to tie it into the libata 
> layer directly. With a small amount of glue it's possible to tie a 
> hotswap bay to a specific sata port, and use the event to trigger a 
> hotplug rescan. Doing it in kernel space means that the device can be 
> destroyed the moment it's removed, reducing the possibility that further 
> writes will be made. There was some amount of resistance to acpi 
> integration in the scsi layer, though I think we eventually reached a 
> compromise about providing support for platform firmware hooks.

This is the way I was planning on doing it too - and I'd like to do that
for SATA - unfortunately, a lot of the removable drives are actually 
PATA, and until hotplug support for this gets integrated into libata,
as a workaround we have to tell userspace to try to unmount the filesystem
first, otherwise the whole system locks up.  Even new laptops such as the
Lenovo X60 have IDE bays on them.

I think that it would be appropriate and possible to determine if we
were a SATA removable drive from the bay driver, and then if so - 
call into the scsi layer (or vice versa) to do the remove completely
in kernel - this is the best way in my opinion anyway since ATM the
eject event is triggered when the user removes the drive, which means
that if it takes a lot of time to trigger the userspace scripts, you
can wind up with problems.  

> 
> Doing it this way also means that the bay itself can be represented in 
> sysfs as an attribute under the appropriate port. That seems more 
> natural than having the bay be entirely separate, despite ACPI providing 
> us with the information for them to be tied together.
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

So what are the firmware hooks that you speak of?  I would love to have
this represented under the appropriate scsi layer (assuming SATA) if 
possible - it seems more natural to me also.
