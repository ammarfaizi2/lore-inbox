Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVLSTHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVLSTHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVLSTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:07:49 -0500
Received: from web50107.mail.yahoo.com ([206.190.38.35]:20321 "HELO
	web50107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932360AbVLSTHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:07:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=k/hIJnUKZhoJyljU0Qngx0e28Pc8TK9DFzY8lReCBsl2S37CmLQXBidiVZEM5GQJbyQxoRSpvlmqPGTrLZuzFvBf748pCSkjdBaq6FRtnbP2ZoFPRGWu+OBK39vZuDKpD0CzLnvfnAv/cOsEWBsrpsMbDEqg1eAOxO6iJoZHH84=  ;
Message-ID: <20051219190744.37598.qmail@web50107.mail.yahoo.com>
Date: Mon, 19 Dec 2005 11:07:44 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH]  EDAC with sysfs interface added
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:   doug thompson  <norsk5@xmission.com>

Patch against 2.6.15-rc5-mm3

EDAC has been modifed to remove old interface and add new interface.

Removed  /proc/mc and /proc/sys/mc from edac
Added    /sys/devices/system/edac  interface
Added          'mc' and 'pci' under 'edac'
Added    Documentation/drivers/edac/edac.txt
Code cleaning in edac_mc.c

Signed-off-by:  doug thompson <norsk5@xmission.com>
---
 Documentation/drivers/edac/edac.txt |  673 +++++++++++++
 MAINTAINERS                         |    9
 drivers/edac/edac_mc.c              | 1831 ++++++++++++++++++++++++++++--------
 drivers/edac/edac_mc.h              |   23
 4 files changed, 2166 insertions(+), 370 deletions(-)

