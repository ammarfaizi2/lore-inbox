Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292370AbSBBUL3>; Sat, 2 Feb 2002 15:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292376AbSBBULT>; Sat, 2 Feb 2002 15:11:19 -0500
Received: from 216-42-72-147.ppp.netsville.net ([216.42.72.147]:30884 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292370AbSBBULJ>; Sat, 2 Feb 2002 15:11:09 -0500
Date: Sat, 02 Feb 2002 15:10:10 -0500
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wedgwood <cw@f00f.org>, Steve Lord <lord@sgi.com>,
        Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <242700000.1012680610@tiny>
In-Reply-To: <20020202205438.D3807@athlon.random>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, February 02, 2002 08:54:38 PM +0100 Andrea Arcangeli <andrea@suse.de> wrote:

>> Chris and I had initially decided to unpack the tails on file open
>> if O_DIRECT is used, but it seems cleaner to add a 
>> reiserfs_get_block_direct_io, and have it return -EINVAL if a read
>> went to a tail.  writes that happen to a tail will trigger tail
>> conversion.
> 
> This is a safe approch (no risk of corruption etc..). However to provide
> the same semantics of the other filesystems it would be even better if
> we could unpack the tail within reiserfs_get_block_direct_io rather than
> returning -EINVAL, but ok, most apps should work fine anyways (and as
> worse people can workaround the magic by remounting reiserfs with notail
> before writing the data that will need to be handled later via
> O_DIRECT).

In the normal case, O_DIRECT can't be done on a file with a tail. 

The way I read generic_file_direct_IO, O_DIRECT is only done in 
units that start block aligned, and continue for a block aligned 
length.  So, this can never include a packed file tail.  

We should only need to worry if i_size on the file is wrong, and allows a 
read/write to a block aligned chunk on a file with a tail, which should
only be legal in the expanding truncate case from older kernels.  The
-EINVAL return should only happen in this (very unlikely) case.

-chris

