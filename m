Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265467AbUFWLqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUFWLqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 07:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266384AbUFWLqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 07:46:10 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:41478 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S265467AbUFWLo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 07:44:59 -0400
Subject: Re: Process hangs copying large file to cifs filesystem
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1085760260.2422.11.camel@taz.graycell.biz>
References: <1085672706.4350.9.camel@taz.graycell.biz>
	 <1085753249.2219.13.camel@taz.graycell.biz>
	 <20040528142239.GK20657@suse.de>
	 <1085760260.2422.11.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Date: Wed, 23 Jun 2004 12:44:54 +0100
Message-Id: <1087991095.2406.7.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2004 11:44:55.0050 (UTC) FILETIME=[80A2F6A0:01C45917]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sex, 2004-05-28 at 17:04 +0100, Nuno Ferreira wrote:
> On Sex, 2004-05-28 at 16:22 +0200, Jens Axboe wrote:
> > On Fri, May 28 2004, Nuno Ferreira wrote:
> > > On Qui, 2004-05-27 at 16:45 +0100, Nuno Ferreira wrote:
> > > > Hi,
> > > > I'm trying to copy a large file (200Mb or bigger) from an ext3
> > > > filesystem to a windows share mounted using CIFS and the cp process
> > > > hangs, sometimes for a long time (several minutes).
> > > > Calling ps, I can see that it's blocking on blk_congestion_wait. 
> [...]
> > 
> > A sysrq-t back trace of that process would be interesting to see.

Hi,
I retested this using 2.6.7 and still have the same problem.
This is copying a 197Mb from an my laptop's IDE hardisk to a cifs
mounted share that's on a Win2000 Server. The laptop has 512Mb.
Here's an lspci:

0000:00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01)
0000:00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 20)
0000:00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
0000:00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
0000:00:11.0 Bridge: ALi Corporation M7101 PMU
0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1

I used netconsole to catch the sysrq-t output, it's attached. Note that
besides the cp process there is a vi process that also froze.
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000000     0     1      0     2               (NOTLB)
ddfc2eb8 00000082 dd556880 00000000 00000001 c0131541 72c2ee54 ddd0b050 
       ddfdcb60 00000001 00000001 00000000 2dd8b700 000f4264 ddeef7d8 00027284 
       ddfc2ecc 0000000b 0000000b c028dae0 ddcf5c54 c013159f 00000000 c0385358 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c011eb00>] process_timeout+0x0/0x10
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c0103cfb>] syscall_call+0x7/0xb

ksoftirqd/0   S DDFBFFCC     0     2      1             3       (L-TLB)
ddfbffc0 00000046 ddeef0b0 ddfbffcc c028d59c 00000001 ddfc2f94 ddfbffb8 
       c01156d7 00000010 dd4b3710 00000000 c2706080 000f4263 ddeef258 00000000 
       ddfbf000 00000000 c011b520 c011b5a0 ddfbf000 ddfc2f90 c0126e04 fffffffc 
Call Trace:
 [<c028d59c>] schedule+0x25c/0x410
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c011b520>] ksoftirqd+0x0/0xa0
 [<c011b5a0>] ksoftirqd+0x80/0xa0
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

events/0      S 00000000     0     3      1     4      22     2 (L-TLB)
ddfbdf54 00000046 00000003 00000000 00000282 c0390d38 ddfdbc70 00000001 
       00000003 00000000 00000086 00000000 df966c80 000f4264 ddeeecd8 00000296 
       ddfdbc58 ddfdbc68 ddfbdfa0 c0124145 00000000 ddfbdf84 c0114cfb ddfdbc70 
Call Trace:
 [<c0124145>] worker_thread+0x1d5/0x200
 [<c0114cfb>] recalc_task_prio+0x8b/0x180
 [<c01e0380>] console_callback+0x0/0xd0
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0123f70>] worker_thread+0x0/0x200
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

khelper       S 00000000     0     4      3             5       (L-TLB)
ddfb4f54 00000046 00000000 00000000 0000007b 0000007b ddfdbbf0 00000001 
       00000003 00000000 dcbc2210 00000000 79736c80 000f4234 ddeee758 00000202 
       ddfdbbd8 ddfdbbe8 ddfb4fa0 c0124145 00000000 c0114e4a c037b3e0 ddfdbbf0 
Call Trace:
 [<c0124145>] worker_thread+0x1d5/0x200
 [<c0114e4a>] activate_task+0x5a/0x70
 [<c0123d30>] __call_usermodehelper+0x0/0x50
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0123f70>] worker_thread+0x0/0x200
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

kacpid        S DDF7B9E0     0     5      3            21     4 (L-TLB)
c13e3f54 00000046 00000000 ddf7b9e0 c01b5241 00000282 ddfdba70 00000001 
       6a847440 000f4242 dd4b2110 00000000 6a847440 000f4242 ddeee1d8 00000292 
       ddfdba58 ddfdba68 c13e3fa0 c0124145 00000000 c0114e4a c037b3e0 ddfdba70 
