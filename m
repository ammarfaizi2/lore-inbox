Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUCYWr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUCYWq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:46:59 -0500
Received: from expms3.cites.uiuc.edu ([128.174.5.207]:11065 "EHLO
	expms3.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S263640AbUCYWoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:44:18 -0500
Date: Thu, 25 Mar 2004 16:44:17 -0600
From: Shawn Lindberg <slindber@uiuc.edu>
Subject: Re: [Problem]: "access beyond end" of DVD-R
To: linux-kernel@vger.kernel.org
X-Mailer: Webmail Mirapoint Direct 3.3.7-GR
MIME-Version: 1.0
Message-Id: <61db4321.26d1c342.8185f00@expms3.cites.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Mar 24 2004, Shawn Lindberg wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Mon, Mar 22 2004, slindber@uiuc.edu wrote:
>>>
>>>
>>>>attempt to access beyond end of device
>>>>hdc: rw=0, want=8174536, limit=8123200
>>>>Buffer I/O error on device hdc, logical block 2043633
>>>>
>>>>There are more attempt to "access beyond end of device" messages, but
>>>>they are similar so I've snipped them.
>>>
>>>Does this make a difference for you (2.6 patch)?
>>
>>I made that one line change to my 2.6.3 kernel from gentoo and it
>>fixed the problem for both the ISO/UDF and UDF discs (I couldn't try
>>the ISO only disc since I don't have it anymore).  I also tried a few
>>CDs to get a rough check for whether it introduced new errors, but
>>they were fine also.  Please let me know if I should do any further
>>testing, and THANKS!
> 
> 
> If you could do one more test to see how they differ that would be
> great. Attaching a patch for that, apply that instead of the other one
> (or just manually paste the added printk in there).
> 
> ===== drivers/ide/ide-cd.c 1.75 vs edited =====
> --- 1.75/drivers/ide/ide-cd.c	Tue Mar 16 09:39:41 2004
> +++ edited/drivers/ide/ide-cd.c	Thu Mar 25 07:55:14 2004
> @@ -2372,7 +2372,8 @@
>  
>  	/* Now try to get the total cdrom capacity. */
>  	stat = cdrom_get_last_written(cdi, &last_written);
> -	if (!stat && last_written) {
> +	if (!stat && (last_written > toc->capacity)) {
> +		printk("old cap %lu, new cap %lu\n", toc->capacity, last_written);
>  		toc->capacity = last_written;
>  		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
>  	}
> 

First I made the above patch.  I saw no change in the output (there was no instance of the new printk in the output - but reading the disc worked).  Then I made this patch:

--- /usr/src/linux/drivers/ide/ide-cd.c.pre-patch	2004-03-24 08:32:50.000000000 -0600
+++ /usr/src/linux/drivers/ide/ide-cd.c	2004-03-25 16:30:37.000000000 -0600
@@ -2420,6 +2420,7 @@
 	/* Now try to get the total cdrom capacity. */
 	stat = cdrom_get_last_written(cdi, &last_written);
 	if (!stat && last_written) {
+		printk("cdrom: old cap %lu, new cap %lu\n", toc->capacity, last_written);
 		toc->capacity = last_written;
 		set_capacity(drive->disk, toc->capacity * sectors_per_frame);
 	}

and I got this as output:

cdrom: old cap 2227408, new cap 2030800
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG fs/udf/super.c:1550:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:538:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG fs/udf/super.c:565:udf_vrs: ISO9660 Primary Volume Descriptor found
UDF-fs DEBUG fs/udf/super.c:568:udf_vrs: ISO9660 Supplementary Volume Descriptor found
UDF-fs DEBUG fs/udf/super.c:574:udf_vrs: ISO9660 Volume Descriptor Set Terminator found
UDF-fs DEBUG fs/udf/super.c:881:udf_load_pvoldesc: recording time 1078289507/0, 2004/03/02 22:51 (1e98)
UDF-fs DEBUG fs/udf/super.c:892:udf_load_pvoldesc: volIdent[] = 'NARUTO (01-25)'
UDF-fs DEBUG fs/udf/super.c:899:udf_load_pvoldesc: volSetIdent[] = '40451003'
UDF-fs DEBUG fs/udf/super.c:1091:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
UDF-fs DEBUG fs/udf/super.c:1101:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=0
UDF-fs DEBUG fs/udf/super.c:929:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG fs/udf/super.c:1011:udf_load_partdesc: Partition (0:0 type 1511) starts at physical 257, block length 2226881
UDF-fs DEBUG fs/udf/super.c:1344:udf_load_partition: Using anchor in block 256
UDF-fs DEBUG fs/udf/super.c:1577:udf_fill_super: Lastblock=0
UDF-fs DEBUG fs/udf/super.c:853:udf_find_fileset: Fileset at block=0, partition=0
UDF-fs DEBUG fs/udf/super.c:915:udf_load_fileset: Rootdir at block=7, partition=0
UDF-fs INFO UDF 0.9.7 (2002/11/15) Mounting volume 'NARUTO (01-25)', timestamp 2004/03/02 22:51 (1e98)
attempt to access beyond end of device
hdc: rw=0, want=8174536, limit=8123200
Buffer I/O error on device hdc, logical block 2043633

with tons more attempt to access beyond end of device messages (and of course reading didn't work).  The moral of the story is that the block inside the if statement is resetting the capacity to something smaller, which is causing my problem.

I hope this helps, and let me know if you'd like me to try anything else.

Shawn Lindberg