diff -uprN orig/Documentation/drivers/edac/edac.txt new/Documentation/drivers/edac/edac.txt
--- orig/Documentation/drivers/edac/edac.txt	1969-12-31 17:00:00.000000000 -0700
+++ new/Documentation/drivers/edac/edac.txt	2005-12-16 17:07:13.000000000 -0700
@@ -0,0 +1,673 @@
+
+
+EDAC - Error Detection And Correction
+
+Written by Doug Thompson <norsk5@xmission.com>
+7 Dec 2005
+
+
+EDAC was written by:
+	Thayne Harbaugh, 
+	modified by Dave Peterson, Doug Thompson, et al, 
+	from the bluesmoke.sourceforge.net project.
+
+
+============================================================================
+EDAC PURPOSE
+
+The 'edac' kernel module goal is to detect and report errors that occur
+within the computer system. In the initial release, memory Correctable Errors
+(CE) and Uncorrectable Errors (UE) are the primary errors being harvested.
+
+Detecting CE events, then harvesting those events and reporting them, 
+CAN be a predictor of future UE events.  With CE events, the system can
+continue to operate, but with less safety. Preventive maintainence and
+proactive part replacement of memory DIMMs exhibiting CEs can reduce 
+the likelihood of the dreaded UE events and system 'panics'.
+
+
+In addition, PCI Bus Parity and SERR Errors are scanned for on PCI devices 
+in order to determine if errors are occurring on data transfers. 
+The presence of PCI Parity errors must be examined with a grain of salt. 
+There are several addin adapters that do NOT follow the PCI specification 
+with regards to Parity generation and reporting. The specification says 
+the vendor should tie the parity status bits to 0 if they do not intend 
+to generate parity.  Some vendors do not do this, and thus the parity bit 
+can "float" giving false positives.
+
+The PCI Parity EDAC device has the ability to "skip" known flakey 
+cards during the parity scan. These are set by the parity "blacklist"
+interface in the sysfs for PCI Parity. (See the PCI section in the sysfs
+section below.) There is also a parity "whitelist" which is used as 
+an explicit list of devices to scan, while the blacklist is a list 
+of devices to skip.
+
+EDAC will have future error detectors that will be added or integrated
+into EDAC in the following list:
+
+	MCE	Machine Check Exception
+	MCA	Machine Check Architecture
+	NMI	NMI notification of ECC errors
+	MSRs 	Machine Specific Register error cases
+	and other mechanisms. 
+
+These errors are usually bus errors, ECC errors, thermal throttling 
+and the like.
+
+
+============================================================================
+EDAC VERSIONING
+
+EDAC is composed of a "core" module (edac_mc.ko) and several Memory 
+Controller (MC) driver modules. On a given system, the CORE 
+is loaded and one MC driver will be loaded. Both the CORE and 
+the MC driver have individual versions that reflect current release 
+level of their respective modules.  Thus, to "report" on what version 
+a system is running, one must report both the CORE's and the 
+MC driver's versions.
+
+
+LOADING
+
+If 'edac' was statically linked with the kernel then no loading is
+necessary.  If 'edac' was built as modules then simply modprobe the
+'edac' pieces that you need.  You should be able to modprobe
+hardware-specific modules and have the dependencies load the necessary core
+modules.
+
+Example:
+
+$> modprobe amd76x_edac
+
+loads both the amd76x_edac.ko memory controller module and the edac_mc.ko
+core module.
+
+
+============================================================================
+EDAC sysfs INTERFACE
+
+EDAC presents a 'sysfs' interface for control, reporting and attribute
+reporting purposes.
+
+EDAC lives in the /sys/devices/system/edac directory. Within this directory
+there currently reside 2 'edac' components:
+
+	mc	memory controller(s) system
+	pci	PCI status system
+
+
+============================================================================
+Memory Controller (mc) Model
+
+First a background on the memory controller's model abstracted in EDAC.
+Each mc device controls a set of DIMM memory modules. These modules are
+layed out in a Chip-Select Row (csrowX) and Channel table (chX). There can
+be multiple csrows and two channels. 
+
+Memory controllers allow for several csrows, with 8 csrows being a typical value.
+Yet, the actual number of csrows depends on the electrical "loading"
+of a given motherboard, memory controller and DIMM characteristics.
+
+Dual channels allows for 128 bit data transfers to the CPU from memory.
+
+
+		Channel 0	Channel 1
+	===================================
+	csrow0	| DIMM_A0	| DIMM_B0 |
+	csrow1	| DIMM_A0	| DIMM_B0 |
+	===================================
+
+	===================================
+	csrow2	| DIMM_A1	| DIMM_B1 |
+	csrow3	| DIMM_A1	| DIMM_B1 |
+	===================================
+
+In the above example table there are 4 physical slots on the motherboard
+for memory DIMMs:
+
+	DIMM_A0
+	DIMM_B0
+	DIMM_A1
+	DIMM_B1
+
+Labels for these slots are usually silk screened on the motherboard. Slots
+labeled 'A' are channel 0 in this example. Slots labled 'B'
+are channel 1. Notice that there are two csrows possible on a 
+physical DIMM. These csrows are allocated their csrow assignment
+based on the slot into which the memory DIMM is placed. Thus, when 1 DIMM
+is placed in each Channel, the csrows cross both DIMMs.
+
+Memory DIMMs come single or dual "ranked". A rank is a populated csrow.
+Thus, 2 single ranked DIMMs, placed in slots DIMM_A0 and DIMM_B0 above 
+will have 1 csrow, csrow0. csrow1 will be empty. On the other hand,
+when 2 dual ranked DIMMs are similiaryly placed, then both csrow0 and
+csrow1 will be populated. The pattern repeats itself for csrow2 and
+csrow3.
+
+The representation of the above is reflected in the directory tree
+in EDAC's sysfs interface. Starting in directory 
+/sys/devices/system/edac/mc each memory controller will be represented 
+by its own 'mcX' directory, where 'X" is the index of the MC.
+
+
+	..../edac/mc/
+		   |
+		   |->mc0
+		   |->mc1
+		   |->mc2
+		   ....
+
+Under each 'mcX' directory each 'csrowX' is again represented by a
+'csrowX', where 'X" is the csrow index:
+
+
+	.../mc/mc0/
+		|
+		|->csrow0
+		|->csrow2
+		|->csrow3
+		....
+
+Notice that there is no csrow1, which indicates that csrow0 is
+composed of a single ranked DIMMs. This should also apply in both
+Channels, in order to have dual-channel mode be operational. Since
+both csrow2 and csrow3 are populated, this indicates a dual ranked
+set of DIMMs for channels 0 and 1.
+
+
+Within each of the 'mc','mcX' and 'csrowX' directories are several
+EDAC control and attribute files.
+
+
+============================================================================
+DIRECTORY 'mc'
+
+In directory 'mc' are EDAC system overall control and attribute files:
+
+
+Panic on UE control file:
+
+	'panic_on_ue'
+
+	An uncorrectable error will cause a machine panic.  This is usually
+	desirable.  It is a bad idea to continue when an uncorrectable error
+	occurs - it is indeterminate what was uncorrected and the operating
+	system context might be so mangled that continuing will lead to further
+	corruption. If the kernel has MCE configured, then EDAC will never
+	notice the UE.
+
+	LOAD TIME: module/kernel parameter: panic_on_ue=[0|1]
+	
+	RUN TIME:  echo "1" >/sys/devices/system/edac/mc/panic_on_ue
+
+
+Log UE control file:
+
+	'log_ue'
+
+	Generate kernel messages describing uncorrectable errors.  These errors
+	are reported through the system message log system.  UE statistics 
+	will be accumulated even when UE logging is disabled.
+	
+	LOAD TIME: module/kernel parameter: log_ue=[0|1]
+	
+	RUN TIME: echo "1" >/sys/devices/system/edac/mc/log_ue
+
+
+Log CE control file:
+
+	'log_ce'
+
+	Generate kernel messages describing correctable errors.  These 
+	errors are reported through the system message log system.  
+	CE statistics will be accumulated even when CE logging is disabled.
+
+	LOAD TIME: module/kernel parameter: log_ce=[0|1]
+
+	RUN TIME: echo "1" >/sys/devices/system/edac/mc/log_ce
+
+
+Polling period control file:
+
+	'poll_msec'
+
+	The time period, in milliseconds, for polling for error information.
+	Too small a value wastes resources.  Too large a value might delay
+	necessary handling of errors and might loose valuable information for
+	locating the error.  1000 milliseconds (once each second) is about
+	right for most uses.
+
+	LOAD TIME: module/kernel parameter: poll_msec=[0|1]
+
+	RUN TIME: echo "1000" >/sys/devices/system/edac/mc/poll_msec
+
+
+Module Version read-only attribute file:
+
+	'mc_version'
+
+	The EDAC CORE modules's version and compile date are shown here to
+	indicate what EDAC is running.
+
+
+
+============================================================================
+'mcX' DIRECTORIES 
+
+
+In 'mcX' directories are EDAC control and attribute files for
+this 'X" instance of the memory controllers:
+
+
+Counter reset control file:
+
+	'reset_counters'
+
+	This write-only control file will zero all the statistical counters 
+	for UE and CE errors.  Zeroing the counters will also reset the timer 
+	indicating how long since the last counter zero.  This is useful 
+	for computing errors/time.  Since the counters are always reset at 
+	driver initialization time, no module/kernel parameter is available.
+
+	RUN TIME: echo "anything" >/sys/devices/system/edac/mc/mc0/counter_reset
+
+		This resets the counters on memory controller 0
+
+
+Seconds since last counter reset control file:
+
+	'seconds_since_reset'
+
+	This attribute file displays how many seconds have elapsed since the
+	last counter reset. This can be used with the error counters to
+	measure error rates.
+
+
+
+DIMM capability attribute file:
+
+	'edac_capability'
+
+	The EDAC (Error Detection and Correction) capabilities/modes of
+	the memory controller hardware.
+
+
+DIMM Current Capability attribute file:
+
+	'edac_current_capability'
+
+	The EDAC capabilities available with the hardware
+	configuration.  This may not be the same as "EDAC capability"
+	if the correct memory is not used.  If a memory controller is
+	capable of EDAC, but DIMMs without check bits are in use, then
+	Parity, SECDED, S4ECD4ED capabilities will not be available
+	even though the memory controller might be capable of those
+	modes with the proper memory loaded.
+
+
+Memory Type supported on this controller attribute file:
+
+	'supported_mem_type'
+
+	This attribute file displays the memory type, usually 
+	buffered and unbuffered DIMMs.
+
+
+Memory Controller name attribute file:
+
+	'mc_name'
+
+	This attribute file displays the type of memory controller
+	that is being utilized.
+
+
+Memory Controller Module name attribute file:
+
+	'module_name'
+
+	This attribute file displays the memory controller module name, 
+	version and date built.  The name of the memory controller 
+	hardware - some drivers work with multiple controllers and 
+	this field shows which hardware is present.
+
+
+Total memory managed by this memory controller attribute file:
+
+	'size_mb'
+
+	This attribute file displays, in count of megabytes, of memory
+	that this instance of memory controller manages.
+
+
+Total Uncorrectable Errors count attribute file:
+
+	'ue_count'
+
+	This attribute file displays the total count of uncorrectable
+	errors that have occurred on this memory controller. If panic_on_ue 
+	is set this counter will not have a chance to increment, 
+	since EDAC will panic the system.
+
+
+Total UE count that had no information attribute fileY:
+
+	'ue_noinfo_count'
+
+	This attribute file displays the number of UEs that
+	have occurred have occurred with  no informations as to which DIMM 
+	slot is having errors.
+
+
+Total Correctable Errors count attribute file:
+
+	'ce_count'
+
+	This attribute file displays the total count of correctable
+	errors that have occurred on this memory controller. This
+	count is very important to examine. CEs provide early
+	indications that a DIMM is beginning to fail. This count
+	field should be monitored for non-zero values and report
+	such information to the system administrator.
+
+
+Total Correctable Errors count attribute file:
+
+	'ce_noinfo_count'
+
+	This attribute file displays the number of CEs that
+	have occurred wherewith no informations as to which DIMM slot
+	is having errors. Memory is handicapped, but operational, 
+	yet no information is available to indicate which slot
+	the failing memory is in. This count field should be also
+	be monitored for non-zero values.
+
+Device Symlink:
+
+	'device'
+
+	Symlink to the memory controller device
+
+
+
+============================================================================
+'csrowX' DIRECTORIES 
+
+In the 'csrowX' directories are EDAC control and attribute files for
+this 'X" instance of csrow:
+
+
+Total Uncorrectable Errors count attribute file:
+
+	'ue_count'
+
+	This attribute file displays the total count of uncorrectable
+	errors that have occurred on this csrow. If panic_on_ue is set
+	this counter will not have a chance to increment, since EDAC
+	will panic the system.
+
+
+Total Correctable Errors count attribute file:
+
+	'ce_count'
+
+	This attribute file displays the total count of correctable
+	errors that have occurred on this csrow. This
+	count is very important to examine. CEs provide early
+	indications that a DIMM is beginning to fail. This count
+	field should be monitored for non-zero values and report
+	such information to the system administrator.
+
+
+Total memory managed by this csrow attribute file:
+
+	'size_mb'
+
+	This attribute file displays, in count of megabytes, of memory
+	that this csrow contatins.
+
+
+Memory Type attribute file:
+
+	'mem_type'
+
+	This attribute file will display what type of memory is currently
+	on this csrow. Normally, either buffered or unbuffered memory.
+
+
+EDAC Mode of operation attribute file:
+
+	'edac_mode'
+
+	This attribute file will display what type of Error detection
+	and correction is being utilized.
+
+
+Device type attribute file:
+
+	'dev_type'
+
+	This attribute file will display what type of DIMM device is
+	being utilized. Example:  x4
+
+
+Channel 0 CE Count attribute file:
+
+	'ch0_ce_count'
+
+	This attribute file will display the count of CEs on this
+	DIMM located in channel 0.
+
+
+Channel 0 UE Count attribute file:
+
+	'ch0_ue_count'
+
+	This attribute file will display the count of UEs on this
+	DIMM located in channel 0.
+
+
+Channel 0 DIMM Label control file:
+
+	'ch0_dimm_label'
+
+	This control file allows this DIMM to have a label assigned 
+	to it. With this label in the module, when errors occur
+	the output can provide the DIMM label in the system log.
+	This becomes vital for panic events to isolate the
+	cause of the UE event.
+
+	DIMM Labels must be assigned after booting, with information
+	that correctly identifies the physical slot with its
+	silk screen label. This information is currently very
+	motherboard specific and determination of this information
+	must occur in userland at this time.
+
+
+Channel 1 CE Count attribute file:
+
+	'ch1_ce_count'
+
+	This attribute file will display the count of CEs on this
+	DIMM located in channel 1.
+
+
+Channel 1 UE Count attribute file:
+
+	'ch1_ue_count'
+
+	This attribute file will display the count of UEs on this
+	DIMM located in channel 0.
+
+
+Channel 1 DIMM Label control file:
+
+	'ch1_dimm_label'
+
+	This control file allows this DIMM to have a label assigned 
+	to it. With this label in the module, when errors occur
+	the output can provide the DIMM label in the system log.
+	This becomes vital for panic events to isolate the
+	cause of the UE event.
+
+	DIMM Labels must be assigned after booting, with information
+	that correctly identifies the physical slot with its
+	silk screen label. This information is currently very
+	motherboard specific and determination of this information
+	must occur in userland at this time.
+
+
+============================================================================
+SYSTEM LOGGING
+
+If logging for UEs and CEs are enabled then system logs will have
+error notices indicating errors that have been detected:
+
+MC0: CE page 0x283, offset 0xce0, grain 8, syndrome 0x6ec3, row 0,
+channel 1 "DIMM_B1": amd76x_edac
+
+MC0: CE page 0x1e5, offset 0xfb0, grain 8, syndrome 0xb741, row 0,
+channel 1 "DIMM_B1": amd76x_edac
+
+
+The structure of the message is:
+	the memory controller			(MC0)
+	Error type				(CE)
+	memory page				(0x283)
+	offset in the page			(0xce0)
+	the byte granularity 			(grain 8)
+		or resolution of the error
+	the error syndrome			(0xb741)
+	memory row				(row 0)
+	memory channel				(channel 1)
+	DIMM label, if set prior		(DIMM B1
+	and then an optional, driver-specific message that may 
+		have additional information.  
+
+Both UEs and CEs with no info will lack all but memory controller, 
+error type, a notice of "no info" and then an optional, 
+driver-specific error message.
+
+
+
+============================================================================
+PCI Bus Parity Detection
+
+
+On Header Type 00 devices the primary status is looked at
+for any parity error regardless of whether Parity is enabled on the
+device.  (The spec indicates parity is generated in some cases).
+On Header Type 01 bridges, the secondary status register is also
+looked at to see if parity ocurred on the bus on the other side of
+the bridge.
+
+
+SYSFS CONFIGURATION
+
+Under /sys/devices/system/edac/pci are control and attribute files as follows:
+
+
+Enable/Disable PCI Parity checking control file:
+
+	'check_pci_parity'
+
+
+	This control file enables or disables the PCI Bus Parity scanning
+	operation. Writing a 1 to this file enables the scanning. Writing 
+	a 0 to this file disables the scanning.
+
+	Enable:
+	echo "1" >/sys/devices/system/edac/pci/check_pci_parity
+
+	Disable:
+	echo "0" >/sys/devices/system/edac/pci/check_pci_parity
+
+
+
+Panic on PCI PARITY Error:
+
+	'panic_on_pci_parity'
+
+
+	This control files enables or disables panic'ing when a parity
+	error has been detected.
+
+
+	module/kernel parameter: panic_on_pci_parity=[0|1]
+
+	Enable:
+	echo "1" >/sys/devices/system/edac/pci/panic_on_pci_parity
+
+	Disable:
+	echo "0" >/sys/devices/system/edac/pci/panic_on_pci_parity
+
+
+Parity Count:
+
+	'pci_parity_count'
+
+	This attribute file will display the number of parity errors that
+	have been detected.
+
+
+
+PCI Device Whitelist:
+
+	'pci_parity_whitelist'
+
+	This control file allows for an explicit list of PCI devices to be
+	scanned for parity errors. Only devices found on this list will
+	be examined.  The list is a line of hexadecimel VENDOR and DEVICE
+	ID tuples:
+
+	1022:7450,1434:16a6
+
+	One or more can be inserted, seperated by a comma.
+
+	To write the above list doing the following as one command line:
+
+	echo "1022:7450,1434:16a6" 
+		> /sys/devices/system/edac/pci/pci_parity_whitelist
+
+
+
+	To display what the whitelist is, simply 'cat' the same file.
+
+
+PCI Device Blacklist:
+
+	'pci_parity_blacklist'
+
+	This control file allows for a list of PCI devices to be
+	skipped for scanning. 
+	The list is a line of hexadecimel VENDOR and DEVICE ID tuples:
+
+	1022:7450,1434:16a6
+
+	One or more can be inserted, seperated by a comma.
+
+	To write the above list doing the following as one command line:
+
+	echo "1022:7450,1434:16a6" 
+		> /sys/devices/system/edac/pci/pci_parity_blacklist
+
+
+	To display what the whitelist current contatins, 
+	simply 'cat' the same file.
+
+=======================================================================
+
+PCI Vendor and Devices IDs can be obtained with the lspci command. Using
+the -n option lspci will display the vendor and device IDs. The system
+adminstrator will have to determine which devices should be scanned or
+skipped.
+
+
+
+The two lists (white and black) are prioritized. blacklist is the lower 
+priority and will NOT be utilized when a whitelist has been set. 
+Turn OFF a whitelist by an empty echo command:
+
+	echo > /sys/devices/system/edac/pci/pci_parity_whitelist
+
+and any previous blacklist will be utililzed.
+
diff -uprN orig/MAINTAINERS new/MAINTAINERS
--- orig/MAINTAINERS	2005-12-16 17:06:02.000000000 -0700
+++ new/MAINTAINERS	2005-12-16 17:07:13.000000000 -0700
@@ -875,6 +875,15 @@ L:	ebtables-devel@lists.sourceforge.net
 W:	http://ebtables.sourceforge.net/
 S:	Maintained
 
+EDAC-CORE
+P:      Doug Thompson
+M:      norsk5@xmission.com, dthompson@linuxnetworx.com
+P:      Dave Peterson
+M:      dsp@llnl.gov, dave_peterson@pobox.com
+L:      bluesmoke-devel@lists.sourceforge.net
+W:      bluesmoke.sourceforge.net
+S:      Maintained
+
 EEPRO100 NETWORK DRIVER
 P:	Andrey V. Savochkin
 M:	saw@saw.sw.com.sg
diff -uprN orig/drivers/edac/edac_mc.c new/drivers/edac/edac_mc.c
--- orig/drivers/edac/edac_mc.c	2005-12-16 17:05:53.000000000 -0700
+++ new/drivers/edac/edac_mc.c	2005-12-16 17:28:02.000000000 -0700
@@ -1,6 +1,6 @@
 /*
  * edac_mc kernel module
- * (C) 2003 Linux Networx (http://lnxi.com)
+ * (C) 2005 Linux Networx (http://lnxi.com)
  * This file may be distributed under the terms of the
  * GNU General Public License.
  *
@@ -8,7 +8,7 @@
  * Based on work by Dan Hollis <goemon at anime dot net> and others.
  *	http://www.anime.net/~goemon/linux-ecc/
  *
- * $Id: edac_mc.c,v 1.7.2.19 2005/10/05 22:01:42 dsp_llnl Exp $
+ * Modified by Dave Peterson and Doug Thompson
  *
  */
 
@@ -28,6 +28,8 @@
 #include <linux/jiffies.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/sysdev.h>
+#include <linux/ctype.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -36,297 +38,1231 @@
 #include "edac_mc.h"
 
 
-#define	EDAC_MC_VERSION	"edac_mc  Ver: 2.0.0.devel " __DATE__
+#define	EDAC_MC_VERSION	"edac_mc  Ver: 2.0.0 " __DATE__
 
 #ifdef CONFIG_EDAC_DEBUG
-int edac_debug_level = 0;
+/* Values of 0 to 4 will generate output */
+int edac_debug_level = 1;
 EXPORT_SYMBOL(edac_debug_level);
 #endif
 
-#define MC_PROC_DIR "mc"
 #define	EDAC_THREAD_NAME	"kedac"
 
 
-/* /proc/mc dir */
-static struct proc_dir_entry *proc_mc;
 
-/* Setable by module parameter and sysctl */
-static int panic_on_ue = 1;
-static int check_pci_parity = 1;	/* default YES check PCI parity */
-static int panic_on_pci_parity = 0;     /* default no panic on PCI Parity */
+/* EDAC Controls, setable by module parameter, and sysfs */
 static int log_ue = 1;
 static int log_ce = 1;
+static int panic_on_ue = 1;
 static int poll_msec = 1000;
 
-static u32 pci_parity_count = 0;
+static int check_pci_parity = 1;	/* default YES check PCI parity */
+static int panic_on_pci_parity = 0;     /* default no panic on PCI Parity */
+static atomic_t pci_parity_count = ATOMIC_INIT(0);
+
+
+/* lock to memory controller's control array */
+static DECLARE_MUTEX(mem_ctls_mutex);
+static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
+
+/* Structure of the whitelist and blacklist arrays */
+struct edac_pci_device_list
+{
+        unsigned int  vendor;         /* Vendor ID */
+        unsigned int  device;         /* Deviice ID */
+};
+
+
+#define MAX_LISTED_PCI_DEVICES         32
+
+/* List of PCI devices (vendor-id:device-id) that should be skipped */
+static struct edac_pci_device_list pci_blacklist[ MAX_LISTED_PCI_DEVICES ];
+static int pci_blacklist_count = 0;
+
+/* List of PCI devices (vendor-id:device-id) that should be scanned */
+static struct edac_pci_device_list pci_whitelist[ MAX_LISTED_PCI_DEVICES ];
+static int pci_whitelist_count = 0;
+
+
+
+
+
+/*  START sysfs data and methods */
+
+static const char *mem_types[] = {
+	[MEM_EMPTY] = "Empty",
+	[MEM_RESERVED] = "Reserved",
+	[MEM_UNKNOWN] = "Unknown",
+	[MEM_FPM] = "FPM",
+	[MEM_EDO] = "EDO",
+	[MEM_BEDO] = "BEDO",
+	[MEM_SDR] = "Unbuffered-SDR",
+	[MEM_RDR] = "Registered-SDR",
+	[MEM_DDR] = "Unbuffered-DDR",
+	[MEM_RDDR] = "Registered-DDR",
+	[MEM_RMBS] = "RMBS"
+};
+
+
+static const char *dev_types[] = {
+	[DEV_UNKNOWN] = "Unknown",
+	[DEV_X1] = "x1",
+	[DEV_X2] = "x2",
+	[DEV_X4] = "x4",
+	[DEV_X8] = "x8",
+	[DEV_X16] = "x16",
+	[DEV_X32] = "x32",
+	[DEV_X64] = "x64"
+};
+
+static const char *edac_caps[] = {
+	[EDAC_UNKNOWN] = "Unknown",
+	[EDAC_NONE] = "None",
+	[EDAC_RESERVED] = "Reserved",
+	[EDAC_PARITY] = "PARITY",
+	[EDAC_EC] = "EC",
+	[EDAC_SECDED] = "SECDED",
+	[EDAC_S2ECD2ED] = "S2ECD2ED",
+	[EDAC_S4ECD4ED] = "S4ECD4ED",
+	[EDAC_S8ECD8ED] = "S8ECD8ED",
+	[EDAC_S16ECD16ED] = "S16ECD16ED"
+};
+
+
+
+/* sysfs object: /sys/devices/system/edac */
+static struct sysdev_class edac_class = {
+	set_kset_name("edac"),
+};
+
+
+/* sysfs objects: 
+ *	/sys/devices/system/edac/mc 
+ *	/sys/devices/system/edac/pci
+ */
+static struct kobject edac_memctrl_kobj;
+static struct kobject edac_pci_kobj;
+
+
+
+
+/* 
+ * /sys/devices/system/edac/mc;
+ * 	data structures and methods 
+ */
+static ssize_t
+memctrl_string_show(void *ptr, char * buffer)
+{
+	char *value = (char*) ptr;
+	return sprintf(buffer,"%s\n",value);
+}
+
+
+static ssize_t
+memctrl_int_show(void *ptr, char * buffer)
+{
+	int *value = (int*) ptr;
+	return sprintf(buffer,"%d\n",*value);
+}
+
+static ssize_t
+memctrl_int_store(void *ptr, const char * buffer, size_t count)
+{
+	int *value = (int*) ptr;
+
+	if (isdigit(*buffer) ) {
+		*value = simple_strtoul(buffer,NULL,0);
+	}
+
+	return count;	
+}
+
+
+
+struct memctrl_dev_attribute {
+	struct attribute	attr;
+	void     *value;
+	ssize_t (*show)(void *,char *);
+	ssize_t (*store)(void *, const char *,size_t);
+};
+
+/* Set of show/store abstract level functions for memory control  object */
+static ssize_t
+memctrl_dev_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+	struct memctrl_dev_attribute *memctrl_dev;
+	memctrl_dev= (struct memctrl_dev_attribute*) attr;
+
+        if (memctrl_dev->show)
+                return memctrl_dev->show(memctrl_dev->value, buffer);
+        return -EIO;
+}
+
+
+static ssize_t
+memctrl_dev_store(struct kobject * kobj, struct attribute * attr,
+             const char * buffer, size_t count)
+{
+	struct memctrl_dev_attribute *memctrl_dev;
+	memctrl_dev= (struct memctrl_dev_attribute*) attr;
+
+        if (memctrl_dev->store)
+                return memctrl_dev->store(memctrl_dev->value, buffer, count);
+	return -EIO;
+}
+
+
+static struct sysfs_ops memctrlfs_ops = {
+        .show   = memctrl_dev_show,
+        .store  = memctrl_dev_store
+};
+
+
+
+#define MEMCTRL_ATTR(_name,_mode,_show,_store)          \
+struct memctrl_dev_attribute attr_##_name = {                       \
+        .attr = {.name = __stringify(_name), .mode = _mode },   \
+	.value  = &_name,					\
+        .show   = _show,                                        \
+        .store  = _store,                                       \
+};
+
+#define MEMCTRL_STRING_ATTR(_name,_data,_mode,_show,_store)          \
+struct memctrl_dev_attribute attr_##_name = {                       \
+        .attr = {.name = __stringify(_name), .mode = _mode },   \
+	.value  = _data,					\
+        .show   = _show,                                        \
+        .store  = _store,                                       \
+};
+
+
+/* cwrow<id> attribute f*/
+MEMCTRL_STRING_ATTR(mc_version,EDAC_MC_VERSION,S_IRUGO,memctrl_string_show,NULL);
+
+/* csrow<id> control files */
+MEMCTRL_ATTR(panic_on_ue,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
+MEMCTRL_ATTR(log_ue,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
+MEMCTRL_ATTR(log_ce,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
+MEMCTRL_ATTR(poll_msec,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
+
+
+/* Base Attributes of the memory ECC object */
+static struct memctrl_dev_attribute *memctrl_attr[] = {
+	&attr_panic_on_ue,
+	&attr_log_ue,
+	&attr_log_ce,
+	&attr_poll_msec,
+	&attr_mc_version,
+	NULL,
+};
+
+/* Main MC kobject release() function */
+static void
+edac_memctrl_master_release(struct kobject * kobj)
+{
+	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
+}
+
+
+static struct kobj_type ktype_memctrl = {
+	.release	= edac_memctrl_master_release,
+        .sysfs_ops      = &memctrlfs_ops,
+	.default_attrs	= (struct attribute **) memctrl_attr,
+};
+
+
+
+/* Initialize the main sysfs entries for edac:
+ *   /sys/devices/system/edac
+ *
+ * and children
+ *
+ * Return:  0 SUCCESS
+ *         !0 FAILURE
+ */
+static int edac_sysfs_memctrl_setup(void)
+{
+	int err=0;
+
+	debugf1("MC: " __FILE__ ": %s()\n", __func__);
+
+	/* create the /sys/devices/system/edac directory */
+	err = sysdev_class_register(&edac_class);
+	if (!err) {
+		/* Init the MC's kobject */
+		memset(&edac_memctrl_kobj, 0, sizeof (edac_memctrl_kobj));
+		kobject_init(&edac_memctrl_kobj);
+
+		edac_memctrl_kobj.parent = &edac_class.kset.kobj;
+		edac_memctrl_kobj.ktype = &ktype_memctrl;
+	
+		/* generate sysfs "..../edac/mc"   */
+		err = kobject_set_name(&edac_memctrl_kobj,"mc");
+		if (!err) {
+			/* FIXME: maybe new sysdev_create_subdir() */
+			err = kobject_register(&edac_memctrl_kobj);
+			if (err) {
+				debugf1("Failed to register '.../edac/mc'\n");
+			} else {
+				debugf1("Registered '.../edac/mc' kobject\n");
+			}
+		}
+	} else {
+		debugf1(KERN_WARNING "__FILE__ %s() error=%d\n", __func__,err);
+	}
+
+	return err;
+}
+
+/* 
+ * MC teardown:
+ *	the '..../edac/mc' kobject followed by '..../edac' itself 
+ */
+static void edac_sysfs_memctrl_teardown(void)
+{
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+
+	/* Unregister the MC's kobject */
+	kobject_unregister(&edac_memctrl_kobj);
+
+	/* release the master edac mc kobject */
+	kobject_put(&edac_memctrl_kobj);
+
+	/* Unregister the 'edac' object */
+	sysdev_class_unregister(&edac_class);
+}
+
+
+
+/* 
+ * /sys/devices/system/edac/pci;
+ * 	data structures and methods 
+ */
+
+struct list_control 
+{
+	struct edac_pci_device_list *list;
+	int *count;
+};
+
+/* Output the list as:  vendor_id:device:id<,vendor_id:device_id> */
+static ssize_t
+edac_pci_list_string_show(void *ptr, char * buffer)
+{
+	struct list_control *listctl;
+	struct edac_pci_device_list *list;
+	char *p = buffer;
+	int len=0;
+	int i;
+	
+	listctl = (struct list_control *) ptr;
+	list = listctl->list;
+
+	for (i = 0; i < *(listctl->count); i++,list++ ) {
+		if (len > 0)
+			len += snprintf(p + len, (PAGE_SIZE-len), ",");
+
+		len += snprintf(p + len, 
+				(PAGE_SIZE-len),
+				"%x:%x",
+				list->vendor,list->device);
+	}
+
+	len += snprintf(p + len,(PAGE_SIZE-len), "\n");
+
+	return (ssize_t) len;
+}
+
+
+/**
+ *
+ * Scan string from **s to **e looking for one 'vendor:device' tuple
+ * where each field is a hex value
+ *
+ * return 0 if an entry is NOT found
+ * return 1 if an entry is found
+ *	fill in *vendor_id and *device_id with values found
+ *
+ * In both cases, make sure *s has been moved forward toward *e
+ */
+static int 
+parse_one_device(const char **s,const char **e, 
+	unsigned int *vendor_id, unsigned int *device_id) 
+{
+	const char *runner, *p;
+
+	/* if null byte, we are done */
+	if (! **s) {
+		(*s)++;	/* keep *s moving */
+		return 0;
+	}
+
+	/* skip over newlines & whitespace */
+	if ( (**s == '\n') || isspace(**s)) {
+		(*s)++;	
+		return 0;
+	}
+
+	if (! isxdigit(**s)) {
+		(*s)++;
+		return 0;
+	}
+
+	/* parse vendor_id */
+	runner = *s;
+	while (runner < *e) {
+		/* scan for vendor:device delimiter */
+		if (*runner == ':') {
+			*vendor_id = simple_strtol((char*) *s, (char**) &p, 16);
+			runner = p + 1;
+			break;
+		}
+		runner++;
+	}
+
+	if (! isxdigit(*runner)) {
+		*s = ++runner;
+		return 0;
+	}
+
+	/* parse device_id */
+	if (runner <  *e) {
+		*device_id = simple_strtol((char*) runner, (char**) &p, 16);
+		runner = p;
+	}
+
+	*s = runner;
+
+	return 1;
+}
+
+
+static ssize_t
+edac_pci_list_string_store(void *ptr, const char * buffer, size_t count)
+{
+	struct list_control *listctl;
+	struct edac_pci_device_list *list;
+	unsigned int vendor_id, device_id;
+	const char *s, *e;
+	int *index;
+
+	s = (char*) buffer;
+	e = s + count;
+
+	listctl = (struct list_control *) ptr;
+	list = listctl->list;
+	index = listctl->count;
+
+	*index = 0;
+	while (*index < MAX_LISTED_PCI_DEVICES) {
+	
+		if (parse_one_device(&s,&e,&vendor_id,&device_id)) {
+			list[ *index ].vendor = vendor_id;
+			list[ *index ].device = device_id;
+			(*index)++;
+		}
+
+		/* check for all data consume */
+		if (s >= e)
+			break;
+	}
+
+	return count;
+}
+
+
+
+static ssize_t
+edac_pci_int_show(void *ptr, char * buffer)
+{
+	int *value = (int*) ptr;
+	return sprintf(buffer,"%d\n",*value);
+}
+
+static ssize_t
+edac_pci_int_store(void *ptr, const char * buffer, size_t count)
+{
+	int *value = (int*) ptr;
+
+	if (isdigit(*buffer) ) {
+		*value = simple_strtoul(buffer,NULL,0);
+	}
+
+	return count;	
+}
+
+
+
+struct edac_pci_dev_attribute {
+	struct attribute	attr;
+	void     *value;
+	ssize_t (*show)(void *,char *);
+	ssize_t (*store)(void *, const char *,size_t);
+};
+
+/* Set of show/store abstract level functions for PCI Parity object */
+static ssize_t
+edac_pci_dev_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+	struct edac_pci_dev_attribute *edac_pci_dev;
+	edac_pci_dev= (struct edac_pci_dev_attribute*) attr;
+
+        if (edac_pci_dev->show)
+                return edac_pci_dev->show(edac_pci_dev->value, buffer);
+        return -EIO;
+}
+
+
+static ssize_t
+edac_pci_dev_store(struct kobject * kobj, struct attribute * attr,
+             const char * buffer, size_t count)
+{
+	struct edac_pci_dev_attribute *edac_pci_dev;
+	edac_pci_dev= (struct edac_pci_dev_attribute*) attr;
+
+        if (edac_pci_dev->show)
+                return edac_pci_dev->store(edac_pci_dev->value, buffer, count);
+	return -EIO;
+}
+
+
+static struct sysfs_ops edac_pci_sysfs_ops = {
+        .show   = edac_pci_dev_show,
+        .store  = edac_pci_dev_store
+};
+
+
+
+#define EDAC_PCI_ATTR(_name,_mode,_show,_store)          \
+struct edac_pci_dev_attribute edac_pci_attr_##_name = {                       \
+        .attr = {.name = __stringify(_name), .mode = _mode },   \
+	.value  = &_name,					\
+        .show   = _show,                                        \
+        .store  = _store,                                       \
+};
+
+#define EDAC_PCI_STRING_ATTR(_name,_data,_mode,_show,_store)          \
+struct edac_pci_dev_attribute edac_pci_attr_##_name = {                       \
+        .attr = {.name = __stringify(_name), .mode = _mode },   \
+	.value  = _data,					\
+        .show   = _show,                                        \
+        .store  = _store,                                       \
+};
+
+
+static struct list_control pci_whitelist_control = {
+	.list = pci_whitelist,
+	.count = &pci_whitelist_count
+};
+
+static struct list_control pci_blacklist_control = {
+	.list = pci_blacklist,
+	.count = &pci_blacklist_count
+};
+
+/* whitelist attribute */
+EDAC_PCI_STRING_ATTR(pci_parity_whitelist,
+	&pci_whitelist_control,
+	S_IRUGO|S_IWUSR,
+	edac_pci_list_string_show,
+	edac_pci_list_string_store);
+
+EDAC_PCI_STRING_ATTR(pci_parity_blacklist,
+	&pci_blacklist_control,
+	S_IRUGO|S_IWUSR,
+	edac_pci_list_string_show,
+	edac_pci_list_string_store);
+
+/* PCI Parity control files */
+EDAC_PCI_ATTR(check_pci_parity,S_IRUGO|S_IWUSR,edac_pci_int_show,edac_pci_int_store);
+EDAC_PCI_ATTR(panic_on_pci_parity,S_IRUGO|S_IWUSR,edac_pci_int_show,edac_pci_int_store);
+EDAC_PCI_ATTR(pci_parity_count,S_IRUGO,edac_pci_int_show,NULL);
+
+
+
+/* Base Attributes of the memory ECC object */
+static struct edac_pci_dev_attribute *edac_pci_attr[] = {
+	&edac_pci_attr_check_pci_parity,
+	&edac_pci_attr_panic_on_pci_parity,
+	&edac_pci_attr_pci_parity_count,
+	&edac_pci_attr_pci_parity_whitelist,
+	&edac_pci_attr_pci_parity_blacklist,
+	NULL,
+};
+
+/* No memory to release */
+static void
+edac_pci_release(struct kobject * kobj)
+{
+	debugf1("EDAC PCI: " __FILE__ ": %s()\n", __func__);
+}
+
+
+static struct kobj_type ktype_edac_pci = {
+	.release	= edac_pci_release,
+        .sysfs_ops      = &edac_pci_sysfs_ops,
+	.default_attrs	= (struct attribute **) edac_pci_attr,
+};
+
+
+/**
+ * edac_sysfs_pci_setup()
+ *
+ */
+static int edac_sysfs_pci_setup(void)
+{
+	int err;
+
+	debugf1("MC: " __FILE__ ": %s()\n", __func__);
+
+	memset(&edac_pci_kobj, 0, sizeof (edac_pci_kobj));
+
+	kobject_init(&edac_pci_kobj);
+	edac_pci_kobj.parent = &edac_class.kset.kobj;
+	edac_pci_kobj.ktype = &ktype_edac_pci;
+
+	err = kobject_set_name(&edac_pci_kobj,"pci");
+	if (!err) {
+		/* Instanstiate the csrow object */
+		/* FIXME: maybe new sysdev_create_subdir() */
+		err = kobject_register(&edac_pci_kobj);
+		if (err) {
+			debugf1("Failed to register '.../edac/pci'\n");
+		} else {
+			debugf1("Registered '.../edac/pci' kobject\n");
+		}
+	}
+
+	return err;
+}
+
+
+static void edac_sysfs_pci_teardown(void)
+{
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+
+	kobject_unregister(&edac_pci_kobj);
+	kobject_put(&edac_pci_kobj);
+}
+
+
+
+/* EDAC sysfs  CSROW data structures and methods */
+
+
+/* Set of more detailed csrow<id> attribute show/store functions */
+static ssize_t csrow_ch0_dimm_label_show(struct csrow_info *csrow, char *data)
+{
+	ssize_t size=0;
+
+	if (csrow->nr_channels > 0) {
+		size = snprintf(data, EDAC_MC_LABEL_LEN,"%s\n", 
+			csrow->channels[0].label);
+	}
+	return size;
+}
+
+static ssize_t csrow_ch1_dimm_label_show(struct csrow_info *csrow, char *data)
+{
+	ssize_t size=0;
+
+	if (csrow->nr_channels > 0) {
+		size = snprintf(data, EDAC_MC_LABEL_LEN, "%s\n", 
+			csrow->channels[1].label);
+	}
+	return size;
+}
+
+static ssize_t csrow_ch0_dimm_label_store(struct csrow_info *csrow, 
+			const char *data, size_t size)
+{
+	ssize_t max_size=0;
+
+	if (csrow->nr_channels > 0) {
+		max_size=min((ssize_t)size,(ssize_t)EDAC_MC_LABEL_LEN-1);
+		strncpy( csrow->channels[0].label, data, max_size );
+		csrow->channels[0].label[max_size] = '\0';
+	}
+	return size;
+}
+
+static ssize_t csrow_ch1_dimm_label_store(struct csrow_info *csrow, 
+			const char *data, size_t size)
+{
+	ssize_t max_size=0;
+
+	if (csrow->nr_channels > 1) {
+		max_size=min((ssize_t)size,(ssize_t)EDAC_MC_LABEL_LEN-1);
+		strncpy( csrow->channels[1].label, data, max_size );
+		csrow->channels[1].label[max_size] = '\0';
+	}
+	return max_size;
+}
+
+
+static ssize_t csrow_ue_count_show(struct csrow_info *csrow, char *data)
+{
+	return sprintf(data,"%u\n", csrow->ue_count);
+}
+
+static ssize_t csrow_ce_count_show(struct csrow_info *csrow, char *data)
+{
+	return sprintf(data,"%u\n", csrow->ce_count);
+}
+
+static ssize_t csrow_ch0_ce_count_show(struct csrow_info *csrow, char *data)
+{
+	ssize_t size=0;
+
+	if (csrow->nr_channels > 0) {
+		size = sprintf(data,"%u\n", 
+			csrow->channels[0].ce_count);
+	}
+	return size;
+}
+
+static ssize_t csrow_ch1_ce_count_show(struct csrow_info *csrow, char *data)
+{
+	ssize_t size=0;
+
+	if (csrow->nr_channels > 1) {
+		size = sprintf(data,"%u\n", 
+			csrow->channels[1].ce_count);
+	}
+	return size;
+}
+
+static ssize_t csrow_size_show(struct csrow_info *csrow, char *data)
+{
+	return sprintf(data,"%u\n", PAGES_TO_MiB(csrow->nr_pages));
+}
+
+
+static ssize_t csrow_mem_type_show(struct csrow_info *csrow, char *data)
+{
+	return sprintf(data,"%s\n", mem_types[csrow->mtype]);
+}
+
+static ssize_t csrow_dev_type_show(struct csrow_info *csrow, char *data)
+{
+	return sprintf(data,"%s\n", dev_types[csrow->dtype]);
+}
+
+static ssize_t csrow_edac_mode_show(struct csrow_info *csrow, char *data)
+{
+	return sprintf(data,"%s\n", edac_caps[csrow->edac_mode]);
+}
+
+
+
+
+struct csrowdev_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct csrow_info *,char *);
+	ssize_t (*store)(struct csrow_info *, const char *,size_t);
+};
+
+
+
+#define to_csrow(k) container_of(k, struct csrow_info, kobj)
+#define to_csrowdev_attr(a) container_of(a, struct csrowdev_attribute, attr)
+
+/* Set of show/store higher level functions for csrow objects */
+static ssize_t
+csrowdev_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+        struct csrow_info *csrow = to_csrow(kobj);
+        struct csrowdev_attribute * csrowdev_attr = to_csrowdev_attr(attr);
+
+        if (csrowdev_attr->show)
+                return csrowdev_attr->show(csrow, buffer);
+        return -EIO;
+}
+
+
+static ssize_t
+csrowdev_store(struct kobject * kobj, struct attribute * attr,
+             const char * buffer, size_t count)
+{
+        struct csrow_info *csrow = to_csrow(kobj);
+        struct csrowdev_attribute * csrowdev_attr = to_csrowdev_attr(attr);
+
+        if (csrowdev_attr->store)
+                return csrowdev_attr->store(csrow, buffer, count);
+        return -EIO;
+}
+
+static struct sysfs_ops csrowfs_ops = {
+        .show   = csrowdev_show,
+        .store  = csrowdev_store
+};
+
+
+#define CSROWDEV_ATTR(_name,_mode,_show,_store)          \
+struct csrowdev_attribute attr_##_name = {                       \
+        .attr = {.name = __stringify(_name), .mode = _mode },   \
+        .show   = _show,                                        \
+        .store  = _store,                                       \
+};
+
+/* cwrow<id>/attribute files */
+CSROWDEV_ATTR(size_mb,S_IRUGO,csrow_size_show,NULL);
+CSROWDEV_ATTR(dev_type,S_IRUGO,csrow_dev_type_show,NULL);
+CSROWDEV_ATTR(mem_type,S_IRUGO,csrow_mem_type_show,NULL);
+CSROWDEV_ATTR(edac_mode,S_IRUGO,csrow_edac_mode_show,NULL);
+CSROWDEV_ATTR(ue_count,S_IRUGO,csrow_ue_count_show,NULL);
+CSROWDEV_ATTR(ce_count,S_IRUGO,csrow_ce_count_show,NULL);
+CSROWDEV_ATTR(ch0_ce_count,S_IRUGO,csrow_ch0_ce_count_show,NULL);
+CSROWDEV_ATTR(ch1_ce_count,S_IRUGO,csrow_ch1_ce_count_show,NULL);
+
+/* control/attribute files */
+CSROWDEV_ATTR(ch0_dimm_label,S_IRUGO|S_IWUSR, 
+		csrow_ch0_dimm_label_show,
+		csrow_ch0_dimm_label_store);
+CSROWDEV_ATTR(ch1_dimm_label,S_IRUGO|S_IWUSR,
+		csrow_ch1_dimm_label_show,
+		csrow_ch1_dimm_label_store);
+
+
+
+/* Attributes of the CSROW<id> object */
+static struct csrowdev_attribute *csrow_attr[] = {
+	&attr_dev_type,
+	&attr_mem_type,
+	&attr_edac_mode,
+	&attr_size_mb,
+	&attr_ue_count,
+	&attr_ce_count,
+	&attr_ch0_ce_count,
+	&attr_ch1_ce_count,
+	&attr_ch0_dimm_label,
+	&attr_ch1_dimm_label,
+	NULL,
+};
+
+
+/* No memory to release */
+static void
+edac_csrow_instance_release(struct kobject * kobj)
+{
+	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
+}
+
+
+static struct kobj_type ktype_csrow = {
+	.release	= edac_csrow_instance_release,
+        .sysfs_ops      = &csrowfs_ops,
+	.default_attrs	= (struct attribute **) csrow_attr,
+};
+
+
+/* Create a CSROW object under specifed edac_mc_device */
+static inline int edac_create_csrow_object( 
+			struct kobject *edac_mci_kobj, 
+			struct csrow_info *csrow, 
+			int index )
+{	
+	int err=0;
+
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
+
+	memset(&csrow->kobj, 0, sizeof (csrow->kobj));
+
+	/* generate ..../edac/mc/mc<id>/csrow<index>   */
+
+	kobject_init(&csrow->kobj);
+	csrow->kobj.parent = edac_mci_kobj;
+	csrow->kobj.ktype = &ktype_csrow;
+	
+	/* name this instance of csrow<id> */
+	err = kobject_set_name(&csrow->kobj,"csrow%d",index);
+	if (!err) {
+		/* Instanstiate the csrow object */
+		err = kobject_register(&csrow->kobj);
+		if (err) {
+			debugf0("Failed to register CSROW%d\n",index);
+		} else {
+			debugf0("Registered CSROW%d\n",index);
+		}
+	}
+
+	return err;
+}
+
+
+/* sysfs data structures and methods for the MCI kobjects */
+
+
+static ssize_t mci_reset_counters_store(struct mem_ctl_info  *mci, 
+	const char *data,size_t count )
+{
+	int row,chan;
+	
+        mci->ue_noinfo_count = 0;
+        mci->ce_noinfo_count = 0;
+        mci->ue_count = 0;
+        mci->ce_count = 0;
+        for (row = 0; row < mci->nr_csrows; row++) {
+                struct csrow_info *ri = &mci->csrows[row];
+
+                ri->ue_count = 0;
+                ri->ce_count = 0;
+                for (chan = 0; chan < ri->nr_channels; chan++)
+                        ri->channels[chan].ce_count = 0;
+        }
+        mci->start_time = jiffies;
+
+	return count;
+}
+
+
+static ssize_t mci_ue_count_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%d\n", mci->ue_count);
+}
+
+static ssize_t mci_ce_count_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%d\n", mci->ce_count);
+}
+
+static ssize_t mci_ce_noinfo_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%d\n", mci->ce_noinfo_count);
+}
+
+static ssize_t mci_ue_noinfo_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%d\n", mci->ue_noinfo_count);
+}
+
+static ssize_t mci_seconds_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%ld\n", (jiffies - mci->start_time) / HZ);
+}
+
 
