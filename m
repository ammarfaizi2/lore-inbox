Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUFVObs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUFVObs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUFVO1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:27:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:9415 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264215AbUFVOSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:18:16 -0400
Subject: Re: deadlocks caused by ext3/reiser dirty_inode calls during
	do_mmap_pgoff
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040621171337.44d1b636.akpm@osdl.org>
References: <1087837153.1512.176.camel@watt.suse.com>
	 <20040621171337.44d1b636.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087913598.1512.264.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 10:13:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 20:13, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > do_mmap_pgoff is called with a write lock on mmap_sem, and can trigger
> > calls to generic_file_mmap, which calls file_accessed to update the
> > atime on the file.
> > 
> > For reiserfs, this might start a transaction, which might have to wait
> > for the currently running transaction to finish.  It looks like ext3 may
> > do the same thing, but I'm not 100% sure on that.
> > 
> > If the currently running transaction happens to by running
> > copy_from_user, like we do during write calls, it might be trying to get
> > a hold of a read lock on the mmap sem while trying to hand page faults.
> 
> heh, good luck writing a testcase.

Hmmm, reiserfs_file_write does fault_in_pages_readable after the
transaction is started.  I can at least make the window smaller for now
by moving that before the transaction is started.  The test case looks
like this, they haven't tried yet on ext3, only reiser3

1. in ltp, create runtest/vmmstress1:
mmstress mmstress
mmap1 mmap1
mmap2 mmap2
mmap3 mmap3
mallocstress mallocstress

create runtest/vmmstress2:
mtest01 mtest01 -p85 -w

create dovmmstress.sh:
sar -o /root/results/vmmstress.sar 300 0&
./runalltests.sh -f /home/plars/test/ltp/runtest/vmmstress2 -t72h -l
/root/results/vmmstress2.log -p -q > /root/results/vmmstress2.out&
./runalltests.sh -f /home/plars/test/ltp/runtest/vmmstress1 -t72h -l
/root/results/vmmstress1.log -p -q |tee /root/results/vmmstress1.out
killall -9 sar
killall -9 sadc

2. run dovmmstress.sh

> I think we can fix both problems by changing filemap_copy_from_user() and
> filemap_copy_from_user_iovec() to not fall back to kmap() - just fail the
> copy in some way if the atomic copy failed.  Then, in
> generic_file_aio_write_nolock(), do a zero-length ->commit_write(),
> put_page(), then go back and retry the whole thing, starting with
> fault_in_pages_readable().

Ugh, ok.  I'm going to start with the smaller reiser patch to move the
prefaulting earlier.

-chris


