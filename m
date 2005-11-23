Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVKWD16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVKWD16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVKWD16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:27:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36993 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932494AbVKWD15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:27:57 -0500
Subject: Optimizing notifier_call_chain
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kernel development list <linux-kernel@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain
Organization: IBM
Date: Tue, 22 Nov 2005 19:27:55 -0800
Message-Id: <1132716475.27586.7.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While making the notifier chain safe, i found room for some optimization.
Please comment on if it is worth pursuing.

notifier_call_chain() calls registered callouts for _all_ events. But, many
of the callouts handle only few events.

If we change notifier_call_chain() to call the callout only on registered
events, we can avoid few function overhead.

Currently, events is of free format, we have to make it bit per event.
Among the existing users, ia64die_chain uses the highest number(25) of 
events. i think 64 bit event would suffice.

simplified logic:
	notifier_call_chain(event) 
	{
		if ((head->event & event) != 0)
			return;
		for_each_callout {
			if ((notifier_block->event & event) != 0)
				notifier_block->call(event);
		}
	}

thanks and regards,

chandra

Following are the current usages of events:

kernel/panic.c:			panic_notifier_list
drivers/char/ipmi/ipmi_si_intf.c:	xaction_notifier_list
kernel/profile.c:		munmap_notifier
kernel/profile.c:		task_exit_notifier
kernel/profile.c:		task_free_notifier
	NO FLAGS(all 5)
drivern/macintosh/adb.c:	adb_client_list
	macros defined in adb.h
	enum adb_message {
		ADB_MSG_POWERDOWN,
		ADB_MSG_PRE_RESET,
		ADB_MSG_POST_RESET
	};
kernel/cpu.c:			cpu_chain
	macros defined in notifier.h
	#define CPU_ONLINE              0x0002
	#define CPU_UP_PREPARE          0x0003
	#define CPU_UP_CANCELED         0x0004
	#define CPU_DOWN_PREPARE        0x0005
	#define CPU_DOWN_FAILED         0x0006
	#define CPU_DEAD                0x0007
drivers/cpufreq/cpufreq.c:	cpufreq_policy_notifier_list
	macros defined in cpufreq.h
	#define CPUFREQ_ADJUST          (0)
	#define CPUFREQ_INCOMPATIBLE    (1)
	#define CPUFREQ_NOTIFY          (2)
drivers/cpufreq/cpufreq.c:	cpufreq_transition_notifier_list
	macros defined in cpufreq.h
	#define CPUFREQ_PRECHANGE       (0)
	#define CPUFREQ_POSTCHANGE      (1)
	#define CPUFREQ_RESUMECHANGE    (8)
	#define CPUFREQ_SUSPENDCHANGE   (9)
net/decnet/dn_dev.c:		dnaddr_chain
net/ipv4/devinet.c:		inetaddr_chain
net/core/dev.c:			netdev_chain
net/ipv6/addrconf.c:		inet6addr_chain
	macros defined in notifier.h (all 4 use NETDEV_*)
	#define NETDEV_UP       0x0001
	#define NETDEV_DOWN     0x0002
	#define NETDEV_REBOOT   0x0003 
	#define NETDEV_CHANGE   0x0004
	#define NETDEV_REGISTER 0x0005
	#define NETDEV_UNREGISTER       0x0006
	#define NETDEV_CHANGEMTU        0x0007
	#define NETDEV_CHANGEADDR       0x0008
	#define NETDEV_GOING_DOWN       0x0009
	#define NETDEV_CHANGENAME       0x000A
	#define NETDEV_FEAT_CHANGE      0x000B
drivers/video/fbmem.c:		fb_notifier_list
	macros defined in fb.h
	#define FB_EVENT_MODE_CHANGE		0x01
	#define FB_EVENT_SUSPEND		0x02
	#define FB_EVENT_RESUME			0x03
	#define FB_EVENT_MODE_DELETE            0x04
	#define FB_EVENT_FB_REGISTERED          0x05
	#define FB_EVENT_GET_CONSOLE_MAP        0x06
	#define FB_EVENT_SET_CONSOLE_MAP        0x07
	#define FB_EVENT_BLANK                  0x08
	#define FB_EVENT_NEW_MODELIST           0x09
	#define FB_EVENT_MODE_CHANGE_ALL	0x0A
	#define FB_EVENT_SET_CON_ROTATE         0x0B
	#define FB_EVENT_GET_CON_ROTATE         0x0C
	#define FB_EVENT_SET_CON_ROTATE_ALL     0x0D
