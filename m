Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbTCGRYL>; Fri, 7 Mar 2003 12:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbTCGRYL>; Fri, 7 Mar 2003 12:24:11 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:37530 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261677AbTCGRYK>; Fri, 7 Mar 2003 12:24:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alex Tomas <bzzz@tmi.comex.ru>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Date: Sat, 8 Mar 2003 18:38:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>
References: <11490000.1046367063@[10.10.2.4]> <m34r6fyya8.fsf@lexa.home.net>
In-Reply-To: <m34r6fyya8.fsf@lexa.home.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030307173425.5C4D3FAAAE@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Mar 03 16:46, Alex Tomas wrote:
> Hi!
>
> The problem is that getdents(2) returns inodes out of order and
> du causes many head seeks. I tried to solve the problem by patch
> I included in. The idea of the patch is pretty simple: just try
> to sort dentries by inode number in readdir(). It works because
> inodes sits at fixed places in ext2/ext3. Please, look at results
> I just got:
>
>                   real        user         sys
>
> ext3+htree:  7m22.236s    0m0.292s    0m2.204s
> ext3-htree:  3m6.539s     0m0.481s    0m2.278s
> [...]
> ext3+sd-30:  2m39.658s    0m0.492s    0m2.138s

Nice.  I posted a similar demonstration some time ago (could it *really* be 
two years?) but I sorted the dirents in user space, which meant it was just a 
demonstration, not a practical solution.

The problem I see with your approach is that the traversal is no longer in 
hash order, so a leaf split in the middle of a directory traversal could 
result in a lot of duplicate dirents.  I'm not sure there's a way around that.

Another approach is to have the inode number correspond approximately to the 
hash value.  That's not as hard as it sounds, it simply means that the goal 
for ext3_new_inode should be influenced by the hash value.  (But watch out 
for interaction with the new Orlov allocator.)  It also depends on some
a priori estimate of the size of a directory so that increasing hash values 
can be distributed more or less uniformly and monotonically across some 
corresponding range of inode numbers. This isn't too hard either, just round 
up the current size of the directory to a power of two and use that as the 
size estimate.  The size estimate would change from time to time over the 
life of the directory, but there are only log N different sizes and that's 
roughly how heavy the load on the inode cache would be during a directory 
traversal.  Finally, a nice property of this approach is that it stays stable 
over many creates and deletes.

We've apparently got a simpler problem though: inode numbers aren't allocated 
densely enough in the inode table blocks.  This is the only thing I can think 
of that could cause the amount of thrashing we're seeing.  Spreading inode 
number allocations out all over a volume is ok, but sparse allocation within 
each table block is not ok because it multiplies the pressure on the cache.  
We want a 30,000 entry directory to touch 1,000 - 2,000 inode table blocks, 
not the worst-case 30,000.  As above, fixing this comes down to tweaking the 
ext3_new_inode allocation goal.

Regards,

Daniel
