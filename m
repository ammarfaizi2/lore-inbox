Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbVKSCTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbVKSCTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbVKSCTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:19:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:19692 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161209AbVKSCTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:19:30 -0500
Subject: [RFC][PATCH 0/7]: Fix for unsafe notifier chain
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, paulmck@us.ibm.com, kaos@sgi.com,
       Alan Stern <stern@rowland.harvard.edu>, greg@kroah.com,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Nov 2005 18:19:27 -0800
Message-Id: <1132366767.9617.12.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.14, notifier chains are unsafe. notifier_call_chain() walks through
the list of a call chain without any protection.

Alan Stern <stern@rowland.harvard.edu> brought the issue and suggested a fix
in lkml on Oct 24 2005:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2

There was a lot of discussion on that thread regarding the issue, and
following were the conclusions about the requirements of the notifier
call mechanism:

	- The chain list has to be protected in all the places where the
	  list is accessed.
	- We need a new notifier_head data structure to encompass the head 
	  of the notifier chain and a semaphore that protects the list.
	- There should be two types of call chains: one that is called in 
	  a process context and another that is called in atomic/interrupt
	  context.
	- No lock should be acquired in notifier_call_chain() for an
	  atomic-type chain.
	- notifier_chain_register() and notifier_chain_unregister() should
	  be called only from process context.
	- notifier_chain_unregister() should _not_ be called from a
	  callout routine.

I posted an RFC that meets the above listed requirements last Friday:
	- http://marc.theaimsgroup.com/?l=linux-kernel&m=113175279131346&w=2
	
Paul McKenney provided some suggestions w.r.t RCU usage. This patchset fixes
the issues he raised.  Keith Owens posted some changes to the diechain for
various architectures; his changes are included here.

This is posted as an RFC as we want to get a green signal from the owners of
the files that our classification of chains as ATOMIC or BLOCKING is ok.
Please comment.

This patchset has 7 patches:

1 of 7: Changes the definition of the heads. Same as what was posted last
	Friday with changes w.r.t Paul's comments.
2 of 7:	Changes that affected only the notifier_head definition.
3 of 7: Changes in which we removed some protection (it's no longer needed
	as the basic infrastructure itself provides the protection).
4 of 7: changes for diechain for different architectures.
5 of 7: changes removing calls to notifier_unregister in the callout.
6 of 7: changes to dcdbas.c (requires special handling).
7 of 7: changes to make usb_notify to use the notify chain infrastructure
	instead of its own.

----------------------------------------

Here are the list of chains and their classification:

BLOCKING:
+++++++++
arch/powerpc/platforms/pseries/reconfig.c:	pSeries_reconfig_chain
arch/s390/kernel/process.c:		idle_chain
drivers/base/memory.c:			memory_chain
drivers/cpufreq/cpufreq.c:		cpufreq_policy_notifier_list
drivers/cpufreq/cpufreq.c:		cpufreq_transition_notifier_list
drivers/macintosh/adb.c:		adb_client_list
drivers/macintosh/via-pmu.c:		sleep_notifier_list
drivers/macintosh/via-pmu68k.c:		sleep_notifier_list
drivers/macintosh/windfarm_core.c:	wf_client_list
drivers/usb/core/notify.c:		usb_notifier_list
drivers/video/fbmem.c:			fb_notifier_list
kernel/cpu.c:				cpu_chain
kernel/module.c:			module_notify_list
kernel/profile.c:			munmap_notifier
kernel/profile.c:			task_exit_notifier
kernel/sys.c:				reboot_notifier_list
net/core/dev.c:				netdev_chain
net/decnet/dn_dev.c:			dnaddr_chain
net/ipv4/devinet.c:			inetaddr_chain

ATOMIC:
+++++++
arch/i386/kernel/traps.c:		i386die_chain
arch/ia64/kernel/traps.c:		ia64die_chain
arch/powerpc/kernel/traps.c:		powerpc_die_chain
arch/sparc64/kernel/traps.c:		sparc64die_chain
arch/x86_64/kernel/traps.c:		die_chain
drivers/char/ipmi/ipmi_si_intf.c:	xaction_notifier_list
kernel/panic.c:				panic_notifier_list
kernel/profile.c:			task_free_notifier
net/bluetooth/hci_core.c:		hci_notifier
net/ipv4/netfilter/ip_conntrack_core.c:	ip_conntrack_chain
net/ipv4/netfilter/ip_conntrack_core.c:	ip_conntrack_expect_chain
net/ipv6/addrconf.c:			inet6addr_chain
net/netfilter/nf_conntrack_core.c:	nf_conntrack_chain
nen/netfilter/nf_conntrack_core.c:	nf_conntrack_expect_chain
net/netlink/af_netlink.c:		netlink_chain


-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


