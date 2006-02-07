Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWBGBcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWBGBcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWBGBcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:32:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33217 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932173AbWBGBcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:32:14 -0500
Date: Tue, 7 Feb 2006 12:31:57 +1100
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-ID: <20060207013157.GU43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com> <20060205202733.48a02dbe.akpm@osdl.org> <20060206054815.GJ43335175@melbourne.sgi.com> <20060205222215.313f30a9.akpm@osdl.org> <20060206115500.GK43335175@melbourne.sgi.com> <20060206151435.731b786c.akpm@osdl.org> <20060207003410.GS43335175@melbourne.sgi.com> <20060206170411.360f3a97.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206170411.360f3a97.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 05:04:11PM -0800, Andrew Morton wrote:
> David Chinner <dgc@sgi.com> wrote:
> >
> > > So to fix both these problems we need to be smarter about terminating the
> > > wb_kupdate() loop.  Something like "loop until no expired inodes have been
> > > written".
> > > 
> > > Wildly untested patch:
> > 
> > Wildly untested assertion - it won't fix my case for the same reason I'm seeing
> > the current code not working - we abort higher up in writeback_inodes()
> > on the age check.
> 
> You mean that we're in the state
> 
> a) big-dirty-expired inode is on s_dirty
> 
> b) small-dirty-not-expired inode is on s_io
> 
> sync_sb_inodes() sees the small-dirty-not-expired inode on s_io and gives up?

Yes, that's right.

> In which case, yes, perhaps leaving big-dirty-expired inode on s_io is the
> right thing to do.  But should we be checking that it has expired before
> deciding to do this?

Well, we are writing it out because it has expired in the first place,
right? And it remains expired until we actually clean it, so I
don't see any need for a check such as this....

> We don't want to get in a situation where continuous
> overwriting of a large file causes other files on that fs to never be
> written out.

Agreed. That's why i proposed the s_more_io queue - it works on those inodes
that need more work only after all the other inodes have been written out.
That prevents starvation, and makes large inode flushes background work (i.e.
occur when there is nothing else to do). it will get much better disk
utilisation than the method I originally proposed, as well, because it'll keep
the disk near congestion levels until the data is written out...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
