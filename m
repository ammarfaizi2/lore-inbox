Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267274AbUHIVi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbUHIVi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHIVi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:38:26 -0400
Received: from hermes.gsix.se ([193.11.224.52]:15560 "EHLO hermes.gsix.se")
	by vger.kernel.org with ESMTP id S267264AbUHIVd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:33:59 -0400
Subject: Re: Bug in 2.6.8-rc3 at mm/page_alloc.c:792 and mm/rmap.c:407
From: Oskar Berggren <beo@sgs.o.se>
To: Hugh Dickins <hugh@veritas.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0408092007000.5981-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0408092007000.5981-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1092087230.14372.36.camel@pitr.ekb.sgsnet.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 23:33:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 21:08, Hugh Dickins wrote:
> On Sun, 8 Aug 2004, Hugh Dickins wrote:
> > On Sun, 8 Aug 2004, Oskar Berggren wrote:
> > > Two BUG's I've been seeing, one in page_alloc.c and one in rmap.c.
> > 
> > This is not the first report of an rmap.c:407,
> > Denis reported one a week ago (on 2.6.7-bk20).
> > 

> > Could you mail me (privately) your /var/log/messages, Oskar, I don't
> > have a clear picture of the relation between your page_alloc.c:792s,
> > your rmap.c:407s and your other oopses.
> 
> Thanks a lot for the /var/log/messages.
> 
> The frustrating thing is that the most interesting lines are missing:
> the "unqualified" printks, e.g. handle_BUG's "--- [ cut here ] ---" line
> and stack traces do appear; but handle_BUG's KERN_ALERT "kernel BUG..."
> and bad_page's very useful KERN_EMERG messages do not appear at all.
> 
> The "kernel BUG" messages you've already told us, but the missing
> bad_page lines might, _might_ be really helpful.  Do you have some
> klogd option set, not to print out the most important messages ;-?
> I hope someone can tell us how to fix that.

Fresh install of Debian using debian installer beta and 'testing'.

> 
> I notice the page_remove_rmap BUG (which we know to be rmap.c:407
> from your mail) was preceded 10 minutes earlier by a bad_page; and
> one of the things bad_page will do is force page->mapcount to 0,
> which would trigger the page_remove_rmap BUG, if that page being
> freed was actually still in use in some process address space.
> 
> Most of the other BUGs (mostly page_alloc.c:792s, __free_pages called
> from below shrink_cache or sock_release, finding page_count already 0)
> were also preceded, less immediately, by bad_pages; though not all.
> 
> It's all consistent with pages being freed while still in use,
> but I don't think I'm saying anything new there.  It doesn't look
> to me like random corruption or bad memory, I don't think those would
> show up so consistently as page freeing errors.  (Though if KERN_ERRs
> aren't getting into /var/log/messages, there might be page table
> corruption swap_free errors missing too.)
> 
> But I've no idea of where to look for the culprit: I'd better get
> on with other things, and hope someone else can take this further.


I think I've managed to catch one of the missing lines that you
mention in todays messages file, and then even more in the
/var/log/syslog file:

