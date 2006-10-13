Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWJMEvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWJMEvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 00:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJMEvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 00:51:00 -0400
Received: from hera.kernel.org ([140.211.167.34]:57780 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750699AbWJMEu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 00:50:59 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: cpufreq@lists.linux.org.uk
Subject: Re: Strange entries in /proc/acpi/thermal_zone for Thinkpad X60
Date: Fri, 13 Oct 2006 00:53:10 -0400
User-Agent: KMail/1.8.2
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-acpi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <452EBF7C.3000409@goop.org>
In-Reply-To: <452EBF7C.3000409@goop.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610130053.10437.len.brown@intel.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 18:19, Jeremy Fitzhardinge wrote:
> I have a Thinkpad X60 with an Intel Core Duo T2400.  In 
> /proc/acpi/thermal_zone, I'm getting two subdirectories, each with their 
> own set of files:
> 
> /proc/acpi/thermal_zone/THM0/cooling_mode:
> <setting not supported>
> cooling mode:   critical
> 
> /proc/acpi/thermal_zone/THM0/polling_frequency:
> <polling disabled>
> 
> /proc/acpi/thermal_zone/THM0/state:
> state:                   ok
> 
> /proc/acpi/thermal_zone/THM0/temperature:
> temperature:             53 C
> 
> /proc/acpi/thermal_zone/THM0/trip_points:
> critical (S5):           127 C


This means that if THM0 reaches 127, your system will shut down.
You don't have much control over this one -- but you could probably
lower the temperature  to do a critical shut-down earlier with something like this:

echo -n "126:125:124:123:122" >trip_points
note that the 1st is the critical one, and the others are hot:passive:active:active place holders.

> 
> /proc/acpi/thermal_zone/THM1/cooling_mode:
> <setting not supported>
> cooling mode:   passive
> 
> /proc/acpi/thermal_zone/THM1/polling_frequency:
> <polling disabled>
> 
> /proc/acpi/thermal_zone/THM1/state:
> state:                   ok
> 
> /proc/acpi/thermal_zone/THM1/temperature:
> temperature:             53 C
> 
> /proc/acpi/thermal_zone/THM1/trip_points:
> critical (S5):           97 C
> passive:                 93 C: tc1=5 tc2=4 tsp=600 devices=0xf7eaa264 0xf7eaa244 

You are not given the opportunity to set the active trip points here.
Looks like you have just a passive trip point at 93 and we would
expect to throttle when we go above 93.
Presumably some other method should be kicking in the fans before
this passive point is reached.

The theory is that...
If the fans kicked in earlier than you liked, you should be able to lower
the passive trip point to below that temperature to make the system
throttle before the fans kick in.

But probably the root cause of your issue is that the fans are _not_ kicking in...

for grins you can probably raise the passive point with something like this

# echo -n "98:97:96:53:45" > trip_points

but it seems that you are doing passive cooling way before  you
get anywhere near 93, so that is the mystery.

-Len

> 
> 
> The interesting thing is that the two sets of files are not consistent - 
> sometimes they don't even show the same temperature.
> 
> The reason I'm interested in this is that I think it's behind some of my 
> cpufreq problems.  Sometimes the kernel decides that I just can't raise 
> the max frequency above 1GHz, because its been thermally limited (I've 
> put printks in to confirm that its the ACPI thermal limit on the policy 
> notifier chain which is limiting the max speed).  It seems to me that 
> having a thermal zone for each core is a BIOS bug, since they're really 
> the same chip, but the THM1 entries should be ignored.  I don't believe 
> the CPU has ever approached either 97 C, let alone 127; while I put it 
> under a fair amount of load, it is sitting on a desktop with no airflow 
> obstructions, so if it really is overheating it suggests a serious 
> design problem with the hardware.
> 
> But I'm just speculating; I'm not really sure what all this means.  Any 
> clues?
> 
> Thanks,
>     J
> 
> _______________________________________________
> Cpufreq mailing list
> Cpufreq@lists.linux.org.uk
> http://lists.linux.org.uk/mailman/listinfo/cpufreq
> 
