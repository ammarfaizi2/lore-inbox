Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbTCHTxb>; Sat, 8 Mar 2003 14:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCHTxb>; Sat, 8 Mar 2003 14:53:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15620 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262180AbTCHTx1>; Sat, 8 Mar 2003 14:53:27 -0500
Date: Sat, 8 Mar 2003 10:47:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: PCI driver module unload race?
Message-ID: <20030308104749.A29145@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What prevents the following scenario from happening?  It's purely
theoretical - I haven't seen this occuring.

- Load PCI driver.

- PCI driver registers using pci_module_init(), and adds itself to sysfs.

- Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
  driver, and calls the PCI drivers probe function.

- The probe function calls kmalloc or some other function which sleeps
  (or gets preempted, if CONFIG_PREEMPT is enabled.)

- We switch to another thread, which happens to be rmmod for this PCI
  driver.  We remove the driver since it has a use count of zero.

- We switch back to the PCI driver.  Oops.

I've probably missed something, but I don't think so.  I suspect we need
struct device_driver to include a struct module pointer which sysfs can
take before calling any driver functions.

Comments?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