Call Trace:
 [<c01b5241>] acpi_enable_gpe+0x65/0x6c
 [<c0124145>] worker_thread+0x1d5/0x200
 [<c0114e4a>] activate_task+0x5a/0x70
 [<c01b1711>] acpi_os_execute_deferred+0x0/0x16
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0123f70>] worker_thread+0x0/0x200
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

kblockd/0     S C03931AC     0    21      3            32     5 (L-TLB)
ddf72f54 00000046 00000001 c03931ac c0393100 ddfd63d8 c13e4970 00000001 
       00000003 00000000 00000086 00000000 39666cc0 000f425f ddd677f8 00000286 
       c13e4958 c13e4968 ddf72fa0 c0124145 00000000 c0114e4a c037b3e0 c13e4970 
Call Trace:
 [<c0124145>] worker_thread+0x1d5/0x200
 [<c0114e4a>] activate_task+0x5a/0x70
 [<c01eb170>] blk_unplug_work+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0123f70>] worker_thread+0x0/0x200
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

khubd         S 00000002     0    22      1            34     3 (L-TLB)
ddd63fb4 00000046 00000002 00000002 ddfd96b8 ddd0d400 00000202 ddd63fa6 
       c0120bdc ddd63000 dcf9a190 00000000 75f2b9c0 000f41fe ddd67278 ddd63000 
       fffff000 ddd63fc0 ddd63000 c0217875 c02afd47 00000000 ddd670d0 c0115690 
Call Trace:
 [<c0120bdc>] sigprocmask+0x4c/0xc0
 [<c0217875>] hub_thread+0xb5/0xe0
 [<c0115690>] default_wake_function+0x0/0x10
 [<c02177c0>] hub_thread+0x0/0xe0
 [<c010227d>] kernel_thread_helper+0x5/0x18

pdflush       S 00000000     0    32      3            35    21 (L-TLB)
ddd60f94 00000046 00001de6 00000000 00000000 00000000 00000000 00000400 
       00000000 00000001 dc99ad90 00000000 752ec780 000f4240 ddd66cf8 ddd60fbc 
       ddd60fb0 ddd60000 c0132e60 c0132d6e ddd60000 ddd60000 ddfc2f84 00000000 
Call Trace:
 [<c0132e60>] pdflush+0x0/0x20
 [<c0132d6e>] __pdflush+0x6e/0x160
 [<c0132e7a>] pdflush+0x1a/0x20
 [<c0132e60>] pdflush+0x0/0x20
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

aio/0         S 00000000     0    35      3          2242    32 (L-TLB)
ddd4ff54 00000046 00000000 00000000 00000000 00000000 00000000 00010000 
       55c0fbc0 000f41fa ddeee5b0 00000000 55c0fbc0 000f41fa ddd25818 ddd4f000 
       c13e5658 c13e5668 ddd4ffa0 c0124145 ddd4ff74 c0114e4a c037b3e0 00000000 
Call Trace:
 [<c0124145>] worker_thread+0x1d5/0x200
 [<c0114e4a>] activate_task+0x5a/0x70
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0123f70>] worker_thread+0x0/0x200
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

kswapd0       S 00000000     0    34      1           118    22 (L-TLB)
ddd57f8c 00000046 c0124814 00000000 ddd66050 00000000 00000000 00000000 
       c0120bdc ddd57000 ddeef630 00000000 52890240 000f41fa ddd661f8 ddd57000 
       c02da4dc ddd57fc0 c02da120 c0137fac c02a1884 00000000 00000000 00000000 
Call Trace:
 [<c0124814>] attach_pid+0x24/0xe0
 [<c0120bdc>] sigprocmask+0x4c/0xc0
 [<c0137fac>] kswapd+0xac/0xd0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0137f00>] kswapd+0x0/0xd0
 [<c010227d>] kernel_thread_helper+0x5/0x18

kseriod       S 00000000     0   118      1           124    34 (L-TLB)
ddd18fb4 00000046 c0124814 00000000 ddd250f0 00000000 00000000 00000000 
       c0120bdc ddd18000 ddeef630 00000000 415efa00 000f41fb ddd25298 ddd18000 
       fffff000 ddd18fc0 ddd18000 c02282e5 c02b06a4 00000000 ddd250f0 c0115690 
Call Trace:
 [<c0124814>] attach_pid+0x24/0xe0
 [<c0120bdc>] sigprocmask+0x4c/0xc0
 [<c02282e5>] serio_thread+0xb5/0xf0
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0228230>] serio_thread+0x0/0xf0
 [<c010227d>] kernel_thread_helper+0x5/0x18

kjournald     S DDD09F50     0   124      1           834   118 (L-TLB)
ddd09f68 00000046 ddfd99fc ddd09f50 c01156d7 00000000 ddfd99fc 00000001 
       00000003 00000000 dd5d76d0 00000000 3938a600 000f425f ddd24d18 ddfd99b8 
       00000000 00000001 ddfd9a0c c0184e7f 00000000 00000005 ddfd99fc ddeee5b0 
