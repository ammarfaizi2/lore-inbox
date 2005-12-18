Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbVLRDHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVLRDHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVLRDHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:07:23 -0500
Received: from web50113.mail.yahoo.com ([206.190.39.150]:950 "HELO
	web50113.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932671AbVLRDHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:07:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JmYZSeaNRBfnEE+Dq3rp28M8gXItl1vZd8bvYhZnKl+agoB5rdraA8868NOu8ydWyJ9kqf+TIAs4vh0GBtASSM+4Oj2c7NWQSeVWY7cSFYJYpvBlOvDrtnPgvQ0i7iW74HMgcVp9YVAf9ZWlkzAGLsf9958efpKEkj/FXjOlz5I=  ;
Message-ID: <20051218030721.82963.qmail@web50113.mail.yahoo.com>
Date: Sat, 17 Dec 2005 19:07:21 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH]  EDAC with new sysfs interface - remove /proc interfaces on  -mm3
To: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:   doug thompson  <norsk5@xmission.com>

Patch against 2.6.15-rc5-mm3

EDAC has been modifed to remove old /proc interfaces and add new interface.

Removed  /proc/mc and /proc/sys/mc from edac
Added    /sys/devices/system/edac  interface
Added          'mc' and 'pci' under 'edac'
Added    Documentation/drivers/edac/edac.txt
Code cleaning in drivers/edac/edac_mc.c

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
+	from the edac.sourceforge.net project.
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
+	c
