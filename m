Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWCPVEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWCPVEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCPVEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:04:34 -0500
Received: from thunk.org ([69.25.196.29]:25730 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751416AbWCPVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:04:33 -0500
Date: Thu, 16 Mar 2006 16:04:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060316210424.GD29275@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com,
	lkml <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, jack@suse.cz
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 10:22:40AM -0800, Badari Pulavarty wrote:
> > However, if what we are doing is overwriting our own data with more an
> > updated, more recent version of the data block, do we guarantee that
> > any ordering semantics apply?  For example, what if we write a data
> > block, and then follow it up with some kind of metadata update (say we
> > touch atime, or add an extended attribute).  Do we guarantee that if
> > the metadata update is committed, that the data block will have made
> > it to disk as well?  
> 
> I don't see how we do this today. Yes. Metadata updates are jounalled,
> but I don't see how current adding buffers through journal_dirty_data
> (bh) call can guarantee that these buffers get added to metadata-update
> transaction ?

Even though there aren't any updates to any metadata blocks that take
place between the journal_start() and journal_stop() calls, if
journal_dirty_data() is called (for example in ordered_writepage),
those buffers will be associated with the currently open transaction,
so they will be guaranteed to be written before the transaction is
allowed to commit.

Remember, journal_start and journal_stop do not delineate a full
ext3/jbd transaction, but rather an operation, where a large number of
operations are bundled together to form a transaction.  When you call
journal_start, and request a certain number of credits (number of
buffers that you maximally intend to dirty), that opens up an
operation.  If the operation turns out not to dirty any metadata
blocks at the time of journal_stop(), all of the credits that were
reserved by jouranl_start() are returned to the currently open
transaction.  However, any data blocks which are marked via
journal_dirty_data() are still going to be associated with the
currently open transaction, and they will still be forced out before
the transaction is allowed to commit.

Does that make sense?

						- Ted
