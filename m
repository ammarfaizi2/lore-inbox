Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUJKIgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUJKIgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUJKIgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 04:36:52 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:24681 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268710AbUJKIgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 04:36:44 -0400
Message-ID: <416A3FF2.3000206@yahoo.com.au>
Date: Mon, 11 Oct 2004 18:10:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Pedro Larroy <piotr@larroy.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [BUG] 2.6.9-rc2 scsi and elevator oops when I/O error
References: <20041011050320.GA28703@larroy.com>
In-Reply-To: <20041011050320.GA28703@larroy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy wrote:
> I've been observing this bug in other kernel versions and other hardware
> configurations, so I think it's easily reproductible.
> 
> Happens when I/O error on external ide <-> usb drives. Can be reproduced
> by unplugging the usb cable while accessing the drive, or with a faulty
> drive.
> 
> I don't think my real u2w scsi controllers would like the real scsi disks
> being hot swapped, so I haven't tried there.
> 
> Regards.
> 

Thanks. It looks like it may possibly not be an elevator specific
oops. Can you try booting with elevator=deadline and see if you can
reproduce the oops please?

[snip]

> SCSI error : <0 0 0 0> return code = 0x70000
> end_request: I/O error, dev sda, sector 10889005
> usb 4-1: USB disconnect, address 2
> SCSI error : <0 0 0 0> return code = 0x70000
> end_request: I/O error, dev sda, sector 10889006
> scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
> sd 0:0:0:0: Illegal state transition cancel->offline
> Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
>  [<c023a230>] scsi_device_set_state+0xbc/0x10a
>  [<c0238605>] scsi_eh_offline_sdevs+0x5a/0x73
>  [<c02389f4>] scsi_unjam_host+0xa7/0xa9
>  [<c0238a8e>] scsi_error_handler+0x98/0xb7
>  [<c02389f6>] scsi_error_handler+0x0/0xb7
>  [<c0104249>] kernel_thread_helper+0x5/0xb
> SCSI error : <0 0 0 0> return code = 0x70000
> end_request: I/O error, dev sda, sector 10889007
> printk: 157 messages suppressed.
> Buffer I/O error on device sda1, logical block 10888944
> lost page write due to I/O error on sda1
> ------------[ cut here ]------------
> kernel BUG at drivers/block/as-iosched.c:1853!
> invalid operand: 0000 [#1]
> Modules linked in: hostap usbnet nfs nls_iso8859_1 nls_cp437 vfat fat nfsd exportfs lockd sunrpc parport_pc lp parport cls_fw sch_sfq sch_htb ipt_REJECT ipt_state iptable_filter iptable_nat ipt_helper ip_conntrack ipt_tos ipt_MARK iptable_mangle ip_tables ide_cd cdrom
> CPU:    0
> EIP:    0060:[<c02176f0>]    Not tainted VLI
> EFLAGS: 00010283   (2.6.9-rc2) 
> EIP is at as_exit+0x44/0x58
> eax: dedab58c   ebx: dedab580   ecx: db995aa0   edx: db963ebc
> esi: ded301b4   edi: 00000286   ebp: dec174b4   esp: db963ef4
> ds: 007b   es: 007b   ss: 0068
> Process scsi_eh_0 (pid: 1550, threadinfo=db962000 task=db995aa0)
> Stack: ded30128 c020fc40 c021179b db911824 db911800 c023ba5b db9119a8 c03963a8 
>        c03963c0 dec174d8 c020c371 c0116abe 00000000 c0380a80 c1627d00 c019af91 
>        db9119c0 c019af93 00000000 db911800 c019b263 00000000 c030eabc 00000000 
> Call Trace:
>  [<c020fc40>] elevator_exit+0xd/0xf
>  [<c021179b>] blk_cleanup_queue+0x31/0x78
>  [<c023ba5b>] scsi_device_dev_release+0xc6/0xd5
>  [<c020c371>] device_release+0x53/0x57
>  [<c0116abe>] recalc_task_prio+0x8f/0x183
>  [<c019af91>] kobject_cleanup+0x8c/0x8e
>  [<c019af93>] kobject_release+0x0/0x8
>  [<c019b263>] kref_put+0x34/0x8d
>  [<c030eabc>] __up_wakeup+0x8/0xc
>  [<c0235a3e>] scsi_done+0x0/0x16
>  [<c0235e63>] __scsi_iterate_devices+0x47/0x51
>  [<c023821f>] scsi_eh_stu+0x80/0xd8
>  [<c023887c>] scsi_eh_ready_devs+0x19/0x6e
>  [<c02389f4>] scsi_unjam_host+0xa7/0xa9
>  [<c0238a8e>] scsi_error_handler+0x98/0xb7
>  [<c02389f6>] scsi_error_handler+0x0/0xb7
>  [<c0104249>] kernel_thread_helper+0x5/0xb
> Code: 8d 43 0c 39 43 0c 75 23 8b 43 70 e8 fa ab f1 ff 8b 83 cc 00 00 00 e8 ae ba ff ff 8b 43 30 e8 51 f9 f1 ff 89 d8 5b e9 49 f9 f1 ff <0f> 0b 3d 07 f8 9b 33 c0 eb d3 0f 0b 3c 07 f8 9b 33 c0 eb c1 55 
>  

