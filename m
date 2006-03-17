Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbWCQRKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWCQRKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWCQRKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:10:06 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:20674 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932737AbWCQRKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:10:04 -0500
Subject: Re: oops in ext3_discard_reservation()
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060317035127.4c70eed3.akpm@osdl.org>
References: <1142577177.7973.6.camel@homer>
	 <20060317035127.4c70eed3.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 17 Mar 2006 09:09:41 -0800
Message-Id: <1142615381.4545.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 03:51 -0800, Andrew Morton wrote:
> Mike Galbraith <efault@gmx.de> wrote:
> >
> > I just received the oops below.  This kernel is mostly virgin, but does
> >  contain a small bundle of scheduler modifications.  Salt to taste.
> > 
> >  	-Mike
> > 
> >  BUG: unable to handle kernel paging request at virtual address 0001001c
> >   printing eip:
> >  c10ab599
> >  *pde = 00000000
> >  Oops: 0000 [#1]
> >  PREEMPT SMP
> >  last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> >  Modules linked in: ohci1394 prism54 xt_tcpudp xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device edd tda9887 saa7134 snd_intel8x0 snd_ac97_codec ieee1394 snd_ac97_bus bt878 snd_pcm ir_kbd_i2c snd_timer snd soundcore i2c_i801 snd_page_alloc ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip6table_filter ip_conntrack ip_tables ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom sd_mod nls_iso8859_1 nls_cp437 nls_utf8
> >  CPU:    1
> >  EIP:    0060:[<c10ab599>]    Not tainted VLI
> >  EFLAGS: 00210206   (2.6.16-rc6-mm1x-smp #19)
> >  EIP is at ext3_discard_reservation+0x29/0x63
> >  eax: f7e39100   ebx: c1583b50   ecx: 00000000   edx: c10b9ca7
> >  esi: 00010000   edi: 00010018   ebp: dffc2e9c   esp: dffc2e8c
> >  ds: 007b   es: 007b   ss: 0068
> >  Process kswapd0 (pid: 583, threadinfo=dffc2000 task=dffc6030)
> >  Stack: <0>f7e39100 ffffffff c1583ab0 c1583b50 dffc2eb8 c10b9d0b dffc2eb8 00010000
> >         c1583b50 c10b9dc1 dffc2ef8 dffc2ecc c10835e5 dffc2ecc c1583b58 c1583b50
> >         dffc2ee4 c1083669 00000012 00000080 f71817a8 f71817a0 dffc2f0c c1083915
> >  Call Trace:
> >   <c1004073> show_stack_log_lvl+0xa9/0xe3   <c100424d> show_registers+0x1a0/0x236
> >   <c1004561> die+0x12f/0x2ae   <c1019aff> do_page_fault+0x353/0x5fa
> >   <c1003a2b> error_code+0x4f/0x54   <c10b9d0b> ext3_clear_inode+0x64/0xb6
> >   <c10835e5> clear_inode+0xa3/0x103   <c1083669> dispose_list+0x24/0x103
> >   <c1083915> shrink_icache_memory+0x1cd/0x220   <c10533c7> shrink_slab+0x160/0x1f9
> >   <c1054942> balance_pgdat+0x200/0x3be   <c1054bd9> kswapd+0xd9/0x125
> >   <c1001005> kernel_thread_helper+0x5/0xb
> >  Code: 5d c3 55 89 e5 57 56 53 83 ec 04 89 c3 8b 70 b4 8b 80 a8 00 00 00 8b 80 78 01 00 00 05 00 11 00 00 89 45 f0 85 f6 74 0a 8d 7e 18 <8b> 57 04 85 d2 75 08 83 c4 04 5b 5e 5f 5d c3 e8 2e 41 30 00 8b
> 
> It died in rsv_is_empty(), accessing rsv->_rsv_end, because `block_i' has a
> value of 0x00010000.
> 
> Looks like a bitflip.    How good is that hardware?
I am not sure what is happening. Smells like another race between two
reservation window freeing. I thought we have thought this through quite
well last year but maybe not.:(

In general, the reservation window allocating and freeing should be
protected by a semaphore, so that we will not run into the case where we
are trying to free a window, while another thread is in the middle of
window-freed-and-then-re-allocating. But in the path of
ext3_delete_inode()->clear_inode()->ext3_clear_inode()-
>ext3_discard_reservation(), since it's only called at the last input(),
so this race seems not exists. 

But with the path of invalidate_inodes->dispose_list->clear_inode-
>ext3_discard_inode, I guess it is still possible that another thread is
in the middle of block allocation, who just freed the current window and
is about to allocating a new window?

Mingming

