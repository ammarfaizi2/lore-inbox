Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269673AbUICNBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269673AbUICNBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269663AbUICNBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:01:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:20116 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269681AbUICNAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:00:01 -0400
Subject: Re: EXT3: problem with copy_from_user inside a transaction
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040903123541.GB8557@x30.random>
References: <20040903150521.B1834@castle.nmd.msu.ru>
	 <20040903123541.GB8557@x30.random>
Content-Type: text/plain
Message-Id: <1094213179.16078.19.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 08:06:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 08:35, Andrea Arcangeli wrote:
> On Fri, Sep 03, 2004 at 03:05:21PM +0400, Andrey Savochkin wrote:
> > Hi Andrew,
> > 
> > filemap_copy_from_user() between prepare_write() and commit_write()
> > appears to be a problem for ext3.
> > 
And reiserv3, and maybe the other journaled filesystems.

> yes, Chris is working on it for a few months.
> 
Working is a generous term, I've somewhat been waiting for a better
solution to pop into my head.  In the end, I think all we can do is not
allow filesystems to take locks (or implicit locks like starting a
transaction) inside the prepare_write call.

This would mean that all the work is done during the commit_write
stage.  The trick is that we would have to handle -ENOSPC since we might
not know we've run out of room until after the data has been copied from
userland.

prepare_write could reserve blocks, which brings us half way to a
generic delayed allocation layer.  But for a quick and dirty start,
doing it all in commit_write should work.

-chris


