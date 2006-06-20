Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWFTPds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWFTPds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFTPds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:33:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19167 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751323AbWFTPdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:33:47 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <44980064.6040306@yahoo.com.au>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <4497EAC6.3050003@yahoo.com.au>
	 <1150807630.3856.1372.camel@quoit.chygwyn.com>
	 <44980064.6040306@yahoo.com.au>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 20 Jun 2006 16:40:52 +0100
Message-Id: <1150818052.3856.1399.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-06-21 at 00:04 +1000, Nick Piggin wrote:
> Thanks.
> 
> Steven Whitehouse wrote:
> >  kernel/printk.c                    |    1 
> >  mm/filemap.c                       |    1 
> >  mm/readahead.c                     |    1 
> 
> These EXPORTs are a bit unfortunate.
> 
> BTW. you have one function that calls file_ra_state_init but never appears
> to use the initialized ra_state.
Thanks for pointing that one out, see:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=0d42e54220ba34e031167138ef91cbd42d8b5876
for the patch to fix that.

> 
> Why is gfs2_internal_read() called the "external read function" in the
> changelog?
> 
Thats a typo/thinko I think. The title of the entry is still correct
though and should give a bit of a clue to that being wrong in the log.

> The internal_read function doesn't look like a great candidate for passing
> a ra_state to, which invokes all the mechanism expecting a regular file
> being accessed by a user program.
> 
> It seems as though you could explicitly control readahead more optimally,
> but I don't know what the best way to do that would be. I assume Andrew
> has had a quick look and doesn't know either.
> 
I'm not sure if he has looked at this specifically, I've not had any
other feedback suggesting that its a bad idea so far. It is used in
places where a regular file is being read, so it would appear to be the
"right thing" in those cases. At least it seems preferable to me than
the alternative of writing a special case readahead which I doubt would
be a great difference in performance.

> The part where you needed file_read_actor looks like pretty much a stright
> cut and paste from __generic_file_aio_read, which indicates that you might
> be exporting at the wrong level.
> 
Yes, and as the comment says:

/**
 * __gfs2_file_aio_read - The main GFS2 read function
 *
 * N.B. This is almost, but not quite the same as __generic_file_aio_read()
 * the important subtle different being that inode->i_size isn't valid
 * unless we are holding a lock, and we do this _only_ on the O_DIRECT
 * path since otherwise locking is done entirely at the page cache
 * layer.
 */

We have to know the i_size since we fall back to buffered I/O in case
the read is outside the current size of the inode, exactly as other
filesystems do. We only do this on the read path though since the write
path for direct I/O works slightly differently and is not a problem in
that case.

I'm certainly interested in any possible solutions to this, but at the
moment, I can't see any easy way around it. Suggestions are very welcome
of course.

> Not sure about the tty_ export. Would it be better to make a generic
> printfish interface on top of it and also replace the interesting dquot.c
> gymnastics? (I don't know)
> 
Possibly. Originally this code had its own copy of tty_write_message()
and it seemed a bit silly to duplicate this. I'm not sure though that we
really need a more generic interface - its only used for a single
function at the moment, and its crude but effective,

Steve.


