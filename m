Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSGQJjl>; Wed, 17 Jul 2002 05:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318254AbSGQJjk>; Wed, 17 Jul 2002 05:39:40 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:48605 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318253AbSGQJjj>; Wed, 17 Jul 2002 05:39:39 -0400
Message-Id: <5.1.0.14.2.20020717103038.00a8c7a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 10:45:41 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 13/13] lseek speedup
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D35012B.EE9B1ABB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:31 17/07/02, Andrew Morton wrote:
>This is a fairly dopey patch to fix up the i_sem contention in lseek.
>Better ideas are welcome, but I'm offline until Monday so don't think
>I'm ignoring them...

I am afraid I don't have any better ideas but I don't think your patch is 
safe. )-:

>We need to decide what we really want to lock in there.  If multiple
>threads are updating f_pos and/or i_size at the same time then they are
>going to see strange results whatever the kernel does.  I'd maintain
>that the only real obligation which the kernel has in this situation is
>to not oops, to not munch data and to not return competely outlandish
>results.

That can only be guaranteed by holding i_sem. Since the BKL was taken out 
of ->readdir(), i_sem is now used for exclusion between ->readdir() and 
->llseek() (well NTFS uses it anyway but many other fs which switched to 
generic_file_llseek() do the same). This exclusion is necessary IMHO.

->readdir() may well blow up or at the very least give "completely 
outlandish results" if someone modifies f_pos while it is running. 
Depending on when exactly it happens, ntfs_readdir() is going to be ok as 
it mostly sets f_pos instead of incrementing it but still, a succeeding 
->llseek(), may actually end up in a different position to the one 
requested because of a concurrent ->readdir().

I know doing the two things at the same time requires a completely crazy 
multithreaded application, but then again many application developers fall 
into that category. (-;

>And the only way we can return outlandish results is on 32-bit SMP if
>one CPU reads i_size or f_pos while another CPU is in the middle of
>modifying it.

I believe it can also happen if ->llseek() is allowed to run concurrently 
with a ->readdir()...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

