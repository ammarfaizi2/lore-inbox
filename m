Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290756AbSAYXc3>; Fri, 25 Jan 2002 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290826AbSAYXcU>; Fri, 25 Jan 2002 18:32:20 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:43784 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S290756AbSAYXcB>;
	Fri, 25 Jan 2002 18:32:01 -0500
Date: Thu, 24 Jan 2002 23:45:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Driver model corrections/additions
Message-ID: <20020124224553.GA1112@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Take a look. I fixed few typos, and added what I think should be are
contexts functions can be called in...

Plus I'm not very fond of idea that userspace is going to manage
devices for us. You probably do not want to apply that comments to
linus' tree, but think about them. 

								Pavel

--- clean/Documentation/driver-model.txt	Wed Dec 19 22:38:12 2001
+++ linux-dm/Documentation/driver-model.txt	Thu Jan 24 23:42:58 2002
@@ -52,7 +52,8 @@
 Each bus layer should implement the callbacks for these drivers. It then
 forwards the calls on to the device-specific callbacks. This means that
 device-specific drivers must still implement callbacks for each operation.
-But, they are not called from the top level driver layer.
+But, they are not called from the top level driver layer. [So for example
+PCI devices will not call device_register but pci_device_register.]
 
 This does add another layer of indirection for calling one of these functions,
 but there are benefits that are believed to outweigh this slowdown.
@@ -60,7 +61,7 @@
 First, it prevents device-specific drivers from having to know about the
 global device layer. This speeds up integration time incredibly. It also
 allows drivers to be more portable across kernel versions. Note that the
-former was intentional, the latter is an added bonus.
+former was intentional, the latter is an added bonus. 
 
 Second, this added indirection allows the bus to perform any additional logic
 necessary for its child devices. A bus layer may add additional information to
@@ -214,7 +215,6 @@
 	It also allows the platform driver (e.g. ACPI) to a driver without the driver
 	having to have explicit knowledge of (atrocities like) ACPI.
 
-
 current_state:
 	Current power state of the device. For PCI and other modern devices, this is
 	0-3, though it's not necessarily limited to those values.
@@ -240,18 +240,24 @@
 }
 
 probe:
-	Check for device existence and associate driver with it.
+	Check for device existence and associate driver with it. In case of device 
+	insertion, *all* drivers are called. Struct device has parent and bus_id 
+	valid at this point. probe() may only be called from process context. Returns
+	0 if it handles that device, -ESRCH if this driver does not know how to handle
+	this device, valid error otherwise.
 
 remove:
 	Dissociate driver with device. Releases device so that it could be used by
 	another driver. Also, if it is a hotplug device (hotplug PCI, Cardbus), an
-	ejection event could take place here.
+	ejection event could take place here. remove() can be called from interrupt 
+	context. [Fixme: Is that good?] Returns 0 on success. [Can we recover from
+	failed remove or should I define that remove() never fails?]
 
 suspend:
-	Perform one step of the device suspend process.
+	Perform one step of the device suspend process. Returns 0 on success.
 
 resume:
-	Perform one step of the device resume process.
+	Perform one step of the device resume process. Returns 0 on success.
 
 The probe() and remove() callbacks are intended to be much simpler than the
 current PCI correspondents.
@@ -264,7 +270,7 @@
 
 Some device initialisation was done in probe(). This should not be the case
 anymore. All initialisation should take place in the open() call for the
-device.
+device. [FIXME: How do you "open" uhci?]
 
 Breaking initialisation code out must also be done for the resume() callback,
 as most devices will have to be completely reinitialised when coming back from
@@ -313,6 +319,7 @@
 
 enum{
 	SUSPEND_NOTIFY,
+	SUSPEND_DISABLE,
 	SUSPEND_SAVE_STATE,
 	SUSPEND_POWER_DOWN,
 };
@@ -320,6 +327,7 @@
 enum {
 	RESUME_POWER_ON,
 	RESUME_RESTORE_STATE,
+	RESUME_ENABLE,
 };
 
 
@@ -341,7 +349,9 @@
 Instead, the walking of the device tree has been moved to userspace. When a
 user requests the system to suspend, it will walk the device tree, as exported
 via driverfs, and tell each device to go to sleep. It will do this multiple
-times based on what the system policy is.
+times based on what the system policy is. [Not possible. Take ACPI enabled 
+system, with battery critically low. In such state, you want to suspend-to-disk,
+*fast*. User maybe is not even running powerd (think system startup)!]
 
 Device resume should happen in the same manner when the system awakens.
 
@@ -353,22 +363,25 @@
 cannot resume the hardware from the requested level, or it feels that it is
 too important to be put to sleep, it should return an error from this function.
 
-It does not have to stop I/O requests or actually save state at this point.
+It does not have to stop I/O requests or actually save state at this point. Called
+from process context.
 
 SUSPEND_DISABLE:
 
 The driver should stop taking I/O requests at this stage. Because the save
 state stage happens afterwards, the driver may not want to physically disable
-the device; only mark itself unavailable if possible.
+the device; only mark itself unavailable if possible. Called from process 
+context.
 
 SUSPEND_SAVE_STATE:
 
 The driver should allocate memory and save any device state that is relevant
-for the state it is going to enter.
+for the state it is going to enter. Called from process context.
 
 SUSPEND_POWER_DOWN:
 
-The driver should place the device in the power state requested.
+The driver should place the device in the power state requested. May be called
+from interrupt context.
 
 
 For resume, the stages are defined as follows:
@@ -376,25 +389,27 @@
 RESUME_POWER_ON:
 
 Devices should be powered on and reinitialised to some known working state.
+Called from process context.
 
 RESUME_RESTORE_STATE:
 
 The driver should restore device state to its pre-suspend state and free any
-memory allocated for its saved state.
+memory allocated for its saved state. Called from process context.
 
 RESUME_ENABLE:
 
-The device should start taking I/O requests again.
+The device should start taking I/O requests again. Called from process context.
 
 
 Each driver does not have to implement each stage. But, it if it does
-implemente a stage, it should do what is described above. It should not assume
+implement a stage, it should do what is described above. It should not assume
 that it performed any stage previously, or that it will perform any stage
-later.
+later. [Really? It makes sense to support SAVE_STATE only after DISABLE].
 
 It is quite possible that a driver can fail during the suspend process, for
 whatever reason. In this event, the calling process must gracefully recover
-and restore everything to their states before the suspend transition began.
+and restore everything to their states before the suspend transition began. 
+[Suspend may not fail, think battery low.]
 
 If a driver knows that it cannot suspend or resume properly, it should fail
 during the notify stage. Properly implemented power management schemes should

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