+static ssize_t mci_mod_name_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%s %s\n", mci->mod_name, mci->mod_ver);
+}
 
-/* lock to memory controller's control array */
-static DECLARE_MUTEX(mem_ctls_mutex);
+static ssize_t mci_ctl_name_show(struct mem_ctl_info  *mci, char *data)
+{
+	return sprintf(data,"%s\n", mci->ctl_name);
+}
 
-static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
 
-#ifdef CONFIG_SYSCTL
+static inline int mci_output_edac_cap(char *buf, unsigned long edac_cap)
+{
+        char *p = buf;
+        int bit_idx;
 
+        for (bit_idx = 0; bit_idx < 8 * sizeof(edac_cap); bit_idx++) {
+                if ((edac_cap >> bit_idx) & 0x1)
+                        p += sprintf(p, "%s ", edac_caps[bit_idx]);
+        }
 
-static ctl_table mc_table[] = {
-	{-1, "panic_on_ue", &panic_on_ue,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-	{-2, "log_ue", &log_ue,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-	{-3, "log_ce", &log_ce,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-	{-4, "poll_msec", &poll_msec,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-	{-7, "panic_on_pci_parity", &panic_on_pci_parity,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-	{-8, "check_pci_parity", &check_pci_parity,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-#ifdef CONFIG_EDAC_DEBUG
-	{-9, "debug_level", &edac_debug_level,
-	 sizeof(int), 0644, NULL, proc_dointvec},
-#endif
-	{0}
-};
+        return p - buf;
+}
 
 
-static ctl_table mc_root_table[] = {
-	{CTL_DEBUG, MC_PROC_DIR, NULL, 0, 0555, mc_table},
-	{0}
-};
+static ssize_t mci_edac_capability_show(
+	struct mem_ctl_info  *mci, char *data)
+{
+	char *p=data;
 
+	p += mci_output_edac_cap(p,mci->edac_ctl_cap);
+	p += sprintf(p, "\n");
 
-static struct ctl_table_header *mc_sysctl_header = NULL;
-#endif				/* CONFIG_SYSCTL */
+	return p - data;
+}
 
+static ssize_t mci_edac_current_capability_show(
+	struct mem_ctl_info  *mci, char *data)
+{
+	char *p=data;
 
-#ifdef CONFIG_PROC_FS
-static const char *mem_types[] = {
-	[MEM_EMPTY] = "Empty",
-	[MEM_RESERVED] = "Reserved",
-	[MEM_UNKNOWN] = "Unknown",
-	[MEM_FPM] = "FPM",
-	[MEM_EDO] = "EDO",
-	[MEM_BEDO] = "BEDO",
-	[MEM_SDR] = "Unbuffered-SDR",
-	[MEM_RDR] = "Registered-SDR",
-	[MEM_DDR] = "Unbuffered-DDR",
-	[MEM_RDDR] = "Registered-DDR",
-	[MEM_RMBS] = "RMBS"
-};
+	p += mci_output_edac_cap(p,mci->edac_cap);
+	p += sprintf(p, "\n");
 
-static const char *dev_types[] = {
-	[DEV_UNKNOWN] = "Unknown",
-	[DEV_X1] = "x1",
-	[DEV_X2] = "x2",
-	[DEV_X4] = "x4",
-	[DEV_X8] = "x8",
-	[DEV_X16] = "x16",
-	[DEV_X32] = "x32",
-	[DEV_X64] = "x64"
-};
+	return p - data;
+}
 
-static const char *edac_caps[] = {
-	[EDAC_UNKNOWN] = "Unknown",
-	[EDAC_NONE] = "None",
-	[EDAC_RESERVED] = "Reserved",
-	[EDAC_PARITY] = "PARITY",
-	[EDAC_EC] = "EC",
-	[EDAC_SECDED] = "SECDED",
-	[EDAC_S2ECD2ED] = "S2ECD2ED",
-	[EDAC_S4ECD4ED] = "S4ECD4ED",
-	[EDAC_S8ECD8ED] = "S8ECD8ED",
-	[EDAC_S16ECD16ED] = "S16ECD16ED"
-};
 
+static inline int mci_output_mtype_cap(char *buf,
+                                           unsigned long mtype_cap)
+{
+        char *p = buf;
+        int bit_idx;
 
-/* FIXME - CHANNEL_PREFIX is pretty bad */
-#define CHANNEL_PREFIX(...) \
-	do { \
-		p += sprintf(p, "%d.%d:%s", \
-			chan->csrow->csrow_idx, \
-			chan->chan_idx, \
-			chan->label); \
-		p += sprintf(p, ":" __VA_ARGS__); \
-	} while (0)
+        for (bit_idx = 0; bit_idx < 8 * sizeof(mtype_cap); bit_idx++) {
+                if ((mtype_cap >> bit_idx) & 0x1)
+                        p += sprintf(p, "%s ", mem_types[bit_idx]);
+        }
 
+        return p - buf;
+}
 
-static inline int mc_proc_output_channel(char *buf,
-					 struct channel_info *chan)
+static ssize_t mci_supported_mem_type_show(
+	struct mem_ctl_info  *mci, char *data)
 {
-	char *p = buf;
+	char *p=data;
 
-	CHANNEL_PREFIX("CE:\t\t%d\n", chan->ce_count);
-	return p - buf;
+	p += mci_output_mtype_cap(p,mci->mtype_cap);
+	p += sprintf(p, "\n");
+
+	return p - data;
 }
 
-#undef CHANNEL_PREFIX
+static ssize_t mci_size_mb_show(
+	struct mem_ctl_info  *mci, char *data)
+{
+	int total_pages, csrow_idx;
 
+        for (total_pages = csrow_idx = 0; csrow_idx < mci->nr_csrows;
+             csrow_idx++) {
+                struct csrow_info *csrow = &mci->csrows[csrow_idx];
 
-#define CSROW_PREFIX(...) \
-	do { \
-		int i; \
-		p += sprintf(p, "%d:", csrow->csrow_idx); \
-		p += sprintf(p, "%s", csrow->channels[0].label); \
-		for (i = 1; i < csrow->nr_channels; i++) \
-			p += sprintf(p, "|%s", csrow->channels[i].label); \
-		p += sprintf(p, ":" __VA_ARGS__); \
-	} while (0)
+                if (!csrow->nr_pages)
+                        continue;
+                total_pages += csrow->nr_pages;
+        }
 
+	return sprintf(data,"%u\n", PAGES_TO_MiB(total_pages));
+}
 
-static inline int mc_proc_output_csrow(char *buf, struct csrow_info *csrow)
-{
-	char *p = buf;
-	int chan_idx;
 
-	debugf3("MC: " __FILE__ ": %s()\n", __func__);
 
-	CSROW_PREFIX("Memory Size:\t%d MiB\n",
-		     (u32) PAGES_TO_MiB(csrow->nr_pages));
-	CSROW_PREFIX("Mem Type:\t\t%s\n", mem_types[csrow->mtype]);
-	CSROW_PREFIX("Dev Type:\t\t%s\n", dev_types[csrow->dtype]);
-	CSROW_PREFIX("EDAC Mode:\t\t%s\n", edac_caps[csrow->edac_mode]);
-	CSROW_PREFIX("UE:\t\t\t%d\n", csrow->ue_count);
-	CSROW_PREFIX("CE:\t\t\t%d\n", csrow->ce_count);
 
-	for (chan_idx = 0; chan_idx < csrow->nr_channels; chan_idx++)
-		p += mc_proc_output_channel(p, &csrow->channels[chan_idx]);
+struct mcidev_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct mem_ctl_info *,char *);
+	ssize_t (*store)(struct mem_ctl_info *, const char *,size_t);
+};
 
-	p += sprintf(p, "\n");
-	return p - buf;
-}
+#define to_mci(k) container_of(k, struct mem_ctl_info, edac_mci_kobj)
+#define to_mcidev_attr(a) container_of(a, struct mcidev_attribute, attr)
 
-#undef CSROW_PREFIX
+static ssize_t
+mcidev_show(struct kobject * kobj, struct attribute * attr, char * buffer)
+{
+        struct mem_ctl_info *mem_ctl_info = to_mci(kobj);
+        struct mcidev_attribute * mcidev_attr = to_mcidev_attr(attr);
 
+        if (mcidev_attr->show)
+                return mcidev_attr->show(mem_ctl_info, buffer);
+        return -EIO;
+}
 
-static inline int mc_proc_output_edac_cap(char *buf,
-					  unsigned long edac_cap)
+static ssize_t
+mcidev_store(struct kobject * kobj, struct attribute * attr,
+             const char * buffer, size_t count)
 {
-	char *p = buf;
-	int bit_idx;
-
-	for (bit_idx = 0; bit_idx < 8 * sizeof(edac_cap); bit_idx++) {
-		if ((edac_cap >> bit_idx) & 0x1)
-			p += sprintf(p, "%s ", edac_caps[bit_idx]);
-	}
+        struct mem_ctl_info *mem_ctl_info = to_mci(kobj);
+        struct mcidev_attribute * mcidev_attr = to_mcidev_attr(attr);
 
-	return p - buf;
+        if (mcidev_attr->store)
+                return mcidev_attr->store(mem_ctl_info, buffer, count);
+        return -EIO;
 }
 
 
-static inline int mc_proc_output_mtype_cap(char *buf,
-					   unsigned long mtype_cap)
+static struct sysfs_ops mci_ops = {
+        .show   = mcidev_show,
+        .store  = mcidev_store
+};
+
+
+#define MCIDEV_ATTR(_name,_mode,_show,_store)          \
+struct mcidev_attribute mci_attr_##_name = {                       \
+        .attr = {.name = __stringify(_name), .mode = _mode },   \
+        .show   = _show,                                        \
+        .store  = _store,                                       \
+};
+
+
+/* Control file */
+MCIDEV_ATTR(reset_counters,S_IWUSR,NULL,mci_reset_counters_store);
+
+/* Attribute files */
+MCIDEV_ATTR(mc_name,S_IRUGO,mci_ctl_name_show,NULL);
+MCIDEV_ATTR(module_name,S_IRUGO,mci_mod_name_show,NULL);
+MCIDEV_ATTR(edac_capability,S_IRUGO,mci_edac_capability_show,NULL);
+MCIDEV_ATTR(size_mb,S_IRUGO,mci_size_mb_show,NULL);
+MCIDEV_ATTR(seconds_since_reset,S_IRUGO,mci_seconds_show,NULL);
+MCIDEV_ATTR(ue_noinfo_count,S_IRUGO,mci_ue_noinfo_show,NULL);
+MCIDEV_ATTR(ce_noinfo_count,S_IRUGO,mci_ce_noinfo_show,NULL);
+MCIDEV_ATTR(ue_count,S_IRUGO,mci_ue_count_show,NULL);
+MCIDEV_ATTR(ce_count,S_IRUGO,mci_ce_count_show,NULL);
+MCIDEV_ATTR(edac_current_capability,S_IRUGO,
+	mci_edac_current_capability_show,NULL);
+MCIDEV_ATTR(supported_mem_type,S_IRUGO,
+	mci_supported_mem_type_show,NULL);
+
+
+
+
+static struct mcidev_attribute *mci_attr[] = {
+	&mci_attr_reset_counters,
+	&mci_attr_module_name,
+	&mci_attr_mc_name,
+	&mci_attr_edac_capability,
+	&mci_attr_edac_current_capability,
+	&mci_attr_supported_mem_type,
+	&mci_attr_size_mb,
+	&mci_attr_seconds_since_reset,
+	&mci_attr_ue_noinfo_count,
+	&mci_attr_ce_noinfo_count,
+	&mci_attr_ue_count,
+	&mci_attr_ce_count,
+	NULL
+};
+
+
+/*
+ * Release of a MC controlling instance
+ */
+static void
+edac_mci_instance_release(struct kobject * kobj)
 {
-	char *p = buf;
-	int bit_idx;
+	struct mem_ctl_info *mci;
+	mci = container_of(kobj,struct mem_ctl_info,edac_mci_kobj);
 
-	for (bit_idx = 0; bit_idx < 8 * sizeof(mtype_cap); bit_idx++) {
-		if ((mtype_cap >> bit_idx) & 0x1)
-			p += sprintf(p, "%s ", mem_types[bit_idx]);
-	}
+	debugf0("MC: " __FILE__ ": %s() idx=%d calling kfree\n", __func__, mci->mc_idx);
 
-	return p - buf;
+	kfree(mci);
 }
 
 
-static int mc_proc_output(struct mem_ctl_info *mci, char *buf)
-{
-	int csrow_idx;
-	u32 total_pages;
-	char *p = buf;
+static struct kobj_type ktype_mci = {
+	.release	= edac_mci_instance_release,
+        .sysfs_ops      = &mci_ops,
+	.default_attrs	= (struct attribute **) mci_attr,
+};
 
-	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
 
-	p += sprintf(p, "Check PCI Parity:\t%d\n", check_pci_parity);
-	p += sprintf(p, "Panic PCI Parity:\t%d\n", panic_on_pci_parity);
-	p += sprintf(p, "Panic UE:\t\t%d\n", panic_on_ue);
-	p += sprintf(p, "Log UE:\t\t\t%d\n", log_ue);
-	p += sprintf(p, "Log CE:\t\t\t%d\n", log_ce);
-	p += sprintf(p, "Poll msec:\t\t%d\n", poll_msec);
+#define EDAC_DEVICE_SYMLINK	"device"
 
-	p += sprintf(p, "\n");
+/*
+ * Create a new Memory Controller kobject instance, 
+ *	mc<id> under the 'mc' directory
+ *
+ * Return:
+ *	0	Success
+ *	!0	Failure
+ */
+static int edac_create_sysfs_mci_device(struct mem_ctl_info *mci) 
+{
+	int i;
+	int err;
+	struct csrow_info *csrow;
+	struct kobject  *edac_mci_kobj=&mci->edac_mci_kobj;
+
+	debugf0("MC: " __FILE__ ": %s() idx=%d\n", __func__, mci->mc_idx);
+
+	memset(edac_mci_kobj, 0, sizeof (*edac_mci_kobj));
+	kobject_init(edac_mci_kobj);
+
+	/* set the name of the mc<id> object */
+	err = kobject_set_name(edac_mci_kobj,"mc%d",mci->mc_idx);
+	if (err)
+		return err;
+
+	/* link to our parent the '..../edac/mc' object */
+	edac_mci_kobj->parent = &edac_memctrl_kobj;
+	edac_mci_kobj->ktype = &ktype_mci;
+
+	/* register the mc<id> kobject */
+	err = kobject_register(edac_mci_kobj);
+	if (err) 
+		return err;
+
+	/* create a symlink for the device */
+	err = sysfs_create_link(
+			edac_mci_kobj,
+			&mci->pdev->dev.kobj,
+			EDAC_DEVICE_SYMLINK);
+	if (err) {
+		kobject_unregister(edac_mci_kobj);
+		return err;
+	}
 
-	p += sprintf(p, "MC Core:\t\t%s\n", EDAC_MC_VERSION );
-	p += sprintf(p, "MC Module:\t\t%s %s\n", mci->mod_name,
-		     mci->mod_ver);
-	p += sprintf(p, "Memory Controller:\t%s\n", mci->ctl_name);
-	p += sprintf(p, "PCI Bus ID:\t\t%s (%s)\n", mci->pdev->dev.bus_id,
-		     pci_name(mci->pdev));
+	/* Make directories for each CSROW object 
+	 * under the mc<id> kobject
+	 */
+	for (i = 0; i < mci->nr_csrows; i++) {
 
-	p += sprintf(p, "EDAC capability:\t");
-	p += mc_proc_output_edac_cap(p, mci->edac_ctl_cap);
-	p += sprintf(p, "\n");
+		csrow = &mci->csrows[i];
 
-	p += sprintf(p, "Current EDAC capability:\t");
-	p += mc_proc_output_edac_cap(p, mci->edac_cap);
-	p += sprintf(p, "\n");
+		/* Only expose populated CSROWs */
+		if (csrow->nr_pages > 0) {
+			err = edac_create_csrow_object(edac_mci_kobj,csrow,i);
+			if (err)
+				goto fail;
+		}
+	}
 
-	p += sprintf(p, "Supported Mem Types:\t");
-	p += mc_proc_output_mtype_cap(p, mci->mtype_cap);
-	p += sprintf(p, "\n");
+	/* Mark this MCI instance as having sysfs entries */
+	mci->sysfs_active = MCI_SYSFS_ACTIVE;
 
-	p += sprintf(p, "\n");
+	return 0;
 
-	for (total_pages = csrow_idx = 0; csrow_idx < mci->nr_csrows;
-	     csrow_idx++) {
-		struct csrow_info *csrow = &mci->csrows[csrow_idx];
 
-		if (!csrow->nr_pages)
-			continue;
-		total_pages += csrow->nr_pages;
-		p += mc_proc_output_csrow(p, csrow);
+	/* CSROW error: backout what has already been registered,  */
+fail:
+	for ( i--; i >= 0; i--) {
+		if (csrow->nr_pages > 0) {
+			kobject_unregister(&mci->csrows[i].kobj);
+			kobject_put(&mci->csrows[i].kobj);
+		}
 	}
 
-	p += sprintf(p, "Total Memory Size:\t%d MiB\n",
-		     (u32) PAGES_TO_MiB(total_pages));
-	p += sprintf(p, "Seconds since reset:\t%ld\n",
-		     (jiffies - mci->start_time) / HZ);
-	p += sprintf(p, "UE No Info:\t\t%d\n", mci->ue_noinfo_count);
-	p += sprintf(p, "CE No Info:\t\t%d\n", mci->ce_noinfo_count);
-	p += sprintf(p, "Total UE:\t\t%d\n", mci->ue_count);
-	p += sprintf(p, "Total CE:\t\t%d\n", mci->ce_count);
-	p += sprintf(p, "Total PCI Parity:\t%u\n\n", pci_parity_count);
-	return p - buf;
+	kobject_unregister(edac_mci_kobj);
+	kobject_put(edac_mci_kobj);
+
+	return err;
 }
 
 
-static int mc_read_proc(char *page, char **start, off_t off, int count,
-			int *eof, void *data)
+/*
+ * remove a Memory Controller instance
+ */
+static void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci) 
 {
-	int len;
-	struct mem_ctl_info *mci = (struct mem_ctl_info *) data;
+	int i;
 
-	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
+	debugf0("MC: " __FILE__ ": %s()\n", __func__);
 
-	down(&mem_ctls_mutex);
-	len = mc_proc_output(mci, page);
-	up(&mem_ctls_mutex);
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
+	/* remove all csrow kobjects */
+	for (i = 0; i < mci->nr_csrows; i++) {
+		if (mci->csrows[i].nr_pages > 0)  {
+			kobject_unregister(&mci->csrows[i].kobj);
+			kobject_put(&mci->csrows[i].kobj);
+		}
+	}
+
+	sysfs_remove_link(&mci->edac_mci_kobj, EDAC_DEVICE_SYMLINK);
 
-	return len;
+	kobject_unregister(&mci->edac_mci_kobj);
+	kobject_put(&mci->edac_mci_kobj);
 }
-#endif				/* CONFIG_PROC_FS */
+
+/* END OF sysfs data and methods */
 
 
-#ifdef CONFIG_EDAC_DEBUG
 
+#ifdef CONFIG_EDAC_DEBUG
 
 EXPORT_SYMBOL(edac_mc_dump_channel);
 
 void edac_mc_dump_channel(struct channel_info *chan)
 {
-	printk(KERN_INFO "\tchannel = %p\n", chan);
-	printk(KERN_INFO "\tchannel->chan_idx = %d\n", chan->chan_idx);
-	printk(KERN_INFO "\tchannel->ce_count = %d\n", chan->ce_count);
-	printk(KERN_INFO "\tchannel->label = '%s'\n", chan->label);
-	printk(KERN_INFO "\tchannel->csrow = %p\n\n", chan->csrow);
+	debugf4( "\tchannel = %p\n", chan);
+	debugf4( "\tchannel->chan_idx = %d\n", chan->chan_idx);
+	debugf4( "\tchannel->ce_count = %d\n", chan->ce_count);
+	debugf4( "\tchannel->label = '%s'\n", chan->label);
+	debugf4( "\tchannel->csrow = %p\n\n", chan->csrow);
 }
 
 
@@ -334,17 +1270,17 @@ EXPORT_SYMBOL(edac_mc_dump_csrow);
 
 void edac_mc_dump_csrow(struct csrow_info *csrow)
 {
-	printk(KERN_INFO "\tcsrow = %p\n", csrow);
-	printk(KERN_INFO "\tcsrow->csrow_idx = %d\n", csrow->csrow_idx);
-	printk(KERN_INFO "\tcsrow->first_page = 0x%lx\n",
+	debugf4( "\tcsrow = %p\n", csrow);
+	debugf4( "\tcsrow->csrow_idx = %d\n", csrow->csrow_idx);
+	debugf4( "\tcsrow->first_page = 0x%lx\n",
 	       csrow->first_page);
-	printk(KERN_INFO "\tcsrow->last_page = 0x%lx\n", csrow->last_page);
-	printk(KERN_INFO "\tcsrow->page_mask = 0x%lx\n", csrow->page_mask);
-	printk(KERN_INFO "\tcsrow->nr_pages = 0x%x\n", csrow->nr_pages);
-	printk(KERN_INFO "\tcsrow->nr_channels = %d\n",
+	debugf4( "\tcsrow->last_page = 0x%lx\n", csrow->last_page);
+	debugf4( "\tcsrow->page_mask = 0x%lx\n", csrow->page_mask);
+	debugf4( "\tcsrow->nr_pages = 0x%x\n", csrow->nr_pages);
+	debugf4( "\tcsrow->nr_channels = %d\n",
 	       csrow->nr_channels);
-	printk(KERN_INFO "\tcsrow->channels = %p\n", csrow->channels);
-	printk(KERN_INFO "\tcsrow->mci = %p\n\n", csrow->mci);
+	debugf4( "\tcsrow->channels = %p\n", csrow->channels);
+	debugf4( "\tcsrow->mci = %p\n\n", csrow->mci);
 }
 
 
@@ -352,17 +1288,17 @@ EXPORT_SYMBOL(edac_mc_dump_mci);
 
 void edac_mc_dump_mci(struct mem_ctl_info *mci)
 {
-	printk(KERN_INFO "\tmci = %p\n", mci);
-	printk(KERN_INFO "\tmci->mtype_cap = %lx\n", mci->mtype_cap);
-	printk(KERN_INFO "\tmci->edac_ctl_cap = %lx\n", mci->edac_ctl_cap);
-	printk(KERN_INFO "\tmci->edac_cap = %lx\n", mci->edac_cap);
-	printk(KERN_INFO "\tmci->edac_check = %p\n", mci->edac_check);
-	printk(KERN_INFO "\tmci->nr_csrows = %d, csrows = %p\n",
+	debugf3( "\tmci = %p\n", mci);
+	debugf3( "\tmci->mtype_cap = %lx\n", mci->mtype_cap);
+	debugf3( "\tmci->edac_ctl_cap = %lx\n", mci->edac_ctl_cap);
+	debugf3( "\tmci->edac_cap = %lx\n", mci->edac_cap);
+	debugf4( "\tmci->edac_check = %p\n", mci->edac_check);
+	debugf3( "\tmci->nr_csrows = %d, csrows = %p\n",
 	       mci->nr_csrows, mci->csrows);
-	printk(KERN_INFO "\tpdev = %p\n", mci->pdev);
-	printk(KERN_INFO "\tmod_name:ctl_name = %s:%s\n",
+	debugf3( "\tpdev = %p\n", mci->pdev);
+	debugf3( "\tmod_name:ctl_name = %s:%s\n",
 	       mci->mod_name, mci->ctl_name);
-	printk(KERN_INFO "\tpvt_info = %p\n\n", mci->pvt_info);
+	debugf3( "\tpvt_info = %p\n\n", mci->pvt_info);
 }
 
 
@@ -405,11 +1341,21 @@ static inline char * align_ptr (void *pt
 
 EXPORT_SYMBOL(edac_mc_alloc);
 
-/* Everything is kmalloc'ed as one big chunk - more efficient.
+/**
+ * edac_mc_alloc: Allocate a struct mem_ctl_info structure
+ * @size_pvt:	size of private storage needed
+ * @nr_csrows:	Number of CWROWS needed for this MC
+ * @nr_chans:	Number of channels for the MC
+ *
+ * Everything is kmalloc'ed as one big chunk - more efficient.
  * Only can be used if all structures have the same lifetime - otherwise
  * you have to allocate and initialize your own structures.
  *
  * Use edac_mc_free() to free mc structures allocated by this function.
+ *
+ * Returns:
+ *	NULL allocation failed
+ *	struct mem_ctl_info pointer
  */
 struct mem_ctl_info *edac_mc_alloc(unsigned sz_pvt, unsigned nr_csrows,
 					unsigned nr_chans)
@@ -444,7 +1390,8 @@ struct mem_ctl_info *edac_mc_alloc(unsig
 	chi = (struct channel_info *) (((char *) mci) + ((unsigned long) chi));
 	pvt = sz_pvt ? (((char *) mci) + ((unsigned long) pvt)) : NULL;
 
-	memset(mci, 0, size);
+	memset(mci, 0, size);	/* clear all fields */
+
 	mci->csrows = csi;
 	mci->pvt_info = pvt;
 	mci->nr_csrows = nr_csrows;
@@ -467,6 +1414,41 @@ struct mem_ctl_info *edac_mc_alloc(unsig
 	return mci;
 }
 
+
+EXPORT_SYMBOL(edac_mc_free);
+
+/**
+ * edac_mc_free:  Free a previously allocated 'mci' structure
+ * @mci: pointer to a struct mem_ctl_info structure
+ *
+ * Free up a previously allocated mci structure
+ * A MCI structure can be in 2 states after being allocated
+ * by edac_mc_alloc().
+ *	1) Allocated in a MC driver's probe, but not yet committed
+ *	2) Allocated and committed, by a call to  edac_mc_add_mc()
+ * edac_mc_add_mc() is the function that adds the sysfs entries
+ * thus, this free function must determine which state the 'mci'
+ * structure is in, then either free it directly or 
+ * perform kobject cleanup by calling edac_remove_sysfs_mci_device().
+ *
+ * VOID Return
+ */
+void edac_mc_free(struct mem_ctl_info *mci)
+{
+	/* only if sysfs entries for this mci instance exist 
+	 * do we remove them and defer the actual kfree via
+	 * the kobject 'release()' callback.
+ 	 *
+	 * Otherwise, do a straight kfree now.
+	 */
+	if (mci->sysfs_active == MCI_SYSFS_ACTIVE)
+		edac_remove_sysfs_mci_device(mci);
+	else
+		kfree(mci);
+}
+
+
+
 EXPORT_SYMBOL(edac_mc_find_mci_by_pdev);
 
 struct mem_ctl_info *edac_mc_find_mci_by_pdev(struct pci_dev *pdev)
@@ -498,7 +1480,7 @@ static int add_mc_to_global_list (struct
 	} else {
 		if (edac_mc_find_mci_by_pdev(mci->pdev)) {
 			printk(KERN_WARNING
-			       "MC: %s (%s) %s %s already assigned %d\n",
+			       "EDAC MC: %s (%s) %s %s already assigned %d\n",
 			       mci->pdev->dev.bus_id, pci_name(mci->pdev),
 			       mci->mod_name, mci->ctl_name, mci->mc_idx);
 			return 1;
@@ -528,8 +1510,19 @@ static int add_mc_to_global_list (struct
 	return 0;
 }
 
+
+
 EXPORT_SYMBOL(edac_mc_add_mc);
 
+/**
+ * edac_mc_add_mc: Insert the 'mci' structure into the mci global list 
+ * @mci: pointer to the mci structure to be added to the list
+ *
+ * Return:
+ *	0	Success
+ *	!0	Failure
+ */
+
 /* FIXME - should a warning be printed if no error detection? correction? */
 int edac_mc_add_mc(struct mem_ctl_info *mci)
 {
@@ -537,9 +1530,9 @@ int edac_mc_add_mc(struct mem_ctl_info *
 
 	debugf0("MC: " __FILE__ ": %s()\n", __func__);
 #ifdef CONFIG_EDAC_DEBUG
-	if (edac_debug_level >= 1)
+	if (edac_debug_level >= 3)
 		edac_mc_dump_mci(mci);
-	if (edac_debug_level >= 2) {
+	if (edac_debug_level >= 4) {
 		int i;
 
 		for (i = 0; i < mci->nr_csrows; i++) {
@@ -556,31 +1549,23 @@ int edac_mc_add_mc(struct mem_ctl_info *
 	if (add_mc_to_global_list(mci))
 		goto finish;
 
-	printk(KERN_INFO
-	       "MC%d: Giving out device to %s %s: PCI %s (%s)\n",
-	       mci->mc_idx, mci->mod_name, mci->ctl_name,
-	       mci->pdev->dev.bus_id, pci_name(mci->pdev));
-
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
-	if (snprintf(mci->proc_name, MC_PROC_NAME_MAX_LEN,
-		     "%d", mci->mc_idx) == MC_PROC_NAME_MAX_LEN) {
-		printk(KERN_WARNING
-		       "MC%d: proc entry too long for device\n",
-		       mci->mc_idx);
+        if (edac_create_sysfs_mci_device(mci)) {
+                printk(KERN_WARNING
+                       "EDAC MC%d: failed to create sysfs device\n",
+                       mci->mc_idx);
 		/* FIXME - should there be an error code and unwind? */
-		goto finish;
-	}
+                goto finish;
+        }
+
+	/* Report action taken */
+	printk(KERN_INFO
+	       "EDAC MC%d: Giving out device to %s %s: PCI %s\n",
+	       mci->mc_idx, mci->mod_name, mci->ctl_name,
+	       pci_name(mci->pdev));
 
-	if(create_proc_read_entry(mci->proc_name, 0, proc_mc,
-	                          mc_read_proc, (void *) mci) == NULL) {
-		printk(KERN_WARNING
-		       "MC%d: failed to create proc entry for controller\n",
-		       mci->mc_idx);
-		/* FIXME - should there be an error code and unwind? */
-		goto finish;
-	}
 
 	rc = 0;
 
@@ -589,6 +1574,8 @@ finish:
 	return rc;
 }
 
+
+
 static void complete_mc_list_del (struct rcu_head *head)
 {
 	struct mem_ctl_info *mci;
@@ -608,6 +1595,14 @@ static void del_mc_from_global_list (str
 
 EXPORT_SYMBOL(edac_mc_del_mc);
 
+/**
+ * edac_mc_del_mc:  Remove the specified mci structure from global list
+ * @mci:	Pointer to struct mem_ctl_info structure
+ *
+ * Returns:
+ *	0	Success
+ *	1 	Failure
+ */
 int edac_mc_del_mc(struct mem_ctl_info *mci)
 {
 	int rc = 1;
@@ -615,13 +1610,13 @@ int edac_mc_del_mc(struct mem_ctl_info *
 	debugf0("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
 	down(&mem_ctls_mutex);
 	del_mc_from_global_list(mci);
-	remove_proc_entry(mci->proc_name, proc_mc);
 	printk(KERN_INFO
-	       "MC%d: Removed device %d for %s %s: PCI %s (%s)\n",
+	       "EDAC MC%d: Removed device %d for %s %s: PCI %s\n",
 	       mci->mc_idx, mci->mc_idx, mci->mod_name, mci->ctl_name,
-	       mci->pdev->dev.bus_id, pci_name(mci->pdev));
+	       pci_name(mci->pdev));
 	rc = 0;
 	up(&mem_ctls_mutex);
+
 	return rc;
 }
 
@@ -696,7 +1691,7 @@ int edac_mc_find_csrow_by_page(struct me
 
 	if (row == -1)
 		printk(KERN_ERR
-		       "MC%d: could not look up page error address %lx\n",
+		       "EDAC MC%d: could not look up page error address %lx\n",
 		       mci->mc_idx, (unsigned long) page);
 
 	return row;
@@ -721,7 +1716,7 @@ void edac_mc_handle_ce(struct mem_ctl_in
 	if (row >= mci->nr_csrows || row < 0) {
 		/* something is wrong */
 		printk(KERN_ERR
-		       "MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
+		       "EDAC MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
 		       mci->mc_idx, row, mci->nr_csrows);
 		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
 		return;
@@ -729,7 +1724,7 @@ void edac_mc_handle_ce(struct mem_ctl_in
 	if (channel >= mci->csrows[row].nr_channels || channel < 0) {
 		/* something is wrong */
 		printk(KERN_ERR
-		       "MC%d: INTERNAL ERROR: channel out of range "
+		       "EDAC MC%d: INTERNAL ERROR: channel out of range "
 		       "(%d >= %d)\n",
 		       mci->mc_idx, channel, mci->csrows[row].nr_channels);
 		edac_mc_handle_ce_no_info(mci, "INTERNAL ERROR");
@@ -739,7 +1734,7 @@ void edac_mc_handle_ce(struct mem_ctl_in
 	if (log_ce)
 		/* FIXME - put in DIMM location */
 		printk(KERN_WARNING
-		       "MC%d: CE page 0x%lx, offset 0x%lx,"
+		       "EDAC MC%d: CE page 0x%lx, offset 0x%lx,"
 		       " grain %d, syndrome 0x%lx, row %d, channel %d,"
 		       " label \"%s\": %s\n", mci->mc_idx,
 		       page_frame_number, offset_in_page,
@@ -777,7 +1772,7 @@ void edac_mc_handle_ce_no_info(struct me
 {
 	if (log_ce)
 		printk(KERN_WARNING
-		       "MC%d: CE - no information available: %s\n",
+		       "EDAC MC%d: CE - no information available: %s\n",
 		       mci->mc_idx, msg);
 	mci->ce_noinfo_count++;
 	mci->ce_count++;
@@ -803,7 +1798,7 @@ void edac_mc_handle_ue(struct mem_ctl_in
 	if (row >= mci->nr_csrows || row < 0) {
 		/* something is wrong */
 		printk(KERN_ERR
-		       "MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
+		       "EDAC MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
 		       mci->mc_idx, row, mci->nr_csrows);
 		edac_mc_handle_ue_no_info(mci, "INTERNAL ERROR");
 		return;
@@ -823,14 +1818,14 @@ void edac_mc_handle_ue(struct mem_ctl_in
 
 	if (log_ue)
 		printk(KERN_EMERG
-		       "MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
+		       "EDAC MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
 		       " labels \"%s\": %s\n", mci->mc_idx,
 		       page_frame_number, offset_in_page,
 		       mci->csrows[row].grain, row, labels, msg);
 
 	if (panic_on_ue)
 		panic
-		    ("MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
+		    ("EDAC MC%d: UE page 0x%lx, offset 0x%lx, grain %d, row %d,"
 		     " labels \"%s\": %s\n", mci->mc_idx,
 		     page_frame_number, offset_in_page,
 		     mci->csrows[row].grain, row, labels, msg);
@@ -846,17 +1841,56 @@ void edac_mc_handle_ue_no_info(struct me
 				    const char *msg)
 {
 	if (panic_on_ue)
-		panic("MC%d: Uncorrected Error", mci->mc_idx);
+		panic("EDAC MC%d: Uncorrected Error", mci->mc_idx);
 
 	if (log_ue)
 		printk(KERN_WARNING
-		       "MC%d: UE - no information available: %s\n",
+		       "EDAC MC%d: UE - no information available: %s\n",
 		       mci->mc_idx, msg);
 	mci->ue_noinfo_count++;
 	mci->ue_count++;
 }
 
 
+#ifdef CONFIG_PCI
+
+
+static inline u16 get_pci_parity_status(struct pci_dev *dev, int secondary)
+{
+	int where;
+	u16 status;
+
+	where = secondary ? PCI_SEC_STATUS : PCI_STATUS;
+	pci_read_config_word(dev, where, &status);
+	status &= PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR |
+		  PCI_STATUS_PARITY;
+
+	if (status)
+		/* reset only the bits we are interested in */
+		pci_write_config_word(dev, where, status);
+
+	return status;
+}
+
+
+typedef void (*pci_parity_check_fn_t) (struct pci_dev *dev);
+
+
+/* Clear any PCI parity errors logged by this device. */
+static void edac_pci_dev_parity_clear( struct pci_dev *dev )
+{
+	u8 header_type;
+
+	get_pci_parity_status(dev, 0);
+
+	/* read the device TYPE, looking for bridges */
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE)
+		get_pci_parity_status(dev, 1);
+}
+
+
 /*
  *  PCI Parity polling
  *
@@ -868,43 +1902,34 @@ static inline void edac_pci_dev_parity_t
 
 	/* read the STATUS register on this device
 	 */
-	pci_read_config_word(dev, PCI_STATUS, &status);
+	status = get_pci_parity_status(dev, 0);
 
 	debugf2("PCI STATUS= 0x%04x %s\n", status, dev->dev.bus_id );
-	status &= PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR |
-		  PCI_STATUS_PARITY;
 
 	/* check the status reg for errors */
 	if (status) {
-
-		/* reset only the bits we are interested in */
-		pci_write_config_word(dev, PCI_STATUS, status);
-
 		if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
 			printk(KERN_CRIT
-			   	"PCI- "
-				"Signalled System Error on %s %s\n",
-				dev->dev.bus_id,
-				pci_name(dev));
+			   	"EDAC PCI- "
+				"Signaled System Error on %s\n",
+				pci_name (dev));
 
 		if (status & (PCI_STATUS_PARITY)) {
 			printk(KERN_CRIT
-			   	"PCI- "
-				"Master Data Parity Error on %s %s\n",
-				dev->dev.bus_id,
-				pci_name(dev));
+			   	"EDAC PCI- "
+				"Master Data Parity Error on %s\n",
+				pci_name (dev));
 
-			pci_parity_count++;
+			atomic_inc(&pci_parity_count);
 		}
 
 		if (status & (PCI_STATUS_DETECTED_PARITY)) {
 			printk(KERN_CRIT
-			   	"PCI- "
-				"Detected Parity Error on %s %s\n",
-				dev->dev.bus_id,
-				pci_name(dev));
+			   	"EDAC PCI- "
+				"Detected Parity Error on %s\n",
+				pci_name (dev));
 
-			pci_parity_count++;
+			atomic_inc(&pci_parity_count);
 		}
 	}
 
@@ -914,61 +1939,83 @@ static inline void edac_pci_dev_parity_t
 	debugf2("PCI HEADER TYPE= 0x%02x %s\n", header_type, dev->dev.bus_id );
 
 	if( (header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE ) {
-
-	 	/* On bridges, need to examine secondary status register  */
-		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
+		/* On bridges, need to examine secondary status register  */
+		status = get_pci_parity_status(dev, 1);
 
 		debugf2("PCI SEC_STATUS= 0x%04x %s\n", status, dev->dev.bus_id );
-		status &= PCI_STATUS_DETECTED_PARITY |
-			  PCI_STATUS_SIG_SYSTEM_ERROR |
-			  PCI_STATUS_PARITY;
 
 		/* check the secondary status reg for errors */
 		if (status) {
-
-			/* reset only the bits we are interested in */
-			pci_write_config_word(dev, PCI_SEC_STATUS, status);
-
 			if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
 				printk(KERN_CRIT
-					"PCI-Bridge- "
-					"Signalled System Error on %s %s\n",
-					dev->dev.bus_id,
-					pci_name(dev));
+					"EDAC PCI-Bridge- "
+					"Signaled System Error on %s\n",
+					pci_name (dev));
 
 			if (status & (PCI_STATUS_PARITY)) {
 				printk(KERN_CRIT
-					"PCI-Bridge- "
-					"Master Data Parity Error on %s %s\n",
-					dev->dev.bus_id,
-					pci_name(dev));
+					"EDAC PCI-Bridge- "
+					"Master Data Parity Error on %s\n",
+					pci_name (dev));
 
-				pci_parity_count++;
+				atomic_inc(&pci_parity_count);
 			}
 
 			if (status & (PCI_STATUS_DETECTED_PARITY)) {
 				printk(KERN_CRIT
-					"PCI-Bridge- "
-					"Detected Parity Error on %s %s\n",
-					dev->dev.bus_id,
-					pci_name(dev));
+					"EDAC PCI-Bridge- "
+					"Detected Parity Error on %s\n",
+					pci_name (dev));
 
-				pci_parity_count++;
+				atomic_inc(&pci_parity_count);
 			}
 		}
 	}
 }
 
+
+/* 
+ * check_dev_on_list: Scan for a PCI device on a white/black list 
+ * @list:	an EDAC  &edac_pci_device_list  white/black list pointer
+ * @free_index:	index of next free entry on the list
+ * @pci_dev:	PCI Device pointer
+ *
+ * see if list contains the device.
+ *
+ * Returns:  	0 not found
+ *		1 found on list
+ */
+static int check_dev_on_list(   struct edac_pci_device_list *list,
+                                int free_index,
+                                struct pci_dev *dev )
+{
+        int i;
+        int rc = 0;     /* Assume not found */
+        unsigned short vendor=dev->vendor;
+        unsigned short device=dev->device;
+
+        /* Scan the list, looking for a vendor/device match
+         */
+        for (i = 0; i < free_index; i++, list++ ) {
+                if (    (list->vendor == vendor ) &&
+                        (list->device == device )) {
+                        rc = 1;
+                        break;
+                }
+        }
+
+        return rc;
+}
+
+
 /*
  * pci_dev parity list iterator
  * 	Scan the PCI device list for one iteration, looking for SERRORs
  *	Master Parity ERRORS or Parity ERRORs on primary or secondary devices
  */
-static inline void edac_pci_dev_parity_iterator(void)
+static inline void edac_pci_dev_parity_iterator(pci_parity_check_fn_t fn)
 {
 	struct pci_dev *dev=NULL;
-	u32 before_count = pci_parity_count;
-
 
 	/* request for kernel access to the next PCI device, if any,
 	 * and while we are looking at it have its reference count
@@ -976,25 +2023,90 @@ static inline void edac_pci_dev_parity_i
 	 */
 	while((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 
-		edac_pci_dev_parity_test( dev );
+                /* if whitelist exists then it has priority, so only scan those
+                 * devices on the whitelist
+                 */
+                if (pci_whitelist_count > 0 ) {
+                        if ( check_dev_on_list( pci_whitelist, pci_whitelist_count, dev ) )
+				fn(dev);
+                } else {
+                        /* if no whitelist, then check if this devices is blacklisted */
+                        if ( !check_dev_on_list( pci_blacklist, pci_blacklist_count, dev ) )
+				fn(dev);
+                }
 	}
+}
+
+
+static void do_pci_parity_check(void)
+{
+	unsigned long flags;
+	int before_count;
+
+	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+
+	if (!check_pci_parity)
+		return;
+
+	before_count = atomic_read(&pci_parity_count);
+
+	/* scan all PCI devices looking for a Parity Error on devices and
+	 * bridges
+	 */
+	local_irq_save(flags);
+	edac_pci_dev_parity_iterator(edac_pci_dev_parity_test);
+	local_irq_restore(flags);
 
 	/* Only if operator has selected panic on PCI Error */
-	if(panic_on_pci_parity) {
+	if (panic_on_pci_parity) {
 		/* If the count is different 'after' from 'before' */
-		if( before_count != pci_parity_count )
+		if (before_count != atomic_read(&pci_parity_count))
 			panic("EDAC: PCI Parity Error");
 	}
 }
 
 
-static void check_mc_devices (void)
+static inline void clear_pci_parity_errors(void)
+{
+	/* Clear any PCI bus parity errors that devices initially have logged
+	 * in their registers.
+	 */
+	edac_pci_dev_parity_iterator(edac_pci_dev_parity_clear);
+}
+
+
+#else  /* CONFIG_PCI */
+
+
+static inline void do_pci_parity_check(void)
+{
+	/* no-op */
+}
+
+
+static inline void clear_pci_parity_errors(void)
+{
+	/* no-op */
+}
+
+
+#endif  /* CONFIG_PCI */
+
+
+
+
+
+/*
+ * Iterate over all MC instances and check for ECC, et al, errors
+ */
+static inline void check_mc_devices (void)
 {
 	unsigned long flags;
 	struct list_head *item;
 	struct mem_ctl_info *mci;
 
 	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+
 	/* during poll, have interrupts off */
 	local_irq_save(flags);
 
@@ -1011,27 +2123,23 @@ static void check_mc_devices (void)
 
 /*
  * Check MC status every poll_msec.
+ * Check PCI status every poll_msec as well.
+ *
  * This where the work gets done for edac.
  *
  * SMP safe, doesn't use NMI, and auto-rate-limits.
  */
-static void check_mc(unsigned long dummy)
+static void do_edac_check(void)
 {
-	unsigned long flags;
 
 	debugf3("MC: " __FILE__ ": %s()\n", __func__);
+
 	check_mc_devices();
 
-	if (check_pci_parity) {
-		/* scan all PCI devices looking for a Parity Error on
-		 * devices and bridges
-		 */
-		local_irq_save(flags);
-		edac_pci_dev_parity_iterator();
-		local_irq_restore(flags);
-	}
+	do_pci_parity_check();
 }
 
+
 /*
  * EDAC thread state information
  */
@@ -1040,8 +2148,7 @@ struct bs_thread_info
 	struct task_struct *task;
 	struct completion *event;
 	char *name;
-	void (*run)(unsigned long dummy);
-	long dummy;
+	void (*run)(void);
 };
 
 static struct bs_thread_info bs_thread;
@@ -1067,12 +2174,12 @@ static int edac_kernel_thread(void *arg)
 
 	/* loop forever, until we are told to stop */
 	while(thread->run != NULL) {
-		void (*run)(unsigned long dummy);
+		void (*run)(void);
 
 		/* call the function to check the memory controllers */
 		run = thread->run;
 		if(run)
-			run(thread->dummy);
+			run();
 
 		if(signal_pending(current))
 			flush_signals(current);
@@ -1099,44 +2206,46 @@ static int __init edac_mc_init(void)
 	int ret;
 	struct completion event;
 
-	debugf0("MC: " __FILE__ ": %s()\n", __func__);
-	printk(KERN_INFO "MC: " __FILE__ " version " EDAC_MC_VER
-	       "\n");
+	printk(KERN_INFO "MC: " __FILE__ " version " EDAC_MC_VERSION "\n");
 
-	/* perform check for first time */
-	check_mc(0);
+	/*
+	 * Harvest and clear any boot/initialization PCI parity errors
+	 *
+	 * FIXME: This only clears errors logged by devices present at time of
+	 * 	module initialization.  We should also do an initial clear
+	 *	of each newly hotplugged device.
+	 */
+	clear_pci_parity_errors();
 
-	/* Create the /proc tree */
-	proc_mc = proc_mkdir(MC_PROC_DIR, &proc_root);
-	if (proc_mc == NULL)
-		return -ENODEV;
+	/* perform check for first time to harvest boot leftovers */
+	do_edac_check();
 
+	/* Create the MC sysfs entires */
+	if (edac_sysfs_memctrl_setup()) {
+		printk(KERN_ERR "EDAC MC: Error initializing sysfs code\n");
+		return -ENODEV;
+	}
 
-#ifdef CONFIG_SYSCTL
-	/* configure the /proc/sys system control filesystem tree */
-	mc_sysctl_header = register_sysctl_table(mc_root_table, 1);
-#endif				/* CONFIG_SYSCTL */
+	/* Create the PCI parity sysfs entries */
+	if (edac_sysfs_pci_setup()) {
+		edac_sysfs_memctrl_teardown();
+		printk(KERN_ERR "EDAC PCI: Error initializing sysfs code\n");
+		return -ENODEV;
+	}
 
 	/* Create our kernel thread */
 	init_completion(&event);
 	bs_thread.event = &event;
 	bs_thread.name = EDAC_THREAD_NAME;
-	bs_thread.run = check_mc;
-	bs_thread.dummy = 0;
+	bs_thread.run = do_edac_check;
 
 	/* create our kernel thread */
 	ret = kernel_thread(edac_kernel_thread, &bs_thread, CLONE_KERNEL);
 	if(ret < 0) {
-		if (proc_mc)
-			remove_proc_entry(MC_PROC_DIR, &proc_root);
+		/* remove the sysfs entries */
+		edac_sysfs_memctrl_teardown();
+		edac_sysfs_pci_teardown();
 
-#ifdef CONFIG_SYSCTL
-		/* if enabled, unregister our /sys tree */
-		if (mc_sysctl_header) {
-			unregister_sysctl_table(mc_sysctl_header);
-			mc_sysctl_header = NULL;
-		}
-#endif                          /* CONFIG_SYSCTL */
 		return -ENOMEM;
 	}
 
@@ -1169,17 +2278,9 @@ static void __exit edac_mc_exit(void)
 	read_unlock(&tasklist_lock);
 	wait_for_completion(&event);
 
-	/* if enabled, unregister our /proc/mc tree */
-	if (proc_mc)
-		remove_proc_entry(MC_PROC_DIR, &proc_root);
-
-#ifdef CONFIG_SYSCTL
-	/* if enabled, unregister our /sys tree */
-	if (mc_sysctl_header) {
-		unregister_sysctl_table(mc_sysctl_header);
-		mc_sysctl_header = NULL;
-	}
-#endif				/* CONFIG_SYSCTL */
+        /* tear down the sysfs device */
+	edac_sysfs_memctrl_teardown();
+	edac_sysfs_pci_teardown();
 }
 
 
diff -uprN orig/drivers/edac/edac_mc.h new/drivers/edac/edac_mc.h
--- orig/drivers/edac/edac_mc.h	2005-12-16 17:05:53.000000000 -0700
+++ new/drivers/edac/edac_mc.h	2005-12-16 17:07:13.000000000 -0700
@@ -31,9 +31,9 @@
 #include <linux/nmi.h>
 #include <linux/rcupdate.h>
 #include <linux/completion.h>
+#include <linux/kobject.h>
 
 
-#define	EDAC_MC_VER	"MC $Revision: 1.4.2.10 $"
 #define EDAC_MC_LABEL_LEN	31
 #define MC_PROC_NAME_MAX_LEN 7
 
@@ -51,11 +51,13 @@ do { if (level <= edac_debug_level) prin
 #define debugf1( ... ) edac_debug_printk(1, __VA_ARGS__ )
 #define debugf2( ... ) edac_debug_printk(2, __VA_ARGS__ )
 #define debugf3( ... ) edac_debug_printk(3, __VA_ARGS__ )
+#define debugf4( ... ) edac_debug_printk(4, __VA_ARGS__ )
 #else				/* !CONFIG_EDAC_DEBUG */
 #define debugf0( ... )
 #define debugf1( ... )
 #define debugf2( ... )
 #define debugf3( ... )
+#define debugf4( ... )
 #endif				/* !CONFIG_EDAC_DEBUG */
 
 
@@ -164,6 +166,10 @@ enum scrub_type {
 #define SCRUB_FLAG_HW_PROG_SRC	BIT(SCRUB_HW_PROG_SRC_CORR)
 #define SCRUB_FLAG_HW_TUN	BIT(SCRUB_HW_TUNABLE)
 
+enum mci_sysfs_status {
+	MCI_SYSFS_INACTIVE = 0,	/* sysfs entries NOT registered */
+	MCI_SYSFS_ACTIVE	/* sysfs entries ARE registered */
+};
 
 /* FIXME - should have notify capabilities: NMI, LOG, PROC, etc */
 
@@ -272,6 +278,9 @@ struct csrow_info {
 	enum mem_type mtype;	/* memory csrow type */
 	enum edac_type edac_mode;	/* EDAC mode for this csrow */
 	struct mem_ctl_info *mci;	/* the parent */
+
+	struct kobject kobj;	/* sysfs kobject for this csrow */
+
 	/* FIXME the number of CHANNELs might need to become dynamic */
 	u32 nr_channels;
 	struct channel_info *channels;
@@ -291,6 +300,9 @@ struct mem_ctl_info {
 				   edac_cap would not have that capability. */
 	unsigned long scrub_cap;	/* chipset scrub capabilities */
 	enum scrub_type scrub_mode;	/* current scrub mode */
+
+	enum mci_sysfs_status sysfs_active;	/* status of sysfs */
+
 	/* pointer to edac checking routine */
 	void (*edac_check) (struct mem_ctl_info * mci);
 	/*
@@ -325,9 +337,13 @@ struct mem_ctl_info {
 	 */
 	struct rcu_head rcu;
 	struct completion complete;
+	
+	/* edac sysfs device control */
+	struct kobject edac_mci_kobj;
 };
 
 
+
 /* write all or some bits in a byte-register*/
 static inline void pci_write_bits8(struct pci_dev *pdev, int offset,
 				   u8 value, u8 mask)
@@ -426,10 +442,7 @@ extern struct mem_ctl_info *edac_mc_allo
 		unsigned nr_csrows, unsigned nr_chans);
 
 /* Free an mc previously allocated by edac_mc_alloc() */
-static inline void edac_mc_free(struct mem_ctl_info *mci)
-{
-	kfree(mci);
-}
+extern void edac_mc_free(struct mem_ctl_info *mci);
 
 
 #endif				/* _EDAC_MC_H_ */


"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

