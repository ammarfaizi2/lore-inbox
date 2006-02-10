Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWBJVK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWBJVK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBJVK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:10:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932201AbWBJVK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:10:57 -0500
Date: Fri, 10 Feb 2006 13:10:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECF182.9020505@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org> <43ECC13F.5080109@yahoo.com.au>
 <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org> <43ECCF68.3010605@yahoo.com.au>
 <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org> <43ECDD9B.7090709@yahoo.com.au>
 <Pine.LNX.4.64.0602101056130.19172@g5.osdl! .org> <43ECF182.9020505@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
> The way I see it, it stems from simply a different expectation of
> MS_ASYNC semantics, rather than exactly what the app is doing.
> 
> If there are no data integrity requirements, then the writing should
> be left up to the VM. If there are, then there will be a MS_SYNC,
> which *will* move those hundred megs to the IO layer so there is no
> reason for MS_ASYNC *not* to get it started earlier (and it will
> be more efficient if it does).

Yes, largely. 

> The semantics your app wants, in my interpretation, are provided
> by MS_INVALIDATE. Which kind of says "bring mmap data into coherence
> with system cache", which would presumably transfer dirty bits if
> modified (though as an implementation detail, we are never actually
> incoherent as far as the data goes, only dirty bits).

This historical meaning as far as I can tell, for MS_INVALIDATE really 
_forgets_ the old mmap'ped contents in a non-coherent system.

Quoting from a UNIX man-page (as found by google):

	...

     If flags is MS_INVALIDATE,  the  function  synchronizes  the
     contents  of  the  memory  region  to match the current file
     contents.

        o  All writes to the mapped  portion  of  the  file  made
           prior  to  the  call  are  visible  by subsequent read
           references to the mapped memory region.

        o  All write references prior to the call,  by  any  pro-
           cess,  to memory regions mapped to the same portion of
           the file using MAP_SHARED, are visible by read  refer-
           ences to the region.

	...

now, it's confusing, but I read that as meaning that the mmap'ed region is 
literally thrown away, and that anybody who has done a "write()" call will 
have their recently written data show up. That's also what the naming 
("invalidate") suggests.

In a non-coherent system (and remember, that's what old UNIX was, when 
MS_INVALIDATE came to be), you -cannot- reasonably synchronize your caches 
any other way than by throwing away your own cached copy.

(Think non-coherent CPU caches in the old non-coherent NUMA machines that 
happily nobody makes any more - same exact deal. The cache ops are either 
"writeback" or "throw away" or a combination of the two.)

So I don't think MS_INVALIDATE has ever really meant what you say it 
means: it certainly hasn't meant it in Linux, and it cannot really have 
meant it in old UNIX either because the kind of op that you imply of a 
two-way coherency simply wasn't _possible_ in original unix..

Now, the "msync(0)" case _could_ very sanely mean "just synchronize with 
the page cache".

			Linus
