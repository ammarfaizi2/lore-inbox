Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRLGRjk>; Fri, 7 Dec 2001 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282453AbRLGRjb>; Fri, 7 Dec 2001 12:39:31 -0500
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:35594 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S278428AbRLGRjR>;
	Fri, 7 Dec 2001 12:39:17 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Fri, 7 Dec 2001 18:41:53 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CNHk-0000u4-00@starship.berlin> <20011207174726.B6640@vestdata.no>
In-Reply-To: <20011207174726.B6640@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16CP0X-0000uE-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 05:47 pm, Ragnar Kjørstad wrote:
> On Fri, Dec 07, 2001 at 04:51:33PM +0100, Daniel Phillips wrote:
> > An alternative way of looking at this is, rather than R5 causing an order
> > of magnitude improvement for certain cases, something else is causing an 
> > order of magnitude slowdown for common cases.  I'd suggest attempting to 
> > root that out.
> 
> In the cases I've studied more closely (e.g. maildir cases) the problem
> with reiserfs and e.g. the tea hash is that there is no common ordering
> between directory entries, stat-data and file-data.
> 
> When new files are created in a directory, the file-data tend to be
> allocated somewhere after the last allocated file in the directory. The
> ordering of the directory-entry and the stat-data (hmm, both?) are
> however dependent on the hash. So, with something like the tea hash the
> new file will be inserted in the middle of the directory.
> 
> 
> In addition to the random lookup type reads, there are three other common
> scenarios for reading the files:
> 
> 1 Reading them in the same order they were created
> The cache will probably not be 100% effective on the
> directory/stat-data, because it's beeing accessed in a random-like
> order. Read-ahead for the file-data on the other hand will be effective.
> 
> 2 Reading the files in filename-order
> Some applications (say, ls -l) may do this, but I doubt it's a very
> common accesspattern. Cache-hit for directory-data will be poor, and
> cache-hit for file-data will be poor unless the files were created in
> the same order. 
> 
> 3 Reading the files in readdir() order.
> This is what I think is the most common access-pattern. I would expect a
> lot of programs (e.g. mail clients using maildir) to read the directory
> and for every filename stat the file and read the data. This will be in
> optimal order for directory-caching, but more importantly it will be
> random-order like access for the file-data.
> 
> I think scenario nr 3 is the one that matters, and I think it is this
> scenario that makes r5 faster than tea in real-life applications on
> reiserfs. (allthough most numbers available are from benchmarks and not
> real life applications).
> 
> The directory content is likely to all fit in cache even for a fairly
> large directory, so cache-misses are not that much of a problem. The
> file-data itself however, will suffer if read-ahead can't start reading
> the next file from disk while the first one is beeing processed.

I've observed disk cache effects with Ext2, the relevant relationship being 
directory entry order vs inode order.  Layout of the index itself doesn't 
seem to matter much because of its small size, and 'popularity', which tends 
to keep it in cache.

Because Ext2 packs multiple entries onto a single inode table block, the 
major effect is not due to lack of readahead but to partially processed inode 
table blocks being evicted.  The easiest thing to do is keep everything 
compact, which it is (dirent: 8 bytes + name, inode: 128 bytes, index: 8 
bytes per ~250 entries).  The next easiest thing is to fix the icache, which 
seems to impose an arbitrary limit regardless of the actual amount of memory 
available.  Beyond that, I have some fancier strategies in mind for making 
processing order correspond better to inode table order by tweaking inode 
allocation policy.  I'll have more to say about that later.  Finally, disk 
cache effects don't show up with HTree until we get into millions of files, 
and even then performance degrades gently, with a worst case that is still 
entirely acceptable.

With ReiserFS we see slowdown due to random access even with small 
directories.  I don't think this is a cache effect.

--
Daniel
