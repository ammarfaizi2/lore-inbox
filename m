Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVHQIKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVHQIKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVHQIKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:10:04 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:6868 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750966AbVHQIKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:10:03 -0400
Message-ID: <4302F0D8.6050409@bigpond.net.au>
Date: Wed, 17 Aug 2005 18:10:00 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for
 2.6.12 and 2.6.13-rc6
References: <43001E18.8020707@bigpond.net.au> <6bffcb0e05081614498879a72@mail.gmail.com>
In-Reply-To: <6bffcb0e05081614498879a72@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040607010400010601020307"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 17 Aug 2005 08:10:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040607010400010601020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michal Piotrowski wrote:
> Hi,
> here are schedulers benchmark (part2):
> [bits deleted]

Here's a summary of your output generated using the attached Python script.

              |         Build Statistics | Overall Statistics
-----------------------------------------------------------------------
     Scheduler|   Real    CPU  SYS   TPT |    CPU   TPT    delay    CXSW
              | (secs) (secs)  (%)   (%) | (secs)   (%)  (secs)
-----------------------------------------------------------------------
     ingosched| 3128.5 5056.3 8.18 161.6 | 5379.5 171.9 159367.4 1556452
     staircase| 3131.2 5032.6 8.09 160.7 | 5352.9 170.9 135193.0 1670366
spa_no_frills| 3103.8 5049.5 7.98 162.7 | 5266.7 169.7 172384.8  520937
   zaphod(d,d)| 3561.7 4823.8 9.25 135.4 | 5132.0 144.1 148361.5 1771617
   zaphod(d,0)| 3551.2 4809.9 9.19 135.4 | 5114.7 144.0 144022.0 1784814
   zaphod(0,d)| 3126.8 5063.2 8.11 161.9 | 5278.1 168.8 173438.4  573587
   zaphod(0,0)| 3105.5 5052.9 7.98 162.7 | 5254.8 169.2 165774.4  577534
     nicksched| 3294.7 5095.1 9.10 154.6 | 5425.4 164.6 104298.2 2205665

where the (x,y) after zaphod means (max_ia_bonus, max_tpt_bonus) and "d" 
means default.  I had to kill a few significant digits to squeeze it 
into 71 columns.  Overall statistics are extracted from the schedstats 
data.  In the "Build Statistics" "CPU" is the sum of the user and sys 
times and "SYS" is the percentage of that which was sys time (as I feel 
that is a better thing to compare than raw sys times).

I was intrigued by the fact that zaphod(d,d) and zaphod(d,0) take longer 
in real time but use less cpu.  I was assuming that this meant that some 
other job was getting some cpu but the schedstats data doesn't support 
that.  Also it wouldn't make sense anyway as you'd expect jobs doing the 
same amount of work to use roughly the same amount of cpu.  My latest 
theory is that your machine has hyper threads and this artifact is 
caused by the mechanism in the scheduler for handling tasks with 
differing priority in sibling hyper thread channels.  Does your system 
have hyper threads?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------040607010400010601020307
Content-Type: text/x-python;
 name="abb.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="abb.py"

#!/bin/env python

import re, sys

version_re = re.compile("version\s+(\d+)")
timestamp_re = re.compile("timestamp\s+(\d+)")
cpu_re = re.compile("cpu\s*(\d+)" + "\s+(\d+)" * 12)
#the domain data is corrupted so we won't try to make any sense of it
domain_re = re.compile("domain\s*(\d+)" + "\s+(\d+)*")
time_re = re.compile("(\S+)\s+(\d+)m(\d+\.\d+)s")

schedstats_ver = "12"

def label(sched_descr):
    name = sched_descr[0]
    if name != "zaphod":
        return name
    for str in sched_descr[1:]:
        if str[:12] == "max_ia_bonus":
            miab = str[13]
        else:
            mtpb = str[14]
    return name + "(" + miab + "," + mtpb + ")"

print " " * 12,
print "| %24s | %s" % ("Build Statistics", "Overall Statistics")
print "-" * 71
print "%13s|" % "Scheduler",
print "%6s" % "Real",
print "%6s" % "CPU",
print "%4s" % "SYS",
print "%5s" % "TPT",
print "|",
print "%6s" % "CPU",
print "%5s" % "TPT",
print "%8s" % "delay",
print "%7s" % "CXSW"
print "             | (secs) (secs)  (%)   (%) | (secs)   (%)  (secs)"
print "-" * 71

