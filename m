Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVATA5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVATA5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVATA5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:57:31 -0500
Received: from gprs215-87.eurotel.cz ([160.218.215.87]:35799 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262014AbVATA5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:57:16 -0500
Date: Thu, 20 Jan 2005 01:44:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050120004404.GA1366@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <20050119220637.GA7513@elf.ucw.cz> <20050119230813.GI14545@atomide.com> <20050119235905.GA1371@elf.ucw.cz> <20050120000755.GD9975@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120000755.GD9975@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > Thanks. Looks like you're running on PIT only, I guess my patch
> > > currently breaks PIT (and possibly HPET) No dmesg message for "
> > > "Using XXX for high-res timesource".
> > 
> > This machine definitely has TSC... What do I have to do in .config to
> > make it do something interesting? My .config is:
> 
> I suspect it's the HPET_TIMER, see below. CONFIG_X86_PM_TIMER is
> optional, otherwise TSC is used.

Now it seems to work okay, see below.

root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -t 10 tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done |
uniq
PCI: Setting latency timer of device 0000:00:11.5 to 64
dyn-tick: Enabling dynamic tick timer
dyn-tick: Timer using dynamic tick
20 Jan 01:39:45 ntpdate[1365]: step time server 195.113.144.238 offset -3.449324 sec
20 Jan 01:40:00 ntpdate[1371]: adjust time server 195.113.144.238 offset 0.005790 sec
20 Jan 01:40:15 ntpdate[1375]: adjust time server 195.113.144.238 offset 0.024061 sec
20 Jan 01:40:31 ntpdate[1380]: adjust time server 195.113.144.238 offset 0.004277 sec
20 Jan 01:40:46 ntpdate[1384]: adjust time server 195.113.144.238 offset 0.000283 sec
Thu Jan 20 01:40:56 CET 2005
Thu Jan 20 01:41:06 CET 2005
Thu Jan 20 01:41:06 CET 2005
Thu Jan 20 01:41:07 CET 2005
Thu Jan 20 01:41:08 CET 2005
Thu Jan 20 01:41:09 CET 2005
Thu Jan 20 01:41:10 CET 2005
Thu Jan 20 01:41:11 CET 2005

Timer interrupts are no longer that common, good.

root@amd:~# cat /proc/interrupts ; sleep 10; cat /proc/interrupts
           CPU0
  0:      16390    IO-APIC-edge  timer
  1:        646    IO-APIC-edge  i8042
 10:         49   IO-APIC-level  acpi
 12:         69    IO-APIC-edge  i8042
 14:       1688    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 17:          1   IO-APIC-level  yenta
 19:          2   IO-APIC-level  ohci1394
 21:       1252   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
 22:          0   IO-APIC-level  VIA8233
 23:          3   IO-APIC-level  eth0
NMI:          0
LOC:      20306
ERR:          0
MIS:          0
           CPU0
  0:      16586    IO-APIC-edge  timer
  1:        647    IO-APIC-edge  i8042
 10:         49   IO-APIC-level  acpi
 12:         69    IO-APIC-edge  i8042
 14:       1744    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 17:          1   IO-APIC-level  yenta
 19:          2   IO-APIC-level  ohci1394
 21:       1337   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
 22:          0   IO-APIC-level  VIA8233
 23:          3   IO-APIC-level  eth0
NMI:          0
LOC:      20647
ERR:          0
MIS:          0

								Pavel
> --- config.orig	2005-01-19 16:05:16.000000000 -0800
> +++ config	2005-01-19 16:06:07.000000000 -0800
> @@ -103,7 +103,7 @@
>  CONFIG_X86_GOOD_APIC=y
>  CONFIG_X86_INTEL_USERCOPY=y
>  CONFIG_X86_USE_PPRO_CHECKSUM=y
> -CONFIG_HPET_TIMER=y
> +# CONFIG_HPET_TIMER is not set
>  CONFIG_NO_IDLE_HZ=y
>  # CONFIG_SMP is not set
>  CONFIG_PREEMPT=y
> @@ -169,7 +169,7 @@
>  CONFIG_ACPI_POWER=y
>  CONFIG_ACPI_PCI=y
>  CONFIG_ACPI_SYSTEM=y
> -# CONFIG_X86_PM_TIMER is not set
> +CONFIG_X86_PM_TIMER=y
>  # CONFIG_ACPI_CONTAINER is not set
>  
>  #


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
