Return-Path: <linux-kernel-owner+w=401wt.eu-S932256AbWLLRHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWLLRHl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWLLRHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:07:41 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:50451 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932256AbWLLRHk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:07:40 -0500
Date: Tue, 12 Dec 2006 19:07:34 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
Message-ID: <20061212170734.GA3333@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061205172512.GA5518@m.safari.iki.fi> <20061205223945.8c81ea91.akpm@osdl.org> <20061206094138.GA15365@m.safari.iki.fi> <20061212104601.GA21258@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20061212104601.GA21258@m.safari.iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 12:46:01 +0200, Sami Farin wrote:
> On Wed, Dec 06, 2006 at 11:41:38 +0200, Sami Farin wrote:
> > On Tue, Dec 05, 2006 at 22:39:45 -0800, Andrew Morton wrote:
> > > On Tue, 5 Dec 2006 19:25:13 +0200
> > > Sami Farin <7atbggg02@sneakemail.com> wrote:
> > > 
> > > > [1.] PROBLEM: 2.6.19 + highmem = BUG at do_wp_page 
> > > 
> > > Can you send the .config please?
> > 
> > I happened to modify configuration a bit,
> > CONFIG_HIGHMEM4G to CONFIG_HIGHMEM64G
> > and added CONFIG_X86_MCE_P4THERMAL=y.
> > Otherwise this should be pretty close.
> > I haven't tried to boot with CONFIG_HIGHMEM64G yet.
> 
> CONFIG_HIGHMEM64G=y doesn't work, either, in case someone cares.
> 
> With mem=896M highmem-enabled kernels work OK.

Maxime Austruy suggested that I try kmap_atomic-debugging.patch
from 2.6.19-mm1 or just 2.6.19-mm1, but no thanks, after reading
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/README

I got these with 2.6.19.1 + CONFIG_HIGHMEM64G + debugging.patch...
fortuna-random updates one block in add_timer_randomness,
and crypto seems to like to use kmap_atomic and seems
like I have to add some magic into fortuna (like, adding
my own aes256 and sha256 functions, hacking a flag into crypto API
so that it uses kmap instead of kmap_atomic, or what...?). 

2006-12-12 17:32:32.090741500 <6>hdf: cache flushes supported
2006-12-12 17:32:32.090743500 <6> hdf:BUG: warning at arch/i386/mm/highmem.c:41/kmap_atomic()
2006-12-12 17:32:32.090745500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
2006-12-12 17:32:32.090746500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
2006-12-12 17:32:32.090747500 <4> [<c0103dcb>] show_trace+0x12/0x14
2006-12-12 17:32:32.090749500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
2006-12-12 17:32:32.090750500 <4> [<c01173e0>] kmap_atomic+0x1e4/0x20e
2006-12-12 17:32:32.090754500 <4> [<c028a459>] update+0x87/0x158
2006-12-12 17:32:32.090757500 <4> [<c028a30d>] crypto_digest_update+0x4a/0x5c
2006-12-12 17:32:32.090758500 <4> [<c03154ff>] add_entropy_words+0xdb/0x12b
2006-12-12 17:32:32.090768500 <4> [<c031586a>] add_timer_randomness+0x91/0x113
2006-12-12 17:32:32.090769500 <4> [<c0315c84>] add_disk_randomness+0xf8/0xfd
2006-12-12 17:32:32.090771500 <4> [<c035ef46>] __ide_end_request+0x66/0xe2
2006-12-12 17:32:32.090772500 <4> [<c035f000>] ide_end_request+0x3e/0x5c
2006-12-12 17:32:32.090773500 <4> [<c0366d40>] ide_dma_intr+0x7a/0xba
2006-12-12 17:32:32.090774500 <4> [<c0360b11>] ide_intr+0xac/0x13f
2006-12-12 17:32:32.090775500 <4> [<c014b0e9>] handle_IRQ_event+0x2f/0x5d
2006-12-12 17:32:32.090780500 <4> [<c014c16f>] handle_fasteoi_irq+0x74/0xc0
2006-12-12 17:32:32.090782500 <4> [<c0105818>] do_IRQ+0x70/0xdc
2006-12-12 17:32:32.090783500 <4> [<c01037fa>] common_interrupt+0x1a/0x20
2006-12-12 17:32:32.090784500 <4> [<c0100f03>] mwait_idle_with_hints+0x41/0x50
2006-12-12 17:32:32.090785500 <4> [<c0100f21>] mwait_idle+0xf/0x1f
2006-12-12 17:32:32.090786500 <4> [<c0100dcb>] cpu_idle+0x8c/0x8e
2006-12-12 17:32:32.090788500 <4> [<c0100387>] _stext+0x23/0x25
2006-12-12 17:32:32.090792500 <4> [<c06858e4>] start_kernel+0x19d/0x1e8
2006-12-12 17:32:32.090793500 <4> =======================

