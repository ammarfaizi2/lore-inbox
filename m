Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270192AbUJSXXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270192AbUJSXXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270194AbUJSXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:19:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:22154 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270172AbUJSWqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:43 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257332675@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <1098225733903@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.14, 2004/10/06 11:50:24-07:00, david-b@pacbell.net

[PATCH] PCI: update Documentation/power/pci.txt

That document was wrong on some things, misleading on others; this
fixes some of the issues I noticed.

However it probably needs to say that drivers for devices that implement
the PCI PM spec "should" always use pci_set_power_state() to reduce the
power usage.  If I get ambitions I might submit a patch to the PCI core
to print a nag message for drivers that don't do that.


Updates the PCI PM docs, better matching the specs and code.

  - List both D3 states (D3hot, D3cold) up front.

  - Clarify that suspend() methods should disable I/0 (including DMA)
    and IRQs; it's not optional.

  - More accurately describe resume(); there are common cases where
    device re-initialization isn't appropriate.  The previous text said
    re-init was always required; that's false.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/power/pci.txt |   51 ++++++++++++++++++++++++++++++--------------
 1 files changed, 35 insertions(+), 16 deletions(-)


diff -Nru a/Documentation/power/pci.txt b/Documentation/power/pci.txt
--- a/Documentation/power/pci.txt	2004-10-19 15:26:43 -07:00
+++ b/Documentation/power/pci.txt	2004-10-19 15:26:43 -07:00
@@ -5,6 +5,7 @@
 An overview of the concepts and the related functions in the Linux kernel
 
 Patrick Mochel <mochel@transmeta.com>
+(and others)
 
 ---------------------------------------------------------------------------
 
@@ -31,10 +32,15 @@
 the higher the number, the longer the latency is for the device to return to 
 an operational state (D0).
 
+There are actually two D3 states.  When someone talks about D3, they usually
+mean D3hot, which corresponds to an ACPI D2 state (power is reduced, the
+device may lose some context).  But they may also mean D3cold, which is an
+ACPI D3 state (power is fully off, all state was discarded); or both.
+
 Bus power management is not covered in this version of this document.
 
-Note that all PCI devices support D0 and D3 by default, regardless of whether or
-not they implement any of the PCI PM spec.
+Note that all PCI devices support D0 and D3cold by default, regardless of
+whether or not they implement any of the PCI PM spec.
 
 The possible state transitions that a device can undergo are:
 
@@ -204,15 +210,16 @@
 	dev->driver->suspend(dev,state);
 
 A driver uses this function to actually transition the device into a low power
-state. This may include disabling I/O, memory and bus-mastering, as well as
-physically transitioning the device to a lower power state.
+state. This should include disabling I/O, IRQs, and bus-mastering, as well as
+physically transitioning the device to a lower power state; it may also include
+calls to pci_enable_wake().
 
 Bus mastering may be disabled by doing:
 
 pci_disable_device(dev);
 
 For devices that support the PCI PM Spec, this may be used to set the device's
-power state:
+power state to match the suspend() parameter:
 
 pci_set_power_state(dev,state);
 
@@ -223,7 +230,7 @@
 obviate the need for some operations.
 
 The driver should update the current_state field in its pci_dev structure in
-this function.
+this function, except for PM-capable devices when pci_set_power_state is used.
 
 resume
 ------
@@ -237,16 +244,28 @@
 transition the device to the D0 state. 
 
 The driver is responsible for reenabling any features of the device that had
-been disabled during previous suspend calls and restoring all state that was
-saved in previous save_state calls.
+been disabled during previous suspend calls, such as IRQs and bus mastering,
+as well as calling pci_restore_state().
+
+If the device is currently in D3, it may need to be reinitialized in resume().
 
-If the device is currently in D3, it must be completely reinitialized, as it
-must be assumed that the device has lost all of its context (even that of its
-PCI config space). For almost all current drivers, this means that the
-initialization code that the driver does at boot must be separated out and
-called again from the resume callback. Note that some values for the device may
-not have to be probed for this time around if they are saved before entering the
-low power state.
+  * Some types of devices, like bus controllers, will preserve context in D3hot
+    (using Vcc power).  Their drivers will often want to avoid re-initializing
+    them after re-entering D0 (perhaps to avoid resetting downstream devices).
+
+  * Other kinds of devices in D3hot will discard device context as part of a
+    soft reset when re-entering the D0 state.
+    
+  * Devices resuming from D3cold always go through a power-on reset.  Some
+    device context can also be preserved using Vaux power.
+
+  * Some systems hide D3cold resume paths from drivers.  For example, on PCs
+    the resume path for suspend-to-disk often runs BIOS powerup code, which
+    will sometimes re-initialize the device.
+
+To handle resets during D3 to D0 transitions, it may be convenient to share
+device initialization code between probe() and resume().  Device parameters
+can also be saved before the driver suspends into D3, avoiding re-probe.
 
 If the device supports the PCI PM Spec, it can use this to physically transition
 the device to D0:
@@ -263,7 +282,7 @@
 ensure correct (and speedy) operation.
 
 The driver should update the current_state field in its pci_dev structure in
-this function.
+this function, except for PM-capable devices when pci_set_power_state is used.
 
 
 enable_wake

