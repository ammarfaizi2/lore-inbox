Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWITSrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWITSrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWITSrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:47:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932202AbWITSrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:47:35 -0400
Date: Wed, 20 Sep 2006 11:47:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060920114719.15909483.akpm@osdl.org>
In-Reply-To: <20060920132011.GA4612@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060920132011.GA4612@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 15:20:11 +0200
Olaf Hering <olh@suse.de> wrote:

> On Thu, Jun 01, Olaf Hering wrote:
> 
> > ...
> > Error -3 while decompressing!
> > c0000000009592a2(2649)->c0000000edf87000(4096)
> > Error -3 while decompressing!
> > c000000000959298(2520)->c0000000edbc7000(4096)
> > Error -3 while decompressing!
> > c000000000959c70(2489)->c0000000f1482000(4096) 
> > Error -3 while decompressing!
> > c00000000095a629(2355)->c0000000edaff000(4096)
> > Error -3 while decompressing!
> > ...
> 
> Today I looked at this bug again and found that 2.6.18-rc6-git2 has
> fix for this. Is the patch below supposed to fix the cramfs corruption
> or does it just paper over the bug?
> 
> ...
> cramfs_read() clears parts of the src buffer because the page is not
> uptodate. invalidate_bdev() called from block_ioctl(BLKFLSBUF) will set
> ClearPageUptodate() after cramfs_read() got the page from read_cache_page()
> ...
> 
> /root/cramfscrash.sh
> #!/bin/bash
> # cd /dev/shm/
> # tar xfz /mounts/mirror/kernel/v2.6/linux-2.6.18.tar.gz
> # cd linux-2.6.18/
> # mkfs.cramfs drivers /tmp/cramfs.image
> mount -vnt proc proc /proc
> echo 1 > /proc/sys/kernel/panic
> echo 9 > /proc/sysrq-trigger

That's a novel way of setting the log level.

> mount -vnt sysfs sysfs /sys
> modprobe -v loop
> mount -vnt cramfs -o loop /tmp/cramfs.image /mnt
> while :;do /sbin/blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
> while :;do /usr/bin/find /mnt -type f -print0|xargs -0 cat &>/dev/null;done
> 
> 
> kernel cmdline
> xmon=off panic=1 sysrq=1 quiet root=/dev/disk/by-uuid/d50e4029-2e91-4332-bb16-24f946a74d3f ro init=/root/cramfscrash.sh
> 
> 
> 
>  016eb4a0ed06a3677d67a584da901f0e9a63c666.patch
> From: Andrew Morton <akpm@osdl.org>
> 
> If a CPU faults this page into pagetables after invalidate_mapping_pages()
> checked page_mapped(), invalidate_complete_page() will still proceed to remove
> the page from pagecache.  This leaves the page-faulting process with a
> detached page.  If it was MAP_SHARED then file data loss will ensue.
> 
> Fix that up by checking the page's refcount after taking tree_lock.

Yes, I think this is a reasonable solution to the cramfs race.  Previously,
invalidate_inode_pages() was removing pages from pagecache even if some
other thread had a ref against them, which is pretty bad behaviour.
