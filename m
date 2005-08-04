Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVHDN41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVHDN41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVHDN4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:56:13 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:50576 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S262540AbVHDNzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:55:14 -0400
Date: Thu, 4 Aug 2005 15:55:13 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: MCE problem on dual Opteron
Message-ID: <Pine.LNX.4.60.0508041409350.15091@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.60.0508041409352.15091@kepler.fjfi.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following problem with 2.6.13-rc5-git1 on a dual Opteron 
machine:

---------
...
[   847.745921] CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
[   847.746066] RIP 10:<ffffffff802c04ee> {pci_conf1_read+0xbe/0x110}
[   847.746149] TSC 189fe311d3f ADDR fdfc000cfe
[   847.746218] Kernel panic - not syncing: Uncorrected machine check
---------

This appears during bootup and it hangs. So my question is: Is this a HW 
problem or is it some kernel (MCE ?) bug? If it is a HW problem is it 
possible to determine what's wrong somehow?

The above mentioned output I get also from 2.6.13-rc4-git4 and 2.6.12.3. 
When I run the original FC4 kernel 2.6.11-1.1369_FC4smp I get the same 
followed by the following call trace:

---------
Call Trace: <#MC> <ffffffff80139195>{panic+133} 
<ffffffff80115e1f>{print_mce+159} <ffffffff80115ed9>{mce_panic+137} 
<ffffffff801165b4><do_machine_check+852} 
<ffffffff802e8f5e>{pci_conf1_read+190} 
<ffffffff802e8f5e>{pci_conf1_read+190} 
<ffffffff8010fe7f>{machine_check+127} 
<ffffffff801f2c60>{selinux_d_instantiate+0} 
<ffffffff802e8f5e>{pci_conf1_read+190} <EOE> 
<ffffffff80541f97>{pci_direct_init+119} <ffffffff8010c232>{init+482} 
<ffffffff8010f76b>{child_rip+8} <ffffffff8010c050>{init+0} 
<ffffffff8010f763>{child_rip+0}
--------

Interesting is, that FC4 automatically sets the 'nomce' option to the 
kernel command line by default (which leads me to that it may actually 
be a bug in the kernel). And when 'nomce' is used the system boots 
and runs quite normally.

Only recently with 2.6.12.3 (which the box was running past few 
months) from time to time (so far it happend 3 times in about a month) the 
box completly stops responding to the outside world (no network, display 
turns off (no signal), USB keyboard and mouse both go dead, however the 
comp isn't turned off because for instance the disks are still normally 
flashing with the LEDs, but that may be due to the intelligent LSI 1030 
controller with its own independent processor), so basically the box is 
dead to te outside world. There's nothing unusual in the kernel logs. The 
only thing that may be a result of that is that the IPMI server management 
card registers the following 4 system events, however I'm not very clever 
from that:

---------
1)
	SEL Entry Number = 5
	SEL Record ID = 0050
	SEL Record Type = 02 - System Event Record
	Timestamp: 3.8.2005 02:31:59
	Generator ID: 21 00
	SEL Message Rev = 04
	Sensor Type = 20 - OS Critical Stop
	Sensor Number = 41 (unknown)
	SEL Event Type = 6F - Sensor-specific, Assertion
	SEL Event Data = A1 69 65
2)
	SEL Entry Number = 6
	SEL Record ID = 0060
	SEL Record Type = 0F - OEM Defined
	Timestamp:
	Generator ID: 65 65
	SEL Message Rev = 2C
	Sensor Type = 20 - OS Critical Stop
	Sensor Number = 6B - (unknown)
	SEL Event Type = 69
	SEL Event Data = 6C 6C 69
3)
	SEL Entry Number = 7
	SEL Record ID = 0070
	SEL Record Type = 0F - OEM Defined
	Timestamp:
	Generator ID: 20 69
	SEL Message Rev = 6E
	Sensor Type = 74
	Sensor Number = 65 - (unknown)
	SEL Event Type = 72
	SEL Event Data = 72 75 70
4)
	SEL Entry Number = 8
	SEL Record ID = 0080
	SEL Record Type = 0F - OEM Defined
	Timestamp:
	Generator ID: 68 61
	SEL Message Rev = 6E
	Sensor Type = 64
	Sensor Number = 6C - (unknown)
	SEL Event Type = 65
	SEL Event Data = 72 21 00
---------

Interesting is, however, that while the timestamp in the above event log 
says 3.8.2005 02:31:59, when I look into the /var/log/messages it looks 
like this:

---------
Aug  3 02:25:01 neutron crond(pam_unix)[6257]: session opened for user root by (uid=0)
Aug  3 02:25:02 neutron crond(pam_unix)[6257]: session closed for user root
Aug  3 02:30:01 neutron crond(pam_unix)[6299]: session opened for user root by (uid=0)
Aug  3 02:30:01 neutron crond(pam_unix)[6300]: session opened for user root by (uid=0)
Aug  3 02:30:01 neutron crond(pam_unix)[6300]: session closed for user root
Aug  3 02:30:01 neutron crond(pam_unix)[6299]: session closed for user root
Aug  3 02:35:01 neutron crond(pam_unix)[6344]: session opened for user root by (uid=0)
Aug  3 02:35:01 neutron crond(pam_unix)[6344]: session closed for user root
...
Aug  3 04:01:02 neutron crond(pam_unix)[8132]: session closed for user root
Aug  3 04:02:01 neutron crond(pam_unix)[8171]: session opened for user root by (uid=0)
Aug  3 18:03:54 neutron syslogd 1.4.1: restart.
Aug  3 18:03:54 neutron kernel: klogd 1.4.1, log source = /proc/kmsg started.
---------

So basically there are logs up until 04:02:01 and then the whole day 
nothing (which is strange) until at 18:03:54 I hit the reset button.

I'll be very glad if anyone could tell me what's going on.

Thanks,
Martin

P.S.: The system is an MSI MS-9245 (AMD8131+8111) with 2xOpteron 246 and 
2 GB of ECC memory.
