Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUIDOdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUIDOdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUIDOdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 10:33:36 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:11270 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S261239AbUIDOdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 10:33:35 -0400
Message-ID: <20040904183333.A26720@castle.nmd.msu.ru>
Date: Sat, 4 Sep 2004 18:33:33 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: EXT3: problem with copy_from_user inside a transaction
References: <20040903150521.B1834@castle.nmd.msu.ru> <20040903123541.GB8557@x30.random> <1094213179.16078.19.camel@watt.suse.com> <20040903175728.C1834@castle.nmd.msu.ru> <1094284064.6301.25.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <1094284064.6301.25.camel@watt.suse.com>; from "Chris Mason" on Sat, Sep 04, 2004 at 03:47:44AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 03:47:44AM -0400, Chris Mason wrote:
> On Fri, 2004-09-03 at 09:57, Andrey Savochkin wrote:
> 
> > > This would mean that all the work is done during the commit_write
> > > stage.  The trick is that we would have to handle -ENOSPC since we might
> > > not know we've run out of room until after the data has been copied from
> > > userland.
> > 
> > What is the problem -ENOSPC?
> > Do you think about the problem of the page existing before this write, it's
> > content overwritten, but the filesystem being unable to commit that write
> > because it needs more space?
> 
> Exactly.  In this case, we've effectively corrupted the page cache. 
> We've copied data in that isn't (and never will be) reflected on disk. 
> It isn't a horribly difficult case, we just need to overwrite the data
> with zeros, making sure to only overwrite the data corresponding to the
> -ENOSPC error.

Zeroing not mapped buffers in case of error is not difficult, indeed.

I was speaking about the following case:
 - one page of a file is dirtied through a userspace mapping,
 - the page doesn't have disk mapping yet (a hole),
 - someone issues write() to this page,
 - the space allocation fails in commit_write(), when the page content has
   already been overwritten with the new data.

Any holes in this scenario? :)

How to handle -ENOSPC in this case?

	Andrey
