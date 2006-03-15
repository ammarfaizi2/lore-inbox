Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWCOF6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWCOF6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 00:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWCOF6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 00:58:05 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:12161 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751965AbWCOF6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 00:58:03 -0500
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
Date: Wed, 15 Mar 2006 05:57:59 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJP1D-0004rM-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One sad piece of data that I came across, perhaps worth investigating
further after this one is chased down:

As described in the last email, the combination of _TMP fakery (in
utils.c) plus the bisecting version of thermal.c (loading only the
zone THM0 and then only up to bisect_get_info=1) got rid of the hangs.

So I got bold and tried _TMP fakery but with the vanilla thermal.c.
The idea being that if _TMP is to blame for all the problems, then S3
sleep should work fine with this setup.  But it hung in the usual way,
on the second sleep.  Below are the dmesgs after the usual boot-time
ones.

This experiment produces a hang even with _TMP faked, whereas the
previous experiment didn't (also with _TMP faked but, after the boot,
loading only the THM0 zone and only doing the _TMP methods of it, even
on wake).  So one of the non-TMP methods below must be causing a
problem?  My suspicion is that it's one of the methods called on wake
(_THM0._PSV or ._TC1, etc. or maybe one of the other zone's methods),
which would explain why the first sleep goes fine but the second one
fails.

I don't think it's any of the calls made when 'thermal' is loading at
boot time, because the same calls happen in the previous experiment.
In that experiment, thermal loads normally (with _TMP faked), and only
after boot do I unload it and replace it with

  modprobe thermal zone_to_keep=0 bisect_get_info=1

Anyway, here are the dmesgs for this experiment (hangs on 2nd sleep):

# loading 'thermal' on boot (with vanilla thermal.c, so it loads
# all the thermal zones):
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM0._PSV] (Node c157be48)
Execute Method: [\_TZ_.THM0._TC1] (Node c157bdc8)
Execute Method: [\_TZ_.THM0._TC2] (Node c157bd88)
Execute Method: [\_TZ_.THM0._TSP] (Node c157bd48)
Execute Method: [\_TZ_.THM0._AC0] (Node c157bf48)
Execute Method: [\_TZ_.THM0._SCP] (Node c157bec8)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM0] (27 C)
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_TZ_.THM2._SCP] (Node c157bac8)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM2] (27 C)
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM6._AC0] (Node c157b908)
Execute Method: [\_TZ_.THM6._SCP] (Node c157b888)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM6] (27 C)
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM7._AC0] (Node c157b6c8)
Execute Method: [\_TZ_.THM7._SCP] (Node c157b648)
ACPI: acpi_evaluate_integer: Faking _TMP
ACPI: Thermal Zone [THM7] (27 C)

# from "echo 100 > THM0/polling_frequency"
ACPI: acpi_evaluate_integer: Faking _TMP
# now doing the 'sleep.sh' script
# though for consistency maybe I should first do 
#   'modprobe -r thermal  ; modprobe thermal' 
eth0: removing device
Unloaded prism54 driver
PM: Preparing system for mem sleep
Stopping tasks: ====================================================|
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
Execute Method: [\_S3_] (Node c157a988)
Execute Method: [\_PTS] (Node c157ab48)
Execute Method: [\_SI_._SST] (Node c157a8c8)
uhci_hcd 0000:00:07.2: suspend_rh
uhci_hcd 0000:00:07.2: uhci_suspend
uhci_hcd 0000:00:07.2: --> PCI D0/legacy
PM: Entering mem sleep
# wake it up
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
Execute Method: [\_TZ_.THM2._AC0] (Node c157bb48)
Execute Method: [\_SI_._SST] (Node c157a8c8)
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM6._AC0] (Node c157b908)
ACPI: acpi_evaluate_integer: Faking _TMP
Execute Method: [\_TZ_.THM7._AC0] (Node c157b6c8)
ACPI: acpi_evaluate_integer: Faking _TMP
uhci_hcd 0000:00:07.2: suspend_rh (auto-stop)
Execute Method: [\_SB_.LID0._PSW] (Node c1564808)
Execute Method: [\_SB_.SLPB._PSW] (Node c1564708)
ds: ds_open(socket 0)
ds: ds_open(socket 1)
ds: ds_open(socket 2)
pccard: card ejected from slot 1
PCMCIA: socket e3003c28: *** DANGER *** unable to remove socket power
ds: ds_release(socket 0)
ds: ds_release(socket 1)
PM: Preparing system for mem sleep

# and it hangs here.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
