Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVGZBBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVGZBBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGZBBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:01:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52621 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261579AbVGZBA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:00:59 -0400
Date: Tue, 26 Jul 2005 06:40:04 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 2/6] Rename __lock_page to lock_page_slow
Message-ID: <20050726011004.GA4472@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com> <20050620162404.GB5380@in.ibm.com> <20050724221702.GA9620@infradead.org> <20050724223634.GB9620@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724223634.GB9620@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 11:36:34PM +0100, Christoph Hellwig wrote:
> On Sun, Jul 24, 2005 at 11:17:02PM +0100, Christoph Hellwig wrote:
> > On Mon, Jun 20, 2005 at 09:54:04PM +0530, Suparna Bhattacharya wrote:
> > > In order to allow for interruptible and asynchronous versions of
> > > lock_page in conjunction with the wait_on_bit changes, we need to
> > > define low-level lock page routines which take an additional
> > > argument, i.e a wait queue entry and may return non-zero status,
> > > e.g -EINTR, -EIOCBRETRY, -EWOULDBLOCK etc. This patch renames 
> > > __lock_page to lock_page_slow, so that __lock_page and 
> > > __lock_page_slow can denote the versions which take a wait queue 
> > > parameter.
> > 
> > How many users that don't use a waitqueue parameter will be left
> > once all AIO patches go in?

Since these patches are intended only for aio reads and (O_SYNC) writes,
that still leaves most other users of regular lock_page() as they are.

> 
> Actually looking at the later patches we always seem to pass
> current->io_wait anyway, so is there a real point for having the
> argument?
> 

Having the parameter enables issual of synchronous lock_page() within
an AIO path, overriding current->io_wait, (for example, consider the case
of a page fault during AIO !), and thus avoids the need to convert and audit
more paths to handle -EIOCBRETRY propagation (though it is possible to
do so as and when the need arises). This is why I decided to keep this
parameter explicit at the low level, and let the caller decide how to
invoke it and handle the return value propagation.

Does that make sense ?

BTW, there is also a potential secondary benefit of a low level
primitive for asynchronous page IO operations etc directly usable
by kernel threads, without having to use the whole gamut of AIO
interfaces.

Thanks for reviewing the code !

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