arch/s390/kernel/process.c:	idle_chain
	macros defined in asm-s390/processor.h
	#define CPU_IDLE        0
	#define CPU_NOT_IDLE    1
drivers/base/memory.c:		memory_chain
	macros defined in memory.h
	#define MEM_ONLINE              (1<<0)
	#define MEM_GOING_OFFLINE       (1<<1)
	#define MEM_OFFLINE             (1<<2)
	#define MEM_MAPPING_INVALID     (1<<3)
kernel/module.c:		module_notify_list
	macros defined in module.h
	enum module_state
	{
		MODULE_STATE_LIVE,
		MODULE_STATE_COMING,
		MODULE_STATE_GOING,
	};
arch/powerpc/platforms/pseries/reconfig.c:	pSeries_reconfig_chain
	macros defined in asm-powerpc/pSeries_reconfig.h
	#define PSERIES_RECONFIG_ADD    0x0001
	#define PSERIES_RECONFIG_REMOVE 0x0002
kernel/sys.c:			reboot_notifier_list
	macros defined in notifier.h
	#define SYS_DOWN        0x0001
	#define SYS_RESTART     SYS_DOWN
	#define SYS_HALT        0x0002
	#define SYS_POWER_OFF   0x0003
drivers/macintosh/via-pmu68k.c:	sleep_notifier_list
	macros defined in pmu.h, but these calls are ifdef'd out
drivers/usb/core/notify.c:	usb_notifier_list
	macros defined in usb.h
	#define USB_DEVICE_ADD          0x0001
	#define USB_DEVICE_REMOVE       0x0002
	#define USB_BUS_ADD             0x0003
	#define USB_BUS_REMOVE          0x0004
drivers/macintosh/windfarm_core.c:	wf_client_list
	macros defined in drivers/macintosh/windfarm.h
	#define WF_EVENT_NEW_CONTROL    0
	#define WF_EVENT_NEW_SENSOR     1
	#define WF_EVENT_OVERTEMP       2
	#define WF_EVENT_NORMALTEMP     3
	#define WF_EVENT_TICK           4
arch/x86_64/kernel/traps.c:	die_chain
	asm-x86_64/kdebug.h
	enum die_val {
		DIE_OOPS = 1,
		DIE_INT3,
		DIE_DEBUG,
		DIE_PANIC,
		DIE_NMI,
		DIE_DIE,
		DIE_NMIWATCHDOG,
		DIE_KERNELDEBUG,
		DIE_TRAP,
		DIE_GPF,
		DIE_CALL,
		DIE_NMI_IPI,
		DIE_PAGE_FAULT,
	};
arch/i386/kernel/traps.c:	i386die_chain
	macros defined in asm-i386/kdebug.h
	enum die_val {
		DIE_OOPS = 1,
		DIE_INT3,
		DIE_DEBUG,
		DIE_PANIC,
		DIE_NMI,
		DIE_DIE,
		DIE_NMIWATCHDOG,
		DIE_KERNELDEBUG,
		DIE_TRAP,
		DIE_GPF,
		DIE_CALL,
		DIE_NMI_IPI,
		DIE_PAGE_FAULT,
	};
arch/ia64/kernel/traps.c:	ia64die_chain
	asm-ia64/kdebug.h
	enum die_val {
		DIE_BREAK = 1,
		DIE_FAULT,
		DIE_OOPS,
		DIE_PAGE_FAULT,
		DIE_MACHINE_HALT,
		DIE_MACHINE_RESTART,
		DIE_MCA_MONARCH_ENTER,
		DIE_MCA_MONARCH_PROCESS,
		DIE_MCA_MONARCH_LEAVE,
		DIE_MCA_SLAVE_ENTER,
		DIE_MCA_SLAVE_PROCESS,
		DIE_MCA_SLAVE_LEAVE,
		DIE_MCA_RENDZVOUS_ENTER,
		DIE_MCA_RENDZVOUS_PROCESS,
		DIE_MCA_RENDZVOUS_LEAVE,
		DIE_INIT_MONARCH_ENTER,
		DIE_INIT_MONARCH_PROCESS,
		DIE_INIT_MONARCH_LEAVE,
		DIE_INIT_SLAVE_ENTER,
		DIE_INIT_SLAVE_PROCESS,
		DIE_INIT_SLAVE_LEAVE,
		DIE_KDEBUG_ENTER,
		DIE_KDEBUG_LEAVE,
		DIE_KDUMP_ENTER,
		DIE_KDUMP_LEAVE,
	};
