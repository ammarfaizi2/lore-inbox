Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUJKPSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUJKPSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUJKPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:16:34 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:52384 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S269079AbUJKPM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:12:57 -0400
Date: Mon, 11 Oct 2004 17:12:49 +0200
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [BUG] 2.6.9-rc2 scsi and elevator oops when I/O error
Message-ID: <20041011151249.GA4940@larroy.com>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20041011050320.GA28703@larroy.com> <416A3FF2.3000206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416A3FF2.3000206@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 11, 2004 at 06:10:26PM +1000, Nick Piggin wrote:
> Pedro Larroy wrote:
> >I've been observing this bug in other kernel versions and other hardware
> >configurations, so I think it's easily reproductible.
> >
> >Happens when I/O error on external ide <-> usb drives. Can be reproduced
> >by unplugging the usb cable while accessing the drive, or with a faulty
> >drive.
> >
> >I don't think my real u2w scsi controllers would like the real scsi disks
> >being hot swapped, so I haven't tried there.
> >
> >Regards.
> >
> 
> Thanks. It looks like it may possibly not be an elevator specific
> oops. Can you try booting with elevator=deadline and see if you can
> reproduce the oops please?
> 
> [snip]
> 
> >SCSI error : <0 0 0 0> return code = 0x70000
> >end_request: I/O error, dev sda, sector 10889005
> >usb 4-1: USB disconnect, address 2
> >SCSI error : <0 0 0 0> return code = 0x70000
> >end_request: I/O error, dev sda, sector 10889006
> >scsi: Device offlined - not ready after error recovery: host 0 channel 0 
> >id 0 lun 0
> >sd 0:0:0:0: Illegal state transition cancel->offline
> >Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
> > [<c023a230>] scsi_device_set_state+0xbc/0x10a
> > [<c0238605>] scsi_eh_offline_sdevs+0x5a/0x73
> > [<c02389f4>] scsi_unjam_host+0xa7/0xa9
> > [<c0238a8e>] scsi_error_handler+0x98/0xb7
> > [<c02389f6>] scsi_error_handler+0x0/0xb7
> > [<c0104249>] kernel_thread_helper+0x5/0xb
> >SCSI error : <0 0 0 0> return code = 0x70000
> >end_request: I/O error, dev sda, sector 10889007
> >printk: 157 messages suppressed.
> >Buffer I/O error on device sda1, logical block 10888944
> >lost page write due to I/O error on sda1
> >------------[ cut here ]------------
> >kernel BUG at drivers/block/as-iosched.c:1853!
> >invalid operand: 0000 [#1]
> >Modules linked in: hostap usbnet nfs nls_iso8859_1 nls_cp437 vfat fat nfsd 
> >exportfs lockd sunrpc parport_pc lp parport cls_fw sch_sfq sch_htb 
> >ipt_REJECT ipt_state iptable_filter iptable_nat ipt_helper ip_conntrack 
> >ipt_tos ipt_MARK iptable_mangle ip_tables ide_cd cdrom
> >CPU:    0
> >EIP:    0060:[<c02176f0>]    Not tainted VLI
> >EFLAGS: 00010283   (2.6.9-rc2) 
> >EIP is at as_exit+0x44/0x58
> >eax: dedab58c   ebx: dedab580   ecx: db995aa0   edx: db963ebc
> >esi: ded301b4   edi: 00000286   ebp: dec174b4   esp: db963ef4
> >ds: 007b   es: 007b   ss: 0068
> >Process scsi_eh_0 (pid: 1550, threadinfo=db962000 task=db995aa0)
> >Stack: ded30128 c020fc40 c021179b db911824 db911800 c023ba5b db9119a8 
> >c03963a8 c03963c0 dec174d8 c020c371 c0116abe 00000000 c0380a80 
> >       c1627d00 c019af91 db9119c0 c019af93 00000000 db911800 c019b263 
> >       00000000 c030eabc 00000000 Call Trace:
> > [<c020fc40>] elevator_exit+0xd/0xf
> > [<c021179b>] blk_cleanup_queue+0x31/0x78
> > [<c023ba5b>] scsi_device_dev_release+0xc6/0xd5
> > [<c020c371>] device_release+0x53/0x57
> > [<c0116abe>] recalc_task_prio+0x8f/0x183
> > [<c019af91>] kobject_cleanup+0x8c/0x8e
> > [<c019af93>] kobject_release+0x0/0x8
> > [<c019b263>] kref_put+0x34/0x8d
> > [<c030eabc>] __up_wakeup+0x8/0xc
> > [<c0235a3e>] scsi_done+0x0/0x16
> > [<c0235e63>] __scsi_iterate_devices+0x47/0x51
> > [<c023821f>] scsi_eh_stu+0x80/0xd8
> > [<c023887c>] scsi_eh_ready_devs+0x19/0x6e
> > [<c02389f4>] scsi_unjam_host+0xa7/0xa9
> > [<c0238a8e>] scsi_error_handler+0x98/0xb7
> > [<c02389f6>] scsi_error_handler+0x0/0xb7
> > [<c0104249>] kernel_thread_helper+0x5/0xb
> >Code: 8d 43 0c 39 43 0c 75 23 8b 43 70 e8 fa ab f1 ff 8b 83 cc 00 00 00 e8 
> >ae ba ff ff 8b 43 30 e8 51 f9 f1 ff 89 d8 5b e9 49 f9 f1 ff <0f> 0b 3d 07 
> >f8 9b 33 c0 eb d3 0f 0b 3c 07 f8 9b 33 c0 eb c1 55 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


It happens more of the same. This time I reproduced by just unplugging
the cable while writting.

Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 

Las patentes de programación son nocivas para la innovación
	http://proinnova.hispalinux.es/

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.deadline.txt"

 code = 0x70000
end_request: I/O error, dev sda, sector 10556008
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556009
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556010
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556011
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556012
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556013
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556014
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556015
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556016
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556017
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556018
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556019
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556020
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556021
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556022
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556023
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556024
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556025
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556026
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556027
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556028
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556029
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556030
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556031
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556032
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556033
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556034
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556035
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556036
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556037
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556038
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556039
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556040
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556041
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556042
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556043
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556044
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556045
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556046
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556047
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556048
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556049
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556050
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556051
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556052
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556053
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556054
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556055
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556056
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556057
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556058
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556059
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556060
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556061
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556062
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556063
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556064
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556065
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556066
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556067
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556068
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556069
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556070
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556071
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556072
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556073
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556074
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556075
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556076
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556077
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556078
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556079
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556080
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556081
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556082
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556083
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556084
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556085
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556086
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556087
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556088
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556089
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556090
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556091
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556092
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556093
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556094
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556095
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556096
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556097
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556098
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556099
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556100
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556101
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556102
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556103
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556104
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556105
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556106
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556107
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556108
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556109
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556110
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556111
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556112
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556113
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556114
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556115
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556116
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556117
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556118
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556119
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556120
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556121
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556122
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556123
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556124
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556125
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556126
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556127
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556128
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556129
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556130
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556131
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556132
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556133
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556134
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556135
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556136
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556137
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556138
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556139
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556140
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556141
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556142
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556143
usb 4-1: USB disconnect, address 2
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556144
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
sd 0:0:0:0: Illegal state transition cancel->offline
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1688
 [<c023a230>] scsi_device_set_state+0xbc/0x10a
 [<c0238605>] scsi_eh_offline_sdevs+0x5a/0x73
 [<c02389f4>] scsi_unjam_host+0xa7/0xa9
 [<c0238a8e>] scsi_error_handler+0x98/0xb7
 [<c02389f6>] scsi_error_handler+0x0/0xb7
 [<c0104249>] kernel_thread_helper+0x5/0xb
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 10556145
printk: 172 messages suppressed.
Buffer I/O error on device sda1, logical block 10556082
lost page write due to I/O error on sda1
------------[ cut here ]------------
kernel BUG at drivers/block/deadline-iosched.c:694!
invalid operand: 0000 [#1]
Modules linked in: nfs nls_iso8859_1 nls_cp437 vfat fat nfsd exportfs lockd sunrpc parport_pc lp parport cls_fw sch_sfq sch_htb ipt_REJECT ipt_state iptable_filter iptable_nat ipt_helper ip_conntrack ipt_tos ipt_MARK iptable_mangle ip_tables ide_cd cdrom
CPU:    0
EIP:    0060:[<c02183d9>]    Not tainted VLI
EFLAGS: 00010293   (2.6.9-rc2) 
EIP is at deadline_exit+0x36/0x40
eax: dedd4408   ebx: dedd4400   ecx: c02183a3   edx: ded30844
esi: ded308c4   edi: 00000286   ebp: deedecb4   esp: c16cfef4
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 730, threadinfo=c16ce000 task=ded8b560)
Stack: ded30838 c020fc40 c021179b dedd5c24 dedd5c00 c023ba5b dedd5da8 c03963a8 
       c03963c0 deedecd8 c020c371 c0116abe 00000000 c0380a80 dd620800 c019af91 
       dedd5dc0 c019af93 00000000 dedd5c00 c019b263 00000000 c030eabc 00000000 
Call Trace:
 [<c020fc40>] elevator_exit+0xd/0xf
 [<c021179b>] blk_cleanup_queue+0x31/0x78
 [<c023ba5b>] scsi_device_dev_release+0xc6/0xd5
 [<c020c371>] device_release+0x53/0x57
 [<c0116abe>] recalc_task_prio+0x8f/0x183
 [<c019af91>] kobject_cleanup+0x8c/0x8e
 [<c019af93>] kobject_release+0x0/0x8
 [<c019b263>] kref_put+0x34/0x8d
 [<c030eabc>] __up_wakeup+0x8/0xc
 [<c0235a3e>] scsi_done+0x0/0x16
 [<c0235e63>] __scsi_iterate_devices+0x47/0x51
 [<c023821f>] scsi_eh_stu+0x80/0xd8
 [<c023887c>] scsi_eh_ready_devs+0x19/0x6e
 [<c02389f4>] scsi_unjam_host+0xa7/0xa9
 [<c0238a8e>] scsi_error_handler+0x98/0xb7
 [<c02389f6>] scsi_error_handler+0x0/0xb7
 [<c0104249>] kernel_thread_helper+0x5/0xb
Code: 2a 8d 43 10 39 43 10 75 18 8b 43 48 e8 10 9f f1 ff 8b 43 24 e8 72 ec f1 ff 89 d8 5b e9 6a ec f1 ff 0f 0b b7 02 a0 13 35 c0 eb de <0f> 0b b6 02 a0 13 35 c0 eb cc 55 89 d5 57 56 89 c6 53 83 ec 04 
 

--wRRV7LY7NUeQGEoC--