Call Trace:
 [<c01156d7>] __wake_up_common+0x37/0x60
 [<c0184e7f>] kjournald+0x1df/0x1f0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0103c0e>] ret_from_fork+0x6/0x14
 [<c0184c80>] commit_timeout+0x0/0x10
 [<c0184ca0>] kjournald+0x0/0x1f0
 [<c010227d>] kernel_thread_helper+0x5/0x18

pccardd       S DD12E050     0   834      1          1112   124 (L-TLB)
dd191f84 00000046 c028dae9 dd12e050 dd12e2a0 c01709de 00100100 00200200 
       940dd836 000f41fe ddeef0b0 00000000 957aa000 000f41fe dd1702d8 00000000 
       dd25cc2c dd25cd90 dd191000 de921b4e de9243db c0120bdc dd25cdb0 dd25cdc8 
Call Trace:
 [<c028dae9>] schedule_timeout+0x69/0xc0
 [<c01709de>] sysfs_create_link+0x7e/0x90
 [<de921b4e>] pccardd+0x16e/0x1d0 [pcmcia_core]
 [<c0120bdc>] sigprocmask+0x4c/0xc0
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<de9219e0>] pccardd+0x0/0x1d0 [pcmcia_core]
 [<c010227d>] kernel_thread_helper+0x5/0x18

dhclient3     S 00000000     0  1112      1          1120   834 (NOTLB)
dcdf6eb8 00000082 dce661a0 00000000 00000001 c0131541 dca2b5c0 dceb5000 
       dca2b000 dceb55c0 00000001 00000000 06500300 000f4200 dd0de878 008f5c1c 
       dcdf6ecc 00000006 00000006 c028dae0 ddfb5058 c013159f 00000000 c0385608 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c011eb00>] process_timeout+0x0/0x10
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c011aacc>] sys_gettimeofday+0x2c/0x70
 [<c0103cfb>] syscall_call+0x7/0xb

portmap       S 00000001     0  1120      1          1291  1112 (NOTLB)
dd0cbf24 00000082 dd0e8400 00000001 dd0dec50 00000010 c02da48c 00000000 
       000000d0 dd0cbf40 dc99b890 00000000 e8194d80 000f4202 dd0dedf8 00000000 
       7fffffff 7fffffff dd0cb000 c028db31 c031ea20 dd157bd8 dcdd0e20 00000001 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c0230a02>] sock_poll+0x12/0x20
 [<c0155e22>] do_pollfd+0x52/0x90
 [<c0155ef4>] do_poll+0x94/0xc0
 [<c015604f>] sys_poll+0x12f/0x220
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0145cef>] filp_close+0x4f/0x80
 [<c0103cfb>] syscall_call+0x7/0xb

syslogd       D DDD28D90     0  1291      1          1679  1120 (NOTLB)
dd859c90 00000082 00000000 ddd28d90 00000000 dd859d34 00000003 00000000 
       00000000 00000000 dd5d76d0 00000000 dbd51ec0 000f4264 dcf9a338 00026ac7 
       dd859ca4 dd859cf8 dd859cd0 c028dae0 d252d41c c0180f73 00000000 d67becd4 
Call Trace:
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c0180f73>] journal_get_write_access+0x33/0x50
 [<c011eb00>] process_timeout+0x0/0x10
 [<c028da3e>] io_schedule_timeout+0xe/0x50
 [<c01ebe02>] blk_congestion_wait+0x72/0x90
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c016030c>] sync_sb_inodes+0x1bc/0x270
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0132212>] get_dirty_limits+0x12/0xd0
 [<c013238d>] balance_dirty_pages+0xbd/0x110
 [<c012f5ad>] generic_file_aio_write_nolock+0x3ed/0x980
 [<c028587b>] unix_dgram_recvmsg+0x13b/0x1e0
 [<c01d3fe4>] opost_block+0xc4/0x170
 [<c012fb9f>] generic_file_write_nolock+0x5f/0x80
 [<c02300c6>] sockfd_lookup+0x16/0x80
 [<c02315bb>] sys_recvfrom+0xeb/0x100
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c01554da>] poll_freewait+0x3a/0x50
 [<c0155822>] do_select+0x192/0x2a0
 [<c012fd69>] generic_file_writev+0x39/0x60
 [<c012fd30>] generic_file_writev+0x0/0x60
 [<c0146903>] do_readv_writev+0x1d3/0x220
 [<c0146380>] do_sync_write+0x0/0xb0
 [<c0231c40>] sys_socketcall+0x150/0x250
 [<c01469e9>] vfs_writev+0x49/0x60
 [<c0146a98>] sys_writev+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

