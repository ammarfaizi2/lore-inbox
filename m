Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVJ3Nnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVJ3Nnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 08:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVJ3Nnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 08:43:51 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:26759 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750866AbVJ3Nnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 08:43:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qgYapTocSARaNGn/3jNHvp+6n5JxT+zE2DdV7N5G5Tr7gCJTWyvAsobnj9Om5xEM+fmfFr6ODdds4W4mKYxKE1IJ70ruyONi9QElK+ZG42AC0lfRxsL2oAMkTE+17/sY9Mp0UK1lK4lcx298D7QxYHa1x0zNHoVGHtDvckstFWY=
Message-ID: <4364CE0D.2050600@gmail.com>
Date: Sun, 30 Oct 2005 22:43:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Paul Collins <paul@briny.ondioline.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.14: Oops on suspend after on-the-fly switch to anticipatory
 i/o scheduler - PowerBook5,4
References: <87mzkscjz3.fsf@briny.internal.ondioline.org> <4364372E.2010904@gmail.com>
In-Reply-To: <4364372E.2010904@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, Paul.
> 
> Paul Collins wrote:
> 
>> I boot with elevator=cfq (wanted to try the ionice stuff, never got
>> around to it).  Having decided to go back to the anticipatory
>> scheduler, I did the following:
>>
>> # echo anticipatory > /sys/block/hda/queue/scheduler
>> # echo anticipatory > /sys/block/hdc/queue/scheduler
>>
>> A while later I did 'sudo snooze', which produced the Oops below.
>>
>> Booting with elevator=as and then changing to cfq, sleep works fine.
>> But if I resume and change back to anticipatory I get a similar Oops
>> on the next 'sudo snooze'.
>>
>>
>>   Oops: kernel access of bad area, sig: 11 [#1]
>>   NIP: C01E1948 LR: C01D6A60 SP: EFBC5C20 REGS: efbc5b70 TRAP: 0300    
>> Not tainted
>>   MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>>   DAR: 00000020, DSISR: 40000000
>>   TASK = efb012c0[1213] 'pmud' THREAD: efbc4000
>>   Last syscall: 54   GPR00: 00080000 EFBC5C20 EFB012C0 EFE9E044 
>> EFBC5CE8 00000002 00000000 C03B0000   GPR08: C046E5D8 00000000 
>> C03B47C8 E6A58360 22042422 1001E4DC 10010000 10000000   GPR16: 
>> 10000000 10000000 10000000 7FE4EB40 10000000 10000000 10010000 
>> C0400000   GPR24: C0380000 00000002 00000002 C046E0C0 00000000 
>> 00000002 00000000 EFBC5CE8   NIP [c01e1948] as_insert_request+0xa8/0x6b0
>>   LR [c01d6a60] __elv_add_request+0xa0/0x100
>>   Call trace:
>>    [c01d6a60] __elv_add_request+0xa0/0x100
>>    [c01ffb84] ide_do_drive_cmd+0xb4/0x190
>>    [c01fc1c0] generic_ide_suspend+0x80/0xa0
>>    [c01d4574] suspend_device+0x104/0x160
>>    [c01d47c0] device_suspend+0x120/0x330
>>    [c03f3b50] pmac_suspend_devices+0x50/0x1b0
>>    [c03f4294] pmu_ioctl+0x344/0x9b0
>>    [c0082aa4] do_ioctl+0x84/0x90
>>    [c0082b3c] vfs_ioctl+0x8c/0x460
>>    [c0082f50] sys_ioctl+0x40/0x80
>>    [c0004850] ret_from_syscall+0x0/0x4c
>>
> 
> Can you please post assembly of as_insert_request?  You can get this by 
> doing 'objdump -d drivers/block/as-iosched.o | less' and copy & pasting 
> as_insert_request part.
> 
> I'm also trying to reproduce the oops but haven't succeeded yet.  Does 
> the oops occur only if the disk is loaded while switching scheduler / 
> snoozing or does it happen regardless of disk load?
> 
> And one more thing.  Can you please try the following program and see if 
> it causes the oops?  The program simply writes 3, sleeps one second and 
> then writes 0.  When redirected to the disk's power/state sysfs node, it 
> will make the disk sleep for 1 second and then wake it up.
> 
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main(int argc, char **argv)
> {
>     int level = 3;
>     if (argc > 1)
>         level = atoi(argv[1]);
>     setvbuf(stdout, NULL, _IONBF, 0);
>     printf("%d", level);
>     sleep(1);
>     printf("0");
>     return 0;
> }
> 
> After compiling, do the following.
> 
> ./a.out > /sys/block/hd?/device/power/state
> 
> Thanks. :-)
> 

  Oh.. Never mind.  Jens seems to know how to fix it.  :-)

-- 
tejun
