Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUJZUNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUJZUNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUJZUNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:13:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:52612 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261440AbUJZULx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:11:53 -0400
Message-ID: <417EAD2F.7040608@osdl.org>
Date: Tue, 26 Oct 2004 13:01:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <417D7EB9.4090800@osdl.org>	 <20041025155626.11b9f3ab.akpm@osdl.org> <417D88BB.70907@osdl.org>	 <20041025164743.0af550ce.akpm@osdl.org> <417D8DFF.1060104@osdl.org>	 <Pine.GSO.4.58.0410260319100.17615@mion.elka.pw.edu.pl>	 <417DBEC1.5000701@osdl.org> <417E71C1.1080400@osdl.org> <58cb370e041026094016ac67d0@mail.gmail.com>
In-Reply-To: <58cb370e041026094016ac67d0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Tue, 26 Oct 2004 08:48:17 -0700, Randy.Dunlap <rddunlap@osdl.org> wrote:
> 
>>>>>>>Yes, that gets further.   :(
>>>>>>>Maybe I'll just (try) apply the kexec patch to a vanilla kernel.
>>>>
>>>>
>>>>
>>>>IDE PIO changes are the part of a vanilla kernel.
>>>>
>>>>If vanilla kernel (+akpm's fix) works OK then
>>>>this bug is not mine fault. :)
>>>>
>>>>
>>>>
>>>>>>I doubt if it'll help much.  It looks like IDE PIO got badly broken.
>>>>
>>>>
>>>>
>>>>Weird, this code was in -mm for over a month.
>>>>
>>>>
>>>>
>>>>>>That's something we have to fix - could you work with Bart on it
>>>>>>please?
>>>>>
>>>>>
>>>>>Sure.  Bart?
>>>>
>>>>
>>>>
>>>>I need more data, IDE PIO works fine here.
>>>>
>>>>
>>>>
>>>>>>How come your disks are running in PIO mode anyway?
>>>>
>>>>
>>>>
>>>>Maybe disks are runing in DMA mode but some application
>>>>triggers PIO access (IDENTIFY command, S.M.A.R.T. etc.)...
>>>>
>>>>
>>>>
>>>>>No idea.
>>>
>>>
>>>Andrew made me look.  Duh.  It's because I'm booting with
>>>ide=nodma.
>>>
>>>So Bart, can you check the noautodma=1 code path?
>>>And I'll test it again on Tuesday without using ide=nodma.
>>
>>Booting 2.6.9-mm1 without using "ide=nodma" works well for me.
>>No other kernel changes.
> 
> 
> I audited the code and only found the unrelated bug in
> /proc/ide/hd?/smart_thresholds, fix below...
> 
> --- ide-disk.c.orig	2004-10-26 15:50:51.000000000 +0200
> +++ ide-disk.c	2004-10-26 18:34:50.736448416 +0200
> @@ -977,6 +977,7 @@
>  	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
>  	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
>  	args.command_type			= IDE_DRIVE_TASK_IN;
> +	args.data_phase				= TASKFILE_IN;
>  	args.handler				= &task_in_intr;
>  	(void) smart_enable(drive);
>  	return ide_raw_taskfile(drive, &args, buf);
> 
> I tried reproducing the OOPS but I couldn't.  Little bird tells me that
> this bug is SMP and/or highmem specific (I don't have such hardware).
> 
> Randy, could you "ide=nodma" with 2.6.10-rc1 (+akpm's fix) and 2.6.9?

Sure, did that.  2.6.9 works fine, 2.6.10-rc1 dies as with 2.6.9-mm1.
Next?


Unable to handle kernel paging request at virtual address fffea000
  printing eip:
c029f206
*pde = 00610067
*pte = 00000000
Oops: 0002 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c029f206>]    Not tainted VLI
EFLAGS: 00010006   (2.6.10-rc1)
EIP is at ide_insw+0xd/0x13
eax: 000001f0   ebx: c05b322c   ecx: 00000100   edx: 000001f0
esi: c05b322c   edi: fffea000   ebp: c0539e78   esp: c0539e74
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0538000 task=c0452b80)
Stack: c05b3180 c0539e98 c029f6bb 000001f0 fffea000 00000100 c05b322c 
00000080
        fffea000 c0539eb8 c02a302d c05b322c fffea000 00000080 00000000 
00000000
        c05b3180 c0539ee4 c02a3714 c05b322c fffea000 00000080 00000000 
fffea000
Call Tra [<c0107dd3>] show_stack+0xaf/0xb7
  [<c0107f58>] show_registers+0x15d/0x1d2
  [<c0108160>] die+0x106/0x18e
  [<c011a089>] do_page_fault+0x4da/0x669
  [<c0107a31>] error_code+0x2d/0x38
  [<c029f6bb>] ata_input_data+0x98/0xa0
  [<c02a302d>] taskfile_input_data+0x26/0x49
  [<c02a3714>] ide_pio_sector+0xcb/0xe5
  [<c02a3960>] task_in_intr+0xe2/0xfe
  [<c029efe8>] ide_intr+0xb6/0x14f
  [<c013da07>] handle_IRQ_event+0x38/0x69
  [<c013db1a>] __do_IRQ+0xe2/0x158
  [<c01093fa>] do_IRQ+0x36/0x60
  [<c0107914>] common_interrupt+0x18/0x20
  [<c01050c3>] cpu_idle+0x31/0x40
  [<c053a8cf>] start_kernel+0x179/0x195
  [<c0100211>] 0xc0100211
Code: 90 90 90 90 90 55 89 e5 8b 55 08 ec 0f b6 c0 5d c3 55 89 e5 8b 
55 08 66 e
  <0>Kernel panic - not syncing: Fatal exception in interruptce:

-- 
~Randy
