Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269839AbUIDIlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269839AbUIDIlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUIDIlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:41:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:25302 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269839AbUIDIlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:41:23 -0400
Subject: Re: EXT3: problem with copy_from_user inside a transaction
From: Chris Mason <mason@suse.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040903175728.C1834@castle.nmd.msu.ru>
References: <20040903150521.B1834@castle.nmd.msu.ru>
	 <20040903123541.GB8557@x30.random>
	 <1094213179.16078.19.camel@watt.suse.com>
	 <20040903175728.C1834@castle.nmd.msu.ru>
Content-Type: text/plain
Message-Id: <1094284064.6301.25.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 03:47:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 09:57, Andrey Savochkin wrote:

> > This would mean that all the work is done during the commit_write
> > stage.  The trick is that we would have to handle -ENOSPC since we might
> > not know we've run out of room until after the data has been copied from
> > userland.
> 
> What is the problem -ENOSPC?
> Do you think about the problem of the page existing before this write, it's
> content overwritten, but the filesystem being unable to commit that write
> because it needs more space?

Exactly.  In this case, we've effectively corrupted the page cache. 
We've copied data in that isn't (and never will be) reflected on disk. 
It isn't a horribly difficult case, we just need to overwrite the data
with zeros, making sure to only overwrite the data corresponding to the
-ENOSPC error.

-chris


