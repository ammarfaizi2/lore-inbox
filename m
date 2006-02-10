Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWBJFR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWBJFR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBJFR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:17:58 -0500
Received: from mail.gmx.de ([213.165.64.21]:25292 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751105AbWBJFR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:17:58 -0500
X-Authenticated: #7534793
Date: Fri, 10 Feb 2006 06:14:52 +0100
From: Gerhard Schrenk <deb.gschrenk@gmx.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: EC interrupt mode by default breaks power button and lid button
Message-ID: <20060210051451.GA4351@mailhub.uni-konstanz.de>
References: <3ACA40606221794F80A5670F0AF15F840AE28A07@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AE28A07@pdsmsx403>
User-Agent: mutt-ng/devel-r655 (Debian)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu, Luming <luming.yu@intel.com> [2006-02-10 00:37]:

> It's interesting. Could you file a bug in ACPI category on
> bugzilla.kernel.org?

http://bugzilla.kernel.org/show_bug.cgi?id=6049

BTW with ec_initr=1 I cannot toggle the hardware based rf_kill (for ipw2200).
But with ec_initr=0 I can toggle it. This is reflected by the blue "WLAN" led and

/sys/devices/pci0000:00/0000:00:1e.0/0000:01:09.0/rf_kill

> BTW, does battery work?

Mmmh. I see interrupt 9 "IO-APIC-edge  acpi" in /proc/interrupts
increase for ec_intr=0. But it seems to increase all the time so I'm not
sure if it's triggered by battery (un)plug events.

However I cannot see any acpid-events in /var/log/acpid with ec_initr=0 when
(un)plugging the battery. (battery was present and correctly detected on boot.)

For ec_intr=1 interrupt 9 "IO-APIC-edge  acpi in /proc/interrupts is
definitely always constant to 1. No acpid-events, too.


Interestingly the following battery problem is independant of ec_intr:

/proc/acpi/battery/BAT1/{info,state} shows only sensible battery data, if the
battery was **present at boot time**. When unplugging the battery it still says
"present: yes" and /proc/acpi/battery/BAT1/info does not change at all. 
/proc/acpi/battery/BAT1/state does change like this:

--- ec1-plugged-state   2006-02-10 04:40:54.000000000 +0100
+++ ec1-unplugged-state 2006-02-10 04:42:31.000000000 +0100
@@ -1,6 +1,6 @@
 present:                 yes
 capacity state:          ok
-charging state:          charging
-present rate:            1930 mA
-remaining capacity:      2433 mAh
-present voltage:         16202 mV
+charging state:          charged
+present rate:            unknown
+remaining capacity:      unknown
+present voltage:         10000 mV


If the battery was **not present at boot time** and is plugged in *after* booting
the system, it will never be detected by /proc/acpi/battery/BAT1/{info,state}.
It always says "present: no". With Kernel v2.6.15 compiling the acpi drivers as modules, i.e. 
CONFIG_ACPI_BATTERY=m and same fo other acpi drivers helps. But I have to

  $ rmmod battery
  $ modprobe battery

first. No chance with statically compiled acpi-drivers. :(

-- Gerhard
