Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267640AbUG3HSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267640AbUG3HSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 03:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUG3HSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 03:18:38 -0400
Received: from guardian.hermes.si ([193.77.5.150]:55557 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S267640AbUG3HRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 03:17:38 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF090208@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: "'linux_udf@hpesjro.fc.hp.com'" <linux_udf@hpesjro.fc.hp.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Can not read UDF CD
Date: Fri, 30 Jul 2004 09:16:53 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried your suggestions , but none of them worked :

(60071 was calculated as per your code)
(all failed with mount error(not printed here), the text below is from
dmesg)

mount -r -t udf -o anchor=60071 /dev/cdrom2 /mnt/cdrom2

UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: yes,
vol_desc_start=30622
UDF-fs DEBUG fs/udf/super.c:1552:udf_fill_super: Multi-session=30622
UDF-fs DEBUG fs/udf/super.c:540:udf_vrs: Starting at sector 30638 (2048 byte
sectors)
attempt to access beyond end of device
hdd: rw=0, want=362776, limit=240288
UDF-fs DEBUG fs/udf/misc.c:225:udf_read_tagged: block=90693, location=60071:
read failed
UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block
30878, tag 30878 != 256
UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)

----

mount -r -t udf -o lastblock=60071 /dev/cdrom2 /mnt/cdrom2

UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: yes,
vol_desc_start=30622
UDF-fs DEBUG fs/udf/super.c:1552:udf_fill_super: Multi-session=30622
UDF-fs DEBUG fs/udf/super.c:540:udf_vrs: Starting at sector 30638 (2048 byte
sectors)
hdd: command error: status=0x51 { DriveReady SeekComplete Error }
hdd: command error: error=0x54
end_request: I/O error, dev hdd, sector 240284
UDF-fs DEBUG fs/udf/super.c:684:udf_find_anchor: Anchor found at block
60069, location mismatch 60069.
UDF-fs DEBUG fs/udf/super.c:684:udf_find_anchor: Anchor found at block
59921, location mismatch 59921.
UDF-fs DEBUG fs/udf/super.c:684:udf_find_anchor: Anchor found at block
59919, location mismatch 59919.
UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block
30878, tag 30878 != 256
UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)

---

With your patch from mail :

mount -r -t udf /dev/cdrom2 /mnt/cdrom2

attempt to access beyond end of device
hdd: rw=0, want=240292, limit=240288
UDF-fs: No partition found (1)

