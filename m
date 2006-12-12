Return-Path: <linux-kernel-owner+w=401wt.eu-S932270AbWLLRtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWLLRtU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWLLRtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:49:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbWLLRtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:49:19 -0500
Date: Tue, 12 Dec 2006 12:49:09 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061212174909.GD2140@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061204204024.2401148d.akpm@osdl.org> <20061205160250.GB9076@kernelslacker.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205160250.GB9076@kernelslacker.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 11:02:50AM -0500, Dave Jones wrote:
 > On Mon, Dec 04, 2006 at 08:40:24PM -0800, Andrew Morton wrote:
 >  
 >  > cpufreq-fix-bug-in-duplicate-freq-elimination-code-in-acpi-cpufreq.patch
 >  > remove-hotplug-cpu-crap-from-cpufreq.patch
 >  > cpufreq-select-consistently-re-2619-rc5-mm1.patch
 >  > cpufreq-set-policy-curfreq-on-initialization.patch
 >  > bug-fix-for-acpi-cpufreq-and-cpufreq_stats-oops-on-frequency-change-notification.patch
 >  > 
 >  > Sent to cpufreq maintainer
 > 
 > I'm travelling right now, and somehow managed to oops my home router
 > 3000 miles away making it hard for me to access mail & stuff.
 > (That "page count went negative" BUG() bit me when I did a killall -9 vpnc)

Finally managed to fish this out of the logs..


Eeek! page_mapcount(page) went negative! (-2)
  page->flags = 404
  page->count = 1
  page->mapping = 00000000
------------[ cut here ]------------
kernel BUG at mm/rmap.c:587!
invalid opcode: 0000 [#2]
SMP 
last sysfs file: /class/net/lo/type
Modules linked in: tun ipt_MASQUERADE iptable_nat ip_nat ipt_LOG xt_limit ipv6 ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport pcspkr ide_cd i2c_viapro i2c_core cdrom 3c59x via_rhine via_ircc mii irda crc_ccitt serio_raw dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<c046396c>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-1.2849.fc6 #1) 
EIP is at page_remove_rmap+0x8b/0xac
eax: 00000000   ebx: c1000000   ecx: ffffffff   edx: 00000046
esi: dcaa2f98   edi: 00000020   ebp: cd3f7f00   esp: cd3e4ddc
ds: 007b   es: 007b   ss: 0068
Process vpnc (pid: 3367, ti=cd3e4000 task=cd3a0b50 task.ti=cd3e4000)
Stack: c0638bad 00000000 c1000000 09bc0000 c045e199 00000000 dcaa2f98 cd3e4e54 
       003ebff8 00000000 00000001 09bdb000 cd377098 c1624a80 c13e5f60 fffffffa 
       ffffffff c1624ad4 cd377098 09bdb000 00000000 cd3e4e54 c1485d4c c1624a80 
Call Trace:
 [<c045e199>] unmap_vmas+0x28e/0x504
 [<c0460c0f>] exit_mmap+0x77/0xf1
 [<c0422d75>] mmput+0x34/0x7a
 [<c0427818>] do_exit+0x20b/0x776
 [<c0427df9>] sys_exit_group+0x0/0xd
 [<cd39a644>] 0xcd39a644
DWARF2 unwinder stuck at 0xcd39a644
Leftover inexact backtrace:
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0430828>] get_signal_to_deliver+0x38b/0x3b3
 [<c04068d1>] do_IRQ+0xb0/0xbc
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0403626>] do_notify_resume+0x7e/0x6c1
 [<c045f135>] __handle_mm_fault+0x82c/0x860
 [<c04068d1>] do_IRQ+0xb0/0xbc
 [<c061455e>] _spin_unlock_irq+0x5/0x7
 [<c0612ccc>] schedule+0x960/0x9dd
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c04040a2>] work_notifysig+0x13/0x19
 =======================
