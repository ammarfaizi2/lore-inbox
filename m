Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266125AbTLaGEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbTLaGEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:04:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57222 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266125AbTLaGEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:04:31 -0500
Date: Wed, 31 Dec 2003 11:39:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Janet Morgan <janetmor@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH linux-2.6.0-test10-mm1] dio-read-race-fix
Message-ID: <20031231060956.GB3285@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3FCD4B66.8090905@us.ibm.com> <1070674185.1929.9.camel@ibm-c.pdx.osdl.net> <1070907814.707.2.camel@ibm-c.pdx.osdl.net> <1071190292.1937.13.camel@ibm-c.pdx.osdl.net> <20031230045334.GA3484@in.ibm.com> <1072830557.712.49.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072830557.712.49.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 04:29:17PM -0800, Daniel McNeil wrote:
> On Mon, 2003-12-29 at 20:53, Suparna Bhattacharya wrote:
> > On Thu, Dec 11, 2003 at 04:51:33PM -0800, Daniel McNeil wrote:
> > > I've done more testing with added debug code.
> > > 
> > > It looks like the filemap_write_and_wait() call is returning
> > > with data that has not made it disk.
> > > 
> > > I added code to filemap_write_and_wait() to check if
> > > mapping->dirty_pages is not empty after calling filemap_fdatawrite()
> > > and filemap_fdatawait() and retry.  Even with the retry, the test still
> > > sees uninitialized data when running tests overnight (I added a printk
> > > so I know the retry is happening).  There are pages left on the
> > > dirty_pages list even after the write and wait.   
> > 
> > There are two calls to filemap_write_and_wait() for a DIO read
> > -- do you know in which if these cases you see dirty pages after
> > the write and wait ? The first is called without i_sem protection,
> > so it is possible for pages to be dirtied by a parallel buffered
> > write which is OK because this is just an extra/superfluous call 
> > when it comes to DIO reads. The second call, however happens with i_sem 
> > held and is used to guarantee that there are no exposures, so if 
> > you are seeing remant dirty pages in this case it would be something 
> > to worry about.
> > 
> 
> Yes there are two calls.  I'm assuming that the retry was caused by the
> call w/o holding the i_sem, since pages can be dirtied in parallel.
> 
> My debug output shows every filemap_write_and_wait() and which pages are
> on the dirty, io, and locked list and which pages are on the clean list
> after the wait. (yes, this is lots of output)
> 
> I changed the test a little bit -- if the test sees non-zero data, it
> opens a new file descriptor and re-reads the data without O_DIRECT and
> also re-reads the 1st page of the non-zero data using O_DIRECT.
> 
> What the debug output shows is:
> 
> The 1st filemap_write_and_wait() writes out some data.
> 
> The 2nd filemap_write_and_wait() sees different dirty pages.  The pages
>   that are seen non-zero by the test (many pages -- 243 in one case) are
>   on the dirty_pages list before the write and on the clean_pages list
>   after the wait.  But some of the pages at the end of the clean list,
>   are seen by the test program as non-zero.
> 
> Since I added the DIO re-read, the debug output shows for the 2nd
>   re-read:
> 
> the 1st filemap_write_and_wait() with NO dirty pages
> the 2nd filemap_write_and_wait() with dirty pages AFTER the pages
>   that mis-matched and the original plus these pages on the clean
>   list after the wait.
> 
> The 2nd re-read and the read without O_DIRECT both get zeroed data.
> 
> Conclusions:
> ===========
> 
> I'm not sure. :(
> 
> It appears like the pages are put on the clean list and PG_writeback is
> cleared while the i/o is in flight and the DIO reads are put on the
> queue ahead of the writeback.
> 
> I am trying to figure out how to add more debug code to prove this
> or figure out what else is going on.
> 
> I'm open to suggestions.

Since the first filemap_write_and_wait call is redundant and somewhat
suspect since its called w/o i_sem (I can think of unexpected side effects
on parallel filemap_write_and_wait calls), have you thought of disabling that
and then trying to see if you can still recreate the problem ? It may
not make a difference, but it seems like the right thing to do and could
at least simplify some of the debugging.

Regards
Suparna

> 
> Daniel
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

