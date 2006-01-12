Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161461AbWALXS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbWALXS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbWALXS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:18:57 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:62898 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161461AbWALXS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:18:56 -0500
Date: Thu, 12 Jan 2006 18:14:55 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.15 OOPS while trying to mount cdrom
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Message-ID: <200601121818_MC3-1-B5C5-46C7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060110184624.GA6721@aitel.hist.no>

On Tue, 10 Jan 2006 Helge Hafting wrote:

> Kernel 2.6.15 amd64, gcc 4.1.0 from debian.
>
> The cdrom (/dev/hda) is usually fine.  I tried booting with
> hda=ide-scsi in order to read a scratched audio cd with cdparanoia.
> That way, I at least get error messages when the scratches are
> too bad.
> 
> I forgot about hda=ide-scsi, and tried to mount /dev/hda as
> usual in order to read an ordinary iso9660 cd.  This is
> probably not supposed to work when ide-scsi is using the device,
> but then I expect something like EBUSY rather than this oops:
> 
> ide-scsi: unsup command: dev hda: flags = REQ_SORTED REQ_CMD REQ_STARTED 
> REQ_ELVPRIV 
> sector 64, nr/cnr 2/2
> bio ffff8100044a9b40, biotail ffff8100044a9b40, buffer ffff81000cb4d000, data 
> 0000000000000000, len 0
> end_request: I/O error, dev hda, sector 64
> isofs_fill_super: bread failed, dev=hda, iso_blknum=16, block=32
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> <ffffffff80235a92>{strlen+2}


The IDE driver probably shouldn't have allowed the bdev to be opened in
the first place.

After that happened, mount attempted to fill the superblock and the I/O
failed.  Upon failure, get_sb_bdev() called deactivate_super()
(fs/super.c line 718) and all hell broke loose.

        - deactivate_super() called fs->kill_sb() (super.c line 176) which
          pointed to kill_block_super() (fs/isofs/inode.c line 1411)

        - kill_block_super() called kobject_uevent() with action KOBJ_UMOUNT
          (Question: why is it sending UMOUNT for a mount that never happened?)

        - kobject_uevent() called kobject_get_path() and one of the objects
          had a null kobject.name, which caused strlen() to oops.

There seem to be several bugs here:

(1) IDE shouldn't have allowed the bdev to be opened.

(2) (maybe) kobject_uevent shouldn't have been called for an unmount event
    when the mount never succeeded.

(3) kobject_get_path() shouldn't oops when a path component has a NULL name,
    or else kobject should fail registration of any such object.


> The pc didn't seem to malfunction after this.

If you attempt to mount the CD a second time, mount will hang in D state; ps(1)
reports it's at text.lock.super.  System cannot be cleanly shut down after that --
shutdown(8) hangs and so does sync(1).


-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
