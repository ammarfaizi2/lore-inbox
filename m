Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVETNby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVETNby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVETNby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:31:54 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:2761 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261371AbVETNbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:31:45 -0400
Subject: [PATCH 2 of 4] ima: related Makefile compile order change and
	Readme
From: Reiner Sailer <sailer@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@mail.wirex.com, kylene@us.ibm.com, emilyr@us.ibm.com,
       toml@us.ibm.com
Content-Type: text/plain
Date: Fri, 20 May 2005 09:36:20 -0400
Message-Id: <1116596180.8156.8.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM Integrity Measurement Architecture (IMA) builds information
about the software that was loaded into a system run-time since the
last reboot. For each loaded executable (binary, kernel module,
library), the IMA calculates once a SHA1 value over the executable file 
and stores it for later reference. IMA uses (optionally) the Trusted
Computing Group Trusted Platform Module to protect the integrity of
the accumulated measurements. IMA can, for example, be used to build 
services that detect compromised malicious software loaded into the 
runtime or can be used to validate expected system configurations.

IMA consists of 3 patches (patch 2,3,4 of 4) and needs another patch
(1 of 4) to enable it to use the TPM driver from inside the kernel.

This current patch 2of4 changes the compile order and ensures that the
crypto api is initialized before IMA comes up and uses it. It also
includes a high-level documentation file.

This patch applies to the clean 2.6.12-rc4 test kernel.

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---
diff -uprN linux-2.6.12-rc4/Documentation/integrity_measurements.txt linux-2.6.12-rc4-ima/Documentation/integrity_measurements.txt
--- linux-2.6.12-rc4/Documentation/integrity_measurements.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/Documentation/integrity_measurements.txt	2005-05-19 21:09:37.000000000 -0400
@@ -0,0 +1,87 @@
+The IBM Integrity Measurement Architecture (IMA) offers means to
+securely identify the software that was loaded into a system run-time
+since the last reboot. The IMA builds the information necessary to
+identify the loaded software and provides the basis for services to
+build on top of such information. However, it does not include any
+means that would enable remote parties to extract the information
+itself.
+
+Guarantees: IMA offers "software load-guarantees" in that
+identification of all loaded software is guaranteed to be reflected in
+measurement data and protected in a hardware TPM security chip (if
+available). IMA is non-intrusive and neither disturbs the system, nor
+prevents the system from any actions. However, if running in real
+mode, when the TPM chip is not accessible IMA might require the system
+not to start (for security guarantee reasons).
+
+Limitations: IMA does not detect corruption of software once it is
+loaded into main memory. Instead, it indicates known vulnerabilities
+in such software (e.g., buffer overflow) by securely identifying the
+software at load-time. Only executable files (binaries, libraries,
+kernel modules) are measured by default. However, IMA offers a
+sysfs-interface that allows applications to instruct the kernel to
+measure files that they have opened.
+
+Assumed usage: Verify system installed software configurations and
+system run-time integrity from a secure management location.
+
+Operation: IMA is mainly an LSM module that measures all files mapped
+executable in the kernel as well as kernel modules. It operates after
+the principle >measure before load< as it is known from the Trusted
+Computing Group to identify static system boot configurations and
+extends this principle into the dynamic run-time. To this end, the
+file_mmap security hook builds a SHA1 hash value (our measurement)
+over the whole file, which is probably only partly mapped. These
+measurements are kept in an ordered list inside the kernel. We measure
+executable files only the first time they are loaded and after they
+changed. We use for efficiency dirty-flagging both in the inode of the
+mapped file (re-use) and in the kernel-held measurement list.
+
+Each time a new measurement entry is created and added to the
+measurement list, the hash value of this measurement entry is also
+"extended" into the hardware TPM chip (if available, see INSTALL). All
+these extensions result in a unique aggregate value (160 bit) inside
+the TPM chip, which securely identifies the current measurement list
+inside the kernel.
+
+Since the TPM chip cannot be manipulated from software and since the
+aggregation of the extended values is done in a way that cannot be
+undone (uses HW SHA1), the aggregate in the TPM serves as an integrity
+check value for the current measurement list in the kernel - since the
+kernel can be corrupted if the system software becomes
+compromised. Any software that might corrupt the system has already
+been measured and its measure value has already been aggregated into
+the hardware TPM chip before such software can corrupt the integrity
+measurement architecture itself.
+
+Benefit: Authorized parties can (i) ask the Linux system that runs IMA
+for the kernel-held measurement list and the current signed
+TPM-aggregate, (ii) recalculate the aggregate using the measurement
+list, and (iii) compare the calculated aggregate with the signed TPM
+aggregate. If both aggregates are the same, then the system has
+delivered the correct and latest measurement list. Since each
+measurement of the measurement list uniquely defines a certain
+executable file, the authorized (remote) party can therefore validate
+the software that was loaded into the Linux system since reboot. Many
+applications are possible. The control of the system is fully in the
+hands of the person that controls the Linux client; this person must
+actively offer services to remote parties so they can retrieve the
+measurement list and/or the signed TPM aggregate.
+
+Some of our work shows that IMA is very useful to detect Rootkit
+exploits that totally take over the software of a Linux system but
+cannot hide themselves from contributing to the TPM aggregate and this
+will be detectable from a non-corrupted platform. While the corrupted
+system might not show the Rootkit, a remote party can securely
+identify known bad or unknown software having been loaded into the
+system.
+
+Practice: IMA runs up about 650 measurements when running a Fedora
+Core 3 environment including Gnome desktop. Our system (cron switched
+off) does not accumulate more than this after 18 days uptime. If lots
+of different files (executables, libraries, and kernel modules) are
+executed, then the list may become very long and evaluating the
+measurements might incur increasing overhead. Generally, IMA is useful
+where the executed content is foreseeable and the validating party
+knows which measurements to expect.
+
diff -uprN linux-2.6.12-rc4/Makefile linux-2.6.12-rc4-ima/Makefile
--- linux-2.6.12-rc4/Makefile	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-ima/Makefile	2005-05-19 17:59:20.000000000 -0400
@@ -562,7 +562,7 @@ export MODLIB
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
+core-y		+= kernel/ mm/ fs/ ipc/ crypto/ security/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \




