Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbUJXLlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUJXLlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUJXLlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:41:16 -0400
Received: from lorien.s2s.msu.ru ([193.232.119.108]:1940 "EHLO
	lorien.s2s.msu.ru") by vger.kernel.org with ESMTP id S261445AbUJXLlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:41:01 -0400
Date: Sun, 24 Oct 2004 15:41:00 +0400
From: Alexander Vodomerov <alex@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: oops on 2.6.9 in 'ip ro del': debug results
Message-ID: <20041024114100.GA7003@lorien.local>
References: <20041024095932.GA25487@lorien.local> <200410241308.04610.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410241308.04610.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 01:08:04PM +0300, Denis Vlasenko wrote:
> Okay, so you've got an oops and want to find out what happened?
Thank you for nice docs!

I recompiled kernel with frame pointers. Here is stack dump and results
of my investigation.

Error occurs in fib_release_info (net/ipv4/fib_semantics.c:164) in the
following lines:

fib_release_info:
	...
	change_nexthops(fi) {
		hlist_del(&nh->nh_hash);
	} endfor_nexthops(fi)

hlist_del calls __hlist_del: 

__hlist_del:
        struct hlist_node *next = n->next;
	struct hlist_node **pprev = n->pprev;
	*pprev = next;           <===  Oops here: pprev = NULL
	if (next) {
		next->pprev = pprev;
	}

Oops is occuring, becuase pprev is NULL (may be it is hlist head?) in
line **prev = next;

I can make any additional debugging. I'm not a kernel hacker, may be you
can provide a link to explation how all this fib/hlist struct works?

BTW, this time I managed to get oops without hang, so it was just copied
from dmesg output:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
802c1c83
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ieee1394 8139too mii crc32 tg3 snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore psmouse usbhid evdev usb_storage ehci_hcd uhci_hcd usbcore sd_mod sg scsi_mod asb100 i2c_sensor i2c_viapro i2c_dev i2c_core tun mga via_agp agpgart
CPU:    0
EIP:    0060:[<802c1c83>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9) 
EIP is at fib_release_info+0x73/0xc0
eax: 00000000   ebx: beaf2974   ecx: 00000000   edx: beaf2914
esi: beaf2978   edi: be33726c   ebp: befc9bf8   esp: befc9bf0
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 1295, threadinfo=befc8000 task=bf01e020)
Stack: 00000001 be337274 befc9c40 802c3d78 beaf2914 be33726c be31b260 00000000 
       000000c8 bec7c254 be32c9a4 be31b260 001bcbe4 bea753b8 00000000 be33726c 
       befc9c74 bec7c264 bec7c254 bfff170c befc9c68 802c1437 bffe3ac0 bec7c264 
Call Trace:
 [<80105d1f>] show_stack+0x7f/0xa0
 [<80105eba>] show_registers+0x15a/0x1c0
 [<8010607e>] die+0xce/0x150
 [<80116aaf>] do_page_fault+0x2df/0x5c7
 [<8010592d>] error_code+0x2d/0x38
 [<802c3d78>] fn_hash_delete+0x1c8/0x280
 [<802c1437>] inet_rtm_delroute+0x67/0x80
 [<8028b720>] rtnetlink_rcv+0x2e0/0x3b0
 [<8029068a>] netlink_data_ready+0x5a/0x70
 [<8028fc53>] netlink_sendskb+0x93/0xa0
 [<80290327>] netlink_sendmsg+0x1f7/0x2f0
 [<8027a4df>] sock_sendmsg+0xbf/0xe0
 [<8027bdac>] sys_sendmsg+0x1bc/0x240
 [<8027c245>] sys_socketcall+0x215/0x240
 [<80104f23>] syscall_call+0x7/0xb
Code: 8d 5a 08 8b 4b 04 85 c0 89 01 74 03 89 48 04 c7 42 08 00 01 10 00 c7 43 04 00 02 20 00 8d 5a 60 8d 72 64 8b 43 04 8b 4e 04 85 c0 <89> 01 74 03 89 48 04 c7 43 04 00 01 10 00 c7 46 04 00 02 20 00 
 