Aug  9 13:07:59 otukt kernel:  <0>Bad page state at free_hot_cold_page
(in process 'events/0', page c1090200)
Aug  9 13:07:59 otukt kernel: flags:0x20000080 mapping:00000000
mapcount:0 count:0
Aug  9 13:07:59 otukt kernel: Backtrace:
Aug  9 13:07:59 otukt kernel:  [bad_page+109/153] bad_page+0x6d/0x99
Aug  9 13:07:59 otukt kernel:  [free_hot_cold_page+81/270]
free_hot_cold_page+0x51/0x10e
Aug  9 13:07:59 otukt kernel:  [sk_free+191/258] sk_free+0xbf/0x102
Aug  9 13:07:59 otukt kernel:  [sk_common_release+87/203]
sk_common_release+0x57/0xcb
Aug  9 13:07:59 otukt kernel:  [inet_release+82/96]
inet_release+0x52/0x60
Aug  9 13:07:59 otukt kernel:  [sock_release+149/225]
sock_release+0x95/0xe1
Aug  9 13:07:59 otukt kernel:  [__crc_bio_get_nr_vecs+4158660/6507043]
xprt_socket_autoclose+0x26/0x63 [sunrpc]
Aug  9 13:07:59 otukt kernel:  [worker_thread+464/655]
worker_thread+0x1d0/0x28f
Aug  9 13:07:59 otukt kernel:  [__crc_bio_get_nr_vecs+4158622/6507043]
xprt_socket_autoclose+0x0/0x63 [sunrpc]
Aug  9 13:07:59 otukt kernel:  [default_wake_function+0/18]
default_wake_function+0x0/0x12
Aug  9 13:07:59 otukt kernel:  [default_wake_function+0/18]
default_wake_function+0x0/0x12
Aug  9 13:07:59 otukt kernel:  [worker_thread+0/655]
worker_thread+0x0/0x28f
Aug  9 13:07:59 otukt kernel:  [kthread+165/171] kthread+0xa5/0xab
Aug  9 13:07:59 otukt kernel:  [kthread+0/171] kthread+0x0/0xab
Aug  9 13:07:59 otukt kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Aug  9 13:07:59 otukt kernel: Trying to fix it up, but a reboot is
needed
Aug  9 13:07:59 otukt kernel: Bad page state at free_hot_cold_page (in
process 'syslogd', page c1090200)
Aug  9 13:07:59 otukt kernel: flags:0x20000080 mapping:00000000
mapcount:0 count:0
Aug  9 13:07:59 otukt kernel: Backtrace:
Aug  9 13:07:59 otukt kernel:  [bad_page+109/153] bad_page+0x6d/0x99
Aug  9 13:07:59 otukt kernel:  [free_hot_cold_page+81/270]
free_hot_cold_page+0x51/0x10e
Aug  9 13:07:59 otukt kernel:  [datagram_poll+43/202]
datagram_poll+0x2b/0xca
Aug  9 13:07:59 otukt kernel:  [poll_freewait+56/64]
poll_freewait+0x38/0x40
Aug  9 13:07:59 otukt kernel:  [do_select+438/712] do_select+0x1b6/0x2c8
Aug  9 13:07:59 otukt kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  9 13:07:59 otukt kernel:  [sys_select+691/1200]
sys_select+0x2b3/0x4b0
Aug  9 13:07:59 otukt kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  9 13:07:59 otukt kernel: Trying to fix it up, but a reboot is
needed
Aug  9 13:12:52 otukt syslogd 1.4.1#15: restart.
Aug  9 13:12:52 otukt kernel: klogd 1.4.1#15, log source = /proc/kmsg
started.
Aug  9 13:12:52 otukt kernel: Inspecting
/boot/System.map-2.6.8-rc3.p4-20040805.01
Aug  9 13:12:52 otukt kernel: Loaded 27129 symbols from
/boot/System.map-2.6.8-rc3.p4-20040805.01.
Aug  9 13:12:52 otukt kernel: Symbols match kernel version 2.6.8.
Aug  9 13:12:52 otukt kernel: No module symbols loaded - kernel modules
not enabled. 
Aug  9 13:12:52 otukt kernel: Linux version 2.6.8-rc3.p4-20040805.01
(root@otukt) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #1 Thu Aug 5
11:41:51 CE
ST 2004


When this happens one can observe the following:
  Machine still responds to ping, but not to SSH connection attempts.
  Mouse pointer still moves, but keyboard does NOT work.
  Window manager (ctwm) still operates with desktop/focus switching,
  moving windows, and closing some X-forwarded programs I had running.

In the end, I saw no other way than a hard reset.


Here are some additional messages I found in an earlier syslog file,
including an oops:

