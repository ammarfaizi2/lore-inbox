Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbTGITcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268560AbTGITcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:32:10 -0400
Received: from mx0.gmx.net ([213.165.64.100]:35792 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S268536AbTGITb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:31:59 -0400
Date: Wed, 9 Jul 2003 21:46:37 +0200 (MEST)
From: h.t.d@gmx.de
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: PROBLEM: ICH5 SATA controller not working in enhanced mode using SMP (2.4.21-ac4)
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000295886@gmx.net
X-Authenticated-IP: [62.116.68.179]
Message-ID: <5849.1057779997@www42.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
 
I try to run a SMP system (hyperthreading cpu) with enhanced SATA enabled 
and i have failed to do so for a few days now. I found a thread on lkml that
talks 
about that issue which seems to be successfully resolved when -ac4 kernel 
and its new scsi sata driver are used. 
 
http://lists.insecure.org/lists/linux-kernel/2003/Jul/0301.html 
 
I followed the instructions and talked to Jeff Mock (he is running the
kernel 
successfully with enhanced sata mode and posted the problem to the list) -
we 
exchanged kernel configs, but my system still hangs on boot... Now here are
my 
observations: 
 
When I am booting with kernel-2.4.21-ac4-smp the system hangs. Here are the 
last three lines of output: 
----- 
SCSI subsystem driver revision: 1.00 
ata1: SATA max UDMA/100 cmd 0xEF88 ctl 0xEF86 bmdma 0xEEB0 irq 18 
ata2: SATA max UDMA/100 cmd 0xEF68 ctl 0xEF82 bmdma 0xEEB8 irq 18 
 
When I am booting 2.4.21-ac4 in uniprocessor mode output looks like: 
----- 
SCSI subsystem driver Revision: 1.00 
ata_piix version 0.9 
PCI: Setting latency timer of device 00:1f.2 to 64 
ata1: SATA max UDMA/100 cmd 0xEF88 ctl 0xEF86 bmdma 0xEEB0 irq 18 
ata2: SATA max UDMA/100 cmd 0xEF68 ctl 0xEF82 bmdma 0xEEB8 irq 18 
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors 
ata1: dev 0 configured for UDMA/100 
ata2: thread exiting 
scsi0 : ata_piix 
scsi1 : ata_piix 
  Vendor: ATA       Model: ST380013AS        Rev: 0.51 
  Type:   Direct-Access                      ANSI SCSI revision: 05 
libata version 0.51 loaded. 
 
Jeff Mocks kernel output looks like this: 
----- 
SCSI subsystem driver Revision: 1.00 
ata_piix version 0.9 
PCI: Setting latency timer of device 00:1f.2 to 64 
ata1: SATA max UDMA/100 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18 
ata2: SATA max UDMA/100 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18 
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors 
ata1: dev 0 configured for UDMA/100 
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors 
ata2: dev 0 configured for UDMA/100 
scsi0 : ata_piix 
scsi1 : ata_piix 
   Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 0.51 
   Type:   Direct-Access                      ANSI SCSI revision: 05 
   Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 0.51 
   Type:   Direct-Access                      ANSI SCSI revision: 05 
libata version 0.51 loaded. 
 
The difference between our systems is that i have a I865PE board with ICH5 
controller and he has a I875P board with ICH5 controller. Both of us are
running 
a mix of PATA and SATA drives and use SMP enabled kernels. Jeff has 2 
SATA drives i have only one (i hope that's not the problem). 
I have tried to use the following kernels (smp support enabled) with
enhanced 
SATA enabled in BIOS: 
2.4.20-gentoo-patched: not working at all 
2.4.21: works but does not detect "second cpu" 
2.4.21-ac4: hangs, detects smp 
2.4.22-pre3: works but does not detect "second cpu" 
2.4.22-pre3-ac1: does not compile (undefined reference to `xapic_support') 
2.5.74: works, detects smp - but no onboard Gbit NIC driver or nvidia driver

available 
 
Using 2.4.21-ac4 without smp support, the scsi SATA driver works (as shown 
above), the machine boots and accesses the SATA disk on /dev/sda. As I need 
SMP support for improved compile times (has high priority on gentoo systems 
;-)) I currently run a 2.4.21-ac4 smp-kernel with legacy (compatible) SATA 
mode enabled in BIOS. I'd like to use SATA in enhanced mode, so I'm asking 
for some hints what to try to get SATA _and_ SMP working. A 2.5 series
kernel 
is currently no option for me as i have no NIC and nvidia driver for it. 
Unpatched kernels don't detect my AGP controller correctly and seem to have 
problems detecting P4 HT cpus as "smp" system... 
 
Conclusion: I think the problem is related to SMP and my chipset somehow, if

anybody can prove that, i might be able to return my mobo and only pay up
for 
a I875 based board in return. If it's not the chipset then there's a problem
with 
the driver it think - a wild guess from me would be that there's a thread 
locking/starvation problem when the sata devices are checked ('thread
exited' 
is mentioned on uniproc-boot, smp-boot doesn't get that far?) 
 
Thanks in advance for any help or hints, i'm not on the list please put me
on CC 
when answering. 
 
 Mike 
 

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++

Jetzt ein- oder umsteigen und USB-Speicheruhr als Prämie sichern!