arch/powerpc/kernel/traps.c:	powerpc_die_chain
	asm-powerpc/kdebug.h
	enum die_val {
		DIE_OOPS = 1,
		DIE_IABR_MATCH,
		DIE_DABR_MATCH,
		DIE_BPT,
		DIE_SSTEP,
		DIE_PAGE_FAULT,
	};
arch/sparc64/kernel/traps.c:	sparc64die_chain
	macros defined in asm-sparc64/kdebug.h
	enum die_val {
		DIE_OOPS = 1,
		DIE_INT3,
		DIE_DEBUG,
		DIE_PANIC,
		DIE_NMI,
		DIE_DIE,
		DIE_NMIWATCHDOG,
		DIE_KERNELDEBUG,
		DIE_TRAP,
		DIE_GPF,
		DIE_CALL,
		DIE_NMI_IPI,
		DIE_PAGE_FAULT,
	};
net/bluetooth/hci_core.c:	hci_notifier
	macros defined in net/bluetooth/hci.h
	#define HCI_DEV_REG			1
	#define HCI_DEV_UNREG			2
	#define HCI_DEV_UP			3
	#define HCI_DEV_DOWN			4
	#define HCI_DEV_SUSPEND			5
	#define HCI_DEV_RESUME			6
	
net/ipv4/netfilter/ip_conntrack_core.c:	ip_conntrack_chain
net/netfilter/nf_conntrack_core.c:	nf_conntrack_chain
	macros defined in netfilter/nf_conntrack_common.h (both)
	enum ip_conntrack_events
	{
		/* New conntrack */
		IPCT_NEW_BIT = 0,
		IPCT_NEW = (1 << IPCT_NEW_BIT),
	
		/* Expected connection */
		IPCT_RELATED_BIT = 1,
		IPCT_RELATED = (1 << IPCT_RELATED_BIT),
	
		/* Destroyed conntrack */
		IPCT_DESTROY_BIT = 2,
		IPCT_DESTROY = (1 << IPCT_DESTROY_BIT),
	
		/* Timer has been refreshed */
		IPCT_REFRESH_BIT = 3,
		IPCT_REFRESH = (1 << IPCT_REFRESH_BIT),
	
		/* Status has changed */
		IPCT_STATUS_BIT = 4,
		IPCT_STATUS = (1 << IPCT_STATUS_BIT),
	
		/* Update of protocol info */
		IPCT_PROTOINFO_BIT = 5,
		IPCT_PROTOINFO = (1 << IPCT_PROTOINFO_BIT),
	
		/* Volatile protocol info */
		IPCT_PROTOINFO_VOLATILE_BIT = 6,
		IPCT_PROTOINFO_VOLATILE = (1 << IPCT_PROTOINFO_VOLATILE_BIT),
	
		/* New helper for conntrack */
		IPCT_HELPER_BIT = 7,
		IPCT_HELPER = (1 << IPCT_HELPER_BIT),
	
		/* Update of helper info */
		IPCT_HELPINFO_BIT = 8,
		IPCT_HELPINFO = (1 << IPCT_HELPINFO_BIT),
	
		/* Volatile helper info */
		IPCT_HELPINFO_VOLATILE_BIT = 9,
		IPCT_HELPINFO_VOLATILE = (1 << IPCT_HELPINFO_VOLATILE_BIT),
	
		/* NAT info */
		IPCT_NATINFO_BIT = 10,
		IPCT_NATINFO = (1 << IPCT_NATINFO_BIT),
	
		/* Counter highest bit has been set */
		IPCT_COUNTER_FILLING_BIT = 11,
		IPCT_COUNTER_FILLING = (1 << IPCT_COUNTER_FILLING_BIT),
	};
net/ipv4/netfilter/ip_conntrack_core.c:	ip_conntrack_expect_chain
nen/netfilter/nf_conntrack_core.c:	nf_conntrack_expect_chain
	macros defined in netfilter/nf_conntrack_common.h (both)
	enum ip_conntrack_expect_events {
		IPEXP_NEW_BIT = 0,
		IPEXP_NEW = (1 << IPEXP_NEW_BIT),
	};
net/netlink/af_netlink.c:	netlink_chain
	macros defined in notifier.h
	#define NETLINK_URELEASE        0x0001

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


