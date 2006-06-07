Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWFGDAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWFGDAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWFGDAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:00:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:62355 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750767AbWFGDAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:00:32 -0400
Subject: Re: [PATCH 9/9] PCI PM: generic suspend/resume fixes
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149554040.559.8.camel@localhost.localdomain>
References: <1149497178.7831.163.camel@localhost.localdomain>
	 <1149502891.30554.1.camel@localhost.localdomain>
	 <1149529685.7831.177.camel@localhost.localdomain>
	 <1149554040.559.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 23:13:27 -0400
Message-Id: <1149650007.7831.226.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 10:33 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-06-05 at 13:48 -0400, Adam Belay wrote:
> 
> > I've only tested this on a few x86 boxes.  However, I think it's moving
> > in the right direction for correctly suspending devices.  It's worth
> > mentioning that the PCI PM specification requires the device to be
> > disabled before entering D3 (something that we fail to do before this
> > patchset), and the vast majority of devices would end up in this state
> > if we were using pci_set_power_state() in this function.
> 
> That should be done only for D3 though. Not other states.

I still think it's important that we actually do disable devices before
entering D3.  Currently there isn't a driver that does.

> 
> > Unfortunately, far too many drivers still depend on this generic suspend
> > call, when they should all implement their own suspend function.  I
> > would except pci_disable_device() issues to the the exception, and as
> > such, device drivers should provide a ->suspend function that doesn't
> > call pci_disable_device() when they know their hardware can be
> > problematic.
> > 
> > With that in mind, any thoughts on giving this a little time in -mm and
> > seeing how it fares?  If any problems come up, we could revert to a more
> > conservative approach.
> 
> Problem is that you may end up disabling something like ... the ACPI
> controller, and that will cause VERY BAD things with your BIOS when
> actually trying to enter S3 or S4

Alright, trying again then. :)


PCI PM: generic suspend/resume fixes

Some drivers never call pci_enable_device() or pci_enable_master() and
instead assume the bios will have initialized the device.  As a
workaround, this patch modifies the generic resume function to verify
which device features need to be enabled by checking the previous state
of the COMMAND register.

Signed-off-by: Adam Belay <abelay@novell.com>
---
 pci-driver.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -urN a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2006-06-06 22:54:47.000000000 -0400
+++ b/drivers/pci/pci-driver.c	2006-06-06 23:05:32.000000000 -0400
@@ -280,7 +280,6 @@
 	return i;
 }
 
-
 /*
  * Default resume method for devices that have no driver provided resume,
  * or not even a driver at all.
@@ -288,14 +287,15 @@
 static void pci_default_resume(struct pci_dev *pci_dev)
 {
 	int retval;
+	u16 cmd = pci_dev->saved_config.command;
 
 	/* restore the PCI config space */
 	pci_restore_state(pci_dev);
 	/* if the device was enabled before suspend, reenable */
-	if (pci_dev->is_enabled)
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
 		retval = pci_enable_device(pci_dev);
 	/* if the device was busmaster before the suspend, make it busmaster again */
-	if (pci_dev->is_busmaster)
+	if (cmd & PCI_COMMAND_MASTER)
 		pci_set_master(pci_dev);
 }
 