klogd         S DD50E000     0  1679      1          1685  1291 (NOTLB)
dd50edc8 00000086 dd6da610 dd50e000 c02d82a4 00001000 dd1486c4 400026c4 
       2a9a8a80 000f4239 dc99ad90 00000000 61d4a9c0 000f424a dd6da7b8 dd36fe00 
       7fffffff dd36ff50 dd50ee28 c028db31 61d4a9c0 dd50edec c0114e4a c037b3e0 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c0114e4a>] activate_task+0x5a/0x70
 [<c028489b>] unix_wait_for_peer+0x8b/0xb0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0234ff9>] memcpy_fromiovec+0x29/0x50
 [<c0285263>] unix_dgram_sendmsg+0x333/0x450
 [<c023052d>] sock_aio_write+0xad/0xd0
 [<c01463ef>] do_sync_write+0x6f/0xb0
 [<c0114cfb>] recalc_task_prio+0x8b/0x180
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0146507>] vfs_write+0xd7/0x100
 [<c01465c8>] sys_write+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

dnsmasq       S 00000000     0  1685      1          1794  1679 (NOTLB)
dccffeb8 00000082 dd2adec0 00000000 00000001 c0131541 00000246 00000000 
       c02300c6 00000000 dd564670 00000000 1302a200 000f4201 dd1718d8 00000000 
       7fffffff 00000004 00000004 c028db31 dcf5fa18 c013159f 00000000 c015556f 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c02300c6>] sockfd_lookup+0x16/0x80
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c0235b22>] datagram_poll+0x12/0xb0
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c012181f>] sys_rt_sigaction+0x6f/0xa0
 [<c0120cc6>] sys_rt_sigprocmask+0x76/0xb0
 [<c0103cfb>] syscall_call+0x7/0xb

acpid         S 00000000     0  1794      1          1822  1685 (NOTLB)
dca72f24 00000082 dd8c1440 00000000 c013ab5e 00000001 dcc44cf0 00000010 
       c02da48c 00000000 000000d0 000f4240 8a28f3c0 000f4201 dcc44e98 00000000 
       7fffffff 7fffffff dca72000 c028db31 dd3e37d8 c0285fb2 c031ff60 dd3e37d8 
Call Trace:
 [<c013ab5e>] handle_mm_fault+0xbe/0x120
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c0285fb2>] unix_poll+0x12/0x90
 [<c0230a02>] sock_poll+0x12/0x20
 [<c0155e22>] do_pollfd+0x52/0x90
 [<c0155ef4>] do_poll+0x94/0xc0
 [<c015604f>] sys_poll+0x12f/0x220
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0103cfb>] syscall_call+0x7/0xb

cupsd         S C0131541     0  1822      1          1846  1794 (NOTLB)
dd571eb8 00000082 00000001 c0131541 dc26ef34 00000000 dd571ed8 dc26eecc 
       00000001 dcc44770 00000010 00000000 9e7e5440 000f4261 dcc44918 0002a169 
       dd571ecc 00000004 00000004 c028dae0 00000000 c015556f c031ea20 c0385418 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c011eb00>] process_timeout+0x0/0x10
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c01a4fea>] __copy_to_user_ll+0x3a/0x60
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c011aa16>] sys_time+0x16/0x50
 [<c0103cfb>] syscall_call+0x7/0xb

exim3         S C0131541     0  1846      1          1855  1822 (NOTLB)
dcbe8eb8 00000086 00000001 c0131541 00000086 c02da314 00000001 00000000 
       00000001 dd565170 00000010 000f4240 ca4be880 000f4202 dd565318 00000000 
       7fffffff 00000002 00000002 c028db31 00000000 c015556f c031ea20 00000246 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c02522ba>] tcp_poll+0x1a/0x140
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c012183d>] sys_rt_sigaction+0x8d/0xa0
 [<c0103cfb>] syscall_call+0x7/0xb

famd          S C0131541     0  1855      1          1859  1846 (NOTLB)
dd60feb8 00000082 00000001 c0131541 00000011 c137fd60 c012ea4e 00000020 
       00000001 dc99b890 00000010 00000000 e8194d80 000f4202 dc99ba38 00000000 
       7fffffff 00000004 00000004 c028db31 00000000 c015556f c031ea20 00000246 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c012ea4e>] filemap_nopage+0x1be/0x2f0
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c02522ba>] tcp_poll+0x1a/0x140
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c02327f6>] sk_free+0x66/0xd0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c0103cfb>] syscall_call+0x7/0xb

gpm           S C02DA244     0  1859      1          1864  1855 (NOTLB)
dcca7eb8 00000086 00000000 c02da244 dd556b00 00000000 00000001 c0131541 
       19e75fc0 000f4215 dd6880b0 00000000 e1c4ccc0 000f4239 dd4b3338 0525f55b 
       dcca7ecc 00000003 00000003 c028dae0 dd556b00 dcca7f4c c0397b5c c03857d0 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c011eb00>] process_timeout+0x0/0x10
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0145965>] dentry_open+0xc5/0x1a0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c011aa16>] sys_time+0x16/0x50
 [<c0103cfb>] syscall_call+0x7/0xb

