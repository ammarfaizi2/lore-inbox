Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUIDUMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUIDUMM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 16:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUIDUML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 16:12:11 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:51210 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S266034AbUIDUMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 16:12:08 -0400
Message-ID: <20040905001206.A32505@castle.nmd.msu.ru>
Date: Sun, 5 Sep 2004 00:12:06 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Chris Mason <mason@suse.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: EXT3: problem with copy_from_user inside a transaction
References: <20040903150521.B1834@castle.nmd.msu.ru> <20040903123541.GB8557@x30.random> <1094213179.16078.19.camel@watt.suse.com> <20040903175728.C1834@castle.nmd.msu.ru> <1094284064.6301.25.camel@watt.suse.com> <20040904183333.A26720@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20040904183333.A26720@castle.nmd.msu.ru>; from "Andrey Savochkin" on Sat, Sep 04, 2004 at 06:33:33PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 06:33:33PM +0400, Andrey Savochkin wrote:
> On Sat, Sep 04, 2004 at 03:47:44AM -0400, Chris Mason wrote:
> > On Fri, 2004-09-03 at 09:57, Andrey Savochkin wrote:
> > > What is the problem -ENOSPC?
> > > Do you think about the problem of the page existing before this write, it's
> > > content overwritten, but the filesystem being unable to commit that write
> > > because it needs more space?
> > 
> > Exactly.  In this case, we've effectively corrupted the page cache. 
> > We've copied data in that isn't (and never will be) reflected on disk. 
> > It isn't a horribly difficult case, we just need to overwrite the data
> > with zeros, making sure to only overwrite the data corresponding to the
> > -ENOSPC error.
> 
> Zeroing not mapped buffers in case of error is not difficult, indeed.
> 
> I was speaking about the following case:
>  - one page of a file is dirtied through a userspace mapping,
>  - the page doesn't have disk mapping yet (a hole),
>  - someone issues write() to this page,
>  - the space allocation fails in commit_write(), when the page content has
>    already been overwritten with the new data.

After some thought, we can check if the page is not completely mapped to disk
and there is a possibility that it's referenced from pte's.
In this case we can "commit" the old content in prepare_write(), allocating
space and instantiating holes...

Any better ideas?

	Andrey
