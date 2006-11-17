Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755942AbWKQVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942AbWKQVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755943AbWKQVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:22:29 -0500
Received: from nz-out-0102.google.com ([64.233.162.200]:34223 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1755942AbWKQVW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:22:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EC1qgb2mKbC6a3K1f4Nfu+OkTGZHh6sqbQBSI0/7Q+zRdPvzAwJvB7HN1iOr8vyMGefg2IYyHxJ+ZcytAUVVX/qiFokrfbMg4Tq39X0y3KLQjA333EnfgxzdqoQi2CFJA3tV6lshMxVMrLRv8kLKzQTbekKdy7d8sr0nMZNnc78=
Message-ID: <8aa016e10611171322h2f736d3fo413ec81298f6a8a2@mail.gmail.com>
Date: Sat, 18 Nov 2006 02:52:27 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       davej@codemonkey.org.uk, paul.s.diefenbaugh@intel.com, linux@brodo.de,
       denis.m.sadykov@intel.com
Subject: [BUG][acpi-cpufreq/userspace-governor]Frequency does not change
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

Looks like I spoke too soon. I tried changing the frequency in cpu1
and then it all fell apart. I got a ridiculously high value. To test
it, I rebooted my system, and this is what happened.

[root@localhost dhaval]# cd /sys/devices/system/cpu/cpu0/cpufreq/
[root@localhost cpufreq]# cat *
0
1862000
1862000
1596000
1862000 1596000
ondemand userspace
1862000
acpi-cpufreq
userspace
1862000
1596000
1862000
cat: stats: Is a directory
[root@localhost cpufreq]# echo 1596000 > scaling_setspeed
[root@localhost cpufreq]# cat *
0
1862000
1862000
1596000
1862000 1596000
ondemand userspace
0
acpi-cpufreq
userspace
1862000
1596000
0
cat: stats: Is a directory
[root@localhost cpufreq]# cd ../../cpu1/cpufreq/
[root@localhost cpufreq]# cat *
1
1862000
1862000
1596000
1862000 1596000
ondemand userspace
1862000
acpi-cpufreq
userspace
1862000
1596000
1862000
cat: stats: Is a directory
[root@localhost cpufreq]# echo 1596000 > scaling_setspeed
[root@localhost cpufreq]# cat *
1
1596000
1862000
1596000
1862000 1596000
ondemand userspace
4294967295
acpi-cpufreq
userspace
1862000
1596000
4294967295
cat: stats: Is a directory
[root@localhost cpufreq]# cd ../../cpu1/cpufreq
[root@localhost cpufreq]# cat *
1
1596000
1862000
1596000
1862000 1596000
ondemand userspace
4294967295
acpi-cpufreq
userspace
1862000
1596000
4294967295
cat: stats: Is a directory


The dmesg is as follows,
acpi-cpufreq: get_cur_freq_on_cpu (0)
acpi-cpufreq: get_cur_val = 100665128
acpi-cpufreq: cur freq = 1862000
userspace: cpufreq_set for cpu 0, freq 1596000 kHz
cpufreq-core: target for CPU 0: 1596000 kHz, relation 0
acpi-cpufreq: acpi_cpufreq_target 1596000 (0)
freq-table: request for target 1596000 kHz (relation: 0) for cpu 0
freq-table: target is 1 (1596000 kHz, 9)
cpufreq-core: notification 0 of frequency transition to 0 kHz
userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
cpufreq-core: notification 1 of frequency transition to 0 kHz
userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
acpi-cpufreq: get_cur_freq_on_cpu (0)
printk: 2 messages suppressed.
acpi-cpufreq: get_cur_freq_on_cpu (1)
acpi-cpufreq: get_cur_val = 100665128
acpi-cpufreq: cur freq = 1862000
userspace: cpufreq_set for cpu 1, freq 1596000 kHz
cpufreq-core: target for CPU 1: 1596000 kHz, relation 0
acpi-cpufreq: acpi_cpufreq_target 1596000 (1)
freq-table: request for target 1596000 kHz (relation: 0) for cpu 1
freq-table: target is 1 (1596000 kHz, 9)
cpufreq-core: notification 0 of frequency transition to 4294967295 kHz
printk: 6 messages suppressed.
acpi-cpufreq: get_cur_freq_on_cpu (0)
acpi-cpufreq: get_cur_val = 100664859
acpi-cpufreq: cur freq = 1596000
acpi-cpufreq: get_cur_freq_on_cpu (1)
acpi-cpufreq: get_cur_val = 100664859
acpi-cpufreq: cur freq = 1596000
[root@localhost cpufreq]#

This is on the 2.6.19-rc5-mm2 with the patch at
http://lkml.org/lkml/2006/11/15/302 applied.

Thanks and regards
Dhaval Giani
