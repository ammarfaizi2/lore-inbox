Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266171AbUFIQEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUFIQEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUFIQEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:04:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:36525 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266171AbUFIQDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:03:39 -0400
Date: Wed, 9 Jun 2004 18:03:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steve Lord <lord@xfs.org>
Cc: nathans@sgi.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in xfs
Message-ID: <20040609160315.GA29531@wohnheim.fh-wedel.de>
References: <20040609122647.GF21168@wohnheim.fh-wedel.de> <40C72746.8060603@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C72746.8060603@xfs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 10:05:42 -0500, Steve Lord wrote:
> Jörn Engel wrote:
> >xfs is quite interesting.  No single function is particularly
> >stack-hungry, but the sheer depth of the call path adds up.  Nathan,
> >can you see if some bytes can be saved here and there?
> >
> >3k is not really bad yet, I just like to keep 1k of headroom for
> >surprises like an extra int foo[256] in a structure.
> 
> Are you doing some form of call chain analysis to arrive
> at this stack?

Yup.

> Actually this one is impossible, the function xfs_bmapi is
> confusing you analyser, it is used for read and write
> calls to map from file offsets to disk blocks. The path
> you chased down from xfs_bmapi is doing a realtime
> allocation, the swapext call does not do allocations,
> it is in this case looking up the contents of an acl
> for a permission check - xfs_bmapi in this case will
> not call much of anything.

Ack.  Clearly some sort of semantical checking would be nice to have,
but for the moment, we still need humans to do that job.  Thanks!

> Once it gets to schedule it is  a little out of XFS's hands what
> happens, or which stack is actually in use. I think the
> path you followed out of schedule is the cleanup of the
> audit structure of a dead process - it is the one doing
> the panicing here. An xfs call into schedule to wait for
> I/O will not be going down that path.

Yes, same problem.

> I think you have to be careful looking at these call chains.

For sure.  But since I scale extremely badly, I try to distribute this
work.  Thanks for taking a share.

There are a few more spots worth looking at, though.  I have no idea,
how often the loops below can iterate, so they may cause problems as
well.  If they are harmless as well, xfs is in a good state wrt stack
usage.  Nice.

WARNING: trivial recursion detected:
      44  xfs_attr_node_inactive
WARNING: trivial recursion detected:
      24  xfs_bmap_count_tree
WARNING: recursion detected:
      56  xfs_map_unwritten
      60  xfs_convert_page
WARNING: recursion detected:
       0  xfs_iaccess
      16  xfs_acl_iaccess
     104  xfs_attr_fetch

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
