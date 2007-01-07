Return-Path: <linux-kernel-owner+w=401wt.eu-S932617AbXAGRg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXAGRg3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbXAGRg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:36:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617AbXAGRg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:36:28 -0500
Date: Sun, 7 Jan 2007 12:36:12 -0500
From: Dave Jones <davej@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: page_mapcount(page) went negative
Message-ID: <20070107173612.GC6111@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Hugh Dickins <hugh@veritas.com>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205160250.GB9076@kernelslacker.org> <20061212174909.GD2140@redhat.com> <458776A5.3060007@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458776A5.3060007@yahoo.com.au>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 04:20:37PM +1100, Nick Piggin wrote:
 > Dave Jones wrote:
 > 
 > > Eeek! page_mapcount(page) went negative! (-2)
 > 
 > Hmm, probably happened once before, too.
 > 
 > >   page->flags = 404
 > 
 > What's that? PG_referenced|PG_reserved? So I'd say it is likely
 > that some driver has got its refcounting wrong.
 > 
 > Unfortunately, this debugging output is almost useless when it
 > comes to trying to track down the problem any further.
 > 
 > And I see we've got another report for 2.6.19.1 from Chris, which
 > is equally vague.
 > 
 > IMO the pattern is much too consistent to be able to attribute
 > them all to hardware problems. And considering it takes so long
 > for these things to appear, can we get something like the attached
 > patch upstream at least until we manage to stamp them out? Any
 > other debugging info we can add?

I finally got another trace out of a 2.6.19.1 with this debug patch..
I'm starting to wonder if this is hardware related.
That box makes me suspicious as its motherboard has a bunch
of bulging capacitors on it. I had three of these, the previous
two died like so: http://www.flickr.com/photos/kernelslacker/251807263/in/set-72157594298237090/
This board hasn't started 'oozing' yet, but I think it may be on
the cards.

iirc, the previous oopses were around the same time of morning,
whilst cron.daily was hammering the hell out of the disk.
Either there's a subtle bug, or this board just can't take the pressure.

		Dave

