Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUEONSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUEONSp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUEONSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 09:18:45 -0400
Received: from thunk.org ([140.239.227.29]:46788 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262438AbUEONSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 09:18:44 -0400
Date: Sat, 15 May 2004 09:18:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
Message-ID: <20040515131838.GA32497@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E1BOQmf-0005cP-4Q@thunk.org> <20040513195310.5725fa43.akpm@osdl.org> <20040514043743.GA22593@thunk.org> <20040513214922.24639ae3.akpm@osdl.org> <20040514174837.GF18086@schnapps.adilger.int> <20040514195920.GB30501@thunk.org> <20040514210622.GH18086@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514210622.GH18086@schnapps.adilger.int>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:06:22PM -0600, Andreas Dilger wrote:
> > I tried that first, actually.  In the test case I was trying, it only
> > worked 33% of the time.  The other 66% of the time, the rm -rf all fit
> > into the current running transaction, and waiting on the previous
> > transaction wasn't sufficient to solve the problem.
> 
> I guess the success ratio dependends on how many blocks are tied up in
> the transaction, the size of the journal, and how much free space is
> left in the filesystem.  In my tests (dd to a file that does O_TRUNC and
> overwrites with the same file size) this change wasn't 100% successful
> but fixed it the majority of the time.

In my case, the filesystem was completely full, and we were doing an
"rm -rf /mntpt/*", followed by a series of mkdir to set up the test
directories.  We were failing on the mkdir approximately 2/3'rds of
the time.  

> > That was why I was retrying at the top-level functions: ext3_mkdir,
> > for example.  There won't be a nested journal transaction there.
> 
> Waiting for the currently committing transaction to complete would
> deadlock Lustre, because it starts journal transactions above ext3 so
> that it can write update records in the same transaction as the
> filesystem operation.

Right, I had forgotten about Lustre.  :-) I was only worrying about
the nested transaction case of writing to the quota file.  So what we
can do is only do the do the log_wait_commit (and retry the
transaction) if current->journal_info is NULL --- i.e., only when the
current process does not have a currently active handle.  If not, we
return -ENOSPC, and let the top-level caller (Lustre in your case)
retry the entire operation.

I think that should be sufficient to keep Lustre happy.

						- Ted
