Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWJXPrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWJXPrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWJXPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:47:41 -0400
Received: from mail.alkar.net ([195.248.191.95]:13518 "EHLO mail.alkar.net")
	by vger.kernel.org with ESMTP id S965161AbWJXPrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:47:40 -0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] commit_write less than prepared by prepare_write
Date: Tue, 24 Oct 2006 19:46:51 +0400
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com, linux-fsdevel@vger.kernel.org,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com, bjornw@axis.com,
       chris.mason@oracle.com
References: <20061022084020.GA23506@wotan.suse.de>
In-Reply-To: <20061022084020.GA23506@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610241946.52337.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Sunday 22 October 2006 12:40, Nick Piggin wrote:
> This is a request for comments and review by filesystem maintainers.
> Especially if you own GFS2, OCFS2, Reiserfs, JFFS! Those using fs/buffer.c
> routines directly should be reasonably safe.
> 
> We have several long standing deadlocks in the core MM when doing
> buffered writes. The full explanation is in 2.6.19-rc2-mm2 in the
> patch mm-fix-pagecache-write-deadlocks.patch and there are some followup
> fixes.
> 
> Basically: when copying the pages from user supplied address to pagecache,
> between prepare_write and commit_write, we can take a fault on the
> copy_from_user and enter the pagefault handler holding the page lock.
> 
> There is no way that this can work safely, so we must do atomic copies
> here, which will just return a short write in the case of a fault.
> 
> The protocol for handling short writes is as follows:
> 
> - If page uptodate, commit_write with the shorter length (potentially 0).
>   Move the counters forward and retry.
> 
> - If the page is not uptodate, we commit a zero length commit_write, at the
>   start offset given by the prepare_write being closed.
> 
> * Note that if we hit some other error condition, we may never run another
>   prepare_write or commit_write, so we can't rely on that.
> 
> For the case of an uptodate page, it may be somewhat safer to commit the
> full length that was prepared (we can always pretend that the uncopied
> part got dirtied; the retry can happily overwrite it). Comments? 

Retry can EFAULT, I guess. For example, if file mapped to user space gets truncated.

> I figure 
> that if we have to audit everything anyway, then keeping this wart would
> be silly.
> 
> For the non-uptodate page:
> We can't run a full length commit_write, because the data in the page is
> uninitialised. Can't zero out the uninitialised data, because that would
> lead to zeros temporarily appearing in the pagecache. Any other ways to
> fix it?
> 
> The problem with doing a short commit, as noted by Mark Fasheh, is that
> prepare_write might have allocated a disk mapping (eg. if we write over a
> hole), and if the commit fails and we unlock the page, then a read from
> the filesystem might think that is valid data.
> 
> Mark's idea is to loop through the page buffers and zero out the
> buffer_new ones when the caller detects a fault here. This should work
> because a hole is zeroes anyway, so we could mark the page uptodate and it
> would eventually get written back to initialise those blocks. But, is
> there any other filesystem specific state that would need to be fixed
> up? Do we need another filesystem call?
> 
> I would prefer that disk block allocation be performed at commit_write
> time. I realise that is probably a lot more rework, and there may be
> reasons why it can't be done?
> 
> Another alternative is to pre-read the page in prepare_write, which
> should always get us out of trouble. Could be a good option for
> simple filesystems. People who care about performance probably want to
> avoid this.
> 
> Any other ideas?
> 
> The regular buffered filesystems seem to be working OK. The bulk of the
> filesystems are in fs-prepare_write-fixes.patch, but it is a bit
> scattered at the moment. Applying the full -mm patch would be a good
> idea.
> 
> The conversion involves:
> * ensure we don't mark the page uptodate in prepare_write if it is not
>   (which is a bug anyway... I found a few of those).
> * ensure we don't mark a non uptodate page as uptodate if the commit
>   was short.
> 
> Filesystems that are non trivial are GFS2, OCFS2, Reiserfs, JFFS so
> I need maintainers to look at those.
> 
> For the "moronic filesystems that do not allow holes", the cont_ routines
> have already been using zero length prepare/commit for something else.
> OGAWA Hirofumi is thinking about this. Any comments?
> 
> Thanks,
> Nick
> 
> 
