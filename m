Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291487AbSBSQsh>; Tue, 19 Feb 2002 11:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291477AbSBSQs2>; Tue, 19 Feb 2002 11:48:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44432 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291475AbSBSQsN>;
	Tue, 19 Feb 2002 11:48:13 -0500
Date: Tue, 19 Feb 2002 11:47:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Steve Lord <lord@sgi.com>
cc: Nakayama Shintaro <nakayama@tritech.co.jp>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        shojima@tritech.co.jp, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: BKL removal from VFS
In-Reply-To: <1014135551.3393.103.camel@jen.americas.sgi.com>
Message-ID: <Pine.GSO.4.21.0202191137490.9938-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Feb 2002, Steve Lord wrote:

> Whoa, light blue touch paper and stand back! Like I said I was not proposing
> this to go into the kernel, just asking your opinion.

You asked - I answered ;-)

BTW, check your use of ->d_parent - a lot of places implicitly assumes that
it can't change under you.  Currently for a filesystem with ->rename() it's
true only if at least one of the following conditions is satisfied:
	* you know that lock on parent is held (e.g. you are in ->lookup()
and its ilk and dentry is one you've got from caller).  Notice that
down(&dentry->d_parent->d_inode->i_sem) is 100% wrong for any such fs.
	* dcache_lock is held.
	* BKL is held.
	* you are called from cross-directory ->rename() (then no dentry
on that filesystem will changes its parent until you are done).

	Surprisingly many places implicitly rely on BKL (i.e. have no
other protection and don't fsck up only because they are always called
under BKL).  Hell, some places don't have _any_ protection - see 2.4.18-rc2
for fixes to such crap in dnotify-related code.

