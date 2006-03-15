Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWCOFky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWCOFky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWCOFky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:40:54 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:37760 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932598AbWCOFkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:40:53 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Wed, 15 Mar 2006 09:46:30 +0800."
             <3ACA40606221794F80A5670F0AF15F840B32A693@pdsmsx403> 
Date: Wed, 15 Mar 2006 05:40:47 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJOkZ-0004gQ-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you just comment out _TMP in kernel or in DSDT, 

I think it needs both excisions: If I comment out just the kernel _TMP
calls, the DSDT might slip one in through the interpreter.  If I
comment out just the DSDT _TMP calls, then the kernel can still call
_TMP.  So instead I modified acpi_evaluate_integer() to return 27 C
(3000 dK) if it's ever asked for a temperature, without doing any
actual work:

--- utils.c.orig	2006-02-27 00:09:35.000000000 -0500
+++ utils.c		2006-03-14 23:36:59.000000000 -0500
@@ -270,7 +270,15 @@ acpi_evaluate_integer(acpi_handle handle
   memset(element, 0, sizeof(union acpi_object));
   buffer.length = sizeof(union acpi_object);
   buffer.pointer = element;
-  status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+  if (strcmp(pathname, "_TMP") != 0)
+    status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
+    else {
+      printk(KERN_INFO PREFIX "acpi_evaluate_integer: Faking _TMP\n");
+        status = AE_OK;
+	   element->type = ACPI_TYPE_INTEGER;
+	     element->integer.value = 3000; /* 27 C, in deciKelvins */
+	     }
+
	if (ACPI_FAILURE(status)) {
	   acpi_util_eval_error(handle, pathname, status);
					return_ACPI_STATUS(status);

This diff is in addition to the previous debugging changes to
thermal.c.

> and do several S3 suspend /resume Cycles without remove thermal
> module, I want to make sure we are at right place to drill down.

I repeated yesterday's experiments: 

  echo 100 > /proc/acpi/thermal_zone/THM0/polling_frequency
  modprobe -rv thermal
  modprobe thermal zone_to_keep=0 bisect_get_info=1
  sleep.sh

with the modified utils.c (being careful to install the new kernel and
reboot, not just reinstall modules, since utils.c is part of the acpi
builtins).  And, unlike yesterday (when _TMP was unhacked), there was
no hang.  Nor did it hang after five more sleep-wake cycles.

Here's are the dmesgs starting when 'thermal' is loaded at boot
(i.e. with the above patch but no special zone_to_keep etc. params),
and then with the commands above:

# during boot
ACPI: thermal_add: THM0
# next line is from the utils.c modification to return 27 C always
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
Execute Method: [\_TZ_.THM0._SCP] (Node c157bec8)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM0] (27 C)
ACPI: thermal_add: THM2
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_TZ_.THM2._SCP] (Node c157bac8)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM2] (27 C)
ACPI: thermal_add: THM6
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM6._AC0] (Node c157b908)
Execute Method: [\_TZ_.THM6._SCP] (Node c157b888)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM6] (27 C)
ACPI: thermal_add: THM7
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM7._AC0] (Node c157b6c8)
Execute Method: [\_TZ_.THM7._SCP] (Node c157b648)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM7] (27 C)
ACPI: thermal_add: _TZ
ACPI: acpi_evaluate_integer: Faking _TMP

# booting is done.  Now for
#   echo 100 > /proc/acpi/thermal_zone/THM0/polling_frequency
ACPI: acpi_evaluate_integer: Faking _TMP
# now "modprobe -rv thermal; modprobe thermal zone_to_keep=0 bisect_get_info=1"
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: thermal_add: THM0
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: thermal_get_info: got temperature, but bisect_get_info = 1 so exiting
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM0] (27 C)
ACPI: thermal_add: THM2
ACPI: thermal_add: ignoring THM2
ACPI: thermal_add: THM6
ACPI: thermal_add: ignoring THM6
ACPI: thermal_add: THM7
ACPI: thermal_add: ignoring THM7
ACPI: thermal_add: _TZ
ACPI: thermal_add: ignoring _TZ
# now sleep.sh
eth0: removing device
Unloaded prism54 driver
PM: Preparing system for mem sleep
Stopping tasks: =======================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
Execute Method: [\_S3_] (Node c157a988)
Execute Method: [\_PTS] (Node c157ab48)
Execute Method: [\_SI_._SST] (Node c157a8c8)
uhci_hcd 0000:00:07.2: suspend_rh
uhci_hcd 0000:00:07.2: uhci_suspend
uhci_hcd 0000:00:07.2: --> PCI D0/legacy
PM: Entering mem sleep
# hit "Fn" key to wake it up
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
PM: Finishing wakeup.
Execute Method: [\_GPE._L0B] (Node c157a848)
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:06.0
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Found IRQ 11 for device 0000:00:02.1
uhci_hcd 0000:00:07.2: PCI legacy resume
PCI: Found IRQ 11 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: uhci_resume
uhci_hcd 0000:00:07.2: uhci_check_and_reset_hc: legsup = 0x2000
uhci_hcd 0000:00:07.2: Performing full reset
usb usb1: root hub lost power or was reset
uhci_hcd 0000:00:07.2: suspend_rh
usb usb1: finish resume
uhci_hcd 0000:00:07.2: wakeup_rh
Restarting tasks...<7>hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
 done
Execute Method: [\_SI_._SST] (Node c157a8c8)
Execute Method: [\_WAK] (Node c157aac8)
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_SI_._SST] (Node c157a8c8)
uhci_hcd 0000:00:07.2: suspend_rh (auto-stop)
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
ds: ds_open(socket 0)
ds: ds_open(socket 1)
ds: ds_open(socket 2)
# from explicit 'cardctl eject' in sleep.sh's wake portion (to save battery)
pccard: card ejected from slot 1
PCMCIA: socket e36dac28: *** DANGER *** unable to remove socket power
ds: ds_release(socket 0)
ds: ds_release(socket 1)
ACPI: acpi_evaluate_integer: Faking _TMP

# and I can keep doing 'sleep.sh' with no problem

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
