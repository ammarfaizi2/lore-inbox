Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274444AbRITMQB>; Thu, 20 Sep 2001 08:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274441AbRITMPv>; Thu, 20 Sep 2001 08:15:51 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:28834
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274444AbRITMPn>; Thu, 20 Sep 2001 08:15:43 -0400
Date: Thu, 20 Sep 2001 08:16:02 -0400
From: Chris Mason <mason@suse.com>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>, linux-kernel@vger.kernel.org
cc: tovarlds@transmeta.com
Subject: Re: [PATCH] Significant performace improvements on reiserfs
 systems, kupdated bugfixes
Message-ID: <391950000.1000988162@tiny>
In-Reply-To: <Pine.LNX.4.30.0109201445170.13543-100000@gamma.student.ljbc>
In-Reply-To: <Pine.LNX.4.30.0109201445170.13543-100000@gamma.student.ljbc>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, September 20, 2001 03:12:44 PM +0800 Beau Kuiper
<kuib-kl@ljbc.wa.edu.au> wrote:

> Hi,
> 
> Resierfs on 2.4 has always been bog slow.
> 
> I have identified kupdated as the culprit, and have 3 patches that fix the
> peformance problems I have had been suffering.

Thanks for sending these along.

> 
> I would like these patches to be reviewed an put into the mainline kernel
> so that others can testthe changes.
> 
> Patch 1.
> 
> This patch fixes reiserfs to use the kupdated code path when told to
> resync its super block, like it did in 2.2.19. This is the culpit for bad
> reiserfs performace in 2.4. Unfortunately, this fix relies on the second
> patch to work properly.

I promised linus I would never reactivate this code, it is just too nasty
;-)  The problem is that write_super doesn't know if it is called from sync
or from kupdated.  The right fix is to have an extra param to write_super,
or another super_block method that gets called instead of write_super when
an immediate commit is not required.

It is possible to get almost the same behaviour as 2.2.x by changing the
metadata sync interval in bdflush to 30 seconds.

> 
> Patch 2
> 
> This patch implements a simple mechinism to ensure that each superblock
> only gets told to be flushed once. With reiserfs and the first patch, the
> superblock is still dirty after being told to sync (probably becasue it
> doesn't want to write out the entire journal every 5 seconds when kupdate
> calls it). This caused an infinite loop because sync_supers would
> always find the reiserfs superblock dirty when called from kupdated. I am
> not convinced that this patch is the best one for this problem
> (suggestions?)

It is ok to leave the superblock dirty, after all, since the commit wasn't
done, the super is still dirty.  If the checks from reiserfs_write_super
are actually slowing things down, then it is probably best to fix the
checks.

> 
> Patch 3
> 
> This patch was generated as I was exploring the buffer cache, wondering
> why reiserfs was so slow on 2.4. I found that kupdated may write buffers
> that are not actually old back to disk. Eg
> 
> Imagine that there are 20 dirty buffers. 16 of them are more that 30
> seconds old (and should be written back), but the other 4 are younger than
> 30 seconds. The current code would force all 20 out to disk, interrupting
> programs still using the young 4 until the disk write was complete.
> 
> I know that it isn't a major problem, but I found it and I have written
> the patch for it :-)
> 
> Please try out these patches and give comments about style, performace
> ect. They fixed my problems, sliced almost a minute off 2.2.19 kernel
> compile time on my duron 700 (from 4min 30sec to 3min 45sec)

Doe you have the results of the individual fixes?

thanks,
Chris

