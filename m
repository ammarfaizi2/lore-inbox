Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751218AbWFEQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWFEQMf (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWFEQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:12:35 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:49104 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751218AbWFEQMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:12:34 -0400
Message-ID: <4484584D.4070108@free.fr>
Date: Mon, 05 Jun 2006 18:14:05 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
        jbeulich@novell.com
Subject: Re: 2.6.17-rc5-mm1
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com> <20060604181002.57ca89df.akpm@osdl.org> <44840838.7030802@free.fr>
In-Reply-To: <44840838.7030802@free.fr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 05.06.2006 12:32, Laurent Riffard a écrit :
> Le 05.06.2006 03:10, Andrew Morton a écrit :
>> On Sun, 4 Jun 2006 20:59:50 -0400
>> Chuck Ebbert <76306.1226@compuserve.com> wrote:
>>
>>> In-Reply-To: <44833955.9000104@free.fr>
>>>
>>> On Sun, 04 Jun 2006 21:49:41 +0200, Laurent Riffard wrote:
>>>
>>>>> Something strange is happening with the stack.  Can you try with 8K stacks?
>>>>>
>>>>> kernel hacking --->
>>>>>    [ ] Use 4Kb for kernel stacks instead of 8Kb
>>>>>
>>>> Good catch!
>>> Jan Beulich was the one who noticed the stack overflow.
>>>
>>>> I just tried with 2.6.17-rc5-mm3. The BUG still happens with 4K stacks,
>>>> but the system runs fine with 8K stacks.
>>> Can you try -mm3 with "check for stack overflows" and 4k stacks?
>> Maybe we could modify the check-for-stack-overflows code with 8k stacks to
>> be "check for overflows which would kill a 4k stack kernel".  By decreasing
>> the thresholds to 3k (say).
>>
>>>> Another info: the system is able to run fine with the following scenario,
>>>> even with 4K stack:
>>>> - boot to runlevel 1
>>>> - load pktcdvd (modprobe + pktsetup)
>>>> - then go to runlevel 5 
>>>> It fails if pktcdvd is loaded at runlevel 2 or higher.
>>> I have no idea why that would happen.
>> I'd be surprised if it has to do with the packet code - more likely someone
>> screwed something up in the lockdep/genirq/unwind area and the kernel went
>> recursive.
>>
>> I tried it here, couldn't reproduce it.  Laurent, can you (re?)send the
>> offending .config?
>  
> .config is attached
> 
> I run a few additional tests:
> 
> - 2.6.17-rc5-mm3 +  CONFIG_DEBUG_STACKOVERFLOW=y,
> CONFIG_DEBUG_STACK_USAGE=y, CONFIG_4KSTACKS=y:
> 
> system freezes right after typing "pktsetup test /dev/dvd". 
> No stack trace printed.
> 
> - Same config as above + lockdep-combo-2.6.17-rc5-mm3.patch +
> lockdep-tracer-2.6.17-rc5-mm3.patch:
> 
> Random Oops (recursive dies) on early boot. I sometimes succeded on 
> booting but the system dies on "pktsetup test /dev/dvd". I can't get a full 
> trace since I don't have my second box here for some days. I tried to boot
> with vga=791, but system hangs with a blank screen.

Here is a bunch of message I got with 2.6.17-rc5-mm3-lockdep with 8K 
stack and CONFIG_DEBUG_STACK_USAGE=y. It happens when I start pktcdvd.

Does it give any hints ?


cdrom: This disc doesn't have any tracks I recognize!
pktcdvd: writer pktcdvd0 mapped to hdc
----------------------------->
| new stack fill maximum: vol_id/2233, 3696 bytes (out of 8136 bytes).
| Stack fill ratio: 45% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{  304} [<c0238c28>] ide_do_drive_cmd+0x11/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3688} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 3720 bytes (out of 8136 bytes).
| Stack fill ratio: 45% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   12} [<c01c6714>] memset+0x9/0x1d
{  316} [<c0238c4a>] ide_do_drive_cmd+0x33/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3712} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 3736 bytes (out of 8136 bytes).
| Stack fill ratio: 45% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   16} [<c01c6696>] memcpy+0xa/0x44
{  328} [<c0238c5c>] ide_do_drive_cmd+0x45/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3728} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 3744 bytes (out of 8136 bytes).
| Stack fill ratio: 46% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   12} [<c01c6714>] memset+0x9/0x1d
{  340} [<c0238c66>] ide_do_drive_cmd+0x4f/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3736} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 3788 bytes (out of 8136 bytes).
| Stack fill ratio: 46% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   64} [<c0133841>] __spin_lock_init+0xd/0x58
{   24} [<c0114207>] init_completion+0x25/0x36
{  308} [<c0238cc0>] ide_do_drive_cmd+0xa9/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3780} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 3816 bytes (out of 8136 bytes).
| Stack fill ratio: 46% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   16} [<c01c6696>] memcpy+0xa/0x44
{   76} [<c0133874>] __spin_lock_init+0x40/0x58
{   24} [<c0114207>] init_completion+0x25/0x36
{  308} [<c0238cc0>] ide_do_drive_cmd+0xa9/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3808} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 3832 bytes (out of 8136 bytes).
| Stack fill ratio: 47% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   20} [<c012e2e3>] lockdep_init_map+0xb/0xb0
{   88} [<c0133880>] __spin_lock_init+0x4c/0x58
{   24} [<c0114207>] init_completion+0x25/0x36
{  308} [<c0238cc0>] ide_do_drive_cmd+0xa9/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=3824} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 4280 bytes (out of 8136 bytes).
| Stack fill ratio: 52% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   36} [<c012f299>] __lockdep_acquire+0xe/0x936
{   40} [<c012fc11>] lockdep_acquire+0x50/0x68
{   36} [<c02a8572>] _spin_lock_irqsave+0x26/0x35
{   20} [<c0120a70>] lock_timer_base+0x1f/0x3a
{   36} [<c0120b0c>] __mod_timer+0x29/0x9c
{   24} [<c0239a24>] __ide_set_handler+0x5c/0x65
{   28} [<c0239c09>] ide_set_handler+0x26/0x3a
{   44} [<e0e579da>] cdrom_transfer_packet_command+0x75/0xcd
{   20} [<e0e57ac6>] cdrom_do_pc_continuation+0x33/0x35
{   44} [<e0e548bb>] cdrom_start_packet_command+0x132/0x13d
{   60} [<e0e55294>] ide_do_rw_cdrom+0x404/0x449
{   96} [<c0238a60>] ide_do_request+0x537/0x6ee
{   16} [<c02391cb>] do_ide_request+0x1e/0x23
{   36} [<c01b64d5>] elv_insert+0x66/0x142
{   32} [<c01b6639>] __elv_add_request+0x88/0x93
{  320} [<c0238d33>] ide_do_drive_cmd+0x11c/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  204} [<e0e559e1>] cdrom_check_status+0x58/0x60
{   88} [<e0e55a57>] ide_cdrom_drive_status+0x2a/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=4272} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

