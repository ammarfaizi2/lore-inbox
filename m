Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVFOO1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVFOO1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFOO1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:27:50 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:46028 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261445AbVFOO1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:27:03 -0400
Subject: [PATCH] 2 of 5 IMA: documentation patch
From: Reiner Sailer <sailer@watson.ibm.com>
To: LKLM <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@mail.wirex.com>
Cc: Kylene Hall <kylene@us.ibm.com>, Emily Rattlif <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, Reiner Sailer <sailer@us.ibm.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 10:30:59 -0400
Message-Id: <1118845859.2269.17.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies against linux-2.6.12-rc6-mm1 and provides the documentation 
part for the Integrity Measurement Architecture. A previous set of patches was posted 
to this mailing list on May 20th. This new set of patches addresses suggestions
from Greg K-H and others.

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---

diff -uprN linux-2.6.12-rc6-mm1_orig/Documentation/ima/INSTALL linux-2.6.12-rc6-mm1-ima/Documentation/ima/INSTALL
--- linux-2.6.12-rc6-mm1_orig/Documentation/ima/INSTALL	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/Documentation/ima/INSTALL	2005-06-14 21:07:18.000000000 -0400
@@ -0,0 +1,332 @@
+File: INSTALL
+
+Installation File for
+IBM Integrity Measurement Architecture
+
+Copyright IBM (c) April 30, 2005
+Author: Reiner Sailer, sailer@watson.ibm.com
+
+For background information, examples, and publications
+   on this topic, please visit:
+   http://www.research.ibm.com/secure_systems_department/projects/tcglinux/
+
+The following instructions work for Fedora Core3 but should be
+generic (you just need a configuration file that works for the kernel)
+
+
+1. Required kernel configuration options
+========================================
+ a)  crypto->SHA1 is (y)           
+          [IMA needs sha before modules are loaded]
+
+ b)  security->Default Linux Capabilities (n) 
+              [IMA cannot share LSM with the capabilities]
+
+ c)  choose (y) for "TCG run-time Integrity Measurement Architecture"
+              [switchtes IMA measurements on]
+
+ d)  choose (y) for "IMA test mode"
+          This option tells IMA to try to use a real hw TPM or bypass it
+          if in test mode.
+          Choose (y) if you don't have a TPM on your machine or if you 
+	  have a TPM on your machine but you want to test IMA and the
+          dependencies first. In any case, make sure you have a TPM
+          driver with the internal kernel interface patch posted to 
+          LKML 05/2005. If you choose (n) and IMA can't start up for any
+          reason, it panics the kernel to protect attestation (see below, 8.). 
+	  Say (n) only after testing your kernel configuration.
+	  If unsure, say (y).
+   
+ e)  If you'd like to compile SELinux and IMA and choose between
+     them at boot-time then configure:
+     NSA SELinux boot paramter
+         NSA SELinux boot parameter default value to (0)
+          (see 3 for kernel command line options)
+
+
+2. Compile and install the new kernel and initrd
+================================================
+make all; make modules_install; make install
+
+
+3. Change kernel command line options
+=====================================
+to activate the Integrity Measurement Architecture at boot-time, 
+add: 'ima=1', to deactivate use 'ima=0' (default)
+
+If you have both SELinux and IBM IMA support compiled into
+the kernel, then switch at least one of:
+ 'ima=1 selinux=0' activates the Integrity Measurement Architecture
+ 'ima=0 selinux=1' activates SELinux
+
+You can't activate both because the kernel does not yet
+support LSM stacking.
+
+
+4. Trouble-shooting (restart your system to activate new kernel)
+================================================================
+Use `dmesg |grep IMA` to print IMA status startup information:
+You may find the following output:
+
+   a) you are fine if you see 
+   the following lines (if you have TPM hardware):
+   ----
+   IBM Integrity Measurement Architecture (IBM IMA vx.x mm/dd/yyyy).
+       IMA (test mode)
+   ----
+   or the following lines (if you don't have TPM hardware):
+   ----
+   IBM Integrity Measurement Architecture (IBM IMA vx.x mm/dd/yyyy).
+       IMA (test mode)
+       IMA (TPM/BYPASS - no TPM chip found)
+   ----
+
+   b) you need to add the "ima=1" kernel boot paramter if you see:
+   ---
+   IBM Integrity Measurement Architecture (IBM IMA vx.x mm/dd/yyyy).
+       IMA (not enabled in kernel command line) aborting!
+   ---
+ 
+   c) you need to disable security->Default Linux Capabilities or
+      SELinux  (see configuration requirements) if you see:
+   ---
+   IBM Integrity Measurement Architecture (IBM IMA vx.x mm/dd/yyyy).
+       IMA (test mode)
+       IMA (LSM/not free) aborting!
+   ---
+
+
+5. Measurement example
+======================
+To read the measurements, read from /ima/binary_measurements. They
+have the following format:
+
+1. PCR         ( 32bit) ... number of the PCR into which this measurement was extended
+2. Measurement (160bit) ... SHA1 value of the file that was measured
+3. Flags       ( 32bit) ... b31-b16 application flags (label of measurement request)
+                            b15-b04 kernel flags (private field, not currently used by IMA)
+                            b03-b00 measure hook identification (file_mmap, load_module, user write to /ima/measurereq)
+4. Filename    (<=40bytes)  name of the file (without path) that was measured
+5. separator   (  8bit) =  '\0'
+
+/ima/binary_measurements returns always full measurement entries (as many as fit
+the buffer). The first 28 bytes are fixed format. After this the Filename extends 
+until the '\0', after which the next measurement starts. Max length of an entry is 
+69bytes including the separator. Reading from /ima/binary_measurements into a buffer 
+with >69bytes will yield 0 bytes if all measurments are read (you are done).
+
+We have written a small script formatting and printing the measurements:
+# print_ima_measurements
+
+### PCR HASH                                     [UUUUKKKH] NAME
+  0 010 3A7DC481417E40A9C1CFE8D55E40BE0B740A3748 [00000000] boot_aggregate
+  1 010 BCF30EC20A2DFB900A5C852B73F94CDA5A8F7D36 [00000001] nash
+  2 010 2A954FC4EBAC54BA26909A5AD52AEE5848425C3F [00000001] udev
+  3 010 BD145AE0CFC2021C065AEAE52355FEFEA741A0E2 [00000001] insmod
+  4 010 E6C3BFACC06E1A93B1D7214870EB7757085E44AE [00000002] jbd
+  5 010 26AEC8A3E2E9EE1FF6B67564DEEBFE16D5E77A9D [00000002] ext3
+  6 010 F3B8622110E3979FC4DE41598157C80F5F688AC6 [00000001] init
+  7 010 5ACBD4089B3BBAD951AD13775B41BB951EAE306C [00000001] ld-2.3.5.so
+  8 010 8F4D9E003B9D0851043B95F03514E965E498DD3D [00000001] bash
+  9 010 25DB40D24D8EC0B971BC4FB0E995211FBA16908C [00000001] libtermcap.so.2.0.8
+ 10 010 1E93D1BF0880268EAFFE4818AD81DA39E0C8EA48 [00000001] libdl-2.3.5.so
+ 11 010 99554AD938DB53DDEAF1EFFBE472F05BF5F95878 [00000001] libsepol.so.1
+ 12 010 DCDDF67F5239F6E029CA7FA4C1332A7A109A22E2 [00000001] libc-2.3.5.so
+ 13 010 E9114FC95121F4F04EBEEE500107C80732279F87 [00000001] libselinux.so.1
+ 14 010 7581908B0A16A31D900FC19F4791875FFB60B6C4 [00000001] libnss_files-2.3.5.so
+
+The Flags have following meaning:
+U - Flags(16bit) ... submitted by the appliation in user space whith measurement request (see 7.)
+K - Flags(12bit) ... kernel flags (for future use)
+H - Flags(4bit)  ... Identifies the measurement hook (MMAP=1,MODULE=2,USER=4)
+
+
+
+6. Statistics / IMA FS
+======================
+
+setup:
+
+mount -t imafs none /ima
+
+/ima
+
+READ-Entries:
+/ima/binary_measurements         ... binary measurement list, format for each entry:
+                                     PCR#   DIGEST   FLAGS   FILENAME    Separator
+                                     32bit||20*8bit||32bit||char[x<=40]||'\0'
+                 
+/ima/binary_measurements_count   ... length of the measurement list (entries)
+/ima/changed_files               ... number of files that are measured and changed between measurements
+/ima/clean_inode_hits            ... number of measurement requests that where skipped because of a clean
+                                     flag in the inode (best performance)
+/ima/clean_hashtable_hits        ... number of measurement requests that where skipped because of a clean
+                                     flag in the hashtable entry (second best performance)
+/ima/dirty_hashtable_hits        ... number of measurement requests that required building a SHA1 over the
+                                     file just to realize it did not really change (files are marked dirty
+                                     if a user requests write permission when opening it)
+/ima/kernel_count                ... number of measurements initiated in the kernel (mmap+module)
+/ima/user_count                  ... number of measurements initiated by user applications (imafs/measurereq)
+/ima/violations                  ... number of violations (if /ima/violations != 0, then attestation will fail)
+
+WRITE-Entries:
+/ima/measurereq                  ... write a request from within a user space application into the kernel:
+                                     struct measure_request {
+                                          int fd;          /* file descriptor of open file to be measured */
+                                          u_int16_t label; /* passed through into measurement (see U-flags in 5) */
+                                     }
+
+
+7. Equipping user space applications to measure input files
+===========================================================
+There are files other than executables that might be important to log,
+e.g., batch files (startup scripts), configuration files, certificates etc.
+IMA can only measure regular files (no symlinks, character files etc.) an
+cannot measure files of the imafs.
+
+For this reason, IMA offers the /ima/measurereq interface. User applications
+can use this entry in the following way to measure the file "/etc/any/config":
+
+struct measure_request {
+	int fd;
+	u_int16_t label;
+};
+int fd_mreq, fd_config;
+struct measure_request mr;
+....
+fd_mreq = open("/ima/measurereq", O_WRONLY);
+if (fd_mreq <= 0) <error>
+...
+/* open config file */
+fd_config = open("/etc/any/config", O_RDONLY); /* do not open measured files RW! (see Note) */
+if (fd_config <= 0) <error>
+
+/* measure the file before using it */
+
+mr.fd = fd_config;       /* file descriptor of the file that shall be measured */
+mr.label=3134;           /* any label/tag; it only appears in the measurement entry  */
+
+if (write(fd_mreq, mr, sizeof(struct measure_request))         -- (A)
+	<error measuring>;                                      |
+/* now use the file -- see NOTE below */                        |- protected
+...                                                             |  section (see Note)
+/* then close the file */                                       |
+close(fd_config)                                               -- (B)
+...
+/* reuse fd_mreq to measure other files if necessary */
+...
+close(fd_mreq);
+
+Note:
+=====
+since the principle of IMA (inherited from TCG) is "measure before load",
+we ensure that the application really reads from the file the data that we measured.
+
+For this reason, we apply detection mechanisms that ensure that the measured file is not 
+unnnoticedly written to by anybody before it is closed by the application that initiated 
+the measurement. Such writing can happen either by the file (inode) already having writers
+at the time the measurement is initiated ((A) above) or by writers that open the file 
+with write/append permission between the measurment request and the last read
+of the file by the application ((A)->(B) above).
+
+If a file is opened read/write while being used in the above <protected section>
+or if a file already has writers when the measurement is being initiated (this also applies
+to measured files opened with write/append permission), then this is a 
+Time-of-Measurement-Time-of-Use (ToMToU) race condition violation and leads to invalidating 
+the measurement aggregate in the TPM. Once this happens, /ima/violations is incremented
+and remote attestations will notice that the TPM aggregate does not match the measurement list.
+
+
+8. Real-mode versus test-mode IMA
+=================================
+
+If the test option is switched off, then IMA runs in real-mode. A kernel
+configured in IMA real-mode guarantees that the kernel panics as soon
+as it looses its ability to talk to the TPM hardware. This guarantees
+that the kernel (if running) has always the opportunity to invalidate
+the TPM measurement aggregate. For example, if for any reason the TPM 
+hardware is not accessible when IMA starts in real-mode, IMA will 
+panic the kernel. Finally, IMA does not respect the IMA enable/disable 
+command line option when in real-mode.
+
+In test-mode, IMA will merely print an error message and go on without the 
+real TPM. Such a system could later on have access to the TPM (e.g., after
+it was corrupted) and recreate arbitrary contents of TPM measurements. Remote
+parties would have difficulty to tell the difference because the chain of trust
+was broken when the originally booted kernel (measured by the boot loader)
+could not extend into the TPM. Finally, IMA can be switched on and off via the 
+command line option as long as IMA runs in test mode; such a system, once corrupted, 
+could re-create a favourite measurement list and extend the TPM aggregate accordingly. 
+Also here, a remote party might have difficulty to predict the actual command line 
+parameters the system used during boot.
+
+We recommend running in test-mode first to ensure all drivers etc. work together
+with the local TPM hardware and later on switch over to real-mode (stacking LSM
+is required to retain access to other LSM users).
+
+
+9. Validating the PCR Aggregate
+===============================
+Given a list of measurements (ordered SHA1 values), the PCR aggregate of these
+measurements can be re-calculated as illustrated by the following 'pseudo'-code 
+(e.g., using openssl library calls):
+
+/* simulates the PCR aggregate */
+unsigned char PCR[SHA_DIGEST_LENGTH];
+
+/* init with initial PCR content 0..0 */
+memset(PCR,0,SHA_DIGEST_LENGTH);
+
+SHA_CTX c;
+
+/* get the measurements one-by-one from /ima/binary_measurements  (or from a list
+   provided from a remote system) */
+while( (len = read( fd_bin_measurements, event, 69 )) ) {
+	buf = event+4; 		  /* position of SHA1 in the measurement entry */
+	SHA1_Init(&c);
+	SHA1_Update(&c, PCR, SHA_DIGEST_LENGTH); /* PCR = SHA(PCR || MEASUREMENT) */
+	SHA1_Update(&c, buf, SHA_DIGEST_LENGTH);
+	SHA1_Final(PCR, &c);
+}	
+
+After reading the latest measurement, the current PCR aggregate is in PCR and can
+be compared with the current TPM PCR aggregate (e.g., cat /sys/class/misc/tpm0/device/pcrs
+and looking at the PCR number #10 in case of the default kernel configuration).
+
+
+
+10. Attestation / Putting the pieces together
+=============================================
+While the PCR aggregate can be validated on the local system, this usually takes 
+place on remote systems. The generic protocol for remote attestation using IMA 
+would look most probably as follows:
+
+Given: 
+(i)   measured System A running IMA (real-mode) and equipped with HW TPM
+(ii)  challenging System B (no IMA or TPM required) 
+(iii) a way to retrieve TPM_SIGNATURE_OVER(PCR registers, Nonce), called QUOTE, 
+      on System A (see TrouSerS project on sourceforge.net or any other TSS implementation)
+
+1. step: B-->A: NonceB (160bit, non-predictable for A)
+
+2. step: A-->B: TPM_SIGNATURE_OVER{PCR registers, NonceB, Versionetc.}, MeasurementList
+
+3. step: B:  
+	a) validate (1) TPM signature; (2) nonce in the signature matches the nonce in the request
+
+      	b) validate Measurement list (see above):
+           b.1 recalculate Aggregate over the Measurement list (see above)
+           b.2 compare aggregate with TPM-signed PCR register holding the aggregate
+           b.3 equal -> success
+               non-equal -> either A was cheating with the list, or the TPM aggregate was 
+                            invalidated on system A (cat /ima/violations on system A yields != 0) 
+
+       c) validate boot aggregate:
+           Ideally, the boot aggregate -- as a SHA1 over the first 8 PCR registers -- should include
+           measurements of later stages of the boot loader, the kernel, the initrd, and the 
+           grub-configuration file. To get there, you need to install a grub boot loader that takes 
+           such measurements and extends them into the TPM PCRs.
+
+       d) validate individual measurements; there are many opportunities here to check program
+           versions against service level agreements, make root-kits visible, check configuration 
+           files etc.
diff -uprN linux-2.6.12-rc6-mm1_orig/Documentation/ima/integrity_measurements.txt linux-2.6.12-rc6-mm1-ima/Documentation/ima/integrity_measurements.txt
--- linux-2.6.12-rc6-mm1_orig/Documentation/ima/integrity_measurements.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/Documentation/ima/integrity_measurements.txt	2005-06-14 16:25:05.000000000 -0400
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
+ima file system that enables applications to instruct the kernel to
+measure files that they have opened (/ima/measurereq).
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


