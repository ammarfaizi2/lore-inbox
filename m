Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269668AbUJGD3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269668AbUJGD3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 23:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269669AbUJGD3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 23:29:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21727 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269668AbUJGD3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 23:29:12 -0400
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20041006120158.GA8024@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	 <20041005112752.GA21094@logos.cnet>
	 <16739.61314.102521.128577@segfault.boston.redhat.com>
	 <20041006120158.GA8024@logos.cnet>
Content-Type: text/plain
Date: Thu, 07 Oct 2004 04:31:35 +0100
Message-Id: <1097119895.4339.12.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-10-06 at 09:01 -0300, Marcelo Tosatti wrote:


> > When attempting to read a file (other than a pipe or FIFO) that supports
> > non-blocking reads and has no data currently available:
> >  o If O_NONBLOCK is set, read( ) shall return -1 and set errno to [EAGAIN].
> 
> This implies read(O_NONBLOCK) should never block.

The spec is usually pretty careful never to come straight out and
require that in all cases, even for true AIO.

> Maybe your code should pass down __GFP_FAIL in the gfp_mask 
> to the page_cache_alloc() to avoid blocking reclaiming pages,
> and possibly pass info down to the block layer 
> "if this is going to block, fail".

It's not just the page allocation that can block, though.  Readahead
requires us to map the buffers being read before we submit the async
read, so we can still block reading indirect blocks.  If we want to
avoid submitting that extra synchronous IO, then either O_NONBLOCK needs
to avoid readahead entirely for non-present pages, or the readahead
itself needs to know that it's a O_NONBLOCK IO and fail cleanly if the
metadata is not in cache.

Cheers,
 Stephen


