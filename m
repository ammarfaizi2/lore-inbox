Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTAIJ6W>; Thu, 9 Jan 2003 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTAIJ6W>; Thu, 9 Jan 2003 04:58:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:41419 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262360AbTAIJ6U>;
	Thu, 9 Jan 2003 04:58:20 -0500
Message-ID: <3E1D49BF.5114A896@digeo.com>
Date: Thu, 09 Jan 2003 02:06:55 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yuval yeret <yuval_yeret@hotmail.com>
CC: linux-kernel@vger.kernel.org, yuval@exanet.com
Subject: Re: 2.4.18-14 kernel stuck during ext3 umount with ping still responding
References: <F12N44yQegpeDBHkKx400013b3e@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2003 10:06:55.0862 (UTC) FILETIME=[D704D160:01C2B7C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yuval yeret wrote:
> 
> Hi,
> 
> I'm running a 2.4.18-14 kernel with a heavy IO profile using ext3 over RAID
> 0+1 volumes.
> 
> >From time to time I get a black screen stuck machine while trying to umount
> a volume during an IO workload (as part of a failback solution - but after
> killing all IO processes ), with ping still responding, but everything else
> mostly dead.
> 
> I tried using the forcedumount patch to solve this problem - to no avail.
> Also tried upgrading the qlogic drivers to the latest drivers from Qlogic.
> 
> After one of the occurences I managed to get some output using the sysrq
> keys.
> 
> This seems similar to what is described in
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=77508 but with a
> different call trace
> 
> What I have here is what I managed to copy down (for some reason pgup/pgdown
> didn't work so not all information is full...) together with a manual lookup
> of the call trace
> from /proc/ksyms :
> 
> process umount
> EIP c01190b8                    (set_running_and_schedule)
> call trace:
> c01144c9        f25f9ec0        IO_APIC_get_PCI_irq_vector
> c010a8b0        f25f9ed0        enable_irq
> c014200c        f25f9ef0        fsync_buffers_list
> c0155595        f25f9efc        clear_inode
> c015553d        f25f9f2c        invalidate_inodes
> c01461d8        f25f9f78        get_super
> c014a629        f25f9f94        path_release
> c0157c58        f25f9fc0        sys_umount
> c0108cab                        sys_sigaltstack
> 
> Any idea what can cause this ?
> 

If you have a large amount of data against two or more filesystems,
and you try to unmount one of them the kernel can seize up for a
very long time in the fsync_dev()->sync_buffers() function.  Under
these circumstances that function has O(n*n) search complexity
and n is quite large.

However your backtrace shows neither of those functions.

Still, as an experiment it would be interesting to see if the below
patch fixes it up.  It converts O(n*n) to O(m), where m > n.



 fs/buffer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- 2420/fs/buffer.c~a	Thu Jan  9 02:03:06 2003
+++ 2420-akpm/fs/buffer.c	Thu Jan  9 02:04:02 2003
@@ -307,11 +307,11 @@ int sync_buffers(kdev_t dev, int wait)
 	 * 2) write out all dirty, unlocked buffers;
 	 * 2) wait for completion by waiting for all buffers to unlock.
 	 */
-	write_unlocked_buffers(dev);
+	write_unlocked_buffers(NODEV);
 	if (wait) {
-		err = wait_for_locked_buffers(dev, BUF_DIRTY, 0);
+		err = wait_for_locked_buffers(NODEV, BUF_DIRTY, 0);
 		write_unlocked_buffers(dev);
-		err |= wait_for_locked_buffers(dev, BUF_LOCKED, 1);
+		err |= wait_for_locked_buffers(NODEV, BUF_LOCKED, 1);
 	}
 	return err;
 }

_
