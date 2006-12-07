Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968514AbWLGDzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968514AbWLGDzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 22:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968670AbWLGDzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 22:55:10 -0500
Received: from colo.lackof.org ([198.49.126.79]:52484 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968514AbWLGDzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 22:55:08 -0500
Date: Wed, 6 Dec 2006 20:55:06 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <greg@kroah.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
Message-ID: <20061207035506.GA2283@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org> <20061206072651.GG17199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206072651.GG17199@kroah.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 11:26:51PM -0800, Greg KH wrote:
> > If this looks good, I'll post a diff for gregkh.
> 
> This looks very good, thanks for doing this work.

welcome - feels like the most significant contribution I've made
to kernel in a long time.

> I do have a few minor comments:

I'll fix up the comments and post a diff in a few days.
Try to answer your questions below.

...
> > 	save_state	Save a device's state before it is suspended.
> 
> There is no such callback.  We have "suspend", "suspend_late",
> "resume_early", and "resume".  You might want to update this.

I'll review all the callbacks and verify we aren't missing any too.
Definitely want to update this. I'll add them but ask someone
else whose used those entry points rewrite my crap with a
seperate patch. I don't want to rathole on this patch.


...
> > 	driver_data	Data private to the driver.
> > 			Most drivers don't need to use driver_data field.
> > 			Best practice is to use driver_data as an index
> > 			into a static list of equivalent device types,
> > 			instead of using it as a pointer.
> 
> Perhaps mention the PCI_DEVICE() and PCI_DEVICE_CLASS() macros to set
> these fields properly?

Yes. Will add that.

> > Have a table entry {PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID}
> 
> PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) is a bit smaller :)

ditto.

> > All fields are passed in as hexadecimal values (no leading 0x).
> > Users need pass only as many fields as necessary:
> > 	ovendor, device, subvendor, and subdevice fields default
> > 	to PCI_ANY_ID (FFFFFFFF),
> > 	oclass and classmask fields default to 0
> > 	odriver_data defaults to 0UL.
> 
> What's with the "o"s here?

Those are supposed to be bullets.

Cute Story: I lost the first blank space on _every_ line when I messed up
my attempt to remove trailing whitespace in vi with ":1,$ s/ *//".
I left out the "$". :(
I didn't realize the mistake until a few minutes later and had to
hand edit every line to fix it up again. *ouch*
Lesson is to be more careful and save state before making global changes.



> 
> > Once added, the driver probe routine will be invoked for any unclaimed
> > PCI devices listed in its (newly updated) pci_ids list.
> > 
> > Device drivers must initialize use_driver_data in the dynids struct
> > in their pci_driver struct prior to calling pci_register_driver in order
> > for the driver_data field to get passed to the driver. Otherwise, only a
> > 0 (zero) is passed in that field.
> 
> Note that _no one_ uses this field, so it might go away soon...

When it's removed, the patch can remove that paragraph.
This is a seperate issue.


...
> > 	o If the driver is not a hotplug driver then use only
> > 	  __init/__exit and __initdata/__exitdata.
> 
> No, don't say this, pci drivers are not "hotplug drivers", and since
> CONFIG_HOTPLUG is really hard to turn off these days, don't confuse
> people with the devinit stuff.  Everyone gets it wrong...

Yeah. I'll drop the "is not a hotplug driver" bullet item.

> > 	o Pointers to functions marked as __devexit must be created using
> > 	  __devexit_p(function_name).  That will generate the function
> > 	  name or NULL if the __devexit function will be discarded.
> 
> I really recommend just not using any of these for almost all PCI
> drivers, as the space savings just really isn't there...

Ok.  fgrep found 321 instances of __devexit_p and thus I think we should
document it's use at a minimum. I'll just add "Most PCI drivers don't need
to use __devexit."

thanks for the comments!
Expect the next rev this weekend sometime.

grant
