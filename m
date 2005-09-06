Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVIFP1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVIFP1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVIFP1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:27:55 -0400
Received: from fmr23.intel.com ([143.183.121.15]:20931 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750716AbVIFP1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:27:55 -0400
Date: Tue, 6 Sep 2005 07:50:36 -0400
From: Benjamin LaHaise <bcrl@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-ID: <20050906115036.GA4566@linux.intel.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <20050902135701.GA4470@linux.intel.com> <20050902135735.5862e97b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902135735.5862e97b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 01:57:35PM -0700, Andrew Morton wrote:
> Cons:
> 
> - Additional arguments to various fastpath functions

One possibility is to split the async and sync versions by way of inline 
functions.  That will result in more icache pressure, though, which makes 
it a questionable optimization.

> - Additional code size
> 
> - Additional code complexity

These are general concerns of all new features.  It is possible to split 
the code out into separate codepaths (the 2.4 async read/write paths were 
completely new), but that cuts down on code sharing between the traditional 
sync read/writes and async code.  If that is a requirement for merging, 
then they certainly could be split out and grown in a separate aio module, 
but that leads to other maintenence headches.

The flip side of this question is that we already have O_DIRECT and all of 
its associated overhead, yet the vast majority of systems don't use it in 
the course of day to day operation.  Maybe we should have config options 
for these things, but where does the line get drawn?

> - Significantly degrades collective understanding of how the VFS works.

That can be improved through the use of debugging options to teach people 
that aio_* functions should not block, which is the only real difference 
between async and non-async functions -- if you'd block, return -EIOCBRETRY 
instead.

> Pros:
> 
> - Unclear.

We already have a number of users demanding buffered filesystem aio -- the 
UML patches to use aio just went in.  Samba is able to make use of aio.  
There are lots of high performance server applications which require aio 
and filesystem caching (think iSCSI servers, web servers/caches).  Right 
now the only way to do that is via threads, which brings into play a lot 
of other overhead.  AIO is one of the last areas in which we don't provide 
a suitable implementation for use in normal applications, only highly 
specialised database users.

		-ben
