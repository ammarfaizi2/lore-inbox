Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUENVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUENVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUENVG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:06:28 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:65175 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261786AbUENVG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:06:26 -0400
Date: Fri, 14 May 2004 15:06:22 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
Message-ID: <20040514210622.GH18086@schnapps.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E1BOQmf-0005cP-4Q@thunk.org> <20040513195310.5725fa43.akpm@osdl.org> <20040514043743.GA22593@thunk.org> <20040513214922.24639ae3.akpm@osdl.org> <20040514174837.GF18086@schnapps.adilger.int> <20040514195920.GB30501@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514195920.GB30501@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2004  15:59 -0400, Theodore Ts'o wrote:
> On Fri, May 14, 2004 at 11:48:37AM -0600, Andreas Dilger wrote:
> > Well, actually my patch just waited on the _previous_ transaction to commit
> > (which can be done anywhere without retrying the operation) and then set
> > h_sync on the _current_ transaction so that as soon as the current operations
> > are completed it will also be committed and the blocks released.  One can't
> > of course arbitrarily call journal_stop() or that breaks the transaction
> > atomicity.
> > 
> > For 99.9% of cases this should be sufficient and doesn't involve changing
> > the code everywhere - only in ext3_new_block().  
> 
> I tried that first, actually.  In the test case I was trying, it only
> worked 33% of the time.  The other 66% of the time, the rm -rf all fit
> into the current running transaction, and waiting on the previous
> transaction wasn't sufficient to solve the problem.

I guess the success ratio dependends on how many blocks are tied up in
the transaction, the size of the journal, and how much free space is
left in the filesystem.  In my tests (dd to a file that does O_TRUNC and
overwrites with the same file size) this change wasn't 100% successful
but fixed it the majority of the time.

> > Also, Ted's approach of retrying the operations "outside" the
> > transaction won't work if there are nested journal transactions
> > being done - those will hold the transaction open so doing
> > journal_stop/journal_start doesn't really accomplish anything.
> 
> That was why I was retrying at the top-level functions: ext3_mkdir,
> for example.  There won't be a nested journal transaction there.

Waiting for the currently committing transaction to complete would
deadlock Lustre, because it starts journal transactions above ext3 so
that it can write update records in the same transaction as the
filesystem operation.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

