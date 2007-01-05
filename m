Return-Path: <linux-kernel-owner+w=401wt.eu-S1750786AbXAEVzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXAEVzi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAEVzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:55:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37649 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbXAEVzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:55:37 -0500
Date: Fri, 5 Jan 2007 22:52:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
Subject: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070105215223.GA5361@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i'm pleased to announce the first release of paravirtualized KVM (Linux 
under Linux), which includes support for the hardware cr3-cache feature 
of Intel-VMX CPUs. (which speeds up context switches and TLB flushes)

the patch is against 2.6.20-rc3 + KVM trunk and can be found at:

   http://redhat.com/~mingo/kvm-paravirt-patches/

Some aspects of the code are still a bit ad-hoc and incomplete, but the 
code is stable enough in my testing and i'd like to have some feedback. 

Firstly, here are some numbers:

2-task context-switch performance (in microseconds, lower is better):

 native:                       1.11
 ----------------------------------
 Qemu:                        61.18
 KVM upstream:                53.01
 KVM trunk:                    6.36
 KVM trunk+paravirt/cr3:       1.60

i.e. 2-task context-switch performance is faster by a factor of 4, and 
is now quite close to native speed!

"hackbench 1" (utilizes 40 tasks, numbers in seconds, lower is better):

 native:                       0.25
 ----------------------------------
 Qemu:                         7.8
 KVM upstream:                 2.8
 KVM trunk:                    0.55
 KVM paravirt/cr3:             0.36

almost twice as fast.

"hackbench 5" (utilizes 200 tasks, numbers in seconds, lower is better):

 native:                       0.9
 ----------------------------------
 Qemu:                        35.2
 KVM upstream:                 9.4
 KVM trunk:                    2.8
 KVM paravirt/cr3:             2.2

still a 30% improvement - which isnt too bad considering that 200 tasks 
are context-switching in this workload and the cr3 cache in current CPUs 
is only 4 entries.

the patchset does the following:

- it provides an ad-hoc paravirtualization hypercall API between a Linux 
  guest and a Linux host. (this will be replaced with a proper
  hypercall later on.)

- using the hypercall API it utilizes the "cr3 target cache" feature in 
  Intel VMX CPUs, and extends KVM to make use of that cache. This 
  feature allows the avoidance of expensive VM exits into hypervisor 
  context. (The guest needs to be 'aware' and the cache has to be
  shared between the guest and the hypervisor. So fully emulated OSs
  wont benefit from this feature.)

- a few simpler paravirtualization changes are done for Linux guests: IO 
  port delays do not cause a VM exit anymore, the i8259A IRQ controller 
  code got simplified (this will be replaced with a proper, hypercall
  based and host-maintained IRQ controller implementation) and TLB 
  flushes are more efficient, because no cr3 reads happen which would 
  otherwise cause a VM exit. These changes have a visible effect
  already: they reduce qemu's CPU usage when a guest idles in HLT, by 
  about 25%. (from ~20% CPU usage to 14% CPU usage if an -rt guest has 
  HZ=1000)

Paravirtualization is triggered via the kvm_paravirt=1 boot option (for 
now, this too is ad-hoc) - if that is passed then the KVM guest will 
probe for paravirtualization availability on the hypervisor side - and 
will use it if found. (If the guest does not find KVM-paravirt support 
on the hypervisor side then it will continue as a fully emulated guest.)

Issues: i only tested this on 32-bit VMX. (64-bit should work with not 
too many changes, the paravirt.c bits can be carried over to 64-bit 
almost as-is. But i didnt want to spread the code too wide.)

Comments, suggestions are welcome!

	Ingo
