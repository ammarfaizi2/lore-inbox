Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUBERyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUBERyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:54:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:57830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266536AbUBERxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:53:43 -0500
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: janetmor@us.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <20040204213336.354d8103.akpm@osdl.org>
References: <3FCD4B66.8090905@us.ibm.com>
	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	 <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <20031230045334.GA3484@in.ibm.com>
	 <1072830557.712.49.camel@ibm-c.pdx.osdl.net>
	 <20031231060956.GB3285@in.ibm.com>
	 <1073606144.1831.9.camel@ibm-c.pdx.osdl.net>
	 <20040109035510.GA3279@in.ibm.com>
	 <1075945198.7182.46.camel@ibm-c.pdx.osdl.net>
	 <20040204213336.354d8103.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076003576.7182.77.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Feb 2004 09:52:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I am still thinking about your patch.  I will run some tests today using
2.6.2-mm1 to see if the problem is fixed.  My 8-proc machine ran
overnight with 6 copies of the read_under running without problems with
my original patch.  Previously on the 8-proc machine, it would hit
uninitialized data within an hour.

The concern I have is that DIO needs filemap_write_and_wait() to
make sure all previously dirty pages have been written back to
disk before the DIO is issued.

If __block_write_full_page() can possibly clear PageWriteback 
with buffer i/o still in flight (even for WB_SYNC_NONE) then
a subsequent filemap_write_and_wait() will miss that page.

For example, I previously tried:

        do {
                get_bh(bh);
+		if (wbc->sync_mode != WB_SYCN_NONE)
+              		 wait_on_buffer(bh);
                if (buffer_mapped(bh) && buffer_dirty(bh)) {
                        if (wbc->sync_mode != WB_SYNC_NONE) {
                                lock_buffer(bh);

and this still saw uninitialized data.

Also, if __block_write_full_page() can redirty a page wouldn't this
allow filemap_write_and_wait() to return with page still dirty that
DIO needs written back?
	 
I'll work on updating the other patches.

Daniel



On Wed, 2004-02-04 at 21:33, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> >  I have found (finally) the problem causing DIO reads racing with
> >  buffered writes to see uninitialized data on ext3 file systems 
> >  (which is what I have been testing on).
> > 
> >  The problem is caused by the changes to __block_write_page_full()
> >  and a race with journaling:
> > 
> >  journal_commit_transaction() -> ll_rw_block() -> submit_bh()
> >  	
> >  ll_rw_block() locks the buffer, clears buffer dirty and calls
> >  submit_bh()
> > 
> >  A racing __block_write_full_page() (from ext3_ordered_writepage())
> > 
> >  	would see that buffer_dirty() is not set because the i/o
> >          is still in flight, so it would not do a bh_submit()
> > 
> >  	It would SetPageWriteback() and unlock_page() and then
> >  	see that no i/o was submitted and call end_page_writeback()
> >  	(with the i/o still in flight).
> > 
> >  This would allow the DIO code to issue the DIO read while buffer writes
> >  are still in flight.  The i/o can be reordered by i/o scheduling and
> >  the DIO can complete BEFORE the writebacks complete.  Thus the DIO
> >  sees the old uninitialized data.
> 
> I suppose we should go for a general fix to the problem.  I'm not 100%
> happy with it.  It's similar to yours, except we only wait if
> wbc->sync_mode says it's a write-for-sync.  Also we hold the buffer lock
> across all the tests.
> 
> 
> 
> 
> 
> 
> Fix a race which was identified by Daniel McNeil <daniel@osdl.org>
> 
> If a buffer_head is under I/O due to JBD's ordered data writeout (which uses
> ll_rw_block()) then either filemap_fdatawrite() or filemap_fdatawait() need
> to wait on the buffer's existing I/O.
> 
> Presently neither will do so, because __block_write_full_page() will not
> actually submit any I/O and will hence not mark the page as being under
> writeback.
> 
> The best-performing fix would be to somehow mark the page as being under
> writeback and defer waiting for the ll_rw_block-initiated I/O until
> filemap_fdatawait()-time.  But this is hard, because in
> __block_write_full_page() we do not have control of the buffer_head's end_io
> handler.  Possibly we could make JBD call into end_buffer_async_write(), but
> that gets nasty.
> 
> This patch makes __block_write_full_page() wait for any buffer_head I/O to
> complete before inspecting the buffer_head state.  It only does this in the
> case where __block_write_full_page() was called for a "data-integrity" write:
> (wbc->sync_mode != WB_SYNC_NONE).
> 
> Probably it doesn't matter, because kjournald is currently submitting (or has
> already submitted) all dirty buffers anyway.
> 
> 
> 
> ---
> 
>  fs/buffer.c |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff -puN fs/buffer.c~O_DIRECT-ll_rw_block-vs-block_write_full_page-fix fs/buffer.c
> --- 25/fs/buffer.c~O_DIRECT-ll_rw_block-vs-block_write_full_page-fix	2004-02-04 20:38:30.000000000 -0800
> +++ 25-akpm/fs/buffer.c	2004-02-04 20:40:19.000000000 -0800
> @@ -1810,23 +1810,24 @@ static int __block_write_full_page(struc
>  
>  	do {
>  		get_bh(bh);
> -		if (buffer_mapped(bh) && buffer_dirty(bh)) {
> -			if (wbc->sync_mode != WB_SYNC_NONE) {
> -				lock_buffer(bh);
> -			} else {
> -				if (test_set_buffer_locked(bh)) {
> +		if (!buffer_mapped(bh))
> +			continue;
> +		if (wbc->sync_mode != WB_SYNC_NONE) {
> +			lock_buffer(bh);
> +		} else {
> +			if (test_set_buffer_locked(bh)) {
> +				if (buffer_dirty(bh))
>  					__set_page_dirty_nobuffers(page);
> -					continue;
> -				}
> -			}
> -			if (test_clear_buffer_dirty(bh)) {
> -				if (!buffer_uptodate(bh))
> -					buffer_error();
> -				mark_buffer_async_write(bh);
> -			} else {
> -				unlock_buffer(bh);
> +				continue;
>  			}
>  		}
> +		if (test_clear_buffer_dirty(bh)) {
> +			if (!buffer_uptodate(bh))
> +				buffer_error();
> +			mark_buffer_async_write(bh);
> +		} else {
> +			unlock_buffer(bh);
> +		}
>  	} while ((bh = bh->b_this_page) != head);
>  
>  	BUG_ON(PageWriteback(page));
> 
> _

