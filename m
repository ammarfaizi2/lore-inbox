Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282392AbRLIChX>; Sat, 8 Dec 2001 21:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282402AbRLIChO>; Sat, 8 Dec 2001 21:37:14 -0500
Received: from dsl-213-023-038-245.arcor-ip.net ([213.23.38.245]:58119 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282392AbRLIChE>;
	Sat, 8 Dec 2001 21:37:04 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Sun, 9 Dec 2001 03:39:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        Nikita Danilov <god@namesys.com>, green@thebsh.namesys.com
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C115BB6.5050402@namesys.com> <20011208201639.B12687@vestdata.no>
In-Reply-To: <20011208201639.B12687@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16Ctsb-00014D-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 8, 2001 08:16 pm, Ragnar Kjørstad wrote:
> On Sat, Dec 08, 2001 at 03:15:50AM +0300, Hans Reiser wrote:
> > >>no, actually this is a problem for v3.  stat data are time of creation 
> > >>ordered (very roughly speaking)
> > >>and directory entries are hash ordered, meaning that ls -l suffers a 
> > >>major performance penalty.
> > >
> > >Yes, just remember that file-body ordering also has the same problem.
> > >(ref the "find . -type f | xargs cat > /dev/null" test wich I think
> > >represent maildir performance pretty closely)
> >
> > So is this a deeply inherent drawback of offering readdir name orders 
> > that differ hugely from time of creation order?
> 
> It should not be, if:
> * If the cache was smart enough to detect that the user is reading all
>   the files in a directory and started reading in files into memory
>   ahead of time. It sounds ugly, so I don't know if I like it.
> or
> * file-bodies were ordered by hash as well.
> 
> > I suppose we could use objectids based on the  hash of the first 
> > assigned filename plus a 60 bit global to the FS counter....
> > 
> > but it is too many bits I think.  I think that using substantially less 
> > than the full hash of the name that is used for directory entry keys  
> > doesn't work....  Comments welcome.  
> 
> The abould stort the file-bodies in optimal order in the three, but
> block-allocation is a seperate issue, right? Even if block-allocation
> would take objectids into account it would be nearly impossible to get
> the optimal order of the file-bodies, because you don't know the number
> of files and their sizes before allocating the blocks for the first
> files. (unless you would move files around after they are allocated)
> 
> So, I think the _only_ way to get the optimal performance for a growing
> directory is to do allocation and ordering by creating-time. 
> 
> That said, maybe trying to find algorithms that are order sub-sets of
> the directories entries in optimal order rather than the whole directory
> is perhaps more constructive? Or look at repackers or other utilities to
> reorder data in batch instead?
> 
> So how is this done in ext2/3 with directory indexes, Daniel? Are there
> any papers available, or would I have to decifer the source?

You should find this useful:

   http://people.nl.linux.org/~phillips/htree/paper/htree.html
   http://people.nl.linux.org/~phillips/htree/htree.ps.gz

The coherency between inode order and file body order is handled for me 
in the existing Ext2 code base.  I haven't really dug into that algorithm but 
it seems to produce servicable results.  Note: Al Viro has taken a look at 
improving that code.  It's an ongoing project that's been discussed on lkml 
and ext2-devel.

As far as coherency between readdir order and inode order goes, I'v just 
left that dangling for the moment.  This doesn't hurt until we get over a 
million files/directory, and then it doesn't hurt an awful lot.  As I 
mentioned earlier, I think the increased table thrashing exhibited over the 
million file mark is more because of shortcomings in icache handling than 
anything else.

In the long run I plan to do some work on inode allocation targets to improve 
the correspondence between readdir order and inode order.

--
Daniel
