Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVCHJc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVCHJc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVCHJc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:32:26 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47279 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261925AbVCHJcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:32:22 -0500
Date: Tue, 8 Mar 2005 15:11:59 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sebastien.dugue@bull.net, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com, daniel@osdl.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-ID: <20050308094159.GA4144@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1110189607.11938.14.camel@frecb000686> <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com> <20050308011814.706c094e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308011814.706c094e.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 01:18:14AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > ...
> > 
> > Bugs in this area seem never-ending don't they - plug one, open up
> > another - hard to be confident/verify :( - someday we'll have to
> > rewrite a part of this code.
> 
> It's solving a complex problem.  Any rewrite would probably end up just as
> hairy once all the new bugs and corner cases are fixed.  Maybe.
> 
> 
> > Hmm, shouldn't dio->result ideally have been adjusted to be within
> > i_size at the time of io submission, so we don't have to deal with
> > this during completion ? We are creating bios with the right size
> > after all. 
> > 
> > We have this: 
> > 		if (!buffer_mapped(map_bh)) {
> > 				....
> > 				if (dio->block_in_file >=
> >                                         i_size_read(dio->inode)>>blkbits) {
> >                                         /* We hit eof */
> >                                         page_cache_release(page);
> >                                         goto out;
> >                                 }
> > 
> > and
> > 		dio->result += iov[seg].iov_len -
> >                         ((dio->final_block_in_request - dio->block_in_file) <<
> >                                         blkbits);
> > 
> > 
> > can you spot what is going wrong here that we have to try and
> > workaround this later ?
> 
> Good question.  Do we have the i_sem coverage to prevent a concurrent
> truncate?
> 
> But from Sebastien's description it doesn't soound as if a concurrent
> truncate is involved.

Daniel McNeil has a testcase that reproduces the problem - seemed
like a single thread thing - that's what puzzles me.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

