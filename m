Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTFYMoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTFYMoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:44:39 -0400
Received: from tiffi.office-b.jamba.net ([194.221.137.169]:29165 "EHLO
	tiffi.office-b.jamba.net") by vger.kernel.org with ESMTP
	id S264156AbTFYMoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:44:37 -0400
Message-ID: <3EF99C85.3050308@jamba.net>
Date: Wed, 25 Jun 2003 14:58:45 +0200
From: Andreas Heilwagen <andreas.heilwagen@jamba.net>
Organization: Jamba! AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.72: kernel BUG at fs/xfs/pagebuf/page_buf.c:1288
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a bug in the XFS page buffer code which occured once a day 
with 2.5.66 and now every few days with 2.5.72. First the bug from the 
serial console which occured during high load:

kernel BUG at fs/xfs/pagebuf/page_buf.c:1288!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c027b790>]    Not tainted
EFLAGS: 00010202
EIP is at bio_end_io_pagebuf+0xf8/0x154
eax: 01008009   ebx: f0497fd0   ecx: c14e86a8   edx: dcca3380
esi: f0497fdc   edi: 00000001   ebp: f7ae9b84   esp: f7ae9b68
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 11, threadinfo=f7ae8000 task=f7aed2e0)
Stack: e1b91600 00000000 ce25bee0 c14e86a8 00000009 00001000 dcca3380 
f7ae9ba0
        c0156515 e1b91600 00001000 00000000 c8684ed0 cdeeb900 f7ae9bbc 
f8cbd1c5
        e1b91600 00001000 00000000 cdeeb900 00000000 f7ae9bd8 c0156515 
cdeeb900
Call Trace:
  [<c0156515>] bio_endio+0x51/0x5c
  [<f8cbd1c5>] clone_endio+0x9d/0xc4 [dm_mod]
  [<c0156515>] bio_endio+0x51/0x5c
  [<c030c9af>] __end_that_request_first+0x107/0x1d8
  [<c030ca97>] end_that_request_first+0x17/0x1c
  [<c0344725>] scsi_end_request+0x29/0xc0
  [<c0344b3a>] scsi_io_completion+0x1fa/0x460
  [<c038b9e7>] sd_rw_intr+0x207/0x214
  [<c0340755>] scsi_finish_command+0xc1/0xcc
  [<c034064d>] scsi_softirq+0xad/0xc4
  [<c012394a>] do_softirq+0x6a/0xd0
  [<c010cdd6>] do_IRQ+0x15a/0x174
  [<c010b4dc>] common_interrupt+0x18/0x20
  [<c0148416>] page_referenced+0x26/0xe0
  [<c0140059>] shrink_list+0x11d/0x5e0
  [<c011be16>] schedule+0x3f6/0x4e0
  [<c010aab9>] need_resched+0x27/0x32
  [<c01406d1>] shrink_cache+0x1b5/0x320
  [<c0140ed4>] shrink_zone+0x7c/0x88
  [<c01411a1>] balance_pgdat+0xe1/0x174
  [<c0141349>] kswapd+0x115/0x11c
  [<c0141234>] kswapd+0x0/0x11c
  [<c011df20>] autoremove_wake_function+0x0/0x3c
  [<c011df20>] autoremove_wake_function+0x0/0x3c
  [<c0108d25>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 08 05 d4 29 44 c0 8b 4d 08 89 fa 89 f3 0f b7 41 18 39
  <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
  <0>Rebooting in 60 seconds..

I am in the unfortunate position to run a production server with 2.5.72 
since the SuperMicro CSE-742S-500 has no working APIC support in the 
2.4.x kernel series. Currently I have 2 XEON CPUs installed.

2.5.66 died once a day with "kernel panic: Aiee, killing interrupt 
handler" in fs/xfs/pagebuf/page_buf.c:1287. The reason is an "invalid 
operand:0000 #5" on CPU:0 with "EIP:0060:[<c024f059>] Not tainted". In 
one case slapd from the OpenLDAP package caused the crash.

Now I run 2.5.72 and got the message above you see first. Furthermore 
the Arkeia backup hangs locally on the same volume every night.

I have an 39320 Dual U320 SCSI controller in the machine with a Overland 
PowerLoader LTO-1 (17 slots) and a Infortrend IFT 6300-12 IDE-Raid with 
one 700G XFS volume configured.

Please tell me what further tests I should conduct to help the analysis?


Looking forward,

Andreas

