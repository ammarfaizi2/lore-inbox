Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUHQF0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUHQF0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268119AbUHQF0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:26:49 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:41688 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S268118AbUHQF0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:26:42 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Tue, 17 Aug 2004 01:26:40 -0400
User-Agent: KMail/1.6.82
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408170044.37750.gene.heskett@verizon.net> <41219076.6090602@yahoo.com.au>
In-Reply-To: <41219076.6090602@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408170126.40816.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.55.227] at Tue, 17 Aug 2004 00:26:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 00:58, Nick Piggin wrote:
>Gene Heskett wrote:
>>On Monday 16 August 2004 19:01, viro@parcelfarce.linux.theplanet.co.uk wrote:
>>>On Mon, Aug 16, 2004 at 06:52:50PM -0400, Gene Heskett wrote:
>>>>Well, I am seing some dups, but they are so volatile that no two
>>>>runs will report the same allocations as dups, and its never more
>>>>than 2 using /proc/fs/ext3 | sort | uniq -c | sort -nr |grep -v '
>>>>1 '
>>>>
>>>>Consecutive runs will show anywhere from 3 to 10 or 12 dups, but
>>>>never is an address repeated between runs.
>>>>
>>>>How is this to be interpreted?
>>>
>>>That's OK.  Keep in mind that you have a *lot* of these guys and
>>>your cat(1) makes a lot of read(2) calls.  So what you see is
>>>
>>><starting to read>
>>><see inode #n that is about to be evicted>
>>><read some more>
>>><inode #n gets evicted, quite possibly - due to memory pressure
>>> from cat(1) or sort(1)>
>>><read more>
>>><somebody wants the same inode again>
>>><read more>
>>><see the inode #n we'd just had read from disk again>
>>>
>>>So few duplicates are all right.
>>
>>I hope so.  I've got a real hoodoozy here, being out of memory
>> (well, maybe 30 megs left) when my nightly run of rsync started,
>> everything came to a grinding halt.  I couldn't even get to the
>> screen the tail -f on the log was running in, but after walking
>> away for 10 minutes. I can once again.  However, things seem to be
>> partially functional so I'm going to see if I can do some
>> cut-n-paste from the log screen to here, but I probably can't send
>> it as sendmail was one of the items the OOM killer killed. 
>> According to top, I'm about 250 megs into the swap, very suddenly.
>>  No swap was in use at 23:55 local.
>
>snip
>
>>I cannot start any new shells, as before.  Is there any usable dna
>> in this sample?
>>
>>Reboot time I guess :(((
>
>All your low memory has been used by dentry and inode caches. This
> isn't very
>interesting because this would be no doubt caused by something
> oopsing while holding the shrinker semaphore as Andrew pointed out.
>
>What is interesting is that first Oops message (I wonder if you
> don't have bad hardware though, I don't think anyone else is seeing
> it).

What 'first Oops message'?  One I posted before?

That comment caused me to go back in the log to well above where I had
been channel surfing with tvtime, and I did find an Oops:

Aug 16 21:15:46 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 16 21:15:46 coyote kernel:  printing eip:
Aug 16 21:15:46 coyote kernel: c015c8db
Aug 16 21:15:46 coyote kernel: *pde = 00000000
Aug 16 21:15:46 coyote kernel: Oops: 0002 [#1]
Aug 16 21:15:46 coyote kernel: Modules linked in: tuner tvaudio bttv video_buf btcx_risc eeprom snd_seq_oss snd_seq
_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_allo
c snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
Aug 16 21:15:46 coyote kernel: CPU:    0
Aug 16 21:15:46 coyote kernel: EIP:    0060:[<c015c8db>]    Not tainted
Aug 16 21:15:46 coyote kernel: EFLAGS: 00210206   (2.6.8-rc4)
Aug 16 21:15:46 coyote kernel: EIP is at prune_icache+0x6b/0x1b0
Aug 16 21:15:46 coyote kernel: eax: 00000000   ebx: dffe0fd0   ecx: d3eb8b80   edx: c0341660
Aug 16 21:15:46 coyote kernel: esi: dffe0fc8   edi: 0000005a   ebp: d3eb8b94   esp: d3eb8b74
Aug 16 21:15:46 coyote kernel: ds: 007b   es: 007b   ss: 0068
Aug 16 21:15:46 coyote kernel: Process yum (pid: 30892, threadinfo=d3eb8000 task=cf6bf7b0)
Aug 16 21:15:46 coyote kernel: Stack: dffe0448 00000000 00000059 dffe0450 df58d0d0 00000080 00000000 d3eb8000
Aug 16 21:15:46 coyote kernel:        d3eb8ba0 c015ca5f 00000080 d3eb8bd4 c0135b14 00000080 000000d2 0108bf00
Aug 16 21:15:46 coyote kernel:        00000000 00021087 00000080 00000000 f7ffea20 0000000a d3eb8c50 00000000
Aug 16 21:15:46 coyote kernel: Call Trace:
Aug 16 21:15:46 coyote kernel:  [<c01044ef>] show_stack+0x7f/0xa0
Aug 16 21:15:46 coyote kernel:  [<c0104688>] show_registers+0x158/0x1b0
Aug 16 21:15:46 coyote kernel:  [<c01047e6>] die+0x66/0xd0
Aug 16 21:15:46 coyote kernel:  [<c01109de>] do_page_fault+0x28e/0x548
Aug 16 21:15:46 coyote kernel:  [<c010415d>] error_code+0x2d/0x38
Aug 16 21:15:46 coyote kernel:  [<c015ca5f>] shrink_icache_memory+0x3f/0x50
Aug 16 21:15:46 coyote kernel:  [<c0135b14>] shrink_slab+0x134/0x170
Aug 16 21:15:46 coyote kernel:  [<c0136954>] try_to_free_pages+0xa4/0x160
Aug 16 21:15:46 coyote kernel:  [<c012fc23>] __alloc_pages+0x1b3/0x320
Aug 16 21:15:46 coyote kernel:  [<c0139a8f>] do_anonymous_page+0x5f/0x180
Aug 16 21:15:46 coyote kernel:  [<c0139c11>] do_no_page+0x61/0x310
Aug 16 21:15:46 coyote kernel:  [<c013a097>] handle_mm_fault+0xd7/0x160
Aug 16 21:15:46 coyote kernel:  [<c01108a0>] do_page_fault+0x150/0x548
Aug 16 21:15:46 coyote kernel:  [<c010415d>] error_code+0x2d/0x38
Aug 16 21:15:46 coyote kernel:  [<c012c279>] do_generic_mapping_read+0x129/0x430
Aug 16 21:15:46 coyote kernel:  [<c012c836>] __generic_file_aio_read+0x1b6/0x1f0
Aug 16 21:15:46 coyote kernel:  [<c012c8c2>] generic_file_aio_read+0x52/0x70
Aug 16 21:15:46 coyote kernel:  [<c0145898>] do_sync_read+0x78/0xa0
Aug 16 21:15:46 coyote kernel:  [<c014598a>] vfs_read+0xca/0x140
Aug 16 21:15:46 coyote kernel:  [<c0145c2b>] sys_read+0x4b/0x80
Aug 16 21:15:46 coyote kernel:  [<c0103f61>] sysenter_past_esp+0x52/0x71
Aug 16 21:15:46 coyote kernel: Code: 89 10 a1 60 16 34 c0 89 58 04 89 03 c7 43 04 60 16 34 c0 89

yum did a segfault about that time. yum is nice code, when
it fscking works, which is maybe half the time on 2 different
FC2 machines here now.

So we're back to the dentry_cache thing...  Duh, NO!, this is in
prune_icache, not prune_dcache, presumably slightly different.  

As far as bad hardware is concerned, warranty time is running out.
I need something  plausible to take back to tcwo as a good reason
for requesting a 'blanket rma' on the whole thing, would they 
please send me another.

Preferably an AMD Athlon 2800XP that wasn't stepping 00.

Or are the bug lists constant across these processors?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
