Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTLLTBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLLTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:01:51 -0500
Received: from verein.lst.de ([212.34.189.10]:59347 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261837AbTLLTBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:01:11 -0500
Date: Fri, 12 Dec 2003 20:00:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nathan Scott <nathans@sgi.com>
Cc: pinotj@club-internet.fr, torvalds@osdl.org, neilb@cse.unsw.edu.au,
       manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031212190002.GA21253@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Nathan Scott <nathans@sgi.com>, pinotj@club-internet.fr,
	torvalds@osdl.org, neilb@cse.unsw.edu.au, manfred@colorfullife.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <mnet2.1070931455.23402.pinotj@club-internet.fr> <20031209020322.GA1798@frodo> <20031209072131.GD24599@lst.de> <20031209235832.GG783@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209235832.GG783@frodo>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 10:58:32AM +1100, Nathan Scott wrote:
> > > [ Christoph, is this failure expected?  I think you/Steve made
> > > some changes there to use __GFP_NOFAIL and assume it wont fail?
> > > (in 2.4 we do memory allocations differently to better handle
> > > failures, but that code was removed...) ]
> > 
> > It looks like the slab allocator doesn't like __GFP_NOFAIL, we'll
> > probably have to revert the XFS memory allocation wrappers to the
> > 2.4 versions.
> > 
> 
> OK, thanks - I'll look into it.

This starts to look really fishy:

hch@bird:/repo/repo/linux-2.5/fs/jbd$ egrep -r NOFAIL *
journal.c:      new_bh = alloc_buffer_head(GFP_NOFS|__GFP_NOFAIL);
journal.c:      return kmalloc(size, flags | (retry ? __GFP_NOFAIL :
0));

both of these end up in the slab layer, just like XFS - except
that __cache_alloc still may fail.  Looks like whe're better of
fixing mm/slab.c

