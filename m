Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUI3Rtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUI3Rtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUI3Rtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:49:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:4305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269371AbUI3Rs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:48:59 -0400
Date: Thu, 30 Sep 2004 10:48:50 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Judith Lebzelter <judith@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: OSDL aio-stress results on latest kernels show buffered random
 read issue
In-Reply-To: <20040929204628.0ffdf10e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.33.0409300917290.4332-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Andrew Morton wrote:

> Judith Lebzelter <judith@osdl.org> wrote:
> >
> > Hello;
> >
> > I am running aio-stress on the most recent kernels and have
> > found that on linux-2.6.8, 2.6.9-rc2 and 2.6.9-rc2-mm4 the
> > performance of buffered random reads is poor compared to the
> > buffered random writes:
> >
> >                2.6.8      2.6.9-rc2     2.6.9-rc2-mm4
> >              --------------------------------------------
> > random write 35.66 MB/s   34.80 MB/s    29.89 MB/s
> > random read   7.69 MB/s    7.50 MB/s     7.68 MB/s
> >
> > ** 2CPU hosts with striped Megaraid. 1G RAM. 4G File.
> >
> >
> > This shows up on our 4CPU host as well. (striped AACRAID.4G
> > RAM. 8G File):
> >              2.6.9-rc2     2.6.9-rc2-mm4   2.6.9-rc2-mm1
> >              -------------------------------------------
> > random write 31.36 MB/s     18.92 MB/s      18.97 MB/s
> > random read  11.13 MB/s      9.74 MB/s      11.05 MB/s
> >
> >
> > There seems to be an issue with the reads.  Usually, reads
> > should be at least as fast as writes of the same type.
> >
> > Also, there seems to be a substantial drop-off in the performance
> > of AIO buffered-random writes in the mm kernels. (14% on 2CPU,
> > 40% on 4CPU)
> >
>
> Well one would expect writes to be much faster than reads because writes
> usually do not involve performing physical I/O, and when pagecache
> writeback finally happens it has vastly more data to work with and hence
> can schedule I/O more efficiently.
>
> Unless you are using O_SYNC or fsync(), in which case ignore the above.

It should be doing an fsync() between the write and read stages.  For all
other types of reads the performance is substantially better than the
writes.
                       2.6.9-rc2-mm4
Direct Random write:     11.17 MB/s
Direct Random read:      44.71 MB/s

>
> The regression within random write performance is unexpected.  Can you
> please provide a URL to the current version of the test tool, and a
> description of how you are invoking it?  What sort of I/O system, what
> filesystem, etc.

I am running aio-stress from Chris Mason;  you can get it from OSDL's
aio-stress test kit:
  bk clone bk://developer.osdl.org/stp-tests/aio-stress

This is how I call it (with only one file):
    aio-stress -o 2 -o 3 -s 4g -r 64k -l -L <files_name>

The 2 CPU host has MegaRAID, with 5 18G disks, striped.  The 4CPU has
Adaptec 2200S x2, with 5 18G disks, striped.

The filesystem is ext2.

>
> Thanks.
>

