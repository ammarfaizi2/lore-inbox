Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUAYF0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 00:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUAYF0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 00:26:23 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:40947 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S263618AbUAYF0V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 00:26:21 -0500
Date: Sun, 25 Jan 2004 00:26:26 -0500
From: Huw Rogers <count0@localnet.com>
To: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems on Uniwill N258SA0
Message-Id: <20040124233749.5637.COUNT0@localnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.07.04 [en]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uniwill N258SA0 (http://www.uniwill.com/Product/N258SA0/N258SA0.html) aka
Hypersonic Aviator NX6, Fujitsu-Siemens AMILO D 1840 Widescreen, etc.).
SiS 648FX chipset, SiS 900 Ethercard, AMI BIOS, ATI  AV350/M10 128Mb.
My machine: Hyperthreaded P4 2.8GHz, .5Gb PC3200 RAM.

Installed Fedora. Upgraded to 2.6.2-rc1 per
http://thomer.com/linux/migrate-to-2.6.html.

Applied kernel patches:
- SiS AGP (http://lkml.org/lkml/2004/1/20/233)
  (needed to run ATI's 3.7 fglrx drivers on the SiS/M10 combo)
- ACPI 20031203 (http://acpi.sourceforge.net/)

All good, but ACPI sleep doesn't work and neither does userland IRQ
balancing with Arjan's irqbalance (http://people.redhat.com/arjanv/irqbalance/),
a standard part of the Fedora install.

irqbalance just locks up the machine totally, hard power-off needed, no
traces in the logs. Probably some issue (race?) with it writing to
/proc/irq/X/smp_affinity. And how is irqbalance supposed to play with
kirqd anyway? Grepping this list and others doesn't give any kind of an
answer. But disabling it gives all interrupts to cpu0 (looking at
/proc/interrupts). kirqd apparently only balances between CPU packages,
not between HT siblings (info gleaned from this list).

Anyway, sleep/suspend/standby functionality (important to most laptop
users, need to close the lid and go): This checkin to
kernel/power/main.c seems to disable suspend with SMP (!?):

--- 1.3/kernel/power/main.c	Sat Jan 24 20:44:47 2004
+++ 1.4/kernel/power/main.c	Sat Jan 24 20:44:47 2004
@@ -172,6 +172,12 @@
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
+	/* Suspend is hard to get right on SMP. */
+	if (num_online_cpus() != 1) {
+		error = -EPERM;
+		goto Unlock;
+	}
+
 	if ((error = suspend_prepare(state)))
 		goto Unlock;

... which, given the prevalence of hyperthreaded CPUs on laptops, is
fighting a trend. I backed out the above with a #if 0 then tried echo -n
1>/proc/acpi/sleep again. This time I got:

Stopping tasks: ===================================================================
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, kirqd not stopped
 done

kirqd just wouldn't stop.

Tried booting with acpi=off and apm=smp to force APM, then ran
apm --suspend, but it put the machine into a LCD blanked state it
couldn't get out of without another hard power cycle.

Questions: Why does irqbalance lock up the machine and how is it
supposed to collaborate with kirqd? How is ACPI suspend supposed to work
on any recent laptop if SMP is barred? Why doesn't kirqd stop when asked
to by ACPI suspend once that restriction is bypassed?

A lot of effort is going into swsusp/pmdisk - but a lot of laptop users
prefer S1 to S4, as it's faster and more reliable. It'd be nice to see a
simpler "spin down the hard drive, reduce CPU clock speed to a minimum,
and power down display/ether/wireless/usb/PCMCIA" working ahead of
hibernation.