Aug  6 12:23:25 otukt kernel: Bad page state at free_hot_cold_page (in
process 'kswapd0', page c10f6c80)
Aug  6 12:23:25 otukt kernel: flags:0x20000000 mapping:cda3f97c
mapcount:0 count:0
Aug  6 12:23:25 otukt kernel: Backtrace:
Aug  6 12:23:25 otukt kernel:  [bad_page+109/153] bad_page+0x6d/0x99
Aug  6 12:23:25 otukt kernel:  [free_hot_cold_page+81/270]
free_hot_cold_page+0x51/0x10e
Aug  6 12:23:25 otukt kernel:  [__pagevec_free+25/33]
__pagevec_free+0x19/0x21
Aug  6 12:23:25 otukt kernel:  [release_pages+118/372]
release_pages+0x76/0x174
Aug  6 12:23:25 otukt kernel:  [__pagevec_release+40/54]
__pagevec_release+0x28/0x36
Aug  6 12:23:25 otukt kernel:  [shrink_cache+640/830]
shrink_cache+0x280/0x33e
Aug  6 12:23:25 otukt kernel:  [shrink_slab+123/390]
shrink_slab+0x7b/0x186
Aug  6 12:23:25 otukt kernel:  [shrink_zone+158/184]
shrink_zone+0x9e/0xb8
Aug  6 12:23:25 otukt kernel:  [balance_pgdat+457/557]
balance_pgdat+0x1c9/0x22d
Aug  6 12:23:25 otukt kernel:  [kswapd+199/215] kswapd+0xc7/0xd7
Aug  6 12:23:25 otukt kernel:  [autoremove_wake_function+0/87]
autoremove_wake_function+0x0/0x57
Aug  6 12:23:25 otukt kernel:  [ret_from_fork+6/20]
ret_from_fork+0x6/0x14
Aug  6 12:23:25 otukt kernel:  [autoremove_wake_function+0/87]
autoremove_wake_function+0x0/0x57
Aug  6 12:23:25 otukt kernel:  [kswapd+0/215] kswapd+0x0/0xd7
Aug  6 12:23:25 otukt kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Aug  6 12:23:25 otukt kernel: Trying to fix it up, but a reboot is
needed
Aug  6 12:47:18 otukt -- MARK --
Aug  6 13:07:18 otukt -- MARK --
Aug  6 13:17:01 otukt /USR/SBIN/CRON[2959]: (root) CMD (   run-parts
--report /etc/cron.hourly)
Aug  6 13:23:37 otukt kernel: Bad page state at free_hot_cold_page (in
process 'events/0', page c107c120)
Aug  6 13:23:37 otukt kernel: flags:0x20100064 mapping:c0dee508
mapcount:1 count:0
Aug  6 13:23:37 otukt kernel: Backtrace:
Aug  6 13:23:37 otukt kernel:  [bad_page+109/153] bad_page+0x6d/0x99
Aug  6 13:23:37 otukt kernel:  [free_hot_cold_page+81/270]
free_hot_cold_page+0x51/0x10e
Aug  6 13:23:37 otukt kernel:  [sk_free+191/258] sk_free+0xbf/0x102
Aug  6 13:23:37 otukt kernel:  [sk_common_release+87/203]
sk_common_release+0x57/0xcb
Aug  6 13:23:37 otukt kernel:  [inet_release+82/96]
inet_release+0x52/0x60
Aug  6 13:23:37 otukt kernel:  [sock_release+149/225]
sock_release+0x95/0xe1
Aug  6 13:23:37 otukt kernel:  [__crc_bio_get_nr_vecs+4158660/6507043]
xprt_socket_autoclose+0x26/0x63 [sunrpc]
Aug  6 13:23:37 otukt kernel:  [worker_thread+464/655]
worker_thread+0x1d0/0x28f
Aug  6 13:23:37 otukt kernel:  [__crc_bio_get_nr_vecs+4158622/6507043]
xprt_socket_autoclose+0x0/0x63 [sunrpc]
Aug  6 13:23:37 otukt kernel:  [default_wake_function+0/18]
default_wake_function+0x0/0x12
Aug  6 13:23:37 otukt kernel:  [default_wake_function+0/18]
default_wake_function+0x0/0x12
Aug  6 13:23:37 otukt kernel:  [worker_thread+0/655]
worker_thread+0x0/0x28f
Aug  6 13:23:37 otukt kernel:  [kthread+165/171] kthread+0xa5/0xab
Aug  6 13:23:37 otukt kernel:  [kthread+0/171] kthread+0x0/0xab
Aug  6 13:23:37 otukt kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Aug  6 13:23:37 otukt kernel: Trying to fix it up, but a reboot is
needed
Aug  6 13:25:07 otukt kernel: Unable to handle kernel paging request at
virtual address fffffffc
Aug  6 13:25:07 otukt kernel:  printing eip:
Aug  6 13:25:07 otukt kernel: c01634fb
Aug  6 13:25:07 otukt kernel: *pde = 00002067
Aug  6 13:25:07 otukt kernel: *pte = 00000000
Aug  6 13:25:07 otukt kernel: Oops: 0000 [#1]
Aug  6 13:25:07 otukt kernel: PREEMPT 
Aug  6 13:25:07 otukt kernel: Modules linked in: ds lp parport ipv6 nfs
lockd sunrpc yenta_socket pcmcia_core 3c59x snd_atiixp snd_ac97_codec
snd
_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd tsdev mousedev
usbhid ohci_hcd usbcore shpchp pciehp pci_hotplug ati_agp agpgart
eth1394 evd
ev ide_scsi scsi_mod ohci1394 ieee1394 ide_cd cdrom genrtc xfs reiserfs
jfs isofs vfat fat ext2 ext3 jbd mbcache ide_generic via82cxxx trm290
tri
flex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix
pdc202xx_old opti621 ns87415 hpt366 ide_disk hpt34x generic cy82c693
cs5530 cs5520 c
md64x atiixp amd74xx alim15x3 aec62xx pdc202xx_new ide_core unix
Aug  6 13:25:07 otukt kernel: CPU:    0
Aug  6 13:25:07 otukt kernel: EIP:    0060:[poll_freewait+26/64]    Not
tainted
Aug  6 13:25:07 otukt kernel: EFLAGS: 00010297  
(2.6.8-rc3.p4-20040805.01) 
Aug  6 13:25:07 otukt kernel: EIP is at poll_freewait+0x1a/0x40
Aug  6 13:25:07 otukt kernel: eax: c7581f44   ebx: ffffffe4   ecx:
00000000   edx: ffffffe8
Aug  6 13:25:07 otukt kernel: esi: c3e09008   edi: c3e09000   ebp:
00000004   esp: c7581ee4
Aug  6 13:25:07 otukt kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 13:25:07 otukt kernel: Process xclock (pid: 2755,
threadinfo=c7580000 task=cc39edd0)
Aug  6 13:25:07 otukt kernel: Stack: 00000000 00000000 00000004 c016387c
c7581f44 00000000 00000000 00000000 
Aug  6 13:25:07 otukt kernel:        00000008 00000000 00000000 00000000
00000304 00000008 c7580000 cb4d58ac 
Aug  6 13:25:07 otukt kernel:        cb4d58a8 cb4d58a4 cb4d58b8 cb4d58b4
cb4d58b0 00000000 00000000 00000000 
Aug  6 13:25:07 otukt kernel: Call Trace:
Aug  6 13:25:07 otukt kernel:  [do_select+438/712] do_select+0x1b6/0x2c8
Aug  6 13:25:07 otukt kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  6 13:25:07 otukt kernel:  [sys_select+691/1200]
sys_select+0x2b3/0x4b0
Aug  6 13:25:07 otukt kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  6 13:25:07 otukt kernel: Code: 8b 43 18 e8 31 5e fb ff 8b 03 e8 f7
df fe ff 39 f3 77 e7 89 
Aug  6 13:47:18 otukt -- MARK --
Aug  6 14:04:23 otukt syslogd 1.4.1#15: restart.
Aug  6 14:04:23 otukt kernel: klogd 1.4.1#15, log source = /proc/kmsg
started.

-- 
Oskar Berggren <beo@sgs.o.se>

