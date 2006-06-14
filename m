Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWFNKOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWFNKOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWFNKOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:14:00 -0400
Received: from mail.gmx.de ([213.165.64.21]:41652 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932281AbWFNKN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:13:59 -0400
X-Authenticated: #704063
Subject: Panic in simple_map_write called from cfi_probe_chip
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org
Content-Type: text/plain
Date: Wed, 14 Jun 2006 12:13:56 +0200
Message-Id: <1150280036.6482.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 

I decided to play around with all the new shiny stuff in 2.6.17-rc6-mm2,
and tried to build a nearly allyesconfig kernel. After some tries,
I got to the point where it still runs after uncompressing, and got
into a panic.

[   31.270647] Photron PNC-2000 flash mapping: 400000 at bf000000
[   31.270737] BUG: unable to handle kernel paging request at virtual address bf000000
[   31.270869]  printing eip:
[   31.270925] c09d516e
[   31.270996] *pde = 00000000
[   31.271051] Oops: 0002 [#1]
[   31.271120] 4K_STACKS PREEMPT
[   31.271270] last sysfs file:
[   31.271340] Modules linked in:
[   31.271453] CPU:    0
[   31.271454] EIP:    0060:[<c09d516e>]    Not tainted VLI
[   31.271456] EFLAGS: 00010286   (2.6.17-rc6-mm2 #7)
[   31.271652] EIP is at simple_map_write+0x4f/0x76
[   31.271737] eax: f0f0f0f0   ebx: c12ed720   ecx: 00000000   edx: 00000020
[   31.271798] esi: dffd19e0   edi: bf000000   ebp: dffd1a0c   esp: dffd19e0
[   31.271885] ds: 007b   es: 007b   ss: 0068
[   31.271941] Process idle (pid: 1, threadinfo=dffd1000 task=dff86b40)
[   31.272032] Stack: f0f0f0f0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   31.272544]        dffd1dd8 c09d511f dffd1dd8 dffd1f04 c09be78e f0f0f0f0 00000000 00000000
[   31.273055]        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000004
[   31.273563] Call Trace:
[   31.277555]  [<c09be78e>] cfi_probe_chip+0x17a/0x13b0
[   31.281571]  [<c09d11c0>] mtd_do_chip_probe+0x73/0x323
[   31.285518]  [<c09be612>] cfi_probe+0xd/0xf
[   31.289447]  [<c09be1a3>] do_map_probe+0x3b/0xbc
[   31.293376]  [<c190e6ab>] init_pnc2000+0x30/0x60
[   31.297311]  [<c01002a1>] init+0x81/0x1df
[   31.297476]  [<c0101005>] kernel_thread_helper+0x5/0xb
[   31.303646] Code: f8 01 75 0b 0f b6 45 d4 03 7b 0c 88 07 eb 35 83 f8 02 75 0c 0f b7 45 d4 03 
7b 0c 66 89 07 eb 24 83 f8 04 75 0a 03 7b 0c 8b 45 d4 <89> 07 eb 15 7e 13 89 c1 03 7b 0c c1 e9
02 f3 a5 89 c1 83 e1 03
[   31.306933] EIP: [<c09d516e>] simple_map_write+0x4f/0x76 SS:ESP 0068:dffd19e0
[   31.307120]  <0>Kernel panic - not syncing: Attempted to kill init!
[   31.307241]

it seems the offendling line is in include/linux/map.h where inline_map_write()
calls __raw_writel(datum.x[0], map->virt + ofs);

due to some inlines not all calls show up here.. basically cfi_probe_chip()
calls cfi_send_gen_cmd() in cfi.h which calls map_write() which in turn
calls inline_map_write(). Since eax is filles with 0xF0 i guess it is
the first call to cfi_send_gen_cmd() in cfi_probe_chip()
cfi_send_gen_cmd(0xF0, 0, base, map, cfi, cfi->device_type, NULL);

Greetings, Eric