> ----------
> From: 	Pat LaVarre[SMTP:p.lavarre@ieee.org]
> Sent: 	29. julij 2004 16:44
> To: 	David Balazic
> Cc: 	'linux_udf@hpesjro.fc.hp.com'; 'linux-kernel@vger.kernel.org'
> Subject: 	Re: Can not read UDF CD
> 
> David B:
> 
> /// In short,
> 
> I suggest quickly trying the mount -o lastblock= and anchor= udf.ko
> options described at:
> 
> http://lxr.linux.no/source/Documentation/filesystems/udf.txt?v=2.6.5
> 
> else working thru til able to try the phgfsck described at my page:
> 
> http://udfko.blog-city.com/read/577369.htm
> 
> If you do post the phgfsck report on the web, I'll gladly link to it.
> 
> /// At length, in Seven parts ...
> 
> /// 1) Similarly
> 
> > UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block
> 30878, tag 30878 != 256
> > UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor block
> found
> > UDF-fs: No partition found (1)
> 
> In the merely private archives of linux_udf, just this week we see me
> suffering thru something highly similar, specifically:
> 
> kernel: UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch
> block 256, tag 0 != 256
> kernel: UDF-fs DEBUG fs/udf/super.c:1342:udf_load_partition: No Anchor
> block found
> kernel: UDF-fs: No partition found (1)
> 
> Note, since 2.6.7, by default these messages will grow more cryptic, we
> will see only:
> 
> kernel: UDF-fs: No partition found (1)
> 
> > > > UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch
> block 30878, tag 30878 != 256
> > > UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch
> block 256, tag 0 != 256
> 
> I'm guessing these messages mean the try to mount halted over garbage
> found at LBA x100 (256), but Ben wrote this code, not me.
> 
> /// 2) Where
> 
> What kind of cable do you use, what is your device name, what is your
> mount point?
> 
> Til I know, I will cover both USB and PATAPI and pretend you want to
> mount /dev/scd0 at /mnt/scd0.
> 
> /// 3) -o lastblock="$n"
> 
> Up in user land, my workaround was:
> 
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
> sudo mount -r -o lastblock="$n" /dev/scd0 /mnt/scd0
> 
> /// 4) patch -p1 ...
> 
> To recover the feature:
> 
> sudo mount -r /dev/scd0 /mnt/scd0
> 
> for such unfriendly discs, I web-published the patch quoted below to the
> patches-udf.lastblock package of http://iomrrdtools.sourceforge.net/
> 
> /// 5) -o anchor=...
> 
> If -o lastblock="$n" doesn't work for you, then one more blind try is -o
> anchor="$n" i.e.
> 
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
> sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0
> 
> Please note -o anchor is arguably reckless except when combined with -r.
> 
> /// 6) phgfsck
> 
> If neither blind try works for you, then to make sense of the disc you
> can try phgfsck.  For example, here, I see:
> 
> $ sudo phgfsck -scsi /dev/sg0 | grep 'AVDPs at'
>         Number of AVDPs: 2, AVDPs at  N-256,  N
> $
> 
> Seeing "AVDP ... at ... N" tells me to try what I mentioned above:
> 
> n="`dc -e \"\`sudo blockdev --getsize /dev/scd0\` 512 * 2048 / 1 - p\"`"
> sudo mount -r -o anchor="$n" /dev/scd0 /mnt/scd0
> 
> /// 7) reconfiguring Linux to permit phgfsck
> 
> http://www.extra.research.philips.com/udf/
> is the Philips page that offers the phgfsck, aka the "Philips UDF
> Verifier".
> 
> My clarification of that page is:
> 
> http://udfko.blog-city.com/read/577369.htm
> 
> Philips deserves nothing but kudos for donating the phgfsck to improve
> UDF interoperability worldwide ... except the fact remains they haven't
> chosen to release their copyright under a license approved as open
> source by such authorities as sourceforge.net.
> 
> Consequently, the phgfsck can be unusually hard to use in Linux. 
> Specifically, it does Not incorporate any of the better SCSI pass thru
> libraries.  Privately, as yet I've heard from Two employees of different
> corporations who privately requested and privately were denied
> permission to donate code into the phgfsck, because its source is partly
> closed.
> 
> First, as yet with the phgfsck, you have to substitute an sg name for
> the regular dev name, even when running 2.6.
> 
> To discover your sg name, you can try each of /dev/sg* to see what
> happens, or you can download yet another tool, such as sg_scan -i or my
> own plscsi -w, found at http://members.aol.com/plscsi/linux/
> 
> In theory `phgfsck -showscsi` will give you device names, but for me
> that query doesn't work reliably.  Trying here just now in
> 2.6.8-rc2-bk7, it hangs.  In the past, I've seen it miss names.
> 
> Often you need root privilege to discover the sg name.
> 
> You will probably have an sg name to find only if your kernel has a
> drivers/scsi/sg.ko and your device name was among the /dev/scd*
> 
> Else you might have to get into substituting ide-scsi.ko for ide-cd.ko,
> especially if your device name was among the /dev/hd*.  linux-scsi
> speaks occasionally of the issues such substitutions raise.
> 
> Pat LaVarre
> http://iomrrdtools.sourceforge.net/
> http://udfko.blog-city.com/
> 
> --- From:
> http://sourceforge.net/project/showfiles.php?group_id=101444&package_id=12
> 5426
> 
> See also: Readme.txt
> ... Copyright (c) 2004 Iomega Corp
> ... free software ...
> ... GNU General Public License as ... either ... or ...
> ...
> 
> diff -urp linux-2.6.8-rc2-bk7/fs/udf/lowlevel.c
> linux-2.6.8-rc2-bk7-pel/fs/udf/lowlevel.c
> --- linux-2.6.8-rc2-bk7/fs/udf/lowlevel.c	2004-06-15
> 23:19:36.000000000 -0600
> +++ linux-2.6.8-rc2-bk7-pel/fs/udf/lowlevel.c	2004-07-28
> 14:46:02.373806296 -0600
> @@ -73,9 +73,9 @@ udf_get_last_block(struct super_block *s
>  	struct block_device *bdev = sb->s_bdev;
>  	unsigned long lblock = 0;
>  
> -	if (ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long)
> &lblock))
> -		lblock = bdev->bd_inode->i_size >> sb->s_blocksize_bits;
> -
> +	if (!ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long)
> &lblock))
> +		return lblock;
> +	lblock = bdev->bd_inode->i_size >> sb->s_blocksize_bits;
>  	if (lblock)
>  		return lblock - 1;
>  	else
> diff -urp linux-2.6.8-rc2-bk7/fs/udf/super.c
> linux-2.6.8-rc2-bk7-pel/fs/udf/super.c
> --- linux-2.6.8-rc2-bk7/fs/udf/super.c	2004-07-28
> 10:36:35.928051888 -0600
> +++ linux-2.6.8-rc2-bk7-pel/fs/udf/super.c	2004-07-28
> 14:45:45.356393336 -0600
> @@ -1562,6 +1562,9 @@ static int udf_fill_super(struct super_b
>   		goto error_out;
>  	}
>  
> +	if (!UDF_SB_LASTBLOCK(sb)) {
> +		UDF_SB_LASTBLOCK(sb) = udf_get_last_block(sb);
> +	}
>  	udf_find_anchor(sb);
>  
>  	/* Fill in the rest of the superblock */
> 
> 
