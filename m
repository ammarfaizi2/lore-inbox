Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUABUMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbUABUMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:12:46 -0500
Received: from faraday.dhtns.com ([64.246.11.56]:25999 "EHLO faraday.dhtns.com")
	by vger.kernel.org with ESMTP id S265640AbUABUMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:12:22 -0500
Date: Fri, 2 Jan 2004 15:12:21 -0500
From: Elliott Bennett <lkml@dhtns.com>
To: linux-kernel@vger.kernel.org
Cc: lkml@dhtns.com
Subject: Re: JFS resize=0 problem in 2.6.0
Message-ID: <20040102201221.GA28116@faraday.dhtns.com>
References: <20031228153028.GB22247@faraday.dhtns.com> <20031229000503.GD1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229000503.GD1882@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 04:05:03PM -0800, Mike Fedyk wrote:
> On Sun, Dec 28, 2003 at 10:30:28AM -0500, lkml@dhtns.com wrote:
> > It seems to me that line 264 is attempting to test for the mount 
> > paramater "resize=0", and when it comes across this, resize to the full
> > size of the volume.  However, this doesn't work.  I believe it should
> > test for the char '0'  (*resize=='0'), not against literal zero.  
> > 
> > Let me know if I'm way off base here.  But the below patch does allow a
> > $ mount -o remount,resize=0 /mnt/test    
> > to resize the jfs filesystem to the full size of the volume.
> 
> And it won't without the patch?
> 
> What errors do you get if it fails without the patch?

It won't without the patch.  

No errors...it just doesn't resize.  :)

Here's a shell snippit.  I have just resized /dev/vg/lv from 700M to
900M, and I'm running the ORIGINAL jfs module:

root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv       713500       220    713280   1% /mnt
root@tesla:~# mount
/dev/mapper/vg-lv on /mnt type jfs (rw)
root@tesla:~# mount -o remount,resize=0 /mnt
root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv       713500       220    713280   1% /mnt

	..the resizing failed.  But, switching to the patched module:

root@tesla:~# umount /mnt
root@tesla:~# rmmod jfs
root@tesla:~# cp ~/jfs_patch.ko /lib/modules/2.6.0/kernel/fs/jfs/jfs.ko
root@tesla:~# mount -t jfs /dev/vg/lv /mnt
root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv       713500       220    713280   1% /mnt
root@tesla:~# mount -o remount,resize=0 /mnt
root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv       917272       244    917028   1% /mnt

	resizing works.

	
	Oddly, now, an additional lvextend and remount/resize fails:

root@tesla:~# lvextend /dev/vg/lv -L +200M
  /dev/hdd: open failed: Read-only file system
  Extending logical volume lv to 1.07 GB
  Logical volume lv successfully resized
root@tesla:~# mount -o remount,resize=0 /mnt
root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv       917272       244    917028   1% /mnt
root@tesla:~# mount
/dev/mapper/vg-lv on /mnt type jfs (rw,resize=0,resize=0)

	note "resize=0,resize=0" above.
	...but unmounting it, remounting it, and then resizing it works:

root@tesla:~# umount /mnt
root@tesla:~# mount -t jfs /dev/vg/lv /mnt
root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv       917272       244    917028   1% /mnt
root@tesla:~# mount -o remount,resize=0 /mnt
root@tesla:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/mapper/vg-lv      1121040       272   1120768   1% /mnt
root@tesla:~# mount
/dev/mapper/vg-lv on /mnt type jfs (rw,resize=0)

	It turns out that it's not so much of the fact that this is a
"second" extention during the same mount as the fact that it was
extended while mounted.  It seems that nomatter when I lvextend (mounted
or unmounted), i must unmount (if mounted), then mount, then
remount/resize for a resize to take effect.  If I don't unmount after
lvextending, and try to resize, I get:
jfs_extendfs: volume hasn't grown, returning


Soo...I would say that something is awry with the resizing of JFS
filesystems.  My patch obviously doesn't fix everything, but at least
makes resizing to fill available space *possible*. :)

The code surrounding my patch change treats the same variable (resize,
which is a pointer to args[0].from) as a string, so it seems pretty
obvious to me it should be comparing to '0'.


-Elliott Bennett

