Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTHAOFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTHAOFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:05:54 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:17309 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270763AbTHAOFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:05:53 -0400
Subject: Re: [PATCH] [2.5] reiserfs: fix races between link and unlink on
	same file
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030801111027.GA1108@namesys.com>
References: <20030731144204.GP14081@namesys.com>
	 <20030731133708.04bcd0c9.akpm@osdl.org> <20030801111027.GA1108@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1059746739.5881.20.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 01 Aug 2003 10:05:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 07:10, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Jul 31, 2003 at 01:37:08PM -0700, Andrew Morton wrote:
> 
> > > This patch (originally by Chris Mason) fixes link/unlink races in reiserfs.
> > Could you describe the race a little more please?  Why is the VFS's hold of
> > i_sem on the parent directory not sufficient?
> 
> Well, we do not take i_sem on parent directory of source filename for sys_link, I think.
> So we might endup in sys_link() with inode that is already deleted/being deleted (and nlink==0).
> Actually, I naturally thought that only i_nlink check to be non zero at reiserfs_link time should be
> enough, but Chris is sure that we need entire patch, so may be he may add more comments to that.
> 

Yes, it's basically a problem of making sure reiserfs_link sees any
changes made by reiserfs_unlink and vice versa.  Toss in the BKL and a
few funcs that schedule and you get small windows where the object
you're linking to can have a inode->i_nlink of zero.

All of which is dealt with properly at the VFS level.  The trick in
reiserfs is that somebody needs to take care of removing the savelink
used to prevent lost files after a crash.  If we don't get the i_nlink
timing right, two different procs might try to remove the savelink, or
it might not get removed at all.

> BTW, looking at vfs_link, this patch (below the message) seems to be
> natural thing to do, is not it?
> 

Looks fine.

-chris


