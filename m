Return-Path: <linux-kernel-owner+w=401wt.eu-S1422689AbWLUEHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWLUEHE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWLUEHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:07:04 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:56328 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422689AbWLUEHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:07:01 -0500
Date: Thu, 21 Dec 2006 04:06:48 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061221040648.GA1499@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612201318.06976.david-b@pacbell.net> <20061221012924.GC32625@srcf.ucam.org> <200612201904.28681.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612201904.28681.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: [PATCH 1/2] Fix /sys/device/.../power/state
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 07:04:28PM -0800, David Brownell wrote:
> On Wednesday 20 December 2006 5:29 pm, Matthew Garrett wrote:
> > I dislike that.
> 
> Tough noogies, as they say.  In a tradeoff between correctness and your
> personal taste (or even mine, sigh!), the normal tradeoff is in favor
> of correctness.

But it's not correct - the test prohibits suspending devices even if 
it would be safe to do so.

> > We're asking to suspend an individual device - whether  
> > the bus supports devices that need to suspend with interrupts disabled 
> > is irrelevent, it's the device that we care about. We should just make 
> > it necessary for every bus to support this method until the interface is 
> > removed.
> 
> But you _didn't_ do anything to "make it necessary".  Which means that
> your patch *WILL* cause bugs whenever a driver uses those calls, and
> courtesy of your patch userspace tries to suspend that device ... 

New patch attached.

> > We shouldn't remove interfaces that userland uses until there's been a 
> > replacement for long enough that userland can switch over.
> 
> Userland can stop using this **TODAY** and just "ifdown", so that
> argument seems weak.  For all your examples, the userland interface
> is already available.

No. The proposed interface is currently implemented by three network 
drivers out of over seventy. Once the rest (or even the majority of the 
rest) are converted to support that, I'd have no objections to the 
removal being scheduled.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 30f3c8c..8a91689 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -9,7 +9,8 @@ be removed from this file.
 What:	/sys/devices/.../power/state
 	dev->power.power_state
 	dpm_runtime_{suspend,resume)()
-When:	July 2007
+	bus->pm_has_noirq_stage()
+When:	Once alternative functionality has been implemented
 Why:	Broken design for runtime control over driver power states, confusing
 	driver-internal runtime power management with:  mechanisms to support
 	system-wide sleep state transitions; event codes that distinguish
diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index d0e79d5..345cca4 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -79,6 +79,7 @@ struct bus_type {
 
 	int  (*resume_early)(struct device *dev);
 	int  (*resume)(struct device *dev);
+	int  (*pm_has_noirq_stage)(struct device *dev);
 };
 
 Bus drivers implement those methods as appropriate for the hardware and
@@ -236,6 +237,10 @@ The phases are seen by driver notifications issued in this order:
 	may stay partly usable until this late.  This "late" call may also
 	help when coping with hardware that behaves badly.
 
+	If a bus implements the suspend_late method, it must also provide a
+	pm_has_noirq_stage function in order to determine whether devices 
+	may be suspended during runtime.
+
 The pm_message_t parameter is currently used to refine those semantics
 (described later).
 
@@ -348,7 +353,9 @@ The phases are seen by driver notifications issued in this order:
 	won't be supported on busses that require IRQs in order to
 	interact with devices.
 
-	This reverses the effects of bus.suspend_late().
+	This reverses the effects of bus.suspend_late(). As with suspend_late,
+	if a bus implements this function it must provide a pm_has_noirq_stage
+	function.
 
    2	bus.resume(dev) is called next.  This may be morphed into a device
    	driver call with bus-specific parameters; implementations may sleep.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f9c903b..6bf1218 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -597,6 +597,16 @@ static int platform_resume(struct device * dev)
 	return ret;
 }
 
+static int platform_pm_has_noirq_stage(struct device * dev)
+{
+	int ret = 0;
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+
+	if (dev->driver && (drv->resume_early || drv->suspend_late))
+		ret = 1;
+	return ret;
+}
+
 struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_attrs	= platform_dev_attrs,
@@ -606,6 +616,7 @@ struct bus_type platform_bus_type = {
 	.suspend_late	= platform_suspend_late,
 	.resume_early	= platform_resume_early,
 	.resume		= platform_resume,
+	.pm_has_noirq_stage = platform_pm_has_noirq_stage,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 2d47517..c4ce060 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -46,7 +46,8 @@ static ssize_t state_store(struct device * dev, struct device_attribute *attr, c
 	int error = -EINVAL;
 
 	/* disallow incomplete suspend sequences */
-	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
+	if (dev->bus && dev->bus->pm_has_noirq_stage 
+			&& dev->bus->pm_has_noirq_stage(dev))
 		return error;
 
 	state.event = PM_EVENT_SUSPEND;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e5ae3a0..c0e4e7a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -351,6 +351,17 @@ static int pci_device_resume(struct device * dev)
 	return error;
 }
 
+static int pci_device_pm_has_noirq_stage(struct device * dev)
+{
+	int error = 0;
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+
+	if (drv && (drv->resume_early || drv->suspend_late))
+		error = 1;
+	return error;
+}
+
 static int pci_device_resume_early(struct device * dev)
 {
 	int error = 0;
@@ -569,6 +580,7 @@ struct bus_type pci_bus_type = {
 	.suspend_late	= pci_device_suspend_late,
 	.resume_early	= pci_device_resume_early,
 	.resume		= pci_device_resume,
+	.pm_has_noirq_stage = pci_device_pm_has_noirq_stage,
 	.shutdown	= pci_device_shutdown,
 	.dev_attrs	= pci_dev_attrs,
 };
diff --git a/include/linux/device.h b/include/linux/device.h
index 49ab53c..1c663c4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -59,6 +59,7 @@ struct bus_type {
 	int (*suspend)(struct device * dev, pm_message_t state);
 	int (*suspend_late)(struct device * dev, pm_message_t state);
 	int (*resume_early)(struct device * dev);
+	int (*pm_has_noirq_stage)(struct device * dev);
 	int (*resume)(struct device * dev);
 };

-- 
Matthew Garrett | mjg59@srcf.ucam.org
