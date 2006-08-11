Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWHKG03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWHKG03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWHKG03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:26:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:1443 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751643AbWHKG02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:26:28 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc3-mm2 - OOM storm
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060810021957.38c82311.akpm@osdl.org>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <44DAF6A4.9000004@free.fr>  <20060810021957.38c82311.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 11 Aug 2006 08:33:51 +0000
Message-Id: <1155285231.5841.6.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 02:19 -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 11:04:36 +0200
> Laurent Riffard <laurent.riffard@free.fr> wrote:
> 
> > Le 06.08.2006 12:08, Andrew Morton a écrit :
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/26.18-rc3-mm2/
> > 
> > Hello,
> > 
> > On my system, a cron runs every day to check the integrity of
> > installed RPMS, it runs "rpm -v" on each package, which computes
> > MD5 hash for each installed file and compares this result, the file 
> > size and modification time with values stored in RPM database.
> > 
> > This is the workload. Since 2.6.18-rc3-mm2, this processus eats 
> > all the memory and triggers OOM.
> > 
> > On my system, "free -t" output normally looks like this ("cached" value 
> > is about half of RAM):
> > # free -t 
> >              total       used       free     shared    buffers     cached
> > Mem:        515032     508512       6520          0      22992     256032
> > -/+ buffers/cache:     229488     285544
> > Swap:      1116428        324    1116104
> > Total:     1631460     508836    1122624
> > 
> > After the rpm database check, "free -t" says:
> >              total       used       free     shared    buffers     cached
> > Mem:        515032     507124       7908          0       8132     398296
> > -/+ buffers/cache:     100696     414336
> > Swap:      1116428      34896    1081532
> > Total:     1631460     542020    1089440
> > 
> > And the value of "cached" won't decrease.
> > 
> 
> Yes, I was just trying to reproduce this.  No luck so far.  Will try your
> .config tomorrow.
> 
> It would be interesting to try disabling CONFIG_ADAPTIVE_READAHEAD -
> perhaps that got broken.

I get no oom-killer action, but as soon as memory gets tight, I get
something even more effective.  rpm -qaV reliably emits the below.

