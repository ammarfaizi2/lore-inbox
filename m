Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWJYUOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWJYUOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWJYUOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:14:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25876 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965225AbWJYUOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:14:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JPUXgwsNadnZAXJdD4CRLmCcCnLUI90vXV+GUMFrWvr6rmISEaO5U9qiAfUXUg91q+EJU+OUVbbScC23OVJcMQjfu2PA4omlA0DEPaMhYYM7DxInKEkqaD5W5QFf0dHw7658XEzXa3+CukHfYl8igwLnoSbIMxPQUNEF8yX3rAQ=
Message-ID: <6b4e42d10610251313g5a42ef9ft524bd3bc525d7f00@mail.gmail.com>
Date: Wed, 25 Oct 2006 13:13:56 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Cc: randy.dunlap@oracle.com, omanakuttan.potty@sun.com, clemens@ladisch.de,
       vojtech@suse.cz, bob.picco@hp.com, venkatesh.pallipadi@intel.com,
       omanakuttan@imap.cc, linux-kernel@vger.kernel.org
In-Reply-To: <p731wowmdlz.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610250013.48194.om.turyx@gmail.com>
	 <p731wowmdlz.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 03/03 : Documentation

------
Signed-Off-by : Om Narasimhan <om.turyx@gmail.com>


 Documentation/hpet.txt              |   56 +++++++++++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt |    9 ++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/Documentation/hpet.txt b/Documentation/hpet.txt
index b7a3dc3..0b1b9d9 100644
--- a/Documentation/hpet.txt
+++ b/Documentation/hpet.txt
@@ -298,3 +298,59 @@ members of the hpet_task structure befor
 hpet_control simply vectors to the hpet_ioctl routine and has the same
 commands and respective arguments as the user API.  hpet_unregister
 is used to terminate usage of the HPET timer reserved by hpet_register.
+
+		HPET Legacy Replacement Route option (hpet_lrr)
+
+HPET is capable of replacing the IRQ0 (connected INT0 PIN) routing for
+timer interrupt. The capability register (at offset 0 of HPET
+base address) has a bit specifying if HPET chip is capbale of doing
+this. OS can read the bit either from HW or ACPI table. (HPET ACPI
+description table -> Event Timer block -> bit 15, page 30 of HPET
+spec).  Ideally (I think so!) BIOS should set the ACPI table than letting
+the OS read H/W, which gives the BIOS a way to configure either legacy
+or Legacy replacement modes.
+
+Typically the motherboard has BIOS configured / hardwired IRQ0 to INT0
+(pin of APIC) connection. Linux assumes IRQ0 connected to INT0 unless it is
+supplied using an override parameter in the MPTable. Some NVidia chipsets /
+BIOS initialization code had configured to override IRQ0 -> INT0 connection
+and later a parameter was introduce (acpi_skip_timer_override) to get IRQ0 ->
+INT0 connection right.
+
+But a number of bioses (both phoenix and AMI) are not working as
+expected. (I have an AMI BIOS which sets ACPI table bit 15 to 0 and then
+connect IRQ0 -> INT2 internally, Another bios I have sets the ACPI table bit
+15 to 0, but does not connect IRQ0 -> INT2. Both would result in a hang in
+calibrate_delay() since there would not be any timer interrupts So I have
+provided a command line parameter which overrides
+the BIOS ACPI entry. So, irrespctive of the BIOS' HPET ACPI Descriptor
+table settings, if the parameter hpet_lrr=[0,1] is specified, it takes
+precedence.
+
+* When to use this parameter?
+
+Some latest versions CK-804 (e.g),(Actually the code initializes the
+CK804 in the BIOS), would correctly set the HPET such that there would not
+be any interrupts on INT0. Linux does not handle this situation very well
+because in linux, if HW is LRR capable, it is enabled from the OS. Still the
+timer interrupt handler is setup for IRQ0. Under this situation, you can
+force the parameter hpet_lrr=1, so that IRQ2 is timer interrupts.
+
+[root@mophia ~]# cat /proc/interrupts | grep 2:
+ 2:        163          0          0          0          1          7
+207     955341    IO-APIC-edge  timer
+
+[root@mophia ~]# uptime
+ 22:52:38 up 15 min,  2 users,  load average: 0.00, 0.01, 0.02
+
+[root@mophia ~]# dmesg | grep -i MP-BIOS
+
+For 15 mts (900 sec), around 95k interrupts on timer looks kinda fine.
+
+* Known Bugs:
+I have tested it only with Nvidia CK-804. There seem to be some kind of timing
+issue between enabling the HPET with LRR set and start of tinerrupts. As a
+result of which, calibrate_delay() hangs because there are no interrupts. If
+you run into such a case, pass lpj=<bogomips * 500> as a work around. i.e, if
+your bogomips is 5000, pass lpj=2500000
+
diff --git a/Documentation/kernel-parameters.txt
b/Documentation/kernel-parameters.txt
index ff571f9..36e469c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -366,6 +366,15 @@ and is between 256 and 4096 characters.
 	hpet=		[IA-32,HPET] option to disable HPET and use PIT.
 			Format: disable

+	hpet_lrr=	[IA32,X86_64,HPET] Option to enable/disable the HPET
+			Legacy replacement route. Please read Documentation/
+			hpet.txt for more info.
+			Format : {"0" | "1"}
+			0 -> Disables Legacy Route Replacement. (Default)
+			1 -> Enables LRR. Please consult your BIOS
+			documentation before doing this.
+
+
 	cm206=		[HW,CD]
 			Format: { auto | [<io>,][<irq>] }