inetd         S C0131541     0  1864      1          1903  1859 (NOTLB)
dd6d4eb8 00000086 00000001 c0131541 dd2cfc40 c13ae660 c012ea4e dd6d4ed8 
       00000001 dd5d6bd0 dd04c170 000f4240 ef8ca6c0 000f4202 dd5d6d78 00000000 
       7fffffff 00000005 00000005 c028db31 00000000 c015556f c031ea20 00000246 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c012ea4e>] filemap_nopage+0x1be/0x2f0
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c02522ba>] tcp_poll+0x1a/0x140
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c012181f>] sys_rt_sigaction+0x6f/0xa0
 [<c0103cfb>] syscall_call+0x7/0xb

racoon        S 00000000     0  1903      1          1913  1864 (NOTLB)
dc80deb8 00000082 dd556d80 00000000 00000001 c0131541 c012ea4e c02300c6 
       00000000 dc80d000 00000001 00000000 6bf26080 000f4260 dd6db2b8 00026e12 
       dc80decc 00000009 00000009 c028dae0 dbf94e58 c013159f 00000000 dd0e84c4 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c012ea4e>] filemap_nopage+0x1be/0x2f0
 [<c02300c6>] sockfd_lookup+0x16/0x80
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c011eb00>] process_timeout+0x0/0x10
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c011aa16>] sys_time+0x16/0x50
 [<c0103cfb>] syscall_call+0x7/0xb

sshd          S C0131541     0  1913      1          1920  1903 (NOTLB)
dc83beb8 00000086 00000001 c0131541 dc0c14b4 00000000 dc83bed8 dc0c144c 
       00000001 dcbc3810 00000010 000f4240 1e755180 000f4203 dcbc39b8 00000000 
       7fffffff 00000004 00000004 c028db31 00000000 c015556f c031ea20 00000246 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c02522ba>] tcp_poll+0x1a/0x140
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c0103cfb>] syscall_call+0x7/0xb

ntpd          S 00000000     0  1920      1          1925  1913 (NOTLB)
dcb04eb8 00000082 dd397100 00000000 00000001 c0131541 bffffa30 ffff037f 
       ffff0320 ffffffff 00000001 00000000 a63f7800 000f4264 dd4b2838 00000000 
       7fffffff 00000007 00000007 c028db31 dbf94358 c013159f 00000000 c015556f 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c015556f>] __pollwait+0x7f/0xc0
 [<c0235b22>] datagram_poll+0x12/0xb0
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c010a405>] convert_fxsr_from_user+0x15/0xe0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c0103cfb>] syscall_call+0x7/0xb

atd           S 00000000     0  1925      1          1928  1920 (NOTLB)
dcc21f5c 00000086 00000000 00000000 c01552b0 dcc21fa0 dd31fc40 00030002 
       00000000 3f67b028 00000000 00000000 43e3d680 000f4203 dd6887d8 0032f5af 
       dcc21f70 000f41a7 00000e10 c028dae0 00000000 00000000 4487bebc c03855e0 
Call Trace:
 [<c01552b0>] filldir64+0x0/0xe0
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c011eb00>] process_timeout+0x0/0x10
 [<c011ebee>] sys_nanosleep+0xce/0x150
 [<c0103cfb>] syscall_call+0x7/0xb

cron          S 00000000     0  1928      1          1933  1925 (NOTLB)
dd817f5c 00000086 00000000 00000000 000001fd 00000000 00001000 00000008 
       00000000 409230c8 00000000 00000000 c7dc6d80 000f4262 dd689858 000331f1 
       dd817f70 000f41a7 0000003c c028dae0 00000000 00000000 4487bebc c0399e80 
Call Trace:
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c011eb00>] process_timeout+0x0/0x10
 [<c011ebee>] sys_nanosleep+0xce/0x150
 [<c0103cfb>] syscall_call+0x7/0xb

gdm           S 00000001     0  1933      1  1934    2044  1928 (NOTLB)
dd120f24 00000086 00000000 00000001 dd689130 00000010 c02da48c 00000000 
       000000d0 c011fe3a dd0df1d0 00000000 056e9f80 000f4207 dd6892d8 00000000 
       7fffffff 7fffffff dd120000 c028db31 dd120fa0 c0150562 00000145 dd157f60 
Call Trace:
 [<c011fe3a>] __group_send_sig_info+0x8a/0xc0
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c0150562>] pipe_poll+0x32/0x90
 [<c0155e22>] do_pollfd+0x52/0x90
 [<c0155ef4>] do_poll+0x94/0xc0
 [<c015604f>] sys_poll+0x12f/0x220
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c0103cfb>] syscall_call+0x7/0xb

gdm           S DA643DA4     0  1934   1933  2043               (NOTLB)
dcac4eec 00000086 db67b708 da643da4 401c6df6 c013a86e dd1b2080 00000001 
       080a5014 c02dce60 00000000 00000000 580bcdc0 000f4208 dd0df378 db4480a8 
       db448040 dcac4f14 00000000 c014feb9 00000000 dd0df1d0 c0116470 dcac4f20 