kernel BUG at mm/vmscan.c:383!
invalid opcode: 0000 [#1]
4K_STACKS PREEMPT SMP 
last sysfs file: /devices/pci0000:00/0000:00:01.0/0000:01:00.0/resource
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event eeprom snd_seq edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 saa7134_dvb mt352 video_buf_dvb nxt200x tda1004x tuner snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer sd_mod saa7134 bt878 i2c_i801 snd_page_alloc prism54 ir_kbd_i2c bttv video_buf ir_common ohci1394 snd_mpu401 snd_mpu401_uart btcx_risc tveeprom ieee1394 snd_rawmidi snd_seq_device snd soundcore
CPU:    1
EIP:    0060:[<c105a166>]    Not tainted VLI
EFLAGS: 00210203   (2.6.18-rc3-mm2-smp #162) 
EIP is at remove_mapping+0xa3/0xbf
eax: 80008009   ebx: c1e48200   ecx: c14ad9c0   edx: c1e48200
esi: c1e48200   edi: c14ad9c0   ebp: dffb7e14   esp: dffb7e08
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 196, ti=dffb7000 task=dffb9a90 task.ti=dffb7000)
Stack: c1e48200 c1e48218 c14ad9c0 dffb7f28 c105a818 dffb7f18 00000000 dffb7f08 
       dffb7f10 c14ad680 c14ad690 dffb7f84 c14ad100 00000020 00000000 00000000 
       00000020 00000000 00000000 c14ad9c0 00000000 00000020 00000000 00000001 
Call Trace:
 [<c105a818>] shrink_inactive_list+0x696/0x8dc
 [<c105aaf0>] shrink_zone+0x92/0xe5
 [<c105b125>] kswapd+0x300/0x40e
 [<c10361d6>] kthread+0xe4/0xe8
 [<c1001005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c1003f83>] show_stack_log_lvl+0xa6/0xcb
 [<c1004180>] show_registers+0x1d8/0x286
 [<c100437f>] die+0x151/0x333
 [<c10045d9>] do_trap+0x78/0xa3
 [<c1004f16>] do_invalid_op+0x97/0xa1
 [<c13e0369>] error_code+0x39/0x40
 [<c105a818>] shrink_inactive_list+0x696/0x8dc
 [<c105aaf0>] shrink_zone+0x92/0xe5
 [<c105b125>] kswapd+0x300/0x40e
 [<c10361d6>] kthread+0xe4/0xe8
 [<c1001005>] kernel_thread_helper+0x5/0xb
Code: f0 e8 46 88 ff ff 89 f8 e8 ba 5d 38 00 f0 ff 4e 04 b8 01 00 00 00 5b 5e 5f 5d c3 89 f8 e8 a5 5d 38 00 31 c0 eb d4 8b 56 0c eb 8d <0f> 0b 7f 01 6f 75 42 c1 89 f6 e9 6b ff ff ff 0f 0b 7e 01 6f 75 
EIP: [<c105a166>] remove_mapping+0xa3/0xbf SS:ESP 0068:dffb7e08
 <0>------------[ cut here ]------------
kernel BUG at mm/vmscan.c:383!
invalid opcode: 0000 [#2]
4K_STACKS PREEMPT SMP 
last sysfs file: /devices/pci0000:00/0000:00:01.0/0000:01:00.0/resource
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event eeprom snd_seq edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 saa7134_dvb mt352 video_buf_dvb nxt200x tda1004x tuner snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer sd_mod saa7134 bt878 i2c_i801 snd_page_alloc prism54 ir_kbd_i2c bttv video_buf ir_common ohci1394 snd_mpu401 snd_mpu401_uart btcx_risc tveeprom ieee1394 snd_rawmidi snd_seq_device snd soundcore
CPU:    0
EIP:    0060:[<c105a166>]    Not tainted VLI
EFLAGS: 00210203   (2.6.18-rc3-mm2-smp #162) 
EIP is at remove_mapping+0xa3/0xbf
eax: 80008009   ebx: c1e784a0   ecx: c14ad9c0   edx: c1e784a0
esi: c1e784a0   edi: c14ad9c0   ebp: dfda3ba0   esp: dfda3b94
ds: 007b   es: 007b   ss: 0068
Process rpm (pid: 6150, ti=dfda3000 task=dffca560 task.ti=dfda3000)
Stack: c1e784a0 c1e784b8 c14ad9c0 dfda3cb4 c105a818 dfda3ca4 00000008 dfda3c94 
       dfda3c9c c14ad680 c14ad690 dfda3cf4 c14ad100 00000020 00000000 00000000 
       00000020 00000000 00000000 c14ad9c0 00000000 00000020 00000000 00000001 
Call Trace:
 [<c105a818>] shrink_inactive_list+0x696/0x8dc
 [<c105aaf0>] shrink_zone+0x92/0xe5
 [<c105b68b>] try_to_free_pages+0x157/0x254
 [<c1055c9b>] __alloc_pages+0x155/0x2b4
 [<c1057595>] __do_page_cache_readahead+0x120/0x2a3
 [<c1057806>] ra_dispatch+0xee/0x100
 [<c1057d83>] page_cache_readahead_adaptive+0x3f4/0xb77
 [<c105349e>] filemap_nopage+0x41d/0x4ad
 [<c105e80d>] __handle_mm_fault+0x12e/0x8fb
 [<c101966a>] do_page_fault+0xdc/0x51f
 [<c13e0369>] error_code+0x39/0x40
 [<b7bc89cf>] 0xb7bc89cf
 [<c1003f83>] show_stack_log_lvl+0xa6/0xcb
 [<c1004180>] show_registers+0x1d8/0x286
 [<c100437f>] die+0x151/0x333
 [<c10045d9>] do_trap+0x78/0xa3
 [<c1004f16>] do_invalid_op+0x97/0xa1
 [<c13e0369>] error_code+0x39/0x40
 [<c105a818>] shrink_inactive_list+0x696/0x8dc
 [<c105aaf0>] shrink_zone+0x92/0xe5
 [<c105b68b>] try_to_free_pages+0x157/0x254
 [<c1055c9b>] __alloc_pages+0x155/0x2b4
 [<c1057595>] __do_page_cache_readahead+0x120/0x2a3
 [<c1057806>] ra_dispatch+0xee/0x100
 [<c1057d83>] page_cache_readahead_adaptive+0x3f4/0xb77
 [<c105349e>] filemap_nopage+0x41d/0x4ad
 [<c105e80d>] __handle_mm_fault+0x12e/0x8fb
 [<c101966a>] do_page_fault+0xdc/0x51f
 [<c13e0369>] error_code+0x39/0x40
Code: f0 e8 46 88 ff ff 89 f8 e8 ba 5d 38 00 f0 ff 4e 04 b8 01 00 00 00 5b 5e 5f 5d c3 89 f8 e8 a5 5d 38 00 31 c0 eb d4 8b 56 0c eb 8d <0f> 0b 7f 01 6f 75 42 c1 89 f6 e9 6b ff ff ff 0f 0b 7e 01 6f 75 
EIP: [<c105a166>] remove_mapping+0xa3/0xbf SS:ESP 0068:dfda3b94
 