----------------------------->
| new stack fill maximum: vol_id/2233, 4368 bytes (out of 8136 bytes).
| Stack fill ratio: 53% - that's still OK, no need to report this.
------------|
{   20} [<c013ba14>] debug_stackoverflow+0x80/0xae
{   28} [<c013cbb6>] __mcount+0x2a/0x97
{   20} [<c010e434>] mcount+0x14/0x18
{   36} [<c012f299>] __lockdep_acquire+0xe/0x936
{   40} [<c012fc11>] lockdep_acquire+0x50/0x68
{   36} [<c02a8572>] _spin_lock_irqsave+0x26/0x35
{   20} [<c0120a70>] lock_timer_base+0x1f/0x3a
{   36} [<c0120b0c>] __mod_timer+0x29/0x9c
{   24} [<c0239a24>] __ide_set_handler+0x5c/0x65
{   28} [<c0239c09>] ide_set_handler+0x26/0x3a
{   44} [<e0e579da>] cdrom_transfer_packet_command+0x75/0xcd
{   20} [<e0e57ac6>] cdrom_do_pc_continuation+0x33/0x35
{   44} [<e0e548bb>] cdrom_start_packet_command+0x132/0x13d
{   60} [<e0e55294>] ide_do_rw_cdrom+0x404/0x449
{   96} [<c0238a60>] ide_do_request+0x537/0x6ee
{   16} [<c02391cb>] do_ide_request+0x1e/0x23
{   36} [<c01b64d5>] elv_insert+0x66/0x142
{   32} [<c01b6639>] __elv_add_request+0x88/0x93
{  320} [<c0238d33>] ide_do_drive_cmd+0x11c/0x16c
{  100} [<e0e553aa>] cdrom_queue_packet_command+0x45/0xd8
{  200} [<e0e554dc>] ide_cdrom_packet+0x9f/0xb9
{   92} [<e0c8a793>] cdrom_get_media_event+0x3f/0x7c
{   88} [<e0e55a71>] ide_cdrom_drive_status+0x44/0x99
{  376} [<e0c8a84b>] cdrom_open+0x7b/0x7ef
{   32} [<e0e54756>] idecd_open+0x8a/0xbd
{  564} [<c016297c>] do_open+0x2db/0x3d4
{  568} [<c0162ad7>] blkdev_get+0x62/0x6a
{  564} [<e0ecb370>] pkt_open+0x92/0xbe2
{  564} [<c0162747>] do_open+0xa6/0x3d4
{   36} [<c0162c31>] blkdev_open+0x28/0x57
{   28} [<c0159c47>] __dentry_open+0xb8/0x192
{   32} [<c0159d9b>] nameidata_to_filp+0x25/0x3a
{   92} [<c0159de9>] do_filp_open+0x39/0x42
{   44} [<c015add2>] do_sys_open+0x45/0xc0
{   24} [<c015ae80>] sys_open+0x18/0x1a
{=4360} [<c02a87ba>] sysenter_past_esp+0x63/0xa1
<---------------------------

-- 
laurent
