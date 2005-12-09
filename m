Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVLICOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVLICOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVLICOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:14:23 -0500
Received: from fmr22.intel.com ([143.183.121.14]:53978 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751190AbVLICOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:14:23 -0500
Date: Thu, 8 Dec 2005 18:14:14 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: [RFC][PATCH 0/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051208181414.E32524@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the duplicate. Had an incomplete subject line in the earlier mail.

Thanks,
Venki

Problem:
Processor C3 state and beyond will shut down the local APIC timer 
on variety of Intel processors. This will be a issue on systems with more than
one logical CPUs, as these systems depend on local APIC timer and timer 
interrupt for scheduling (idle_balance/busy_balance) and process accounting 
purposes. 
One of the side-effects of this is, the idle time reported for a CPU can be less
than the actual time is spends idling. As a result of this wrong idle time
being reported, ondemand governor and other similar programs that depend on
the idle statistics may get misled. ondemand governor will think system is 
less idle than it really is and will increase the CPU frequency unnecessarily, 
for example.

Solution:
After my failed attempt earlier  
(http://www.ussg.iu.edu/hypermail/linux/kernel/0504.3/1640.html),
I am back with another attempt.

The basic idea is to use the external timer interrupt and have one CPU broadcast
it to all the other C3 capable CPUs through an IPI. The C3 capable CPUs will 
disable local APIC timer. Note that C3 capability on a CPU can appear/disappear
during run-time. So, whether a CPU uses local APIC or timer interrupt broadcast
can change at run time. But, once a CPU is detected as C3 capable we start using
the broadcast mode (even when CPU is not really in C3).

This patch should be a noop on systems that does not support C3.

The patch is split into 3 parts
* remove sub-jiffy control in local APIC timer.
* i386 apic changes to switch from APIC timer to broadcast timer
* x86_64 apic changes to switch from APIC timer to broadcast timer

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Comments?

Thanks,
Venki


