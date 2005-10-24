Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVJXQJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJXQJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJXQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:09:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40927 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751123AbVJXQJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:09:33 -0400
Date: Mon, 24 Oct 2005 11:09:27 -0500
From: David Teigland <teigland@redhat.com>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] GFS: quotas
Message-ID: <20051024160927.GC3755@redhat.com>
References: <20051010171048.GK22483@redhat.com> <20051024121617.GM32605@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024121617.GM32605@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 02:16:17PM +0200, Jan Kara wrote:
> > Code that deals with quotas.
>   Is there some documentation how the GFS quotas are supposed to work?
> I've just briefly looked through the code and it seems they are quite
> similar to the current VFS ones. What are the differences (especially
> why don't you implement GFS quotas as just another format of VFS quotas)?

Hi, yes there is.  It's important for gfs to control when it updates the
quota file.  If every machine sharing the file system needed to read or
write the quota file on every operation, it would be a terrible
bottleneck.  Below is a summary of the current implementation that Ken
wrote and that I'll add to quota.c; let me know if this helps.

Thanks,
Dave

     Quota change tags are associated with each transaction that
allocates or deallocates space.  Those changes are accumulated locally
to each node (in a per-node file) and then are periodically synced to
the quota file.  This avoids the bottleneck of constantly touching the
quota file, but introduces fuzziness in the current usage value of IDs
that are being used on different nodes in the cluster simultaneously.
So, it is possible for a user on multiple nodes to overrun their
quota, but that overrun is controlable.  Since quota tags are part of
transactions, there is no need to a quota check program to be run on
node crashes or anything like that.

There are couple of knobs that let the administrator manage the quota
fuzziness.  "quota_quantum" sets the maximum time a quota change can
be sitting on one node before being synced to the quota file.  (The
default is 60 seconds.)  Another knob, "quota_scale" controls how
quickly the frequency of quota file syncs increases as the user moves
closer to their limit.  The more frequent the syncs, the more accurate
the quota enforcement, but that means that there is more contention
between the nodes for the quota file.  The default value is one.  This
sets the maximum theoretical quota overrun (with infinite node with
infinite bandwidth) to twice the user's limit.  (In practice, the
maximum overrun you see should be much less.)  A "quota_scale" number
greater than one makes quota syncs more frequent and reduces the
maximum overrun.  Numbers less than one (but greater than zero) make
quota syncs less frequent.  These two values can be changed with
gfs2_tool.

GFS quotas also use per-ID Lock Value Blocks (LVBs) to cache the
contents of the quota file, so it is not being constantly read.

