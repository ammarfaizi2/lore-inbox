Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUGaXUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUGaXUb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 19:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUGaXUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 19:20:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:48911 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262328AbUGaXU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 19:20:28 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [BUG] kernel BUG at linux-2.6.7-bk20.src/mm/rmap.c:407!
Date: Sun, 1 Aug 2004 02:20:17 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408010220.17416.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

One of my supervise processes was nuked,
out of the blue. No more ill effects on the system.

void page_remove_rmap(struct page *page)
{
        BUG_ON(PageReserved(page));
        BUG_ON(!page->mapcount);   <==================== line 407

        page_map_lock(page);
        page->mapcount--;
        if (!page->mapcount) {
                if (page_test_and_clear_dirty(page))
                        set_page_dirty(page);
                if (PageAnon(page))
                        clear_page_anon(page);
                dec_page_state(nr_mapped);
        }
        page_map_unlock(page);
}

------------[ cut here ]------------
kernel BUG at /.1/usr/srcdevel/kernel/linux-2.6.7-bk20.src/mm/rmap.c:407!
invalid operand: 0000 [#1]
Modules linked in: snd_pcm_oss iptable_mangle snd_mixer_oss iptable_filter snd_via82xx snd_pcm snd_timer snd_ac97_codec snd_page_alloc snd_mpu
CPU:    0
EIP:    0060:[<c013846b>]    Not tainted
EFLAGS: 00010246   (2.6.7-bk20)
EIP is at page_remove_rmap+0x4e/0x62
eax: 00000000   ebx: 0000a000   ecx: 00000000   edx: c10001e0
esi: ceee0028   edi: c10001e0   ebp: ced18dc8   esp: ced18dc8
ds: 007b   es: 007b   ss: 0068
Process supervise (pid: 394, threadinfo=ced18000 task=ced11160)
Stack: ced18de4 c01335f6 c10001e0 0000f71b 40400000 cf6b7400 40012000 ced18e14
       c0133730 c0654204 cf6b7400 40000000 00012000 00000000 00000000 c0654204
       40000000 cf6b7400 40012000 ced18e3c c0133786 c0654204 cf6b7400 40000000
Call Trace:
 [<c0105cc6>] show_stack+0x71/0x86
 [<c0105e0f>] show_registers+0x119/0x165
 [<c0105f34>] die+0x50/0xa8
 [<c010623b>] do_invalid_op+0x94/0x96
 [<c010594d>] error_code+0x2d/0x40
 [<c01335f6>] zap_pte_range+0x122/0x215
 [<c0133730>] zap_pmd_range+0x47/0x69
 [<c0133786>] unmap_page_range+0x34/0x60
 [<c01338a1>] unmap_vmas+0xef/0x1c5
 [<c0136d8a>] exit_mmap+0x64/0x122
 [<c01125ec>] mmput+0x47/0x5f
 [<c0115dae>] do_exit+0xdf/0x337
 [<c011607c>] do_group_exit+0x2b/0x68
 [<c011c67c>] get_signal_to_deliver+0x200/0x2b6
 [<c0105423>] do_signal+0x49/0xc0
 [<c01054d3>] do_notify_resume+0x39/0x46
 [<c01056be>] work_notifysig+0x13/0x15
Code: 0f 0b 97 01 a0 d0 42 c0 eb bc 0f 0b 96 01 a0 d0 42 c0 eb ab
--
vda

