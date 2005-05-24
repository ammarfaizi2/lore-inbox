Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVEXNeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVEXNeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVEXNcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:32:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63374 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261156AbVEXNWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:22:51 -0400
Date: Tue, 24 May 2005 19:02:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Carsten Otte <cotte@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
Message-ID: <20050524133211.GA4896@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42930B64.2060105@freenet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 01:09:24PM +0200, Carsten Otte wrote:
> Suparna Bhattacharya wrote:
> 
> >On Mon, May 23, 2005 at 07:30:20PM +0200, Carsten Otte wrote:
> >  
> >
> >>diff -ruN linux-git/mm/filemap.h linux-git-xip/mm/filemap.h
> >>--- linux-git/mm/filemap.h	1970-01-01 01:00:00.000000000 +0100
> >>+++ linux-git-xip/mm/filemap.h	2005-05-23 19:01:27.000000000 +0200
> >>@@ -0,0 +1,94 @@
> >>+/*
> >>+ *	linux/mm/filemap.c
> >>+ *
> >>    
> >>
> >
> >I guess you meant "filemap.h" not "filemap.c" ? Shouldn't this be
> >in include/linux instead ?
> >  
> >
> Yea, Andrew Morton fixed this one while merging into -mm. Cut&Paste - sorry
> 
> > OK, though this leaves filemap.c alone which is good, I have to admit
> >
> >that this entire duplication of read/write routines really worries me.
> >
> >There has to be a third way.
> >  
> >
> Well those carbon copied functions are -as Christoph pointed out- just
> wrappers. In addition,
> we don't have sync read/write, just aio_read/aio_write, readv/writev,
> and sendfile.
> We saved almost as much patches to filemap.c as we have added stuff to
> filemap_xip:
> cotte@cotte:~/patches$ cat v2/linux-2.6-xip-2-filemap.patch |wc -l
> 789
> cotte@cotte:~/patches$ cat v3/linux-2.6-xip-2-filemap.patch |wc -l
> 868
> Given that the copied wrappers add just 80 lines after all, I agree with
> Christoph that this is
> worth buying reduced complexity for.


The issue is not about the lines of code (though in my quick skim through I see
a duplication of at least 300 lines for read/write alone between filemap.c
and filemap_xip.c ... the total duplication is likely higher). It is
the concern of having one more area of code to change/fix if there are
modifications to these routines. If it is worth having generic code for
XIP, then I guess it should be worth doing it right ... 

BTW, your calculation between your previous patch and current one is a
reasonable argument for not reverting back to the earlier version, but
then that wasn't what I was suggesting. Hope that was clear. Not complicating
the common path in filemap.c with if (xip) branches is a good idea.

Right now you have chosen what is possibly the lesser of two evils,
but having had to end up modifying code in multiple places in read/write and
inadvertant bugs introduced thus in the past and paid for over time :( 
has made me quite wary of code duplication in this particular area, simple
as it seems.

I'll take a closer look and see if I can think of any other way to abstract
this better. Maybe the long term solution is what Christoph suggested
in terms of collapsing interfaces.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

