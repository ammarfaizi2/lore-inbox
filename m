Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUENT7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUENT7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUENT7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:59:25 -0400
Received: from thunk.org ([140.239.227.29]:14529 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262431AbUENT7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:59:23 -0400
Date: Fri, 14 May 2004 15:59:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
Message-ID: <20040514195920.GB30501@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E1BOQmf-0005cP-4Q@thunk.org> <20040513195310.5725fa43.akpm@osdl.org> <20040514043743.GA22593@thunk.org> <20040513214922.24639ae3.akpm@osdl.org> <20040514174837.GF18086@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514174837.GF18086@schnapps.adilger.int>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:48:37AM -0600, Andreas Dilger wrote:
> 
> Well, actually my patch just waited on the _previous_ transaction to commit
> (which can be done anywhere without retrying the operation) and then set
> h_sync on the _current_ transaction so that as soon as the current operations
> are completed it will also be committed and the blocks released.  One can't
> of course arbitrarily call journal_stop() or that breaks the transaction
> atomicity.
> 
> For 99.9% of cases this should be sufficient and doesn't involve changing
> the code everywhere - only in ext3_new_block().  

I tried that first, actually.  In the test case I was trying, it only
worked 33% of the time.  The other 66% of the time, the rm -rf all fit
into the current running transaction, and waiting on the previous
transaction wasn't sufficient to solve the problem.

> Also, Ted's approach of retrying the operations "outside" the
> transaction won't work if there are nested journal transactions
> being done - those will hold the transaction open so doing
> journal_stop/journal_start doesn't really accomplish anything.

That was why I was retrying at the top-level functions: ext3_mkdir,
for example.  There won't be a nested journal transaction there.  This
will be an issue for prepare_write(), though.  If we are in nested
transaction, we're going to have to wait for the currently committing
transaction, and hope for the best.  If that's not sufficient, we're
going to have return the ENOSPC failure.

						- Ted