Call Trace:
 [<c013a86e>] do_no_page+0x14e/0x290
 [<c014feb9>] pipe_wait+0x79/0xa0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c015b2fb>] inode_update_time+0xbb/0xc0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0150074>] pipe_readv+0x194/0x280
 [<c0150180>] pipe_read+0x20/0x30
 [<c0146330>] vfs_read+0xb0/0x100
 [<c0146568>] sys_read+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

XFree86       S 00000000     0  2043   1934          2219       (NOTLB)
dcae9eb8 00000086 dd2ada60 00000000 00000001 c0131541 bffff360 ffff037f 
       ffff0020 ffffffff 00000001 00000000 ce99ab40 000f4264 ddd24218 00069de5 
       dcae9ecc 0000000b 0000000b c028dae0 dbc5cd18 c013159f 00000000 c0385498 
Call Trace:
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c013159f>] __get_free_pages+0x1f/0x40
 [<c011eb00>] process_timeout+0x0/0x10
 [<c01557fd>] do_select+0x16d/0x2a0
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c010a405>] convert_fxsr_from_user+0x15/0xe0
 [<c0155bfe>] sys_select+0x2ae/0x480
 [<c011aacc>] sys_gettimeofday+0x2c/0x70
 [<c0103cfb>] syscall_call+0x7/0xb

bash          S DD31E1C8     0  2044      1  2259    2045  1933 (NOTLB)
dd8c9f48 00000086 dd51a2c0 dd31e1c8 dcbc2d10 c0113f14 00000001 c0124814 
       00000001 080ed408 dd5d76d0 00000000 095f1f80 000f4247 dcbc2eb8 fffffe00 
       dcbc2d10 dcbc2da8 dcbc2da8 c011a3da dd8c9f70 dd8c9000 00000001 00000000 
Call Trace:
 [<c0113f14>] do_page_fault+0x114/0x4cc
 [<c0124814>] attach_pid+0x24/0xe0
 [<c011a3da>] sys_wait4+0x17a/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01a50a2>] copy_to_user+0x32/0x50
 [<c011a4b7>] sys_waitpid+0x27/0x2b
 [<c0103cfb>] syscall_call+0x7/0xb

bash          S DCF34804     0  2045      1  2254    2046  2044 (NOTLB)
db69af48 00000082 dd5e26a0 dcf34804 dd6db690 c0113f14 00000001 c0124814 
       00000001 0810d268 dc99ad90 00000000 2d7a74c0 000f4240 dd6db838 fffffe00 
       dd6db690 dd6db728 dd6db728 c011a3da db69af70 db69a000 00000001 00000000 
Call Trace:
 [<c0113f14>] do_page_fault+0x114/0x4cc
 [<c0124814>] attach_pid+0x24/0xe0
 [<c011a3da>] sys_wait4+0x17a/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01a50a2>] copy_to_user+0x32/0x50
 [<c011a4b7>] sys_waitpid+0x27/0x2b
 [<c0103cfb>] syscall_call+0x7/0xb

getty         S 00000000     0  2046      1          2056  2045 (NOTLB)
db728e88 00000086 00000000 00000000 ddd6b200 db728e90 dce926a0 c0390d80 
       0804ad78 00000282 ddfe5600 00000000 232b4300 000f4204 dd170858 db689000 
       7fffffff db728f20 db728000 c028db31 00000001 00000000 0000b98c db7261f6 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c01d5b87>] read_chan+0x5d7/0x760
 [<c01e08f4>] con_write+0x24/0x40
 [<c01d5e8c>] write_chan+0x17c/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01d1328>] tty_read+0xc8/0xf0
 [<c01d5d10>] write_chan+0x0/0x230
 [<c0146330>] vfs_read+0xb0/0x100
 [<c013ca9d>] do_munmap+0xed/0x120
 [<c0146568>] sys_read+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

getty         S 00000000     0  2056      1          2057  2046 (NOTLB)
db6fbe88 00000082 00000000 00000000 ddd6ba00 db6fbe90 dce926a0 c0390d80 
       0804ad78 00000282 ddfe5600 00000000 23d31bc0 000f4204 ddd24798 db63e000 
       7fffffff db6fbf20 db6fb000 c028db31 00000000 00001000 00001000 dca8b1f6 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c01d5b87>] read_chan+0x5d7/0x760
 [<c01e08f4>] con_write+0x24/0x40
 [<c01d5e8c>] write_chan+0x17c/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01d1328>] tty_read+0xc8/0xf0
 [<c01d5d10>] write_chan+0x0/0x230
 [<c0146330>] vfs_read+0xb0/0x100
 [<c013ca9d>] do_munmap+0xed/0x120
 [<c0146568>] sys_read+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

