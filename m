Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269805AbUJGMWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269805AbUJGMWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUJGMWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:22:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22742 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269805AbUJGMEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:04:39 -0400
Date: Thu, 7 Oct 2004 07:12:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
Message-ID: <20041007101213.GC10234@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com> <20041005112752.GA21094@logos.cnet> <16739.61314.102521.128577@segfault.boston.redhat.com> <20041006120158.GA8024@logos.cnet> <1097119895.4339.12.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097119895.4339.12.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 04:31:35AM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, 2004-10-06 at 09:01 -0300, Marcelo Tosatti wrote:

> > >  o If O_NONBLOCK is set, read( ) shall return -1 and set errno to [EAGAIN].
> > 
> > This implies read(O_NONBLOCK) should never block.
> 
> The spec is usually pretty careful never to come straight out and
> require that in all cases, even for true AIO.
>
> > Maybe your code should pass down __GFP_FAIL in the gfp_mask 
> > to the page_cache_alloc() to avoid blocking reclaiming pages,
> > and possibly pass info down to the block layer 
> > "if this is going to block, fail".
> 
> It's not just the page allocation that can block, though.  Readahead
> requires us to map the buffers being read before we submit the async
> read, so we can still block reading indirect blocks.  If we want to
> avoid submitting that extra synchronous IO, then either O_NONBLOCK needs
> to avoid readahead entirely for non-present pages, or the readahead
> itself needs to know that it's a O_NONBLOCK IO and fail cleanly if the
> metadata is not in cache.

Hi Stephen!

Oh yes, theres also the indirect blocks which we might need to read from
disk.

Now the question is, how strict should the O_NONBLOCK implementation be 
in reference to "not blocking" ?

Maybe Jeff's currently implementation is just fine avoiding the 
potential block at !PageUptodate.
