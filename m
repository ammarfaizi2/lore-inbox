Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUFAPMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUFAPMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUFAPMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:12:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:45513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262339AbUFAPKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:10:32 -0400
Date: Tue, 1 Jun 2004 07:59:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Paul Slootman <paul+nospam@wurtel.net>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: floppy oddness in 2.6.7-rc2 [PATCH included]
Message-Id: <20040601075910.6aa42b4b.rddunlap@osdl.org>
In-Reply-To: <20040601142852.GA14985@wurtel.net>
References: <20040601142852.GA14985@wurtel.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 16:28:52 +0200 Paul Slootman wrote:

| When trying to write to a floppy in /dev/fd0 (1.44MB), it gave a
| "No such device or address" error and the kernel logged the message
| "kernel: end_request: I/O error, dev fd1, sector 0".
| 
| Note I accessed /dev/fd0; the kernel reports an error on fd1
| 
| Yes, the /dev/fd0 entry is correct:
| wurtel:/tmp# ls -l /dev/fd[01]
| brw-rw----    1 root     floppy     2,   0 Dec 29  2001 /dev/fd0
| brw-rw----    1 root     floppy     2,   1 Aug  5  2001 /dev/fd1
| 
| When booting, this was (correctly) reported:
| 
| Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
| FDC 0 is a post-1991 82077
| 
| Kernel configured with CONFIG_BLK_DEV_FD=y
| 
| When reading /dev/fd0 with a diskette in /dev/fd1, it gives the contents
| of /dev/fd1, however, it stops after 4096 bytes. Using /dev/fd1 it reads
| the floppy in /dev/fd1 completely.
| 
| Giving the diff a quick glance I see this patch to floppy.c:
| 
| @@ -4247,35 +4225,40 @@
|  int __init floppy_init(void)
|  {
|  	int i, unit, drive;
| -	int err;
| +	int err, dr;
|  
|  	raw_cmd = NULL;
| +	i = 0;
|  
| -	for (i = 0; i < N_DRIVE; i++) {
| -		disks[i] = alloc_disk(1);
| -		if (!disks[i])
| -			goto Enomem;
| -
| -		disks[i]->major = FLOPPY_MAJOR;
| -		disks[i]->first_minor = TOMINOR(i);
| -		disks[i]->fops = &floppy_fops;
| -		sprintf(disks[i]->disk_name, "fd%d", i);
| -
| -		init_timer(&motor_off_timer[i]);
| -		motor_off_timer[i].data = i;
| -		motor_off_timer[i].function = motor_off_callback;
| +	for (dr = 0; dr < N_DRIVE; dr++) {
| +		disks[dr] = alloc_disk(1);
| +		if (!disks[dr]) {
| +			err = -ENOMEM;
| +			goto out_put_disk;
| +		}
| +
| +		disks[dr]->major = FLOPPY_MAJOR;
| +		disks[dr]->first_minor = TOMINOR(i);
| +		disks[dr]->fops = &floppy_fops;
| +		sprintf(disks[dr]->disk_name, "fd%d", dr);
| +
| +		init_timer(&motor_off_timer[dr]);
| +		motor_off_timer[dr].data = dr;
| +		motor_off_timer[dr].function = motor_off_callback;
|  	}
| 
| 
| I expect this line:
| +		disks[dr]->first_minor = TOMINOR(i);
| is the problem. i was changed into dr for some reason, however the
| TOMINOR(i) is not changed to TOMINOR(dr)
| This patch should fix it:
| 
| --- linux/drivers/block/floppy.c.orig	2004-05-30 12:53:21.000000000 +0200
| +++ linux/drivers/block/floppy.c	2004-06-01 16:26:20.000000000 +0200
| @@ -4238,7 +4238,7 @@
|  		}
|  
|  		disks[dr]->major = FLOPPY_MAJOR;
| -		disks[dr]->first_minor = TOMINOR(i);
| +		disks[dr]->first_minor = TOMINOR(dr);
|  		disks[dr]->fops = &floppy_fops;
|  		sprintf(disks[dr]->disk_name, "fd%d", dr);
|  
| I haven't tested it, due to lack of test system at this moment.
| 
| 
| Please CC me on responses, as I read through a mail->news gateway that's
| not always up to date.
| 
| Paul Slootman

I agree.  Andrew, please apply.

Thanks, Paul.

--
~Randy
