Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWCPXnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWCPXnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWCPXnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:43:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:33669 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964897AbWCPXnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:43:41 -0500
Subject: Re: ext3_ordered_writepage() questions
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       sct@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060316220545.GB18753@atrey.karlin.mff.cuni.cz>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
	 <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316210424.GD29275@thunk.org>
	 <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316220545.GB18753@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 15:45:21 -0800
Message-Id: <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 23:05 +0100, Jan Kara wrote:
> > On Thu, 2006-03-16 at 16:04 -0500, Theodore Ts'o wrote:
> > > On Thu, Mar 16, 2006 at 10:22:40AM -0800, Badari Pulavarty wrote:
> > > > > However, if what we are doing is overwriting our own data with more an
> > > > > updated, more recent version of the data block, do we guarantee that
> > > > > any ordering semantics apply?  For example, what if we write a data
> > > > > block, and then follow it up with some kind of metadata update (say we
> > > > > touch atime, or add an extended attribute).  Do we guarantee that if
> > > > > the metadata update is committed, that the data block will have made
> > > > > it to disk as well?  
> > > > 
> > > > I don't see how we do this today. Yes. Metadata updates are jounalled,
> > > > but I don't see how current adding buffers through journal_dirty_data
> > > > (bh) call can guarantee that these buffers get added to metadata-update
> > > > transaction ?
> > > 
> > > Even though there aren't any updates to any metadata blocks that take
> > > place between the journal_start() and journal_stop() calls, if
> > > journal_dirty_data() is called (for example in ordered_writepage),
> > > those buffers will be associated with the currently open transaction,
> > > so they will be guaranteed to be written before the transaction is
> > > allowed to commit.
> > > 
> > > Remember, journal_start and journal_stop do not delineate a full
> > > ext3/jbd transaction, but rather an operation, where a large number of
> > > operations are bundled together to form a transaction.  When you call
> > > journal_start, and request a certain number of credits (number of
> > > buffers that you maximally intend to dirty), that opens up an
> > > operation.  If the operation turns out not to dirty any metadata
> > > blocks at the time of journal_stop(), all of the credits that were
> > > reserved by jouranl_start() are returned to the currently open
> > > transaction.  However, any data blocks which are marked via
> > > journal_dirty_data() are still going to be associated with the
> > > currently open transaction, and they will still be forced out before
> > > the transaction is allowed to commit.
> > > 
> > > Does that make sense?
> > 
> > Makes perfect sense, except that it doesn't match what I see through
> > "debugfs" - logdump :(
> > 
> > I wrote a testcase to re-write same blocks again & again - there is
> > absolutely nothing showed up in log. Which implied to me that, all 
> > the jorunal_dirty_data we did on all those buffers, did nothing -
> > since there is no current transaction. What am I missing ?
>   The data buffers are not journaled. The buffers are just attached to the
> transaction and when the transaction is committed, they are written
> directly to their final location. This ensures the ordering but no data
> goes via the log... I guess you should see empty transactions in the log
> which are eventually commited when they become too old.

Yep. I wasn't expecting to see buffers in the transaction/log. I was
expecting to see some "dummy" transaction - which these buffers are
attached to provide ordering. (even though we are not doing metadata
updates). In fact, I was expecting to see "ctime" update in the
transaction.

Thanks,
Badari

