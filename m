Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWCPSVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWCPSVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCPSVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:21:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:32727 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932703AbWCPSVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:21:01 -0500
Subject: Re: ext3_ordered_writepage() questions
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, jack@suse.cz
In-Reply-To: <20060316180904.GA29275@thunk.org>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
	 <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 10:22:40 -0800
Message-Id: <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 13:09 -0500, Theodore Ts'o wrote:
> > >Yup.  Ordered-mode JBD commit needs to write and wait upon all dirty
> > >file-data buffers prior to journalling the metadata.  If we didn't run
> > >journal_dirty_data_fn() against those buffers then they'd still be under
> > >I/O after commit had completed.
> > >
> > In  non-block allocation case, what metadata are we journaling in 
> > writepage() ?
> > block allocation happend in prepare_write() and commit_write() journaled the
> > transaction. All the meta data updates should be done there.  What JBD 
> > commit are you refering to here ?
> 
> Basically, this boils down to what is our definition of ordered-mode?
> 
> If the goal is to make sure we avoid the security exposure of
> allocating a block and then crashing before we write the data block,
> potentially exposing previously written data that might be belong to
> another user, then what Badari is suggesting would avoid this
> particular problem.

Yes, if the block allocation is needed, my patch is basically
no-op, we go through regular code.

> However, if what we are doing is overwriting our own data with more an
> updated, more recent version of the data block, do we guarantee that
> any ordering semantics apply?  For example, what if we write a data
> block, and then follow it up with some kind of metadata update (say we
> touch atime, or add an extended attribute).  Do we guarantee that if
> the metadata update is committed, that the data block will have made
> it to disk as well?  

I don't see how we do this today. Yes. Metadata updates are jounalled,
but I don't see how current adding buffers through journal_dirty_data
(bh) call can guarantee that these buffers get added to metadata-update
transaction ?


> Today that is the way things work, but is that
> guarantee part of the contract of ordered-mode?



BTW, thanks Ted for putting this in human-readable terms :)

Thanks,
Badari

						

