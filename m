Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUBECGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUBECGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:06:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:14777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265071AbUBECGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:06:48 -0500
Date: Wed, 4 Feb 2004 18:07:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: janetmor@us.ibm.com, pbadari@us.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
Message-Id: <20040204180754.28801410.akpm@osdl.org>
In-Reply-To: <1075945198.7182.46.camel@ibm-c.pdx.osdl.net>
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
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> I have found (finally) the problem causing DIO reads racing with
> buffered writes to see uninitialized data on ext3 file systems 
> (which is what I have been testing on).

What kernel?  If -mm, is this the only remaining buffered-vs-direct
problem?

> The problem is caused by the changes to __block_write_page_full()
> and a race with journaling:
> 
> journal_commit_transaction() -> ll_rw_block() -> submit_bh()
> 	
> ll_rw_block() locks the buffer, clears buffer dirty and calls
> submit_bh()
> 
> A racing __block_write_full_page() (from ext3_ordered_writepage())
> 
> 	would see that buffer_dirty() is not set because the i/o
>         is still in flight, so it would not do a bh_submit()
> 
> 	It would SetPageWriteback() and unlock_page() and then
> 	see that no i/o was submitted and call end_page_writeback()
> 	(with the i/o still in flight).
> 
> This would allow the DIO code to issue the DIO read while buffer writes
> are still in flight.  The i/o can be reordered by i/o scheduling and
> the DIO can complete BEFORE the writebacks complete.  Thus the DIO
> sees the old uninitialized data.

ow.  How'd you work this out?

> Here is a quick hack that fixes it, but I am not sure if this the
> proper long term fix.

The problem is that ext3 and the VFS are using different paradigms.  VFS is
all page-based, but ext3 is all block-based.  One or the other needs to do
something nasty.

One approach would be to change the JBD write_out_data_locked loop to use
block_write_full_page(bh->b_page) instead of buffer_head operations.  But
that could get hairy with blocksize < PAGE_SIZE.

Thanks for working this out.  Let me ponder it for a bit.
