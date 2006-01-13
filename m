Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161497AbWAMIkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161497AbWAMIkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161499AbWAMIkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:40:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18632 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161497AbWAMIke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:40:34 -0500
Date: Fri, 13 Jan 2006 00:38:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: helgehaf@aitel.hist.no, greg@kroah.com, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com
Subject: Re: 2.6.15 OOPS while trying to mount cdrom
Message-Id: <20060113003826.3dfb3bd6.akpm@osdl.org>
In-Reply-To: <200601121818_MC3-1-B5C5-46C7@compuserve.com>
References: <200601121818_MC3-1-B5C5-46C7@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> In-Reply-To: <20060110184624.GA6721@aitel.hist.no>
> 
> On Tue, 10 Jan 2006 Helge Hafting wrote:
> 
> > Kernel 2.6.15 amd64, gcc 4.1.0 from debian.
> >
> > The cdrom (/dev/hda) is usually fine.  I tried booting with
> > hda=ide-scsi in order to read a scratched audio cd with cdparanoia.
> > That way, I at least get error messages when the scratches are
> > too bad.
> > 
> > I forgot about hda=ide-scsi, and tried to mount /dev/hda as
> > usual in order to read an ordinary iso9660 cd.  This is
> > probably not supposed to work when ide-scsi is using the device,
> > but then I expect something like EBUSY rather than this oops:
> > 
> > ide-scsi: unsup command: dev hda: flags = REQ_SORTED REQ_CMD REQ_STARTED 
> > REQ_ELVPRIV 
> > sector 64, nr/cnr 2/2
> > bio ffff8100044a9b40, biotail ffff8100044a9b40, buffer ffff81000cb4d000, data 
> > 0000000000000000, len 0
> > end_request: I/O error, dev hda, sector 64
> > isofs_fill_super: bread failed, dev=hda, iso_blknum=16, block=32
> > Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> > <ffffffff80235a92>{strlen+2}
> 
> 
> The IDE driver probably shouldn't have allowed the bdev to be opened in
> the first place.
> 
> After that happened, mount attempted to fill the superblock and the I/O
> failed.  Upon failure, get_sb_bdev() called deactivate_super()
> (fs/super.c line 718) and all hell broke loose.
> 
>         - deactivate_super() called fs->kill_sb() (super.c line 176) which
>           pointed to kill_block_super() (fs/isofs/inode.c line 1411)
> 
>         - kill_block_super() called kobject_uevent() with action KOBJ_UMOUNT
>           (Question: why is it sending UMOUNT for a mount that never happened?)

Happily, all that code just got deleted:

    Also the new poll() interface to /proc/mounts is a nicer way to
    notify about changes than sending events through the core.
    The uevents should only be used for driver core related requests to
    userspace now.

I dunno how this removal works with forward- and backward- compatible
userspace.   Maybe it doesn't.

>         - kobject_uevent() called kobject_get_path() and one of the objects
>           had a null kobject.name, which caused strlen() to oops.


> There seem to be several bugs here:
> 
> (1) IDE shouldn't have allowed the bdev to be opened.

Maybe.  We've got in trouble in the past with making mounts try to get
exclusive access.  I can't immediately remember what the problem was.

> (2) (maybe) kobject_uevent shouldn't have been called for an unmount event
>     when the mount never succeeded.

Sounds reasonable.

> (3) kobject_get_path() shouldn't oops when a path component has a NULL name,
>     or else kobject should fail registration of any such object.

The printk in kobject_register() will oops if kobj->name is null, so yes,
it seems reasonable to make kobject_register() fail up-front if there's no
->name.   Greg agree?


Helge, it would be good if you could try the same trick on 2.6.15-git9 or
-git10, see if it behaves correctly.
