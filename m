Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUHaG3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUHaG3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUHaG3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:29:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28665 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266753AbUHaG1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:27:32 -0400
Subject: Re: data loss in 2.6.9-rc1-mm1
From: Ram Pai <linuxram@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <413131A0.4070100@yahoo.com.au>
References: <Pine.LNX.4.44.0408281519300.4593-100000@localhost.localdomain>
	 <413131A0.4070100@yahoo.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1093933516.2424.55.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Aug 2004 23:25:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 18:30, Nick Piggin wrote:
> Hugh Dickins wrote:
> > On Sat, 28 Aug 2004, Nick Piggin wrote:
 ..snip..
> 
> But anyway, I think we agree my (our) version should cover that.
> 
> > 
> >>I agree. We'll leave it to someone else to decide, then ;)
> > 
> > 
> > I vote for Nick's patch.
> > 
> 
> OK - maybe that can go for a spin in the next -mm. Andrew did you
> get it?

So in case my vote counts, add my vote too :)  .


> 
> > I do have one reservation on do_generic_mapping_read,
> > common to all these versions, unrelated to the current issue.
> > 
> > I'm surprised to notice that you're careful to re-i_size_read
> > after readpage, but otherwise rely on the initial i_size_read.
> > We could go around this loop many many times, faulting user pages
> > in actor, rescheduling away: the old (e.g. 2.4 or 2.6.0) code was
> > deficient after readpage, but at least it reassessed i_size each
> > time around the loop.  I guess if the file is truncated meanwhile,
> > the common case would be for a find_get_page to fail, and then the
> > situation be corrected after readpage; perhaps it's more likely to
> > show up as read returning too little on a large file being steadily
> > appended.  Maybe you already ruled these cases out as not worth the
> > overhead of handling, but it does surprise me that the old code was
> > safer in this respect.
> > 
> 
> Yeah I guess it is a case of doing the minimum that is really
> needed.
> 
> Although considering page_cache_readahead call can do an i_size_read,
> it might be nicer to probably change the interface to have it passed down
> instead

We are experimenting some patches to see if sending the i_size parameter
to page_cache_readahead() can help or not. There are couple of
advantages in doing that. (1) Quick ramp-up to max-readahead pages for
sequential workload. (2) being able to read atleast the requested number
of pages in one shot instead of reading one page at a time in case the
readahead window gets closed.

But the biggest performance boost has been seen with large max-readahead
window sizes. Currently most of the underlying block devices default to
32 pages max-readahead  even though the underlying device can handle
much larger reads. We could extract much more sequential read
performance if the max-readahead was set to much higher values like 256
pages which most modern devices are capable off. The problem AFAICT is
that the block device layer defaults the max-readahead value for most
block devices to 32, without consulting the capability of the underlying
block device driver. 

RP


