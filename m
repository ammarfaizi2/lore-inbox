Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUHQL5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUHQL5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUHQL5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:57:48 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:13436 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263972AbUHQL5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:57:43 -0400
Message-ID: <4121F2AC.7000907@yahoo.com.au>
Date: Tue, 17 Aug 2004 21:57:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408170044.37750.gene.heskett@verizon.net> <41219076.6090602@yahoo.com.au> <200408170126.40816.gene.heskett@verizon.net>
In-Reply-To: <200408170126.40816.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Tuesday 17 August 2004 00:58, Nick Piggin wrote:
> 
>>Gene Heskett wrote:

>>>Reboot time I guess :(((
>>
>>All your low memory has been used by dentry and inode caches. This
>>isn't very
>>interesting because this would be no doubt caused by something
>>oopsing while holding the shrinker semaphore as Andrew pointed out.
>>
>>What is interesting is that first Oops message (I wonder if you
>>don't have bad hardware though, I don't think anyone else is seeing
>>it).
> 
> 
> What 'first Oops message'?  One I posted before?
> 

Well, the first Oops that your running kernel raises. Usually you
don't bother about subsequent oopses and misbehaviour because the
first one can cause the system to go into a funny state - this is
a prime example.

> That comment caused me to go back in the log to well above where I had
> been channel surfing with tvtime, and I did find an Oops:
> 
> Aug 16 21:15:46 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Aug 16 21:15:46 coyote kernel:  printing eip:
> Aug 16 21:15:46 coyote kernel: c015c8db
> Aug 16 21:15:46 coyote kernel: *pde = 00000000
> Aug 16 21:15:46 coyote kernel: Oops: 0002 [#1]
> Aug 16 21:15:46 coyote kernel: Modules linked in: tuner tvaudio bttv video_buf btcx_risc eeprom snd_seq_oss snd_seq
> _midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_allo
> c snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
> Aug 16 21:15:46 coyote kernel: CPU:    0
> Aug 16 21:15:46 coyote kernel: EIP:    0060:[<c015c8db>]    Not tainted
> Aug 16 21:15:46 coyote kernel: EFLAGS: 00210206   (2.6.8-rc4)
> Aug 16 21:15:46 coyote kernel: EIP is at prune_icache+0x6b/0x1b0
> Aug 16 21:15:46 coyote kernel: eax: 00000000   ebx: dffe0fd0   ecx: d3eb8b80   edx: c0341660
> Aug 16 21:15:46 coyote kernel: esi: dffe0fc8   edi: 0000005a   ebp: d3eb8b94   esp: d3eb8b74
> Aug 16 21:15:46 coyote kernel: ds: 007b   es: 007b   ss: 0068
> Aug 16 21:15:46 coyote kernel: Process yum (pid: 30892, threadinfo=d3eb8000 task=cf6bf7b0)
> Aug 16 21:15:46 coyote kernel: Stack: dffe0448 00000000 00000059 dffe0450 df58d0d0 00000080 00000000 d3eb8000
> Aug 16 21:15:46 coyote kernel:        d3eb8ba0 c015ca5f 00000080 d3eb8bd4 c0135b14 00000080 000000d2 0108bf00
> Aug 16 21:15:46 coyote kernel:        00000000 00021087 00000080 00000000 f7ffea20 0000000a d3eb8c50 00000000
> Aug 16 21:15:46 coyote kernel: Call Trace:
> Aug 16 21:15:46 coyote kernel:  [<c01044ef>] show_stack+0x7f/0xa0
> Aug 16 21:15:46 coyote kernel:  [<c0104688>] show_registers+0x158/0x1b0
> Aug 16 21:15:46 coyote kernel:  [<c01047e6>] die+0x66/0xd0
> Aug 16 21:15:46 coyote kernel:  [<c01109de>] do_page_fault+0x28e/0x548
> Aug 16 21:15:46 coyote kernel:  [<c010415d>] error_code+0x2d/0x38
> Aug 16 21:15:46 coyote kernel:  [<c015ca5f>] shrink_icache_memory+0x3f/0x50
> Aug 16 21:15:46 coyote kernel:  [<c0135b14>] shrink_slab+0x134/0x170
> Aug 16 21:15:46 coyote kernel:  [<c0136954>] try_to_free_pages+0xa4/0x160
> Aug 16 21:15:46 coyote kernel:  [<c012fc23>] __alloc_pages+0x1b3/0x320
> Aug 16 21:15:46 coyote kernel:  [<c0139a8f>] do_anonymous_page+0x5f/0x180
> Aug 16 21:15:46 coyote kernel:  [<c0139c11>] do_no_page+0x61/0x310
> Aug 16 21:15:46 coyote kernel:  [<c013a097>] handle_mm_fault+0xd7/0x160
> Aug 16 21:15:46 coyote kernel:  [<c01108a0>] do_page_fault+0x150/0x548
> Aug 16 21:15:46 coyote kernel:  [<c010415d>] error_code+0x2d/0x38
> Aug 16 21:15:46 coyote kernel:  [<c012c279>] do_generic_mapping_read+0x129/0x430
> Aug 16 21:15:46 coyote kernel:  [<c012c836>] __generic_file_aio_read+0x1b6/0x1f0
> Aug 16 21:15:46 coyote kernel:  [<c012c8c2>] generic_file_aio_read+0x52/0x70
> Aug 16 21:15:46 coyote kernel:  [<c0145898>] do_sync_read+0x78/0xa0
> Aug 16 21:15:46 coyote kernel:  [<c014598a>] vfs_read+0xca/0x140
> Aug 16 21:15:46 coyote kernel:  [<c0145c2b>] sys_read+0x4b/0x80
> Aug 16 21:15:46 coyote kernel:  [<c0103f61>] sysenter_past_esp+0x52/0x71
> Aug 16 21:15:46 coyote kernel: Code: 89 10 a1 60 16 34 c0 89 58 04 89 03 c7 43 04 60 16 34 c0 89
> 
> yum did a segfault about that time. yum is nice code, when
> it fscking works, which is maybe half the time on 2 different
> FC2 machines here now.
> 

Although an Oops is always the kernel's (or bad hardware's) fault.
So in this case you can let yum off the hook :)

> So we're back to the dentry_cache thing...  Duh, NO!, this is in
> prune_icache, not prune_dcache, presumably slightly different.  
> 

Yeah, both are going to cause cache shrinking to stop working.

> As far as bad hardware is concerned, warranty time is running out.
> I need something  plausible to take back to tcwo as a good reason
> for requesting a 'blanket rma' on the whole thing, would they 
> please send me another.
> 

Not too sure really. At this stage keep trying patches that you get
sent :P
