Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbTAOTE4>; Wed, 15 Jan 2003 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTAOTE4>; Wed, 15 Jan 2003 14:04:56 -0500
Received: from f134.law7.hotmail.com ([216.33.237.134]:48139 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266930AbTAOTEx>;
	Wed, 15 Jan 2003 14:04:53 -0500
X-Originating-IP: [209.19.52.103]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, yuval@exanet.com
Subject: Re: 2.4.18-14 kernel stuck during ext3 umount with ping still responding
Date: Wed, 15 Jan 2003 21:13:43 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F134wsXZZTHfyQgeDKv00011132@hotmail.com>
X-OriginalArrivalTime: 15 Jan 2003 19:13:43.0479 (UTC) FILETIME=[385C6470:01C2BCCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The problem reproduces on a 2.4.18-19 kernel as well. Took some more time 
but finally it roared its ugly head.

This is the stack trace from the new kernel:

>c01190b8	f3791eb4	set_running_and_schedule
>c010a8b0	f3791ed0	enable_irq
>c014200c	f3791f0c	IO_APIC_get_PCI_irq_vector
>c0155595	f3791f0c	clear_inode
>c01556639	f3791f60	invalidate_inodes
>c0149629	f3791f8	set_binfmt
>c0157c58	f3791f94	sys_umount
>c0108cab	0f3791fc0	sys_sigaltstack


Andrew Morton suggested a buffer.c patch for reducing search complexity, 
which I will try next.

Any further comments/suggestions are welcome

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
Help STOP SPAM: Try the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail

