Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTJIMxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTJIMxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:53:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38100 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262128AbTJIMxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:53:53 -0400
Date: Thu, 9 Oct 2003 18:29:02 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
Message-ID: <20031009125902.GA11697@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031005013326.3c103538.akpm@osdl.org> <1065655095.1842.34.camel@ibm-c.pdx.osdl.net> <20031009111624.GA11549@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009111624.GA11549@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:46:24PM +0530, Suparna Bhattacharya wrote:
> On Wed, Oct 08, 2003 at 04:18:15PM -0700, Daniel McNeil wrote:
> > I'm been testing AIO on test6-mm4 using a ext3 file system and
> > copying a 88MB file to an already existing preallocated file of 88MB.
> > I been using my aiocp program to copy the file using i/o sizes of
> > 1k to 512k and outstanding aio requests of between 1 and 64 using
> > O_DIRECT, O_SYNC and O_DIRECT & O_SYNC.  Everything works as long
> > as the file is pre-allocated.  When copying the file to a new file
> > (O_CREAT|O_DIRECT), I get the following oops:
> 
> What are the i/o sizes and block sizes for which you get the oops ?
> Is this only for large i/o sizes ?
> 
> __aio_run_iocbs should have been called only for buffered i/o, 
> so this sounds like an O_DIRECT fallback to buffered i/o.
> Possibly after already submitting some blocks direct to BIO,
> the i/o completion path for which ends up calling aio_complete
> releasing the iocb. That could explain the use-after-free situation
> you see.
> 
> But, O_DIRECT write should fallback to buffered i/o only if it 
> encounters holes in the middle of the file, not for simple appends 
> as in your case. Need to figure out how this could have happened ...

Took a quick look at aiocp.c - wondering if its possible that
some of the later read requests complete earlier and trigger
a write to higher offset first. Resulting in the file being
extended with holes in between - holes which get overwritten
at a later point as the earlier read requests complete.

Though I don't yet see how a situation could arise in the 
single threaded case where part of the request gets submitted 
direct to BIO and the rest falls back to buffered-io ... Need 
to think about it a bit more. 
Are your writes all block aligned ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

