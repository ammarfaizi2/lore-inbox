Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274538AbRITPWI>; Thu, 20 Sep 2001 11:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274537AbRITPV7>; Thu, 20 Sep 2001 11:21:59 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:49391 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S274536AbRITPVq>;
	Thu, 20 Sep 2001 11:21:46 -0400
Date: Thu, 20 Sep 2001 23:20:26 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: Chris Mason <mason@suse.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems,
 kupdated bugfixes
In-Reply-To: <391950000.1000988162@tiny>
Message-ID: <Pine.LNX.4.30.0109202305350.19677-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Chris Mason wrote:

>
>
> On Thursday, September 20, 2001 03:12:44 PM +0800 Beau Kuiper
> <kuib-kl@ljbc.wa.edu.au> wrote:
>
> > Hi,
> >
> > Resierfs on 2.4 has always been bog slow.
> >
> > I have identified kupdated as the culprit, and have 3 patches that fix the
> > peformance problems I have had been suffering.
>
> Thanks for sending these along.
>
> >
> > I would like these patches to be reviewed an put into the mainline kernel
> > so that others can testthe changes.
> >
> > Patch 1.
> >
> > This patch fixes reiserfs to use the kupdated code path when told to
> > resync its super block, like it did in 2.2.19. This is the culpit for bad
> > reiserfs performace in 2.4. Unfortunately, this fix relies on the second
> > patch to work properly.
>
> I promised linus I would never reactivate this code, it is just too nasty
> ;-)  The problem is that write_super doesn't know if it is called from sync
> or from kupdated.  The right fix is to have an extra param to write_super,
> or another super_block method that gets called instead of write_super when
> an immediate commit is not required.

I don't think that this could happen until 2.5.x though, as either
solution touches every file system. However, if we added an extra methed,
we could do this while only slightly touching the other filesystems (where
kupdated sync == real sync) Simply see if the method exists (is non-null)
and call that instead with a kupdate sync instead of the normal
super_sync. Are you interested in me writing a patch to do this?


>
> It is possible to get almost the same behaviour as 2.2.x by changing the
> metadata sync interval in bdflush to 30 seconds.
>

But then kupdate doesn't flush normal data as regularly as it should, plus
it is almost as messy as Patch 1 :-)

> >
> > Patch 2
> >
> > This patch implements a simple mechinism to ensure that each superblock
> > only gets told to be flushed once. With reiserfs and the first patch, the
> > superblock is still dirty after being told to sync (probably becasue it
> > doesn't want to write out the entire journal every 5 seconds when kupdate
> > calls it). This caused an infinite loop because sync_supers would
> > always find the reiserfs superblock dirty when called from kupdated. I am
> > not convinced that this patch is the best one for this problem
> > (suggestions?)
>
> It is ok to leave the superblock dirty, after all, since the commit wasn't
> done, the super is still dirty.  If the checks from reiserfs_write_super
> are actually slowing things down, then it is probably best to fix the
> checks.

I meant, there might be better wway to prevent the endless loop than
adding an extra field to the superblock data structure. I beleive (I
havn't explored reiserfs code much) the slowdown is caused by the journal
being synced with the superblock, thus causing:

1) Too much contention for disk resources.
2) A huge increase in the number of times programs must be suspended to
wait for the disk
3) Poor CPU utilization in code that uses the filesystem regularly (like
compiling)

>
> >
> > Patch 3
> >
> > This patch was generated as I was exploring the buffer cache, wondering
> > why reiserfs was so slow on 2.4. I found that kupdated may write buffers
> > that are not actually old back to disk. Eg
> >
> > Imagine that there are 20 dirty buffers. 16 of them are more that 30
> > seconds old (and should be written back), but the other 4 are younger than
> > 30 seconds. The current code would force all 20 out to disk, interrupting
> > programs still using the young 4 until the disk write was complete.
> >
> > I know that it isn't a major problem, but I found it and I have written
> > the patch for it :-)
> >
> > Please try out these patches and give comments about style, performace
> > ect. They fixed my problems, sliced almost a minute off 2.2.19 kernel
> > compile time on my duron 700 (from 4min 30sec to 3min 45sec)
>
> Doe you have the results of the individual fixes?

Patch 3 doesn't improve performace much (even in theory the number of
dirty buffers being wrongly flushed is pretty low)

Patch 2 doesn't improve performace at all (unless you apply patch 1,
without it, the computer will bog itself into the ground on the
first kupdated)

Patch 1 makes a huge difference because it stops reiserfs from reacting
badly on a kupdated.

Are there any good benchmarks you want me to run, on the plain and modded
kernels.

Thanks
Beau Kuiper
kuib-kl@ljbc.wa.edu.au

>
> thanks,
> Chris
>

