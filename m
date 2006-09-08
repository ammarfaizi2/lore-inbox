Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWIHUrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWIHUrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWIHUrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:47:17 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:27077 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751219AbWIHUrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:47:16 -0400
Date: Fri, 8 Sep 2006 21:42:32 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Message-ID: <20060908204232.GA17644@srcf.ucam.org>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com> <20060908195842.GA17220@srcf.ucam.org> <20060908132123.16137ea3.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908132123.16137ea3.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 01:21:23PM -0700, Kristen Carlson Accardi wrote:
> On Fri, 8 Sep 2006 20:58:42 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Do we really want it under /proc? It would seem to make more sense for 
> > it to be under /sys.
> 
> I agree - this is under proc because this is an acpi driver, and the acpi
> subsystem is still using the /proc fs for driver/user space interface. I
> thought I would just conform to their standard.

Yeah, that's the current situation. I think pretty much everyone would 
like to see it die off, though :)

> > What gets generated if I rip a drive out without notifying the system 
> > beforehand? Dell hardware doesn't appear to send any event when poking 
> > the eject lever.
> 
> I tested the Dell M65 with this patch, and you are right - it does not
> send an event when you press the eject button, but rather when you do the
> actual remove.  I sent a mail to their BIOS people informing them that we
> would find it helpful to have the eject request as well as the removal event,
> but, I am not holding my breath.  The remove event seems to be "good enough",
> although I can definitely forsee issues.

Right. My prime concern in this case is that userspace ends up seeing 
the drive for a significant period of time despite it having been 
removed. 

> This is the way I was planning on doing it too - and I'd like to do that
> for SATA - unfortunately, a lot of the removable drives are actually 
> PATA, and until hotplug support for this gets integrated into libata,
> as a workaround we have to tell userspace to try to unmount the filesystem
> first, otherwise the whole system locks up.  Even new laptops such as the
> Lenovo X60 have IDE bays on them.

Really? Ouch. I did hack up some vague support for pata hotswap some 
time ago, but dropped it when I realised that there wasn't a terribly 
easy way to remove a single device in drivers/ide. Removing an entire 
bus isn't helpful when your test machine has the hard drive and CD drive 
on the same channel.

> So what are the firmware hooks that you speak of?  I would love to have
> this represented under the appropriate scsi layer (assuming SATA) if 
> possible - it seems more natural to me also.

The idea was to add something to init_scsi in drivers/scsi/scsi.c along 
the lines of scsi_platform_register(). On most platforms this would be a 
noop, but on ACPI systems it would do something like pci_acpi_init does 
in drivers/pci/pci-acpi.c. That way when SCSI devices (including libata 
ones) get registered, there's a callback into the scsi-acpi code which 
can associate them with the appropriate ACPI address. When an event is 
received that can then be handled by the scsi-acpi code, which has the 
corresponding SCSI device structure and can call the relevant hotplug 
code.

The added advantage of this is that it would allow fairly clean 
integration of the ACPI suspend/resume methods for PATA and SATA 
devices, plus any further information that ever gets exposed via ACPI.

http://lkml.org/lkml/2005/12/8/152 is the relevant part of the 
discussion, though the patch appears somewhere earlier in the thread. As 
Jeff mentions the SCSI layer may not be the ideal place to do this, 
though I haven't checked whether it's straightforward to do it in libata 
itself yet. Even if not, it wouldn't be hard to swap the code over when 
necessary. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
