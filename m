Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284369AbRLHTRP>; Sat, 8 Dec 2001 14:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284373AbRLHTRF>; Sat, 8 Dec 2001 14:17:05 -0500
Received: from stine.vestdata.no ([195.204.68.10]:43223 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S284369AbRLHTQr>; Sat, 8 Dec 2001 14:16:47 -0500
Date: Sat, 8 Dec 2001 20:16:39 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, Nikita Danilov <god@namesys.com>,
        green@thebsh.namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Message-ID: <20011208201639.B12687@vestdata.no>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no> <E16CNHk-0000u4-00@starship.berlin> <20011207174726.B6640@vestdata.no> <3C112E20.2080105@namesys.com> <20011207235641.B18104@vestdata.no> <3C115BB6.5050402@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C115BB6.5050402@namesys.com>; from reiser@namesys.com on Sat, Dec 08, 2001 at 03:15:50AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 03:15:50AM +0300, Hans Reiser wrote:
> >>no, actually this is a problem for v3.  stat data are time of creation 
> >>ordered (very roughly speaking)
> >>and directory entries are hash ordered, meaning that ls -l suffers a 
> >>major performance penalty.
> >
> >Yes, just remember that file-body ordering also has the same problem.
> >(ref the "find . -type f | xargs cat > /dev/null" test wich I think
> >represent maildir performance pretty closely)
>
> So is this a deeply inherent drawback of offering readdir name orders 
> that differ hugely from time of creation order?

It should not be, if:
* If the cache was smart enough to detect that the user is reading all
  the files in a directory and started reading in files into memory
  ahead of time. It sounds ugly, so I don't know if I like it.
or
* file-bodies were ordered by hash as well.

> I suppose we could use objectids based on the  hash of the first 
> assigned filename plus a 60 bit global to the FS counter....
> 
> but it is too many bits I think.  I think that using substantially less 
> than the full hash of the name that is used for directory entry keys  
> doesn't work....  Comments welcome.  

The abould stort the file-bodies in optimal order in the three, but
block-allocation is a seperate issue, right? Even if block-allocation
would take objectids into account it would be nearly impossible to get
the optimal order of the file-bodies, because you don't know the number
of files and their sizes before allocating the blocks for the first
files. (unless you would move files around after they are allocated)

So, I think the _only_ way to get the optimal performance for a growing
directory is to do allocation and ordering by creating-time. 

That said, maybe trying to find algorithms that are order sub-sets of
the directories entries in optimal order rather than the whole directory
is perhaps more constructive? Or look at repackers or other utilities to
reorder data in batch instead?

So how is this done in ext2/3 with directory indexes, Daniel? Are there
any papers available, or would I have to decifer the source?



-- 
Ragnar Kjørstad
Big Storage
