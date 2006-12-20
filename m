Return-Path: <linux-kernel-owner+w=401wt.eu-S964860AbWLTDn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWLTDn1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWLTDn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:43:27 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:33919 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbWLTDn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:43:26 -0500
Date: Wed, 20 Dec 2006 03:43:15 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061220034315.GA19440@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191536.28998.david-b@pacbell.net> <20061220000955.GA17231@srcf.ucam.org> <200612191919.36813.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191919.36813.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 07:19:36PM -0800, David Brownell wrote:
> On Tuesday 19 December 2006 4:09 pm, Matthew Garrett wrote:
> > I'm sorry, which bit of "Don't break userspace API without adequate 
> > prior warning and with a workable replacement" is difficult to 
> > understand?
> 
> What part of "it was already broken" do YOU not understand?  The
> whole notion is unsustainable.  It doesn't work cross-platform, or
> for multiple bus types.  It confuses system-wide suspend mechanisms
> with runtime mechanisms.  It breaks guaranteed parent/child ordering
> of suspend/resume calls.  (And more...)

Linux is utterly riddled with broken APIs. It's possible to see that as 
a downside of the "Release early, release often" model, but the 
advantage is that we get the opportunity to determine how these 
interfaces are broken. Based on that, we can either improve the existing 
interface or decide that it's broken beyond repair and design a new one.

What we don't do is decide that an interface is broken, deprecate it 
and in the same release break it even for the cases where it 
previously worked. That's just insane.

> Let us know when you get tired of whining and want to move on to
> getting a real solution to the set of problems here.  I've pointed
> out that reverting Linus' patch would be one option to get your
> short term issue rsolved ... that would remove a capability from
> PCI drivers, but you could then use that deprecated mechanism.
> I've also pointed out that you could start working towards a real
> long term solution.

I could, and in the long run I intend to. On the other hand, I don't 
expect to have enough time to fix every single in-tree network driver 
before 2.6.20, so...

> Do you have an alternate solution?

How about something like this? Entirely untested, but I think it shows 
the basic idea.

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f9c903b..4865918 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -597,6 +597,17 @@ static int platform_resume(struct device * dev)
 	return ret;
 }
 
+static int platform_requires_disabled_interrupts(struct device * dev)
+{
+	int ret = 0;
+
+	if (dev->driver && (dev->driver->resume_early 
+			    || dev->driver->suspend_late))
+		ret = 1;
+
+	return ret;
+}
+
 struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_attrs	= platform_dev_attrs,
@@ -604,8 +615,9 @@ struct bus_type platform_bus_type = {
 	.uevent		= platform_uevent,
 	.suspend	= platform_suspend,
 	.suspend_late	= platform_suspend_late,
-	.resume_early	= platform_resume_early,
+	.resume_early	= platform_resume_early,	
 	.resume		= platform_resume,
+	.requires_disabled_interrupts = platform_requires_disabled_interrupts,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 2d47517..97c6d65 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -46,7 +46,8 @@ static ssize_t state_store(struct device * dev, struct device_attribute *attr, c
 	int error = -EINVAL;
 
 	/* disallow incomplete suspend sequences */
-	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
+	if (dev->bus && dev->bus->requires_disabled_interrupts 
+	    && dev->bus->requries_disabled_interrupts())
 		return error;
 
 	state.event = PM_EVENT_SUSPEND;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e5ae3a0..9808d42 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -351,6 +351,18 @@ static int pci_device_resume(struct device * dev)
 	return error;
 }
 
+static int pci_device_requires_disabled_interrupts(struct device * dev)
+{
+	int error = 0;
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+
+	if (drv && (drv->resume_early || drv_suspend_late))
+		error = 1;
+
+	return error;
+}
+
 static int pci_device_resume_early(struct device * dev)
 {
 	int error = 0;
@@ -569,6 +581,7 @@ struct bus_type pci_bus_type = {
 	.suspend_late	= pci_device_suspend_late,
 	.resume_early	= pci_device_resume_early,
 	.resume		= pci_device_resume,
+	.requires_disabled_interrupts = pci_requires_disabled_interrupts,
 	.shutdown	= pci_device_shutdown,
 	.dev_attrs	= pci_dev_attrs,
 };
diff --git a/include/linux/device.h b/include/linux/device.h
index 49ab53c..0686234 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -59,6 +59,7 @@ struct bus_type {
 	int (*suspend)(struct device * dev, pm_message_t state);
 	int (*suspend_late)(struct device * dev, pm_message_t state);
 	int (*resume_early)(struct device * dev);
+	int (*requires_disabled_interrupts)(struct device * dev);
 	int (*resume)(struct device * dev);
 };
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
