Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRLGQsa>; Fri, 7 Dec 2001 11:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGQsR>; Fri, 7 Dec 2001 11:48:17 -0500
Received: from stine.vestdata.no ([195.204.68.10]:17052 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S283274AbRLGQrj>; Fri, 7 Dec 2001 11:47:39 -0500
Date: Fri, 7 Dec 2001 17:47:26 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011207174726.B6640@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no> <E16CNHk-0000u4-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16CNHk-0000u4-00@starship.berlin>; from phillips@bonn-fries.net on Fri, Dec 07, 2001 at 04:51:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 04:51:33PM +0100, Daniel Phillips wrote:
> I did try R5 in htree, and at least a dozen other hashes.  R5 was the worst 
> of the bunch, in terms of uniformity of distribution, and caused a measurable 
> slowdown in Htree performance.  (Not an order of magnitude, mind you, 
> something closer to 15%.)

That sounds reasonable.
 
> An alternative way of looking at this is, rather than R5 causing an order of 
> magnitude improvement for certain cases, something else is causing an order 
> of magnitude slowdown for common cases.  I'd suggest attempting to root that 
> out.

In the cases I've studied more closely (e.g. maildir cases) the problem
with reiserfs and e.g. the tea hash is that there is no common ordering
between directory entries, stat-data and file-data.

When new files are created in a directory, the file-data tend to be
allocated somewhere after the last allocated file in the directory. The
ordering of the directory-entry and the stat-data (hmm, both?) are
however dependent on the hash. So, with something like the tea hash the
new file will be inserted in the middle of the directory.


In addition to the random lookup type reads, there are three other common
scenarios for reading the files:

1 Reading them in the same order they were created
The cache will probably not be 100% effective on the
directory/stat-data, because it's beeing accessed in a random-like
order. Read-ahead for the file-data on the other hand will be effective.

2 Reading the files in filename-order
Some applications (say, ls -l) may do this, but I doubt it's a very
common accesspattern. Cache-hit for directory-data will be poor, and
cache-hit for file-data will be poor unless the files were created in
the same order. 

3 Reading the files in readdir() order.
This is what I think is the most common access-pattern. I would expect a
lot of programs (e.g. mail clients using maildir) to read the directory
and for every filename stat the file and read the data. This will be in
optimal order for directory-caching, but more importantly it will be
random-order like access for the file-data.

I think scenario nr 3 is the one that matters, and I think it is this
scenario that makes r5 faster than tea in real-life applications on
reiserfs. (allthough most numbers available are from benchmarks and not
real life applications).

The directory content is likely to all fit in cache even for a fairly
large directory, so cache-misses are not that much of a problem. The
file-data itself however, will suffer if read-ahead can't start reading
the next file from disk while the first one is beeing processed.



I'm counting on Hans or someone else from the reiserfs team to correct
me if I'm wrong. 


-- 
Ragnar Kjørstad
Big Storage