getty         S 00000000     0  2057      1          2182  2056 (NOTLB)
db75de88 00000082 00000000 00000000 ddd6be00 db75de90 dcdd04c0 c0390d80 
       0804ad7e 00000282 ddfe5600 00000000 83d90480 000f4204 dc99a438 db83f000 
       7fffffff db75df20 db75d000 c028db31 00000000 00001000 00008000 db6811f6 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c01d5b87>] read_chan+0x5d7/0x760
 [<c01e08f4>] con_write+0x24/0x40
 [<c01d5e8c>] write_chan+0x17c/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01d1328>] tty_read+0xc8/0xf0
 [<c01d5d10>] write_chan+0x0/0x230
 [<c0146330>] vfs_read+0xb0/0x100
 [<c013ca9d>] do_munmap+0xed/0x120
 [<c0146568>] sys_read+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

getty         S 00000000     0  2182      1          2220  2057 (NOTLB)
db6abe88 00000086 00000000 00000000 ddd6b800 db6abe90 dcfec920 c0390d80 
       0804ad78 00000282 ddfe5600 00000000 78e26600 000f4206 dd171358 dbbe6000 
       7fffffff db6abf20 db6ab000 c028db31 00000000 00001000 00001000 db6cb1f6 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c01d5b87>] read_chan+0x5d7/0x760
 [<c01e08f4>] con_write+0x24/0x40
 [<c01d5e8c>] write_chan+0x17c/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01d1328>] tty_read+0xc8/0xf0
 [<c01d5d10>] write_chan+0x0/0x230
 [<c0146330>] vfs_read+0xb0/0x100
 [<c013ca9d>] do_munmap+0xed/0x120
 [<c0146568>] sys_read+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

gdmgreeter    S 00000001     0  2219   1934                2043 (NOTLB)
dcd6ef24 00000082 00000001 00000001 dd4b2110 00000010 c02da48c 00000000 
       cd593c00 000f4264 ddd24070 00000000 cd593c00 000f4264 dd4b22b8 00026b08 
       dcd6ef38 00000198 dcd6e000 c028dae0 dcd6efa0 c0150562 00000145 c0385320 
Call Trace:
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c0150562>] pipe_poll+0x32/0x90
 [<c011eb00>] process_timeout+0x0/0x10
 [<c0155ef4>] do_poll+0x94/0xc0
 [<c015604f>] sys_poll+0x12f/0x220
 [<c01a50a2>] copy_to_user+0x32/0x50
 [<c01554f0>] __pollwait+0x0/0xc0
 [<c011aacc>] sys_gettimeofday+0x2c/0x70
 [<c0103cfb>] syscall_call+0x7/0xb

getty         S 00000000     0  2220      1          2247  2182 (NOTLB)
db6afe88 00000086 00000000 00000000 ddd6b600 db6afe90 dcfec2e0 c0390d80 
       0804ad78 00000282 ddfe5600 00000000 c7bec640 000f4208 dd170dd8 dc9e4000 
       7fffffff db6aff20 db6af000 c028db31 00000001 00000000 0000b98c db6f91f6 
Call Trace:
 [<c028db31>] schedule_timeout+0xb1/0xc0
 [<c01d5b87>] read_chan+0x5d7/0x760
 [<c01e08f4>] con_write+0x24/0x40
 [<c01d5e8c>] write_chan+0x17c/0x230
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c0115690>] default_wake_function+0x0/0x10
 [<c01d1328>] tty_read+0xc8/0xf0
 [<c01d5d10>] write_chan+0x0/0x230
 [<c0146330>] vfs_read+0xb0/0x100
 [<c013ca9d>] do_munmap+0xed/0x120
 [<c0146568>] sys_read+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

pdflush       S 00000400     0  2242      3                  35 (L-TLB)
dccc4f94 00000046 dccc4f48 00000400 00000000 00000001 00000000 00000001 
       00000000 00000001 00000000 00000000 be62c780 000f4263 dcf9b938 dccc4fbc 
       dccc4fb0 dccc4000 c0132e60 c0132d6e dccc4000 dccc4000 ddd60f58 00000000 
Call Trace:
 [<c0132e60>] pdflush+0x0/0x20
 [<c0132d6e>] __pdflush+0x6e/0x160
 [<c0132e7a>] pdflush+0x1a/0x20
 [<c0132e60>] pdflush+0x0/0x20
 [<c0126e04>] kthread+0x94/0xa0
 [<c0126d70>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18

cifsoplockd   S DB774F88     0  2247      1          2250  2220 (L-TLB)
db774f7c 00000046 dcf9b790 db774f88 00000046 dceb8380 dcf9b790 dd093340 
       dcf9a710 c0119626 dcbc3290 00000000 45ecc440 000f4263 dcbc2938 0002e821 
       db774f90 db774000 00000000 c028dae0 00000097 dcbc2790 db774000 c0385420 
Call Trace:
 [<c0119626>] exit_notify+0x1f6/0x6c0
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c011eb00>] process_timeout+0x0/0x10
 [<de9c0a52>] cifs_oplock_thread+0x1d2/0x1e3 [cifs]
 [<de9c0880>] cifs_oplock_thread+0x0/0x1e3 [cifs]
 [<de9c0880>] cifs_oplock_thread+0x0/0x1e3 [cifs]
 [<c010227d>] kernel_thread_helper+0x5/0x18

