Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVA0J7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVA0J7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVA0J7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:59:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63465 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262537AbVA0J7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:59:20 -0500
Date: Thu, 27 Jan 2005 09:59:18 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Attila Body <compi@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: UDF madness
Message-ID: <20050127095918.GO8859@parcelfarce.linux.theplanet.co.uk>
References: <1106688285.5297.3.camel@smiley> <20050126201141.59c90e69.akpm@osdl.org> <20050127075749.GM8859@parcelfarce.linux.theplanet.co.uk> <1106818204.1955.18.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106818204.1955.18.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 09:30:04AM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, 2005-01-27 at 07:57, Al Viro wrote:
> 
> > 	Note that fs users of file_fsync() are definitely not going to be
> > involved into contention here - they need opened file => held active
> > reference to superblock.
> 
> > 	So we are left only with fs-internal asynchronous callers of
> > lock_super().  UDF, UFS, sysv, hpfs and ext2 are out of question - they
> > don't have async callers of that sort.  ext3... maybe, I'm not familiar
> > with resize code in there.  In any case, that'd better be fixed in
> > ext3 if such abuse exists.
> 
> ext3 resize is like file_fsync() --- it's an ioctl, so there's a
> guaranteed open file at that point.
> 
> But while the resize code originally used lock_super() to protect from
> races against allocation/deallocation, the ordering fixes in it means
> that that's all safe anyway now.  The lock_super() is currently only
> really used to guard against two threads doing resize at the same time,
> and if it's a problem, it would be trivial to use a different lock.

That's fine - it does make sense to move to separate lock, but in any
case we are safe against generic_shutdown_super().  And it means that
at least there (which is the source of UDF problems) lock_super() can die.
