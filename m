Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWCPSJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWCPSJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWCPSJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:09:11 -0500
Received: from thunk.org ([69.25.196.29]:8171 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932691AbWCPSJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:09:10 -0500
Date: Thu, 16 Mar 2006 13:09:04 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060316180904.GA29275@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jack@suse.cz
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4410CA25.2090400@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Yup.  Ordered-mode JBD commit needs to write and wait upon all dirty
> >file-data buffers prior to journalling the metadata.  If we didn't run
> >journal_dirty_data_fn() against those buffers then they'd still be under
> >I/O after commit had completed.
> >
> In  non-block allocation case, what metadata are we journaling in 
> writepage() ?
> block allocation happend in prepare_write() and commit_write() journaled the
> transaction. All the meta data updates should be done there.  What JBD 
> commit are you refering to here ?

Basically, this boils down to what is our definition of ordered-mode?

If the goal is to make sure we avoid the security exposure of
allocating a block and then crashing before we write the data block,
potentially exposing previously written data that might be belong to
another user, then what Badari is suggesting would avoid this
particular problem.

However, if what we are doing is overwriting our own data with more an
updated, more recent version of the data block, do we guarantee that
any ordering semantics apply?  For example, what if we write a data
block, and then follow it up with some kind of metadata update (say we
touch atime, or add an extended attribute).  Do we guarantee that if
the metadata update is committed, that the data block will have made
it to disk as well?  Today that is the way things work, but is that
guarantee part of the contract of ordered-mode?

						- Ted