Code: 82 1e fc ff 8b 43 10 c7 04 24 ad 8b 63 c0 89 44 24 04 e8 6f 1e fc ff 8b 46 40 85 c0 74 0d 8b 50 08 b8 c6 8b 63 c0 e8 07 ce fd ff <0f> 0b 4b 02 42 8b 63 c0 8b 53 10 89 d8 59 5b 5b 5e 83 f2 01 83 
EIP: [<c046396c>] page_remove_rmap+0x8b/0xac SS:ESP 0068:cd3e4ddc
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():0
 [<c04051db>] dump_trace+0x69/0x1af
 [<c0405339>] show_trace_log_lvl+0x18/0x2c
 [<c04058ed>] show_trace+0xf/0x11
 [<c04059ea>] dump_stack+0x15/0x17
 [<c04394a2>] down_read+0x12/0x20
 [<c0431601>] blocking_notifier_call_chain+0xe/0x29
 [<c0427628>] do_exit+0x1b/0x776
 [<c040588e>] die+0x29d/0x2c2
 [<c0405fd3>] do_invalid_op+0xa2/0xab
 [<c0404b85>] error_code+0x39/0x40
DWARF2 unwinder stuck at error_code+0x39/0x40
Leftover inexact backtrace:
 [<c046396c>] page_remove_rmap+0x8b/0xac
 [<c045e199>] unmap_vmas+0x28e/0x504
 [<c0460c0f>] exit_mmap+0x77/0xf1
 [<c0422d75>] mmput+0x34/0x7a
 [<c0427818>] do_exit+0x20b/0x776
 [<c042f153>] __dequeue_signal+0x151/0x15c
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0427df9>] sys_exit_group+0x0/0xd
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0430828>] get_signal_to_deliver+0x38b/0x3b3
 [<c04068d1>] do_IRQ+0xb0/0xbc
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0403626>] do_notify_resume+0x7e/0x6c1
 [<c045f135>] __handle_mm_fault+0x82c/0x860
 [<c04068d1>] do_IRQ+0xb0/0xbc
 [<c061455e>] _spin_unlock_irq+0x5/0x7
 [<c0612ccc>] schedule+0x960/0x9dd
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c04040a2>] work_notifysig+0x13/0x19
 =======================
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: vpnc/0x00000001/3367
 [<c04051db>] dump_trace+0x69/0x1af
 [<c0405339>] show_trace_log_lvl+0x18/0x2c
 [<c04058ed>] show_trace+0xf/0x11
 [<c04059ea>] dump_stack+0x15/0x17
 [<c06123af>] schedule+0x43/0x9dd
 [<c04276f7>] do_exit+0xea/0x776
 [<c040588e>] die+0x29d/0x2c2
 [<c0405fd3>] do_invalid_op+0xa2/0xab
 [<c0404b85>] error_code+0x39/0x40
DWARF2 unwinder stuck at error_code+0x39/0x40
Leftover inexact backtrace:
 [<c046396c>] page_remove_rmap+0x8b/0xac
 [<c045e199>] unmap_vmas+0x28e/0x504
 [<c0460c0f>] exit_mmap+0x77/0xf1
 [<c0422d75>] mmput+0x34/0x7a
 [<c0427818>] do_exit+0x20b/0x776
 [<c042f153>] __dequeue_signal+0x151/0x15c
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0427df9>] sys_exit_group+0x0/0xd
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0430828>] get_signal_to_deliver+0x38b/0x3b3
 [<c04068d1>] do_IRQ+0xb0/0xbc
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c0403626>] do_notify_resume+0x7e/0x6c1
 [<c045f135>] __handle_mm_fault+0x82c/0x860
 [<c04068d1>] do_IRQ+0xb0/0xbc
 [<c061455e>] _spin_unlock_irq+0x5/0x7
 [<c0612ccc>] schedule+0x960/0x9dd
 [<c0615375>] do_page_fault+0x0/0x4db
 [<c04040a2>] work_notifysig+0x13/0x19
 =======================


That was from a 2.6.18.3 kernel iirc.

		Dave

-- 
http://www.codemonkey.org.uk
