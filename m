Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSKKWHz>; Mon, 11 Nov 2002 17:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSKKWHz>; Mon, 11 Nov 2002 17:07:55 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:10764 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S261541AbSKKWHw>; Mon, 11 Nov 2002 17:07:52 -0500
Date: Mon, 11 Nov 2002 23:18:39 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: buffer layer error at fs/buffer.c:399
In-Reply-To: <3DCEFF7A.F7534A72@digeo.com>
Message-ID: <Pine.LNX.4.44.0211110244020.1451-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Andrew Morton wrote:

> > buffer layer error at fs/buffer.c:399
> > Pass this trace through ksymoops for reporting
> > Call Trace:
> >  [<c0151db6>] __find_get_block_slow+0xe6/0x150
> >  [<c0152ec6>] __find_get_block+0xd6/0xf0
> >  [<c0153277>] unmap_underlying_metadata+0x17/0x50
> 
> This means that we had pagecache floating about which has buffers,
> but those buffers had unexpected block numbers.  Possibly something
> went wrong during an earlier invalidation of the device during the
> mount process.  Do you remember if a fsck happened during that bootup?

Very likely, yes. AFAICT from the syslog the first occurence was about 4 
hours after reboot. During the reboot there was a journal recovery for all 
ext3-fs (all except rootfs are ext3). The initscripts force fsck when ext2
appears unclean so I'm pretty sure there was an automatic fsck. But 
unfortunately I don't recall for sure whether it detected and fixed any 
inconsistency. It completed without manual interaction and the forced fsck 
after the fs/buffer.c:399 message didn't show anything.

> Is there anything unusual about your setup?  Using initrd?  Is the

No initrd. Nothing unusual IMHO. I wouldn't call the 1k blocksize unusual 
since it was silently done by some distribution installer quite some time 
ago and didn't  cause any harm so far. The box had 2.5.45 running for 
about a week and I've never seen the buffer layer error message before -
but there were more than a few unclean shutdowns due to sysfs/usb issues.

> rootfs backed by a normal old disk?

It's /dev/hda1 on a 40GB IDE disk - no indication of any IDE problem.

> Could I please see a `dumpe2fs -h' of that device?

see below.

> Please, run with this patch and see if if happens again, thanks.

Despite a few intentional unclean reboots it didn't reappear until now.
I'll keep the patch applied and will report if it does. However, chances 
are it won't: After the initial appearance I could retrigger it a few 
times when writing larger files. But suddenly it didn't appear anymore. 
Maybe it was a singular event, hardly to reproduce.

Thanks,
Martin

-----------------

dumpe2fs 1.25 (20-Sep-2001)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          a0dd0fc0-fe31-11d5-9437-e3df28bee53c
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              128016
Block count:              512032
Reserved block count:     25601
Free blocks:              172670
Free inodes:              99826
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2032
Inode blocks per group:   254
Last mount time:          Mon Nov 11 19:35:39 2002
Last write time:          Mon Nov 11 19:41:44 2002
Mount count:              1
Maximum mount count:      33
Last checked:             Mon Nov 11 19:35:38 2002
Check interval:           15552000 (6 months)
Next check after:         Sat May 10 20:35:38 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128

