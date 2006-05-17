Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWEQIyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWEQIyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEQIyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:54:39 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:34502
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750706AbWEQIyj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:54:39 -0400
Message-Id: <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
In-Reply-To: Your message of "Wed, 17 May 2006 10:13:14 +0200."
             <20060517081314.GA20415@suse.de>
From: Valdis.Kletnieks@vt.edu
References: <20060517081314.GA20415@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147856025_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 04:53:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147856025_4166P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 May 2006 10:13:14 +0200, Olaf Hering said:
> 
> The on-disk data structures from AIX are not known, also the filesystem
> layout is not known. There is a msdos partition signature at the end of
> the first block, and the kernel recognizes 3 small (and overlapping) partitions.
> But they are not usable. Maybe the firmware uses it to find the bootloader
> for AIX, but AIX boots also if the first block is cleared.
>
> Handle the whole disk as empty disk.
> This fixes also YaST who compares the output from parted (and formerly fdisk)
> with /proc/partitions. fdisk recognizes the AIX label since a long time,
> SuSE has a patch for parted to handle the disk label as unknown.

One has to wonder if it might not be better to treat this case as
"one partition covering the entire disk", or even better, decode the AIX LVM
info and see if there's any LVM segments present on the disk, so as to limit
the chances of accidentally splatting live data.

The first 64K of the disk (a 'Physical Volume' in AIX LVM jargon) is
a Volume Group Descriptor Area (VGDA) described in <sys/bootrecord.h>

"The VGDA consists of

    * BOOTRECORD: - first 512 bytes. Allows the Read Only System (ROS) to boot system
    * BAD BLK DIRECTORY - found in <sys/bddir.h>
    * LVM RECORD - found in <lvmrec.h>"

(from http://www.ahinc.com/aix/logicalvol.htm)

I'd attach the .h files in question (we have AIX boxes here still), but they
have IBM copyrights on them. Best either play "Chinese Wall" or have somebody
in IBM OK the use of the .h files...

--==_Exmh_1147856025_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEauSZcC3lWbTT17ARAjWlAJwNXSXyi5rFHHGgpwbMMie+92Kb6wCg1xCV
kyAjzojANmCXieg6p8weZoU=
=ofVF
-----END PGP SIGNATURE-----

--==_Exmh_1147856025_4166P--
