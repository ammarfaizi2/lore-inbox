Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbSJDRGR>; Fri, 4 Oct 2002 13:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSJDRGR>; Fri, 4 Oct 2002 13:06:17 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:44783 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262568AbSJDRGO>; Fri, 4 Oct 2002 13:06:14 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 4 Oct 2002 11:09:35 -0600
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021004170935.GX3000@clusterfs.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021004195315.A14062@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004195315.A14062@namesys.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2002  19:53 +0400, Oleg Drokin wrote:
> On Tue, Oct 01, 2002 at 02:43:30PM -0600, Andreas Dilger wrote:
> > As a result, if the size of the directory + inode table blocks is larger
> > than memory, and also larger than 1/4 of the journal, you are essentially
> > seek-bound because of random block dirtying.
> > You should see what the size of the directory is at its peak (probably
> > 16 bytes * 300k ~= 5MB, and add in the size of the directory blocks
> > (128 bytes * 300k ~= 38MB) and make the journal 4x as large as that,
> > so 192MB (mke2fs -j -J size=192) and re-run the test (I assume you have
> > at least 256MB+ of RAM on the test system).
> 
> Hm. But all of that won't help if you need to read inodes from disk first,
> right? (until that inode allocation in chunks implemented, of course).

Ah, but see the follow-up reply - increasing the size of the journal as
advised improved the htree performance to 15% and 55% faster than
reiserfs for creates and deletes, respectively:

On Wed, 2 Oct 2002 14:48:59 +0400 Paul P Komkoff Jr replied:
> Thanks for detailed explanation - it saved much time for me and
> accortind to yours directions I have recalculated my test. Now ext3 is
> better :)
> 
>                 real            user            cpu
> e3
> create          2m49.545s       0m4.162s        2m20.766s
> delete          2m8.155s        0m3.614s        1m34.945s
> 
> reiser
> create          3m13.577s       0m4.338s        2m54.026s
> delete          4m39.249s       0m3.968s        4m16.297s
> 
> e3
> create          2m50.766s       0m4.024s        2m21.197s
> delete          2m8.755s        0m3.501s        1m35.737s
> 
> reiser
> create          3m13.015s       0m4.432s        2m53.412s
> delete          4m41.011s       0m3.893s        4m16.845s


On Oct 04, 2002  19:53 +0400, Oleg Drokin wrote some more:
> BTW, in case of inode allocation in chunks attached to directory blocks,
> you won't get any benefit in case if application creates file in some
> tempoarry dir and then rename()s it to its proper place, or am I missing
> something?

No, you are correct.  Renaming the files will randomly re-hash the names
and break any coherency between the directory leaf blocks and the inode
blocks.  However, such files are often short-lived anyways (mail spools
and such), and for the normal case (e.g. untar of a file) the names are
constant, so there should be a benefit for smaller journals from this.

> > What is very interesting from the above results is that the CPU usage
> > is _much_ smaller for ext3+htree than for reiserfs.  It looks like
> 
> This is only in case of deletion, probably somehow related to constant item
> shifting when some of the items are deleted.

Well, even for creates it is 19% less CPU.  The re-tested wall-clock
time for htree creates is now less than the CPU usage of reiserfs, so
it is impossible for reiserfs to achieve this number without
optimization of the code somehow.  For deletes the cpu usage of htree
is 40% less, but we are currently not doing leaf block compaction, so
there would probably be a slight performance hit to merge blocks
(although we have some plans to do that efficiently also).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

