Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUC3RPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbUC3RPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:15:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:26518 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263769AbUC3RPB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:15:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>
Subject: Re: [RFC, PATCH] Reservation based ext3 preallocation
Date: Tue, 30 Mar 2004 09:07:33 -0800
User-Agent: KMail/1.4.1
Cc: tytso@mit.edu, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com
References: <200403190846.56955.pbadari@us.ibm.com> <1080636930.3548.4549.camel@localhost.localdomain> <20040330014523.6a368a69.akpm@osdl.org>
In-Reply-To: <20040330014523.6a368a69.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403300907.33995.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 March 2004 01:45 am, Andrew Morton wrote:

Andrew,

> - Using ext3_find_next_zero_bit(bitmap_bh->b_data in
>   alloc_new_reservation() is risky.  There are some circumstances when you
>   have a huge number of "free" blocks in ->b_data, but they are all unfree
>   in ->b_committed_data.  You could end up with astronomical search
>   complexity in there.  You should search both bitmaps to find a block
>   which really is allocatable.  Otherwise you'll have
>   ext3_try_to_allocate() failing 20,000 times in succession and much CPU
>   will be burnt.

Can you explain this a little more ?  What does b->data and b->commited_data 
represent ?  We are assuming that b->data will always be uptodate. 

May be we should use ext3_test_allocatable() also.
Mingming, what was the reason for using ext3_find_next_zero_bit() only ?
We had this discussion earlier, but I forgot :(

> - I suspect ext3_try_to_allocate_with_rsv() could be reorganised a bit to
>   reduce the goto spaghetti?

will do :)

>
> - Please provide a mount option which enables the feature, defaulting to
>   "off".

Sure.

>
> - Make sure that you have a many-small-file test.  Say, untar a kernel
>   tree onto a clean filesystem and make sure that reading all the files in
>   the tree is nice and fast.
>
>   This is to check that the reservation is being discarded appropriately
>   on file close, and that those small files are contiguous on-disk.  If we
>   accidentally leave gaps in between them the many-small-file bandwidth
>   takes a dive.

Hmm. Ted proposed that we should keep reservation after file close. 
We weren't sure about this either. Its on our TODO list.

>
> - There's a little program called `bmap' in
>   http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz which
>   can be used to dump out a file's block allocation map, to check
>   fragmentation.

Thanks. will use that. We are using debugfs for now. Do you have any tools
to dump out whats in journal ? I want to understand log format etc.. 
Just curious.

>
> Apart from that, looking good.  Where are the benchmarks? ;)

We are first concentrating on tiobench regression. We see clear
degrade with tiobench on ext3, since it creates lots of files in the
same directory. Once we are happy with tiobench, we go for others
kernel untars, rawiobench etc.

Thanks,
Badari