Then it seemed to work OK, till I ran "memset 1000" which allocates
1000<<20 bytes of memory and then does memset() for it.
This shouldn't be caused by my crypto stuff?

2006-12-12 17:40:22.880176500 <1>BUG: unable to handle kernel paging request at virtual address fffb9e40
2006-12-12 17:40:22.880192500 <1> printing eip:
2006-12-12 17:40:22.880193500 <4>c015117f
2006-12-12 17:40:22.880194500 <1>*pde = 00000000
2006-12-12 17:40:22.880195500 <0>Oops: 0002 [#1]
2006-12-12 17:40:22.880196500 <0>SMP 
2006-12-12 17:40:22.880197500 <4>Modules linked in: xt_CLASSIFY ipt_ECN xt_CONNMARK ipt_connlimit ipt_TARPIT xt_length ipt_set xt_multiport ip_set_iphash ip_set_nethash ip_set_portmap ipt_REJECT ip6t_LOG xt_limit ipt_LOG ipt_hashlimit ip6table_mangle iptable_mangle iptable_nat ip_nat tcp_highspeed tcp_htcp tcp_hybla tcp_scalable ipt_owner tcp_vegas tcp_westwood ip_set xt_state sch_netem sch_hfsc sch_htb sch_sfq cls_fw cls_u32 cls_route sch_ingress sch_red sch_tbf ip_conntrack sch_teql sch_prio sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark ip6table_filter intelfb i2c_algo_bit ip6_tables i810 iptable_filter ip_tables lp parport_pc parport usb_storage i2c_dev eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm ohci1394 snd_timer snd ieee1394 soundcore e1000 pcspkr ehci_hcd iTCO_wdt snd_page_alloc i2c_i801 i2c_cor
2006-12-12 17:40:22.880248500 e uhci_hcd
2006-12-12 17:40:22.880249500 <0>CPU:    0
2006-12-12 17:40:22.880250500 <0>EIP:    0060:[<c015117f>]    Not tainted VLI
2006-12-12 17:40:22.880251500 <0>EFLAGS: 00010296   (2.6.19.1-highmem #7)
2006-12-12 17:40:22.880253500 <0>EIP is at prep_new_page+0xb5/0x106
2006-12-12 17:40:22.880254500 <0>eax: 00000000   ebx: c17c00a0   ecx: 00000070   edx: 80000000
2006-12-12 17:40:22.880255500 <0>esi: 00000000   edi: fffb9e40   ebp: e9347e3c   esp: e9347e14
2006-12-12 17:40:22.880257500 <0>ds: 007b   es: 007b   ss: 0068
2006-12-12 17:40:22.880262500 <0>Process memset (pid: 3164, ti=e9346000 task=f5f10550 task.ti=e9346000)
2006-12-12 17:40:22.880276500 <0>Stack: fffb9000 00000006 00000001 00000000 000280d2 00000000 c17c00a0 00000001 
2006-12-12 17:40:22.880278500 <0>       00000246 c0564c00 e9347e68 c01516ad c0564c8c 00000002 c0564c80 00000000 
2006-12-12 17:40:22.880279500 <0>       c17c00a0 00000000 c0564c00 c05652a0 00000044 e9347e98 c0151886 000280d2 
2006-12-12 17:40:22.880281500 <0>Call Trace:
2006-12-12 17:40:22.880286500 <0> [<c01516ad>] buffered_rmqueue+0x93/0x134
2006-12-12 17:40:22.880287500 <0> [<c0151886>] get_page_from_freelist+0xa2/0xb9
2006-12-12 17:40:22.880289500 <0> [<c01518eb>] __alloc_pages+0x4e/0x2b0
2006-12-12 17:40:22.880290500 <0> [<c015af19>] do_anonymous_page+0x4b/0x1e6
2006-12-12 17:40:22.880291500 <0> [<c015b6b4>] __handle_mm_fault+0x125/0x2eb
2006-12-12 17:40:22.880292500 <0> [<c0115e4d>] do_page_fault+0x18f/0x692
2006-12-12 17:40:22.880343500 <0> [<c04b2f09>] error_code+0x39/0x40
2006-12-12 17:40:22.880345500 <0> [<08048736>] 0x8048736
2006-12-12 17:40:22.880346500 <0> =======================
2006-12-12 17:40:22.880347500 <0>Code: e4 00 00 00 00 d3 e0 83 f8 00 7e 3d 31 f6 89 45 e0 89 fb ba 03 00 00 00 89 d8 e8 89 60 fc ff b9 00 04 00 00 89 45 d8 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 45 d8 e8 7c 62 fc ff 83 45 e4 01 83 c3 
2006-12-12 17:40:22.880360500 <0>EIP: [<c015117f>] prep_new_page+0xb5/0x106 SS:ESP 0068:e9347e14
2006-12-12 17:40:22.880367500 <4> <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
2006-12-12 17:40:22.880368500 <4>in_atomic():1, irqs_disabled():1
2006-12-12 17:40:22.880369500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
2006-12-12 17:40:22.880371500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
2006-12-12 17:40:22.880372500 <4> [<c0103dcb>] show_trace+0x12/0x14
2006-12-12 17:40:22.880373500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
2006-12-12 17:40:22.880379500 <4> [<c011fb13>] __might_sleep+0xa3/0xab
2006-12-12 17:40:22.880394500 <4> [<c0138d35>] down_read+0x15/0x29
2006-12-12 17:40:22.880405500 <4> [<c012f917>] blocking_notifier_call_chain+0x1c/0x42
2006-12-12 17:40:22.880482500 <4> [<c0123711>] profile_task_exit+0x11/0x13
2006-12-12 17:40:22.880559500 <4> [<c0124ff2>] do_exit+0x1c/0x43b
2006-12-12 17:40:22.880634500 <4> [<c01043da>] do_trap+0x0/0xbd
2006-12-12 17:40:22.880712500 <4> [<c0116018>] do_page_fault+0x35a/0x692
2006-12-12 17:40:22.880840500 <4> [<c04b2f09>] error_code+0x39/0x40
2006-12-12 17:40:22.880921500 <4> [<c015117f>] prep_new_page+0xb5/0x106
2006-12-12 17:40:22.880949500 <4> [<c01516ad>] buffered_rmqueue+0x93/0x134
2006-12-12 17:40:22.881080500 <4> [<c0151886>] get_page_from_freelist+0xa2/0xb9
2006-12-12 17:40:22.881110500 <4> [<c01518eb>] __alloc_pages+0x4e/0x2b0
2006-12-12 17:40:22.881239500 <4> [<c015af19>] do_anonymous_page+0x4b/0x1e6
2006-12-12 17:40:22.881269500 <4> [<c015b6b4>] __handle_mm_fault+0x125/0x2eb
2006-12-12 17:40:22.881349500 <4> [<c0115e4d>] do_page_fault+0x18f/0x692
2006-12-12 17:40:22.881426500 <4> [<c04b2f09>] error_code+0x39/0x40
2006-12-12 17:40:22.881505500 <4> [<08048736>] 0x8048736
2006-12-12 17:40:22.881551500 <4> =======================
2006-12-12 17:40:22.881653500 <6>note: memset[3164] exited with preempt_count 1

Other things worth noting, maybe: I use loop-aes-v3.1e for encrypted swap.

-- 
