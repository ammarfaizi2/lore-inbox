Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWDRSsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWDRSsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDRSsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:48:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932277AbWDRSsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:48:54 -0400
Date: Tue, 18 Apr 2006 11:48:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz, acurrid@nvidia.com,
       amartin@nvidia.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MSI failure on Nvidia nForce
Message-ID: <20060418114844.49f79773@localhost.localdomain>
In-Reply-To: <444531F8.3040109@garzik.org>
References: <20060418111944.6ed0505e@localhost.localdomain>
	<444531F8.3040109@garzik.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006 14:37:44 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Stephen Hemminger wrote:
> > I got a report of sky2 driver irq test failing on x86_64 using
> > the following configuration.  Is this a known problem?
> > Should workaround be done at PCI layer?
> > 
> > What the driver does is setup MSI handler, then do a software generated
> > IRQ and check that it was received (similar to tg3).  If IRQ test fails
> > it falls back to INTx.
> 
> Please describe precisely -how- it fails.
> 
> pci_enable_msi() does not fail properly on systems that do not support 
> MSI.  This is a major unresolved problem that is preventing MSI 
> deployment, and causing every driver writer to include a does-MSI-work 
> test in their driver.
> 
> We need to find a good generic test, or if that fails, adopt an 
> ACPI-like rule:  whitelist systems with working MSI before $X date, and 
> blacklist systems with broken MSI after $X date.
> 
> 	Jeff
> 

The message from the driver reported was:

> I'me currently getting a lot of hang up with my computer (x86_64,
> ati,...). I've saw this message in my dmesg :
> 
> sky2: 0000:02:00.0: No interupt was generated using MSI, switching to
> INTx mode. Please report this failure to the PCI maintener and include
> system chipset information.

Which means that. pci_enable_msi succeeded, but the IRQ routing was
screwed up.. There maybe more of a BIOS problem on this system because
the IRQ is showing up as edge triggered as well. Edge triggered interrupts
don't work with NAPI.

cat /proc/interrupts
           CPU0
  0:     333581    IO-APIC-edge  timer
  1:       1461    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:          2    IO-APIC-edge  ehci_hcd:usb1, NVidia CK804
  8:          0    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 10:      55872    IO-APIC-edge  sky2
 11:      21025    IO-APIC-edge  libata
 15:         49    IO-APIC-edge  ide1
NMI:        587
LOC:     333569
ERR:          0
MIS:          0
