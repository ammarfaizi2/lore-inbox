Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288765AbSATPtV>; Sun, 20 Jan 2002 10:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288767AbSATPtM>; Sun, 20 Jan 2002 10:49:12 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:43436 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288765AbSATPs4>; Sun, 20 Jan 2002 10:48:56 -0500
Message-Id: <5.1.0.14.2.20020120154049.04d7fbc0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 20 Jan 2002 15:49:20 +0000
To: Hans Reiser <reiser@namesys.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Possible Idea with filesystem buffering.
Cc: Shawn <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3C4AAA95.8040702@namesys.com>
In-Reply-To: <Pine.LNX.4.40.0201200359520.503-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:31 20/01/02, Hans Reiser wrote:
>In version 4 of reiserfs, our plan is to implement writepage such that it 
>does not write the page but instead pressures the reiser4 cache and marks 
>the page as recently accessed.  This is Linus's preferred method of doing that.

But why do you want to do your own cache? Any individual fs driver is in no 
position to know the overall demands on the VMM of the currently running 
kernel/user programs/etc. As such it is IMHO inefficient and I think it 
won't actually work due to VMM requiring to free specific memory and hence 
calling writepage on that specific memory so it can throw the pages away 
afterwards but in your concept writepage won't result in the page being 
marked clean and the vm has made no progress and you have just created a 
hole load of headaches for the VMM which it can't solve...

The VMM should be the ONLY thing in the kernel that has full control of all 
caches in the system, and certainly all fs caches. Why you are putting a 
second cache layer underneath the VMM is beyond me. It would be much better 
to fix/expand the capabilities of the existing VMM which would have the 
benefit that all fs could benefit not just ReiserFS.

>Personally, I think that makes writepage the wrong name for that function, 
>but I must admit it gets the job done, and it leaves writepage as the 
>right name for all filesystems that don't manage their own cache, which is 
>most of them.

Yes it does make it the wrong name, but not only that it also breaks the 
existing VMM if I understand anything about the VMM (which may of course 
not be the case...).

Just a thought.

Best regards,

Anton


>Hans
>
>Shawn wrote:
>
>>I've noticed that XFS's filesystem has a separate pagebuf_daemon to handle
>>caching/buffering.
>>
>>Why not make a kernel page/caching daemon for other filesystems to use
>>(kpagebufd) so that each filesystem can use a kernel daemon interface to
>>handle buffering and caching.
>>
>>I found that XFS's buffering/caching significantly reduced I/O load on the
>>system (with riel's rmap11b + rml's preempt patches and Andre's IDE
>>patch).
>>
>>But I've not been able to acheive the same speed results with ReiserFS :-(
>>
>>Just as we have a filesystem (VFS) layer, why not have a buffering/caching
>>layer for the filesystems to use inconjunction with the VM?
>There is hostility to this from one of the VM maintainers.  He is 
>concerned that separate caches were what they had before and they behaved 
>badly.  I think that they simply coded them wrong the time before.  The 
>time before, the pressure on the subcaches was uneven, with some caches 
>only getting pressure if the other caches couldn't free anything, so of 
>course it behaved badly.
>
>>
>>
>>Comments, suggestions, flames welcome ;)
>>
>>Shawn.
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

