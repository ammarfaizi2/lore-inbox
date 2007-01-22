Return-Path: <linux-kernel-owner+w=401wt.eu-S1751901AbXAVHbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXAVHbA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 02:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXAVHbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 02:31:00 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:33906 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbXAVHa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 02:30:59 -0500
Message-ID: <45B47200.6030908@in.ibm.com>
Date: Mon, 22 Jan 2007 13:42:48 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.9 (X11/20061215)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, ashok.raj@intel,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       mingo@redhat.com
Subject: [Need Help] Cpuhotplug operations on 32-bit mode of xeon-64bit processor
 crashes the system.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw cpuhotplug operations on 32-bit mode of xeon-64bit processors 
crashing the system. This happens on latest 2.6.20-rc5 kernel also. Same 
(i386 cpuhotplug code) runs fine on xeon-32bit processors.
Steps to reproduce.
====================
echo 0 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu6/online
================================
dmesg shows.
==============
Breaking affinity for irq 4
cpu_mask_to_apicid: Not a valid mask!
CPU 6 is now offline
=======================

On debugging the problem, I found that problem is not in cpuhotplug code 
but in apic part. Execution of  "stale" IPI's by onlined cpus(which we 
offlined earlier) is causing the crash. Now we need to debug,why IPI's 
are reaching the offlined cpu's too.

1)   During the calculation of apicid's, if cpu to which IPI has to 
deliver is not in
same apic cluster,it prints "Not a valid mask" error and returns "0xFF" 
which means broadcast the IPI's to all cpus(which are offlined too) and 
hence the problem.

2) I booted the system with maxcpus=2 boot parameter, and tried cpu 
hotplugging on it.
but still problem recreates(I think there is no concept of apic clusters 
if there are only 2 cpus). Hence it makes me to conclude that problem is 
in delivery of IPI's.

So Iam completely stuck here. Iam not able to move forward in debugging. 
So could someone(may be intel folks) please throw some light on this.

Thanks in advance
  Srinivasa DS
  LTC-IBM