Jan  7 04:24:35 firewall kernel: Eeek! page_mapcount(page) went negative! (-1)
Jan  7 04:24:35 firewall kernel:   page->flags = 414
Jan  7 04:24:35 firewall kernel:   page->count = 1
Jan  7 04:24:35 firewall kernel:   page->mapping = 00000000
Jan  7 04:24:35 firewall kernel:   vma->vm_ops->nopage = filemap_nopage+0x0/0x33e
Jan  7 04:24:35 firewall kernel: ------------[ cut here ]------------
Jan  7 04:24:35 firewall kernel: kernel BUG at mm/rmap.c:581!
Jan  7 04:24:35 firewall kernel: invalid opcode: 0000 [#1]
Jan  7 04:24:35 firewall kernel: SMP 
Jan  7 04:24:35 firewall kernel: last sysfs file: /class/net/lo/type
Jan  7 04:24:35 firewall kernel: Modules linked in: tun ipt_MASQUERADE iptable_nat ip_nat ipt_LOG xt_limit ipv6 ip_conntrack_netbios_ns ipt_REJECT xt_state i
p_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport sr_mod sg pcspkr i2c_via
pro ide_cd i2c_core 3c59x via_rhine cdrom mii via_ircc irda crc_ccitt serio_raw dm_snapshot dm_zero dm_mirror dm_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Jan  7 04:24:35 firewall kernel: CPU:    0
Jan  7 04:24:35 firewall kernel: EIP:    0060:[<c046d995>]    Not tainted VLI
Jan  7 04:24:35 firewall kernel: EFLAGS: 00010286   (2.6.19-1.2886.fc6debug #1)
Jan  7 04:24:35 firewall kernel: EIP is at page_remove_rmap+0x8b/0xac
Jan  7 04:24:35 firewall kernel: eax: 00000034   ebx: c1000000   ecx: c042818c   edx: da0b3550
Jan  7 04:24:35 firewall kernel: esi: daecd0c0   edi: 00000020   ebp: cd386140   esp: ce2f4dc4
Jan  7 04:24:35 firewall kernel: ds: 007b   es: 007b   ss: 0068
Jan  7 04:24:35 firewall kernel: Process zcat (pid: 22721, ti=ce2f4000 task=da0b3550 task.ti=ce2f4000)
Jan  7 04:24:35 firewall kernel: Stack: c066b7b6 00000000 c1000000 08050000 c0467c63 c06c7f10 00000046 00000000 
Jan  7 04:24:35 firewall kernel:        daecd0c0 ce2f4e44 003f7ffd 00000000 00000001 08055000 cf354080 dde93520 
Jan  7 04:24:35 firewall kernel:        c1401e80 00000000 fffffff9 dde9358c cf354080 08055000 00000000 ce2f4e44 
Jan  7 04:24:35 firewall kernel: Call Trace:
Jan  7 04:24:35 firewall kernel:  [<c0467c63>] unmap_vmas+0x2a6/0x536
Jan  7 04:24:35 firewall kernel:  [<c046aaa8>] exit_mmap+0x77/0x105
Jan  7 04:24:35 firewall kernel:  [<c0425471>] mmput+0x37/0x80
Jan  7 04:24:35 firewall kernel:  [<c042a4b5>] do_exit+0x21c/0x7a3
Jan  7 04:24:35 firewall kernel:  [<c042aac9>] sys_exit_group+0x0/0xd
Jan  7 04:24:35 firewall kernel:  [<c043383d>] get_signal_to_deliver+0x38b/0x3b3
Jan  7 04:24:35 firewall kernel:  [<c0403677>] do_notify_resume+0x83/0x6c6
Jan  7 04:24:35 firewall kernel:  [<c0404159>] work_notifysig+0x13/0x1a
Jan  7 04:24:35 firewall kernel:  [<0804a84e>] 0x804a84e
Jan  7 04:24:35 firewall kernel:  =======================
Jan  7 04:24:35 firewall kernel: Code: 4c a4 fb ff 8b 43 10 c7 04 24 b6 b7 66 c0 89 44 24 04 e8 39 a4 fb ff 8b 46 40 85 c0 74 0d 8b 50 08 b8 cf b7 66 c0 e8 d
8 a9 fd ff <0f> 0b 45 02 4b b7 66 c0 8b 53 10 89 d8 59 5b 5b 5e 83 f2 01 83 
Jan  7 04:24:35 firewall kernel: EIP: [<c046d995>] page_remove_rmap+0x8b/0xac SS:ESP 0068:ce2f4dc4
Jan  7 04:24:35 firewall kernel:  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Jan  7 04:24:35 firewall kernel: in_atomic():1, irqs_disabled():0
Jan  7 04:24:35 firewall kernel:  [<c0405108>] dump_trace+0x69/0x1b6
Jan  7 04:24:35 firewall kernel:  [<c040526d>] show_trace_log_lvl+0x18/0x2c
Jan  7 04:24:35 firewall kernel:  [<c0405868>] show_trace+0xf/0x11
Jan  7 04:24:35 firewall kernel:  [<c0405965>] dump_stack+0x15/0x17
Jan  7 04:24:35 firewall kernel:  [<c043ccca>] down_read+0x15/0x4e
Jan  7 04:24:35 firewall kernel:  [<c04345b6>] blocking_notifier_call_chain+0xe/0x29
Jan  7 04:24:35 firewall kernel:  [<c042a2b4>] do_exit+0x1b/0x7a3
Jan  7 04:24:35 firewall kernel:  [<c0405809>] die+0x2c3/0x2e8
Jan  7 04:24:35 firewall kernel:  [<c0405d4a>] do_invalid_op+0xa2/0xab
Jan  7 04:24:35 firewall kernel:  [<c063f7a1>] error_code+0x39/0x40
Jan  7 04:24:35 firewall kernel:  [<c046d995>] page_remove_rmap+0x8b/0xac
Jan  7 04:24:35 firewall kernel:  [<c0467c63>] unmap_vmas+0x2a6/0x536
Jan  7 04:24:35 firewall kernel:  [<c046aaa8>] exit_mmap+0x77/0x105
Jan  7 04:24:35 firewall kernel:  [<c0425471>] mmput+0x37/0x80
Jan  7 04:24:35 firewall kernel:  [<c042a4b5>] do_exit+0x21c/0x7a3
Jan  7 04:24:35 firewall kernel:  [<c042aac9>] sys_exit_group+0x0/0xd
Jan  7 04:24:35 firewall kernel:  [<c043383d>] get_signal_to_deliver+0x38b/0x3b3
Jan  7 04:24:35 firewall kernel:  [<c0403677>] do_notify_resume+0x83/0x6c6
Jan  7 04:24:35 firewall kernel:  [<c0404159>] work_notifysig+0x13/0x1a
Jan  7 04:24:35 firewall kernel:  [<0804a84e>] 0x804a84e
Jan  7 04:24:35 firewall kernel:  =======================
Jan  7 04:24:35 firewall kernel: Fixing recursive fault but reboot is needed!
Jan  7 04:24:35 firewall kernel: BUG: scheduling while atomic: zcat/0x00000001/22721
Jan  7 04:24:35 firewall kernel:  [<c0405108>] dump_trace+0x69/0x1b6
Jan  7 04:24:35 firewall kernel:  [<c040526d>] show_trace_log_lvl+0x18/0x2c
Jan  7 04:24:35 firewall kernel:  [<c0405868>] show_trace+0xf/0x11
Jan  7 04:24:35 firewall kernel:  [<c0405965>] dump_stack+0x15/0x17
Jan  7 04:24:35 firewall kernel:  [<c063c72f>] __sched_text_start+0x4f/0xa58
Jan  7 04:24:35 firewall kernel:  [<c042a397>] do_exit+0xfe/0x7a3
Jan  7 04:24:35 firewall kernel:  [<c0405809>] die+0x2c3/0x2e8
Jan  7 04:24:35 firewall kernel:  [<c0405d4a>] do_invalid_op+0xa2/0xab
Jan  7 04:24:35 firewall kernel:  [<c063f7a1>] error_code+0x39/0x40
Jan  7 04:24:35 firewall kernel:  [<c046d995>] page_remove_rmap+0x8b/0xac
Jan  7 04:24:35 firewall kernel:  [<c0467c63>] unmap_vmas+0x2a6/0x536
Jan  7 04:24:35 firewall kernel:  [<c046aaa8>] exit_mmap+0x77/0x105
Jan  7 04:24:35 firewall kernel:  [<c0425471>] mmput+0x37/0x80
Jan  7 04:24:35 firewall kernel:  [<c042a4b5>] do_exit+0x21c/0x7a3
Jan  7 04:24:35 firewall kernel:  [<c042aac9>] sys_exit_group+0x0/0xd
Jan  7 04:24:35 firewall kernel:  [<c043383d>] get_signal_to_deliver+0x38b/0x3b3
Jan  7 04:24:35 firewall kernel:  [<c0403677>] do_notify_resume+0x83/0x6c6
Jan  7 04:24:35 firewall kernel:  [<c0404159>] work_notifysig+0x13/0x1a
Jan  7 04:24:35 firewall kernel:  [<0804a84e>] 0x804a84e
Jan  7 04:24:35 firewall kernel:  =======================


-- 
http://www.codemonkey.org.uk
