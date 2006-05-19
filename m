Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWESUEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWESUEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWESUEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:04:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932191AbWESUEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:04:30 -0400
Date: Fri, 19 May 2006 13:07:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: cel@citi.umich.edu
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 5/6] nfs: check all iov segments for correct memory
 access rights
Message-Id: <20060519130712.01828395.akpm@osdl.org>
In-Reply-To: <446E1E4D.7050800@citi.umich.edu>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519112231.5ed3d565.akpm@osdl.org>
	<446E1E4D.7050800@citi.umich.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@citi.umich.edu> wrote:
>
> Andrew Morton wrote:
> >> +		if (unlikely(!access_ok(type, buf, len))) {
> >> +			retval = -EFAULT;
> >> +			goto out;
> >> +		}
> > 
> > Now what's up here?  Why does NFS, at this level, care about the page's
> > virtual address?  get_user_pages() will handle that?
> 
> I guess I'm not clear on what behavior is desired for scatter/gather if 
> one of the segments in an iov fails.
> 
> If one of the iov's will cause an EFAULT, how is that reported back to 
> the application,

If nothing has yet been transferred to/from userspace, return -EFAULT.

If something has been transferred, return the number of bytes transferred.

> and what happens to the I/O being requested in the 
> other segments of the vector?

The filesystem driver needs to handle it somehow.

>  When do we use an "all or nothing" 
> semantic, and when is it OK for some segments to fail?

Actually, fs/direct-io.c cheats and doesn't implement the correct
semantics.  It returns either all-bytes-transferred or -EFOO.  The way I
justify that is to point out that returning a partial transfer count
doesn't make a lot of sense when the I/Os could complete in any order -
yes, we know how much data got transferred, but we don't know whereabouts
in the user's memory that data ended up.  So the user cannot trust _any_ of
it.

NFS direct-io can do the same.

But access_ok() isn't sufficient.  All it tells you is that the virtual
address is a legal one for an application.  But we could still get EFAULT
when trying to access it.

