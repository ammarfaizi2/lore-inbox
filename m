Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755841AbWKQToB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbWKQToB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbWKQToB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:44:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:62357 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1755841AbWKQToA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:44:00 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,435,1157353200"; 
   d="scan'208"; a="147934359:sNHT20339585"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq userspace governor does not reflect changes
Date: Fri, 17 Nov 2006 11:42:58 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E763B5@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq userspace governor does not reflect changes
Thread-Index: AccKfQn9ie+hyudOTsuDAA0LXQKUpgAAqbxQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dhaval Giani" <dhaval.giani@gmail.com>, <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Nov 2006 19:42:59.0234 (UTC) FILETIME=[9604D820:01C70A80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/sys/devices/....../cpuX/cpufreq/scaling_cur_freq
Gives you the information about last frequency that Linux tried to set
on this CPU 

/sys/devices/....../cpuX/cpufreq/cpuinfo_cur_freq
(When supported) Gives you the information about actual frequency that
the CPU is running at. 

Zero frequency value below is certainly a bug in the driver. What is the
kernel you are using?
On the particular CPU you have here, all cores in a package indeed share
the frequency. But, it does not really show up in affected_cpus as OS is
not coordinating the shared-ness of P-state across cores. That means, OS
programs each core individually based on CPU utilization and hardware
will pick the highest frequency among the two and run both cores at that
frequency.

-Venki

>-----Original Message-----
>From: Dhaval Giani [mailto:dhaval.giani@gmail.com] 
>Sent: Friday, November 17, 2006 11:17 AM
>To: Pallipadi, Venkatesh; davej@codemonkey.org.uk
>Cc: linux-kernel@vger.kernel.org
>Subject: cpufreq userspace governor does not reflect changes
>
>Hey there,
>
>I finally managed to get cpufreq working. And while using the
>userspace governor, I came up with a curious output.
>
>[root@localhost cpufreq]# cat *
>0
>1862000
>1596000
>1862000 1596000
>ondemand userspace performance
>1862000
>acpi-cpufreq
>userspace
>1862000
>1596000
>1862000
>cat: stats: Is a directory
>[root@localhost cpufreq]# echo 1596000 > scaling_setspeed
>[root@localhost cpufreq]# cat *
>0
>1862000
>1596000
>1862000 1596000
>ondemand userspace performance
>0
>acpi-cpufreq
>userspace
>1862000
>1596000
>0
>cat: stats: Is a directory
>[root@localhost cpufreq]#
>
>This is on a Core 2 Duo E6300 processor. The dmesg looks like this,
>
>cpufreq-core: setting new policy for CPU 0: 1596000 - 1862000 kHz
>acpi-cpufreq: acpi_cpufreq_verify
>freq-table: request for verification of policy (1596000 - 
>1862000 kHz) for cpu 0
>freq-table: verification lead to (1596000 - 1862000 kHz) for cpu 0
>acpi-cpufreq: acpi_cpufreq_verify
>freq-table: request for verification of policy (1596000 - 
>1862000 kHz) for cpu 0
>freq-table: verification lead to (1596000 - 1862000 kHz) for cpu 0
>cpufreq-core: new min and max freqs are 1596000 - 1862000 kHz
>cpufreq-core: governor switch
>cpufreq-core: __cpufreq_governor for CPU 0, event 2
>cpufreq-core: __cpufreq_governor for CPU 0, event 1
>userspace: managing cpu 0 started (1596000 - 1862000 kHz, 
>currently 1862000 kHz)
>cpufreq-core: governor: change or update limits
>cpufreq-core: __cpufreq_governor for CPU 0, event 3
>userspace: limit event for cpu 0: 1596000 - 1862000 kHz,currently
>1862000 kHz, last set to 1862000 kHz
>cpufreq-core: target for CPU 0: 1862000 kHz, relation 0
>acpi-cpufreq: acpi_cpufreq_target 1862000 (0)
>freq-table: request for target 1862000 kHz (relation: 0) for cpu 0
>freq-table: target is 0 (1862000 kHz, 0)
>acpi-cpufreq: Already at target state (P0)
>printk: 30 messages suppressed.
>userspace: cpufreq_set for cpu 0, freq 1596000 kHz
>cpufreq-core: target for CPU 0: 1596000 kHz, relation 0
>acpi-cpufreq: acpi_cpufreq_target 1596000 (0)
>freq-table: request for target 1596000 kHz (relation: 0) for cpu 0
>freq-table: target is 1 (1596000 kHz, 9)
>cpufreq-core: notification 0 of frequency transition to 0 kHz
>userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
>cpufreq-core: notification 1 of frequency transition to 0 kHz
>userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
>[root@localhost cpufreq]#
>
>How can I verify what is the processor speed I'm running at? And is
>this the result expected? (Also is this how I change the frequency in
>a multi-core system? Googling did not really get me anything) As a
>side note, I'm also curious to know whether multi core systems support
>the processors running at multiple clock speeds? (Somewhere I remember
>understanding the code to add all the processors to be added to
>affected_cpus map, and if any cpu in that one is affected, all of them
>are. Did i understand it right?)
>
>Thanks and regards
>Dhaval Giani
>
