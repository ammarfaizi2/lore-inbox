Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEFPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEFPWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEFPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 11:22:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13525 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261205AbVEFPW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 11:22:29 -0400
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Cliff White <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
In-Reply-To: <20050506101434.GC25677@atrey.karlin.mff.cuni.cz>
References: <20050421152345.6b87aeae@es175>
	 <20050503144325.GF4501@atrey.karlin.mff.cuni.cz>
	 <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com>
	 <E1DTMKq-00043x-BO@es175>
	 <1115315827.26913.907.camel@dyn318077bld.beaverton.ibm.com>
	 <20050506101434.GC25677@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1115392011.26913.930.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2005 08:06:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 03:14, Jan Kara wrote:
>   Hello Badari!
> 
> > I have an extremely simple patch to fix the problem.
> > Basically, move the journal_start_handle from writepages()
> > to ext3_writepages_get_block() (which gets called after locking
> > the page). What am I missing here ? The patch can't
> > be that simple :(
>   Umm. I think this change does not help much - you solve the problem
> for the first page but then you unlock that page and you'd like to lock
> the next one and you're again in trouble (trying to acquire PageLock
> wile holding transaction open).
>   I can see three solutions of the problem:
> Either do ext3_journal_start/stop for each page - you should be actually
> getting the handle of the same transaction until the transaction gets
> filled. But still you'll have some overhead of the calls in JBD. I
> actually don't see much difference to the approach we used before your
> patch but probably there's some.

I will patch it and find out if it buys anything. I am not hopeful
either.

>   Or rewrite __mpage_writepages() to lock a page range (e.g. lock pages
> until we find some on which we'd block) and then call some filesystem
> routine to write-out all the locked pages (which would start a
> transaction and so on). But this is more work.

We are re-writing mpage_writepages() anyway for supporting delayed
and multiblock allocation. So I will talk to Suparna and see if we
can do this also. But this requires more calls to figure out, if we
need block allocation and then start the transaction. (getblock(READ)
followed by getblock(WRITE) after starting transaction). Isn't it ?

>   Finally there's the theoretical ;) possibility to rewrite all the
> write-out code and change the lock ordering to journal->PageLock...
> 

Its beyond my capabilities :(

Thanks,
Badari

