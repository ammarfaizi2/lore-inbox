Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTB0VNq>; Thu, 27 Feb 2003 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTB0VNq>; Thu, 27 Feb 2003 16:13:46 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:48836 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S266961AbTB0VNp>;
	Thu, 27 Feb 2003 16:13:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Date: Fri, 28 Feb 2003 05:12:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       chrisl@vmware.com
References: <11490000.1046367063@[10.10.2.4]> <20030227200425.253F03FE26@mx01.nexgo.de> <20030227140019.G1373@schatzie.adilger.int>
In-Reply-To: <20030227140019.G1373@schatzie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030227212403.D28DA3C7CB@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 February 2003 22:00, Andreas Dilger wrote:
> > 11 ms sounds like two seeks for each returned dirent, which sounds like a
> > bug.
>
> I think you are pretty dead on there.  The difference is that with
> unindexed entries, the directory entry and the inode are in the same order,
> while with indexed directories they are essentially in random order to each
> other.  That means that each directory lookup causes a seek to get the
> directory inode data instead of doing allocation order (which is sequential
> reads on disk).
>
> In the past both would have been slow equally, but the orlov allocator in
> 2.5 causes a number of directories to be created in the same group before
> moving on to the next group, so you have nice batches of sequential reads.

I think you're close to the truth there, but out-of-order inode table access 
would only introduce one seek per inode table block, and the cache should 
take care of the rest.  Martin's numbers suggest the cache isn't caching at 
all.

Martin, does iostat show enormously more reads for the Htree case?

Regards,

Daniel
