Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSGMRXg>; Sat, 13 Jul 2002 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSGMRXf>; Sat, 13 Jul 2002 13:23:35 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:53767 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315222AbSGMRXf>; Sat, 13 Jul 2002 13:23:35 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
cc: pmenage@ensim.com
In-reply-to: Your message of "Sat, 13 Jul 2002 04:52:25 EDT."
             <Pine.GSO.4.21.0207130409090.13648-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jul 2002 10:25:55 -0700
Message-Id: <E17TQeZ-0006OR-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Frankly, I'd rather moved setting DCACHE_REFERENCED to dput().  We don't
>care for that bit for dentries with positive ->d_count.
>
>So I'd just do
>
>vi fs/dcache.c -c '/|= DCACHE_R/d|/nr_un/pu|<|x'
>
>and be done with that.  Linus?
>

Some possibly minor issues with that: 

- accessing foo/../bar, won't mark foo as referenced, even though it
might be being referenced frequently. Probably not a common case for foo
to be accessed exclusively in this way, but it could be fixed by marking
a dentry referenced when following ".."

- currently, negative dentries start off unreferenced and get marked
referenced the second and subsequent time that they're used. This would
change to starting off referenced (by the ref count set in lock_nd()
after the ->lookup()) but then not being marked referenced ever again,
as they're always looked at under dcache_lock, and no count is taken on
them. So used-once negative dentries would hang around longer, and
frequently-used negative dentries would be cleaned up sooner.

- referenced bit will be set possibly long after the reference is 
actually taken/used, which might make dentry pruning a little less 
accurate.

I was considering suggesting moving the reference bit setting to
unlock_nd(), since that's another place where we're already changing
d_count, but that still has the first two problems that I mentioned.
Either way, moving d_vfsflags to the same cacheline as d_count would
probably be a good idea.

Paul

