Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292917AbSCDVf2>; Mon, 4 Mar 2002 16:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSCDVfT>; Mon, 4 Mar 2002 16:35:19 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:3460 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292914AbSCDVfO>; Mon, 4 Mar 2002 16:35:14 -0500
Date: Mon, 4 Mar 2002 21:34:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304213446.N1444@redhat.com>
In-Reply-To: <mason@suse.com> <200203041811.g24IBRQ09280@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203041811.g24IBRQ09280@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Mar 04, 2002 at 12:11:27PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 12:11:27PM -0600, James Bottomley wrote:

> The way I've seen a database do this is to set up the actions 
> as linked threads which are run as part of the completion routine of the 
> previous thread.  Thus, you don't need to wait for the update to complete, you 
> just kick off the transaction.   You are prevented from stepping on your own 
> transaction because if you want to alter the same row again you have to wait 
> for the row lock to be released.  The row locks are the "barriers" in this 
> case, but they preserve the concept of transaction independence.

Right, but in the database world we are usually doing synchronous
transactions, so allowing the writeback to be done in parallel is
important; and typically there's a combination of undo and redo
logging, so there is a much more relaxed ordering requirement on the
main data writes.

In filesystems it's much more common just to use redo logging, so we
can't do any file writes before the journal commit; and the IO is
usually done as writeback after the application's syscall has
finished.

Linux already has such fine-grained locking for the actual completion
of the filesystem operations, and in the journaling case,
coarse-grained writeback is usually done because it's far more
efficient to be able to batch up a bunch of updates into a single
transaction in the redo log.

There are some exceptions.  GFS, for example, takes care to maintain
transactional fine grainedness even for writeback, because in a
distributed filesystem you have to be able to release pinned metadata
back to another node on demand as quickly as possible, and you don't
want to force huge compound transactions out to disk when doing so.

Cheers,
 Stephen
