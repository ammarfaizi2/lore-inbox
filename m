Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTJTJHT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTJTJHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:07:14 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36521 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262446AbTJTJHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:07:05 -0400
Date: Mon, 20 Oct 2003 11:07:04 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7-bk7 SCSI USB emulation problem M-Sys DiskOnKey
Message-ID: <20031020090704.GA31204@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other USB mass storage devices work, but when trying to mount my 256Mbyte
M-Sys DiskOnKey under Linux, I get the following:

10:26:13 kernel: hub 1-0:1.0: new USB device on port 1,assigned address 2
10:26:13 kernel: scsi0 : SCSI emulation for USB Mass Storage devices
10:26:13 kernel:   Vendor: M-Sys     Model: DiskOnKey Rev: 4.20
10:26:13 kernel:   Type:   Direct-Access ANSI SCSI revision: 02
10:26:13 kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
10:26:13 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
10:26:13 kernel: WARNING: USB Mass Storage data integrity not assured
10:26:13 kernel: USB Mass Storage device found at 2

20 seconds later, I try to mount it:

10:26:33 kernel: SCSI device sda: 499712 512-byte hdwr sectors (256 MB)
10:26:33 kernel: sda: Write Protect is off
10:26:33 kernel: sda: Mode Sense: 00 46 00 00

Mount is now stuck in D-state, in WCHAN scsi_wait_req.
Stack trace:

10:51:43 kernel: mount         D 97652E52     0 12647  12508                     (NOTLB)
10:51:43 kernel: cf667b9c 00000082 ded806a0 97652e52 00013841 c027c2d3 97652e52 00013841 
10:51:43 kernel:        ded806a0 00000f7d 97652fa7 00013841 dc8ec080 cf666000 cf667c14 cf667bb8 
10:51:43 kernel:        cf667bf0 c011c1c5 00000000 dc8ec080 c011bfa0 00000000 00000000 00000206 
10:51:43 kernel: Call Trace:
10:51:43 kernel:  [as_can_break_anticipation+227/304] as_next_request+0x33/0x40
10:51:43 kernel:  [sleep_on_timeout+101/128] wait_for_completion+0x65/0xa0
10:51:43 kernel:  [wait_for_completion+64/160] default_wake_function+0x0/0x30
10:51:43 kernel:  [wait_for_completion+64/160] default_wake_function+0x0/0x30
10:51:43 kernel:  [scsi_request_sense+202/288] scsi_insert_special_req+0x3a/0x40
10:51:43 kernel:  [scsi_eh_tur+142/208] scsi_wait_req+0x7e/0xa0
10:51:43 kernel:  [scsi_try_to_abort_cmd+16/96] scsi_wait_done+0x0/0x60
10:51:43 kernel:  [scsi_device_unbusy+91/96] __scsi_mode_sense+0xcb/0x1f0
10:51:43 kernel:  [sd_init_command+123/720] sd_read_cache_type+0x11b/0x1c0
10:51:43 kernel:  [proc_ide_read_config+366/368] scsi_allocate_request+0x2e/0x70
10:51:43 kernel:  [sd_init_command+561/720] sd_revalidate_disk+0x111/0x150
10:51:43 kernel:  [nr_blockdev_pages+19/96] check_disk_change+0x73/0x90
10:51:43 kernel:  [append_to_buffer+314/368] sd_open+0x7a/0x110
10:51:43 kernel:  [bd_claim+18/96] do_open+0xe2/0x320
10:51:43 kernel:  [buffered_rmqueue+132/272] buffered_rmqueue+0xa4/0x110
10:51:43 kernel:  [do_open+189/816] blkdev_get+0x7d/0xa0
10:51:43 kernel:  [open_by_devnum+86/112] do_open+0x1b6/0x320
10:51:43 kernel:  [blkdev_direct_IO+112/128] bdev_test+0x0/0x20
10:51:43 kernel:  [blkdev_writepage+16/48] bdev_set+0x0/0x10
10:51:43 kernel:  [do_open+284/816] blkdev_open+0x3c/0x80
10:51:43 kernel:  [sys_fchown+32/96] dentry_open+0x110/0x1a0
10:51:43 kernel:  [chown_common+178/240] filp_open+0x62/0x70
10:51:43 kernel:  [get_unused_fd+107/384] sys_open+0x5b/0x90
10:51:43 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

After three minutes exactly, the following happens:

10:29:33 kernel: SCSI device sda: drive cache: write through
10:29:33 kernel: SCSI device sda: 499712 512-byte hdwr sectors (256 MB)
10:29:33 kernel: sda: Write Protect is off
10:29:33 kernel: sda: Mode Sense: 00 46 00 00

After again three minutes:

10:32:33 kernel: SCSI device sda: drive cache: write through
10:32:33 kernel:  sda: sda1

And things work. If I now umount and mount again, the procedure is swift,
with no 2*3 minute delay. If I perform read operations on the device, they are
performed at USB-1.0 speed, although this is supposed to be a 2.0 device. An
md5sum of a 31 megabyte file takes half a minute.

If I unplug and replug the device and try to mount, it again takes three
minutes.

If I plug in an older device, (USB-1.0), it works flawlessly:

11:00:15 kernel: hub 1-0:1.0: new USB device on port 1, assigned address 4
11:00:15 kernel: scsi2 : SCSI emulation for USB Mass Storage devices
11:00:15 kernel:   Vendor: mini      Model: disk              Rev: 1.11
11:00:15 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
11:00:15 kernel: SCSI device sda: 64512 512-byte hdwr sectors (33 MB)
11:00:15 kernel: sda: test WP failed, assume Write Enabled
11:00:15 kernel: sda: asking for cache data failed
11:00:15 kernel: sda: assuming drive cache: write through
11:00:15 kernel:  sda: sda1
11:00:15 kernel: Attached scsi removable disk sda at scsi2, channel 0, id 0, lun 0
11:00:15 kernel: Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
11:00:15 kernel: WARNING: USB Mass Storage data integrity not assured
11:00:15 kernel: USB Mass Storage device found at 4

Thanks for your help. Anything I can do to help, just let me know!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
