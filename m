Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVEMH5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVEMH5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVEMH5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:57:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48565 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262285AbVEMH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:57:37 -0400
Date: Fri, 13 May 2005 08:57:43 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jim Washer <e2big@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIRMED bug in do_generic_file_read
Message-ID: <20050513075743.GG1150@parcelfarce.linux.theplanet.co.uk>
References: <200505130057.j4D0vvh08761@crg8.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505130057.j4D0vvh08761@crg8.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 05:57:57PM -0700, Jim Washer wrote:
> Well, my original post got ZERO responses, but I've continued to look 
> at this, and with the help of a colleague I think we've bottomed out.

> do_generic_file_read does indeed have a bug, as mentioned below. However, 
> this bug is generally not hit as the call to a_ops->readpage (normally 
> pointing at blkdev_readpage) NEVER returns an error. However, the Veritas 
> code's readpage does return errors, and this triggers this KERNEL BUG.

Hardly.  What it does, apparently, is extra page_cache_release().
 
> I don't know enough about the page cache to know if simply NULLing the 
> page->mapping pointer is safe.

Analysis above is BS.
	a) page with non-NULL ->mapping == page in cache.  Code that adds
page to page cache grabs a reference before putting it on the lists.
	b) code that evicts page from cache drops a reference after getting
the sucker off lists.
	c) final page_cache_release() while page is still in cache is,
indeed, a bug.  Of memory-corrupting variety.
	d) ->readpage() has no fscking business playing with any of the above.
	e) while we are at it, -EFAULT is a hell of a strange error for
->readpage(), but that's a separate story.

Check for unbalanced page_cache_release() in their code.

> Anyone care to address this?

See above.  Anything beyond that requires
	1) access to their code
	2) good supply of industrial-strength barf-bags to deal with
inevitable consequences of (1).
