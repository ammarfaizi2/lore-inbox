Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUENEt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUENEt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 00:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUENEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 00:49:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:37608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264101AbUENEtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 00:49:50 -0400
Date: Thu, 13 May 2004 21:49:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after
 journal commit
Message-Id: <20040513214922.24639ae3.akpm@osdl.org>
In-Reply-To: <20040514043743.GA22593@thunk.org>
References: <E1BOQmf-0005cP-4Q@thunk.org>
	<20040513195310.5725fa43.akpm@osdl.org>
	<20040514043743.GA22593@thunk.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:
>
> On Thu, May 13, 2004 at 07:53:10PM -0700, Andrew Morton wrote:
> > "Theodore Ts'o" <tytso@mit.edu> wrote:
> > >
> > > It is possible for block allocation to fail, even if there is space in
> > >  the filesystem, because all of the free blocks were recently deleted and
> > >  so could not be allocated until after the currently running transaction
> > >  is committed.   This can result in a very strange and surprising result
> > >  where a system call such as a mkdir() will fail even though there is
> > >  plenty of disk space apparently available.
> > 
> > I merged a little patch for this into post-2.6.6, but that only addresses
> > prepare_write().
> 
> Oh, sorry, I didn't see that patch.

Andreas's patch is a bit sneaky: it simply sets ->h_sync on the current
transaction then does journal_stop().  I think your patch can do the same
thing?

again:
	handle = ext3_journal_start(...);

	...

	if (err == -ENOSPC && ext3_should_retry_alloc(inode, handle, &retry)) {
		goto again;
	} else {
		err2 = ext3_journal_stop(handle);
		if (!err)
			err = err2;
	}
	return err;

Something like that.