cifsd         S 00000087     0  2250      1                2247 (L-TLB)
dc867dcc 00000046 c0375000 00000087 c010606c fdffffff 1ffffbff ffd7ff02 
       dc867000 ddd04248 dc99ad90 00000000 0a157100 000f4264 dcbc23b8 000277fc 
       dc867de0 00000000 dc867e94 c028dae0 d252d854 00000000 0000007b c0385380 
Call Trace:
 [<c010606c>] do_IRQ+0xdc/0x150
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c011eb00>] process_timeout+0x0/0x10
 [<c0232e48>] sk_wait_data+0xb8/0xd0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0254fc5>] tcp_recvmsg+0x365/0x700
 [<c0271b8a>] inet_recvmsg+0x4a/0x70
 [<c023037c>] sock_recvmsg+0x9c/0xd0
 [<c028d59c>] schedule+0x25c/0x410
 [<c0130273>] mempool_alloc+0x63/0x100
 [<c028dae9>] schedule_timeout+0x69/0xc0
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c011eb00>] process_timeout+0x0/0x10
 [<de9c6d76>] cifs_demultiplex_thread+0xd6/0x770 [cifs]
 [<de9c6ca0>] cifs_demultiplex_thread+0x0/0x770 [cifs]
 [<c010227d>] kernel_thread_helper+0x5/0x18

cp            D 00000000     0  2254   2045                     (NOTLB)
ddd59cd0 00000082 c02da20c 00000000 00000001 00000086 00000086 00000000 
       c02da120 c02da120 dd6880b0 00000000 dbd51ec0 000f4264 dc99af38 00026ac7 
       ddd59ce4 ddd59d38 ddd59d10 c028dae0 00000001 c0131541 00000001 c0385000 
Call Trace:
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c0131541>] __alloc_pages+0x2c1/0x300
 [<c011eb00>] process_timeout+0x0/0x10
 [<c028da3e>] io_schedule_timeout+0xe/0x50
 [<c01ebe02>] blk_congestion_wait+0x72/0x90
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0132212>] get_dirty_limits+0x12/0xd0
 [<c013238d>] balance_dirty_pages+0xbd/0x110
 [<c012f5ad>] generic_file_aio_write_nolock+0x3ed/0x980
 [<c012e2d0>] file_read_actor+0xc0/0xd0
 [<c012e477>] __generic_file_aio_read+0x197/0x1d0
 [<c012e210>] file_read_actor+0x0/0xd0
 [<c012fb9f>] generic_file_write_nolock+0x5f/0x80
 [<c014623f>] do_sync_read+0x6f/0xb0
 [<c01060a3>] do_IRQ+0x113/0x150
 [<c012fc8e>] generic_file_write+0x3e/0x60
 [<de9c05bc>] cifs_write_wrapper+0x4c/0xb0 [cifs]
 [<c01464e0>] vfs_write+0xb0/0x100
 [<c01465c8>] sys_write+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

vi            D D67BED64     0  2259   2044                     (NOTLB)
d67becc0 00000086 00000000 d67bed64 0028000f 00000000 00000000 00000000 
       00000000 c13b2a60 dc99ad90 00000000 dbd51ec0 000f4264 dd5d7878 00026ac7 
       d67becd4 d67bed28 d67bed00 c028dae0 d252d3bc c0180f73 00000000 ddd59ce4 
Call Trace:
 [<c028dae0>] schedule_timeout+0x60/0xc0
 [<c0180f73>] journal_get_write_access+0x33/0x50
 [<c011eb00>] process_timeout+0x0/0x10
 [<c028da3e>] io_schedule_timeout+0xe/0x50
 [<c01ebe02>] blk_congestion_wait+0x72/0x90
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c016030c>] sync_sb_inodes+0x1bc/0x270
 [<c0116470>] autoremove_wake_function+0x0/0x50
 [<c0132212>] get_dirty_limits+0x12/0xd0
 [<c013238d>] balance_dirty_pages+0xbd/0x110
 [<c012f5ad>] generic_file_aio_write_nolock+0x3ed/0x980
 [<c01dca7d>] build_attr+0x11d/0x120
 [<c01e08f4>] con_write+0x24/0x40
 [<c012fc24>] generic_file_aio_write+0x64/0x90
 [<c0173340>] ext3_file_write+0x30/0xb0
 [<c01463ef>] do_sync_write+0x6f/0xb0
 [<c01395e5>] unmap_vmas+0xf5/0x1b0
 [<c013c812>] unmap_region+0x92/0xe0
 [<c01464e0>] vfs_write+0xb0/0x100
 [<c01465c8>] sys_write+0x38/0x60
 [<c0103cfb>] syscall_call+0x7/0xb

-- 
Nuno Ferreira