while True:
    line = sys.stdin.readline()
    if not line:
        break
    if line.rstrip() != "scheduler:":
        continue
    scheduler_descr = []
    while True:
        line = sys.stdin.readline()
        if line.rstrip() == "schedstat:":
            break
        if line != "\n":
            scheduler_descr.append(line.rstrip())
    line = sys.stdin.readline()
    vem = version_re.match(line)
    if not vem:
        raise "Expected schedstats version: not found."
    elif vem.groups()[0] != schedstats_ver:
        raise "I'm built for schedstats version %s but %s found" % \
            (schedstats_ver, vem.groups()[0])
    line = sys.stdin.readline()
    tsm = timestamp_re.match(line)
    if not tsm:
        raise "Expected timestamp: not found."
    start_timestamp = int(tsm.groups()[0])
    start_cpu = {}
    while True:
        line = sys.stdin.readline()
        if line == "\n":
            break
        cpum = cpu_re.match(line)
        if not cpum:
            raise "Expected cpu data: not found."
        else:
            cpugs = cpum.groups()
            icpu = []
            for str in cpugs[1:]:
                icpu.append(int(str))
            start_cpu[cpugs[0]] = tuple(icpu)
        line = sys.stdin.readline()
        dm = domain_re.match(line)
        if not dm:
            raise "Expected domain data: not found."
        else:
            # ignore domain data as it's been corrupted
            pass
    while True:
        line = sys.stdin.readline()
        tm = time_re.match(line)
        if tm:
            break
    real_time = float(tm.groups()[1]) * 60 + float(tm.groups()[2])
    line = sys.stdin.readline()
    tm = time_re.match(line)
    if not tm:
        raise "Expected cpu time used in user mode"
    user_time = float(tm.groups()[1]) * 60 + float(tm.groups()[2])
    line = sys.stdin.readline()
    tm = time_re.match(line)
    if not tm:
        raise "Expected cpu time used in system mode"
    sys_time = float(tm.groups()[1]) * 60 + float(tm.groups()[2])
    while True:
        line = sys.stdin.readline()
        if line.rstrip() == "schedstat:":
            break
    line = sys.stdin.readline()
    vem = version_re.match(line)
    if not vem:
        raise "Expected schedstats version: not found."
    elif vem.groups()[0] != schedstats_ver:
        raise "I'm built for schedstats version %s but %s found" % \
            (schedstats_ver, vem.groups()[0])
    line = sys.stdin.readline()
    tsm = timestamp_re.match(line)
    if not tsm:
        raise "Expected timestamp: not found."
    stop_timestamp = int(tsm.groups()[0])
    stop_cpu = {}
    while True:
        line = sys.stdin.readline()
        if line == "\n":
            break
        cpum = cpu_re.match(line)
        if not cpum:
            raise "Expected cpu data: not found."
        else:
            cpugs = cpum.groups()
            icpu = []
            for str in cpugs[1:]:
                icpu.append(int(str))
            stop_cpu[cpugs[0]] = tuple(icpu)
        line = sys.stdin.readline()
        dm = domain_re.match(line)
        if not dm:
            raise "Expected domain data: not found."
        else:
            # ignore domain data as it's been corrupted
            pass
    delta_stats = {}
    combined_delta_stats = []
    for key in start_cpu.keys():
        start = start_cpu[key]
        stop = stop_cpu[key]
        delta_array = []
        for i in range(len(start)):
            delta = stop[i] - start[i]
            delta_array.append(delta)
            try:
                combined_delta_stats[i] += delta
            except:
                combined_delta_stats.append(delta)
        delta_stats[key] = tuple(delta_array)
    if start_timestamp < stop_timestamp:
        duration = stop_timestamp - start_timestamp
    else:
        duration = (stop_timestamp + 2**32 - 1) - start_timestamp
    total_time = user_time + sys_time
    percent_sys = sys_time * 100 / total_time
    percent_cpu = total_time * 100 / real_time
    total_cpu = combined_delta_stats[9]
    total_percent_cpu = float(total_cpu) * 100 / duration
    total_delay = combined_delta_stats[10]
    total_context_switches = combined_delta_stats[11]
    print "%13s|" % label(scheduler_descr),
    print "%5.1f" % real_time,
    print "%5.1f" % total_time,
    print "%3.2f" % percent_sys,
    print "%4.1f" % percent_cpu,
    print "|",
    print "%5.1f" % (float(total_cpu) / 1000),
    print "%4.1f" % total_percent_cpu,
    print "%7.1f" % (float(total_delay) / 1000),
    print "%7d" % total_context_switches

--------------040607010400010601020307--
