Return-Path: <linux-kernel-owner+w=401wt.eu-S964932AbXATMqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXATMqg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 07:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932877AbXATMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 07:46:35 -0500
Received: from lucidpixels.com ([66.45.37.187]:38316 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932873AbXATMqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 07:46:34 -0500
Date: Sat, 20 Jan 2007 07:46:33 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org, xfs@oss.sgi.com, Neil Brown <neilb@suse.de>
Subject: Re: Kernel 2.6.19.2 New RAID 5 Bug (oops when writing Samba -> RAID5)
In-Reply-To: <Pine.LNX.4.64.0701200718290.29223@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0701200745420.3756@p34.internal.lan>
References: <Pine.LNX.4.64.0701200718290.29223@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2007, Justin Piszcz wrote:

> My .config is attached, please let me know if any other information is 
> needed and please CC (lkml) as I am not on the list, thanks!
> 
> Running Kernel 2.6.19.2 on a MD RAID5 volume.  Copying files over Samba to 
> the RAID5 running XFS.
> 
> Any idea what happened here?
> 

It happened again under heavy read I/O when I was running md5sum -c on 
some of my files.

[  551.942958] BUG: unable to handle kernel paging request at virtual address fffb97b0
[  551.942970]  printing eip:
[  551.942972] c0358bd8
[  551.942974] *pde = 00003067
[  551.942976] *pte = 00000000
[  551.942980] Oops: 0002 [#1]
[  551.942982] PREEMPT SMP 
[  551.942989] CPU:    0
[  551.942990] EIP:    0060:[<c0358bd8>]    Not tainted VLI
[  551.942991] EFLAGS: 00010286   (2.6.19.2 #1)
[  551.942999] EIP is at copy_data+0x130/0x179
[  551.943001] eax: 00000000   ebx: 00001000   ecx: 00000214   edx: fffb9000
[  551.943005] esi: dd2007b0   edi: fffb97b0   ebp: 00001000   esp: f76ffe1c
[  551.943007] ds: 007b   es: 007b   ss: 0068
[  551.943011] Process md4_raid5 (pid: 1309, ti=f76fe000 task=f7081560 task.ti=f76fe000)
[  551.943013] Stack: c1d880c0 00000003 cd2f0540 00000000 dd200000 0000000e 00000000 000000a8 
[  551.943027]        00001000 cd2f0540 dd1f1adc f6435c48 dd1f1ad8 c035a977 34f3db20 c027be16 
[  551.943043]        c0553328 00000002 00000002 c01146b9 f6435c48 c0553328 f6435c48 dd1f193c 
[  551.943056] Call Trace:
[  551.943059]  [<c035a977>] handle_stripe+0x1ca/0x2986
[  551.943065]  [<c027be16>] __next_cpu+0x22/0x33
[  551.943072]  [<c01146b9>] find_busiest_group+0x124/0x4fd
[  551.943136]  [<c01140af>] __wake_up+0x32/0x43
[  551.943140]  [<c03580e0>] release_stripe+0x21/0x2e
[  551.943145]  [<c035d233>] raid5d+0x100/0x161
[  551.943150]  [<c036b03c>] md_thread+0x40/0x103
[  551.943155]  [<c012dbbe>] autoremove_wake_function+0x0/0x4b
[  551.943160]  [<c036affc>] md_thread+0x0/0x103
[  551.943165]  [<c012da1a>] kthread+0xfc/0x100
[  551.943169]  [<c012d91e>] kthread+0x0/0x100
[  551.943173]  [<c0103b4b>] kernel_thread_helper+0x7/0x1c
[  551.943178]  =======================
[  551.943180] Code: 8b 4c 24 08 8b 41 2c 8b 4c 24 1c 03 54 08 08 8b 44 24 
0c 85 c0 0f 85 3a ff ff ff 89 d9 c1 e9 02 8b 44 24 18 8d 3c 02 03 74 24 10 
<f3> a5 89 d9 83 e1 03 74 02 f3 a4 e9 37 ff ff ff 01 ee 89 74 24 
[  551.943254] EIP: [<c0358bd8>] copy_data+0x130/0x179 SS:ESP 0068:f76ffe1c
[  551.943262]  <6>note: md4_raid5[1309] exited with preempt_count 3

I will run resync/check on this array and then see if that fixes it.

Justin.
