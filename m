Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTLaJNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTLaJNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:13:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58605 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263173AbTLaJNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:13:06 -0500
Date: Wed, 31 Dec 2003 14:48:28 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel McNeil <daniel@osdl.org>, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-ID: <20031231091828.GA4012@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3FCD4B66.8090905@us.ibm.com> <1070674185.1929.9.camel@ibm-c.pdx.osdl.net> <1070907814.707.2.camel@ibm-c.pdx.osdl.net> <1071190292.1937.13.camel@ibm-c.pdx.osdl.net> <1071624314.1826.12.camel@ibm-c.pdx.osdl.net> <20031216180319.6d9670e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216180319.6d9670e4.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 06:03:19PM -0800, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > I have found something else that might be causing the problem.
> > filemap_fdatawait() skips pages that are not marked PG_writeback.
> > However, when a page is going to be written, PG_dirty is cleared
> > before PG_writeback is set (while the PG_locked is set).  So it
> > looks like filemap_fdatawait() can see a page just before it is
> > going to be written and not wait for it.  Here is a patch that
> > makes filemap_fdatawait() wait for locked pages as well to make
> > sure it does not missed any pages.
> 
> This filemap_fdatawait() behaviour is as-designed.  That function is only
> responsible for waiting on I/O which was initiated prior to it being
> invoked.  Because it is designed for fsync(), fdatasync(), O_SYNC, msync(),
> sync(), etc.

Hmm, the filemap_fdatawrite - fdatawait combination as a whole is responsible
for waiting for writes initiated prior to it being invoked to get to disk, 
isn't it ? 

It seems like the case Daniel is thinking about is when 
a process has issued writes to the page cache, and then filemap_fdatawrite
is called, while these pages are being written back to disk parallely by 
another thread (not holding i_sem). The filemap_fdatawrite wouldn't see
pages that are in the process of being written out by the background
thread so it doesn't mark them for writeback. The following filemap_fdatawait 
would find these pages on the locked_pages list all right, but if its
unlucky enough to be in the window that Daniel mentions where PG_dirty 
is cleared but PG_writeback hasn't yet been set, then the page would
have move to the clean list without waiting for the actual writeout
to complete !

So if this is a valid race ... then this could mean that fsync et al 
may potentially return before all prior writes have actually been 
sync'ed. In practice, possibly the sync'ing of metadata ends up waiting 
for i/o that might be ordered later in the queue, and hence effectively 
sees the data i/o completed as well. 

> 
> Now, it could be that this behaviour is not appropriate for the O_DIRECT
> sync function - the result of your testing will be interesting.
> 
> 

The above reasoning applies not just to DIO but regular buffered i/o - fsync
kind of situations as well.

But since Daniel's tests failed even with the patch, maybe this isn't
the cause for the latest DIO exposures. Though that doesn't mean the race
doesn't exist.

I guess it would help to see what happens without the first (non i_sem 
protected) filemap_write_and_wait in DIO.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

