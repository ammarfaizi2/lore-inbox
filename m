Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTESSZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTESSZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:25:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51860 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262627AbTESSZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:25:23 -0400
Subject: Re: Race between vmtruncate and mapped areas?
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       linux-mm@kvack.org, mika.penttila@kolumbus.fi
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFFBD08E4B.5FDF2864-ON88256D2B.0063F36A-88256D2B.0063F5EE@us.ibm.com>
From: Paul McKenney <Paul.McKenney@us.ibm.com>
Date: Mon, 19 May 2003 11:11:50 -0700
X-MIMETrack: Serialize by Router on D03NM116/03/M/IBM(Release 6.0.1 [IBM]|May 6, 2003) at
 05/19/2003 12:38:01
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> On Sat, May 17, 2003 at 11:19:39AM -0700, Paul McKenney wrote:
> > > On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > > not sure why you need a callback, the lowlevel if needed can
serialize
> > > using the same locking in the address space that vmtruncate uses. I
> > > would wait a real case need before adding a callback.
> >
> > FYI, we verified that the revalidate callback could also do the same
> > job that the proposed nopagedone callback does -- permitting
filesystems
> > that provide their on vm_operations_struct to avoid the race between
> > page faults and invalidating a page from a mapped file.
>
> don't you need two callbacks to avoid the race? (really I mean, to call
> two times a callback, the callback can be also the same)

I do not believe so -- though we could well be talking about
different race conditions.  The one that I am worried about
is where a distributed filesystem has a page fault against an
mmap race against an invalidation request.  The thought is
that the DFS takes one of its locks in the nopage callback,
and then releases it in the revalidate callback.  The
invalidation request would use the same DFS lock, and would
therefore not be able to run between nopage and revalidate.
It would call something like invalidate_mmap_range(), which
in turn calls zap_page_range(), which acquires the
mm->page_table_lock.  Since do_no_page() does not release
mm->page_table_lock until after it fills in the PTE, I believe
things are covered.

So, is there another race that I am missing here?  ;-)

                                    Thanx, Paul

