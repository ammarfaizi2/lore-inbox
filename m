Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUECUXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUECUXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUECUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:23:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18396 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263944AbUECUX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:23:26 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040503110854.5abcdc7e.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au>  <20040503110854.5abcdc7e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1083615727.7949.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2004 13:22:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 11:08, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > What ends up happening is that readahead gets turned off, then the
> > 16K read ends up being done in 4 synchronous 4K chunks. Because they
> > are synchronous, they have no chance of being merged with one another
> > either.
> 
> yup.
> 
> > I have attached a proof of concept hack... I think what should really
> > happen is that page_cache_readahead should be taught about the size
> > of the requested read, and ensures that a decent amount of reading is
> > done while within the read request window, even if
> > beyond-request-window-readahead has been previously unsuccessful.
> 
> The "readahead turned itself off" thing is there to avoid doing lots of
> pagecache lookups in the very common case where the file is fully cached.
> 
> The place which needs attention is handle_ra_miss().  But first I'd like to
> reacquaint myself with the intent behind the lazy-readahead patch.  Was
> never happy with the complexity and special-cases which that introduced.

lazy-readahead has no role to play here. The readahead window got closed
because the i/o pattern was totally random. My guess is multiple threads
are generating 16k i/o on the same fd. In such a case the i/os can  get
interleaved and the readahead window size goes for a toss(which is
expected  behavior)

Well if this is infact the case: the question is
	1. does the i/o pattern really has some sequentiality to 
		deserve a readahead?
	2. or should we ensure that the interleaved case be somehow
		 handled, by including the size parameter?

I know Nick has implied option (2) but I think from the readahead's
point of view it is (1),
RP


