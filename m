Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbUC3Sh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUC3Sh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:37:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:64220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263808AbUC3ShZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:37:25 -0500
Date: Tue, 30 Mar 2004 10:36:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: cmm@us.ibm.com, tytso@mit.edu, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] Reservation based ext3 preallocation
Message-Id: <20040330103643.07c94296.akpm@osdl.org>
In-Reply-To: <200403300907.33995.pbadari@us.ibm.com>
References: <200403190846.56955.pbadari@us.ibm.com>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<200403300907.33995.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Tuesday 30 March 2004 01:45 am, Andrew Morton wrote:
> 
> Andrew,
> 
> > - Using ext3_find_next_zero_bit(bitmap_bh->b_data in
> >   alloc_new_reservation() is risky.  There are some circumstances when you
> >   have a huge number of "free" blocks in ->b_data, but they are all unfree
> >   in ->b_committed_data.  You could end up with astronomical search
> >   complexity in there.  You should search both bitmaps to find a block
> >   which really is allocatable.  Otherwise you'll have
> >   ext3_try_to_allocate() failing 20,000 times in succession and much CPU
> >   will be burnt.
> 
> Can you explain this a little more ?  What does b->data and b->commited_data 
> represent ?  We are assuming that b->data will always be uptodate. 

The comment Alex pointed to is splendid ;)

> May be we should use ext3_test_allocatable() also.

I think so.

> > - There's a little program called `bmap' in
> >   http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz which
> >   can be used to dump out a file's block allocation map, to check
> >   fragmentation.
> 
> Thanks. will use that. We are using debugfs for now. Do you have any tools
> to dump out whats in journal ? I want to understand log format etc.. 
> Just curious.

I cannot think of any.  It wouldn't surprise me if e2fsck had a debug mode
which printed out this info, but I have not looked.

> >
> > Apart from that, looking good.  Where are the benchmarks? ;)
> 
> We are first concentrating on tiobench regression. We see clear
> degrade with tiobench on ext3, since it creates lots of files in the
> same directory. Once we are happy with tiobench, we go for others
> kernel untars, rawiobench etc.

OK..  dbench on SMP hardware shows poor layout also.
