Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWEITVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWEITVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWEITVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:21:03 -0400
Received: from verein.lst.de ([213.95.11.210]:8421 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750824AbWEITVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:21:02 -0400
Date: Tue, 9 May 2006 21:20:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, bcrl@kvack.org, cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-ID: <20060509192051.GA19378@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com> <20060509120105.7255e265.akpm@osdl.org> <20060509190310.GA19124@lst.de> <20060509121305.0840e770.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509121305.0840e770.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:13:05PM -0700, Andrew Morton wrote:
> > there's another patch ontop which I didn't bother to redo until this is
> > accepted which kills a lot more code.  After that filesystems only have
> > to implement one method each for all kinds of read/write calls.  Which
> > allows to both make the mm/filemap.c far less complex and actually
> > understandable aswell as for any filesystem that uses more complex
> > read/write variants than direct filemap.c calls.  In addition to these
> > simplification we also get a feature (async vectored I/O) for free.
> 
> Fair enough, thanks.  Simplifying filemap.c would be a win.
> 
> I'll crunch on these three patches in the normal fashion.  It'll be good if
> we can get the followup patch done within the next week or two so we can
> get it all tested at the same time.  Although from your description it
> doesn't sound like it'll be completely trivial...

That patch is lots of tirival and boring work.  If anyone wants to beat
me to it:

 - in any filesystem that implements the generic_file_aio_{read,write}
   directly remove these apply this patch to the file_operations
   vectors:


-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.read		= do_sync_read,
+	.write		= do_sync_write,

   Note that this does _not_ cause additional indirection for normal
   sys_read/sys_write calls because they call .aio_read/.aio_write
   directly.  It's only needed because we have various places in the
   tree that like to call .read/.write directly

 - in the filesystems that implement more or less trivial wrappers
   around  generic_file_read/generic_file_write to the
   aio_read/aio_write prototypes so they can set .read/.write as above

 - after that generic_file_read/generic_file_write/generic_file_read/
   generic_file_write_nolock should have no callers left and the code
   for read/write in mm/filemap.c can be collapsed into very few functions.
   What's left should be something like:

     - generic_file_aio_read
       (__generic_file_aio_read and generic_file_aio_read merged into one)
     - __generic_file_aio_write
       (basically the current __generic_file_aio_write_nolock)
     - generic_file_aio_write_nolock
     - generic_file_aio_write
       (small wrappers around __generic_file_aio_write)
