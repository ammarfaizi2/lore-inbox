Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbTAVRxD>; Wed, 22 Jan 2003 12:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbTAVRxD>; Wed, 22 Jan 2003 12:53:03 -0500
Received: from bay2-f23.bay2.hotmail.com ([65.54.247.23]:36103 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S262266AbTAVRxB>;
	Wed, 22 Jan 2003 12:53:01 -0500
X-Originating-IP: [212.143.73.102]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, yuval@exanet.com
Subject: Re: 2.4.18-14 kernel stuck during ext3 umount with ping still responding
Date: Wed, 22 Jan 2003 20:02:04 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F23TCi90gP8yJr0002f60d@hotmail.com>
X-OriginalArrivalTime: 22 Jan 2003 18:02:04.0973 (UTC) FILETIME=[5F24ADD0:01C2C240]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, took some time to reproduce the environment with the kernel including 
the patch, but seems it didn't help after all.

The ctrl-scroll-lock output shows a stuck umount in R status, with a similar 
call trace as before, but the inner calls a little different:

c0141295                        __wait_on_buffer
c014200c                        fsync_buffers_list
c0155595        f25f9efc        clear_inode
c015553d        f25f9f2c        invalidate_inodes
c01461d8        f25f9f78        get_super
c014a629        f25f9f94        path_release
c0157c58        f25f9fc0        sys_umount
c0108cab                        sys_sigaltstack

This is using a 2.4.18-19.7 kernel patched as per the below suggestion.

Any pointers/suggestions are welcome

Thanks,
Yuval








>From: Andrew Morton <akpm@digeo.com>
>To: yuval yeret <yuval_yeret@hotmail.com>
>CC: linux-kernel@vger.kernel.org, yuval@exanet.com
>Subject: Re: 2.4.18-14 kernel stuck during ext3 umount with ping still 
>responding
>Date: Thu, 09 Jan 2003 02:06:55 -0800
>
>yuval yeret wrote:
> >
> > Hi,
> >
> > I'm running a 2.4.18-14 kernel with a heavy IO profile using ext3 over 
>RAID
> > 0+1 volumes.
> >
> > >From time to time I get a black screen stuck machine while trying to 
>umount
> > a volume during an IO workload (as part of a failback solution - but 
>after
> > killing all IO processes ), with ping still responding, but everything 
>else
> > mostly dead.
> >
> > I tried using the forcedumount patch to solve this problem - to no 
>avail.
> > Also tried upgrading the qlogic drivers to the latest drivers from 
>Qlogic.
> >
> > After one of the occurences I managed to get some output using the sysrq
> > keys.
> >
> > This seems similar to what is described in
> > http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=77508 but with a
> > different call trace
> >
> > What I have here is what I managed to copy down (for some reason 
>pgup/pgdown
> > didn't work so not all information is full...) together with a manual 
>lookup
> > of the call trace
> > from /proc/ksyms :
> >
> > process umount
> > EIP c01190b8                    (set_running_and_schedule)
> > call trace:
> > c01144c9        f25f9ec0        IO_APIC_get_PCI_irq_vector
> > c010a8b0        f25f9ed0        enable_irq
> > c014200c        f25f9ef0        fsync_buffers_list
> > c0155595        f25f9efc        clear_inode
> > c015553d        f25f9f2c        invalidate_inodes
> > c01461d8        f25f9f78        get_super
> > c014a629        f25f9f94        path_release
> > c0157c58        f25f9fc0        sys_umount
> > c0108cab                        sys_sigaltstack
> >
> > Any idea what can cause this ?
> >
>
>If you have a large amount of data against two or more filesystems,
>and you try to unmount one of them the kernel can seize up for a
>very long time in the fsync_dev()->sync_buffers() function.  Under
>these circumstances that function has O(n*n) search complexity
>and n is quite large.
>
>However your backtrace shows neither of those functions.
>
>Still, as an experiment it would be interesting to see if the below
>patch fixes it up.  It converts O(n*n) to O(m), where m > n.
>
>
>
>  fs/buffer.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
>--- 2420/fs/buffer.c~a	Thu Jan  9 02:03:06 2003
>+++ 2420-akpm/fs/buffer.c	Thu Jan  9 02:04:02 2003
>@@ -307,11 +307,11 @@ int sync_buffers(kdev_t dev, int wait)
>  	 * 2) write out all dirty, unlocked buffers;
>  	 * 2) wait for completion by waiting for all buffers to unlock.
>  	 */
>-	write_unlocked_buffers(dev);
>+	write_unlocked_buffers(NODEV);
>  	if (wait) {
>-		err = wait_for_locked_buffers(dev, BUF_DIRTY, 0);
>+		err = wait_for_locked_buffers(NODEV, BUF_DIRTY, 0);
>  		write_unlocked_buffers(dev);
>-		err |= wait_for_locked_buffers(dev, BUF_LOCKED, 1);
>+		err |= wait_for_locked_buffers(NODEV, BUF_LOCKED, 1);
>  	}
>  	return err;
>  }
>
>_


_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

