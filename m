Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311595AbSCZQgR>; Tue, 26 Mar 2002 11:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSCZQgH>; Tue, 26 Mar 2002 11:36:07 -0500
Received: from www.wen-online.de ([212.223.88.39]:2311 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S311595AbSCZQfv>;
	Tue, 26 Mar 2002 11:35:51 -0500
Date: Tue, 26 Mar 2002 17:55:08 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [datapoint] Re: 2.5.7 rm -r in tmpfs problem
In-Reply-To: <Pine.GSO.4.21.0203231038320.3631-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10203261736010.440-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Alexander Viro wrote:

> There are known problems with rm(1) on ramfs/tmpfs/etc. - the thing assumes
> that offsets in directory remain stable after unlink(2), but locking changes
> didn't affect.

Ok, I finally found a wee bit of clue.  I understand the assumption,
and in virgin 2.5.4, that assumption is enforced... somefsckingwhere ;-)

However, the locking changes do affect it in some magical way, and do
cause (well, trigger anyway) the breakage.

In 2.5.4, I creats a directory with 170 (two more than will fit in one call)
entries, and rm -r it.  Over all three dcache_readdir() calls, (one for the
first 168 entries (+.+..), one for the last two entries + seek, and one to
determine that we're empty), the dentry count remains stable at 170.  If I
apply the locking changes, POOF, my dentries disappear exactly as they do in
kernels >= 2.5.5-pre1.

64 Kibble-$$ question:

Why are my dentries going awol with the locking changes applied?

2.5.4.virgin
enter pos=0 count=170
seek pos=0 count=170
exit pos=170 count=170
enter pos=170 count=170
seek pos=0 count=170
exit pos=172 count=170
enter pos=172 count=170
exit EOF

2.5.4.locking
enter pos=0 count=170
seek pos=0 count=170
exit pos=170 count=170
enter pos=170 count=2
exit EOF

	-Mike

