Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUHVPEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUHVPEu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUHVPEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:04:50 -0400
Received: from av11-1-sn4.m-sp.skanova.net ([81.228.10.106]:3219 "EHLO
	av11-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S267364AbUHVPEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:04:37 -0400
Date: Sun, 22 Aug 2004 17:04:35 +0200 (CEST)
Message-Id: <200408221504.i7MF4Z719895@d1o404.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [213.64.150.229] 2004-08-22 17:04:35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

NOTE
I wrote the text below just prior to the posting of
01-2.6-cbq-leaks.diff but applying it doesn't change the
situation here. I still get the same Oops as below. Slight
changes in memory address but the Call Trace is identical.
So, different problem?
ENDNOTE

Yes, saw the same thing on eth0 but had a confusing time to catch a
clean error situation. Having been used to stable kernels for a long
time I've disabled all debugging options and compile for size. So
when 2.6.8[.1] threw an Oops at the end of every "shutdown -r now"
the feedback was useless ("halt" gave no Oops). What looked to be
the same Oops came when doing a "rmmod 8139too". 2.6.7 has no such
issues.

Turning on CONFIG_KALLSYMS (and CONFIG_CC_OPTIMIZE_FOR_SIZE off), with
CONFIG_FRAME_POINTER, a slew of other debug options and the
CONFIG_MAGIC_SYSRQ, hid the Oops and gave the result Nuno Silva
has described.

To make a long story short, I didn't trust my very old system enough
to report.

But now I've seen the QoS/wshaper connection and achieved a good Oops
with only CONFIG_KALLSYMS and CONFIG_FRAME_POINTER set.

Typing it here in case it has some kind of value (hand-copied):

[...]
Unmounting local filesystems...
Flushing filesystem buffers...
Please stand by while rebooting...
Unable to handle kernel paging request at virtual address 8bc289a9
 printing eip:
c02ae9c0
*pde = 00000000
Ooops: 0000 [#1]
PREEMPT
Modules linked in: 8139too crc32
CPU:    0
EIP:    0060:[<c02ae9c0>]   Not tainted
EFLAGS: 00010286   (2.6.8-debug)
EIP is at fib_sync_down+0x50/0xb0
eax: cfaee800 ebx: 948bff0d ecx: 8bc28955 edx: c0267eb8
esi: 00000001 edi: 00000000 ebp: cf0a1ea4 esp: cf0a1e8c
de: 007b es: 007b ss: 0068
Process reboot (pid: 151, threadinfo=cf0a1000 task=cfa3e090)
Stack:
000000ff 00000001 cfaee800 cfaee800 cfaee800 00000002 cf0a1eb0 c02ad8d1
c033affc cf0a1ebc c02ad9b9 c033affc cf0a1ed0 c0121508 cfaee800 00000002
00001003 cf0a1ee0 c025dadf cfaee800 00000002 cf0a1ef8 c025ef32 00000000
Call Trace:
 [<c0104d7a>] show_stack+0x7a/0x90
 [<c0104ef9>] show_registers+0x149/0x1a0
 [<c010508d>] die+0x8d/0x100
 [<c0111b45>] do_page_fault+0x1e5/0x569
 [<c0104a15>] error_code+0x2d/0x38
 [<c02ad8d1>] fib_disable_ip+0x11/0x30
 [<c02ad9b9>] fib_netdev_event+0x69/0x80
 [<c0121508>] notifier_call_chain+0x28/0x50
 [<c025dadf>] dev_close+0x8f/0xa0
 [<c025ef32>] dev_change_flags+0x52/0x120
 [<c02a82f5>] devinet_ioctl+0x245/0x590
 [<c02aa573>] inet_ioctl+0x63/0xb0
 [<c0255b82>] sock_ioctl+0xe2/0x230
 [<c0159a95>] sys_ioctl+0x105/0x260
 [<c010400b>] syscall_call+0x7/0xb
Code: 8b 41 54 85 c0 74 19 8d 51 58 31 f6 8b 5a 04 f6 c3 01 74 2c
/etc/rc.d/rc.6: line 49: 151 Segmentation fault /sbin/reboot -d -f -i
INIT: no more processes left in this runlevel
<5>portmap: server localhost not responding, timed out
RPC: failed to contact portmap (errno -5).
portmap: server localhost not responding, timed out
RPC: failed to contact portmap (errno -5).
--endOops--

The -i parametre to reboot (which is a symlink to halt) means to shut
down all network interfaces. My halt command doesn't use the -i, hence
the lack of Oops.

Mvh
Mats Johannesson



