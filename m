Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbUBECBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbUBECBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:01:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3001 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264557AbUBECBi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:01:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Daniel McNeil <daniel@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
Date: Wed, 4 Feb 2004 17:54:48 -0800
User-Agent: KMail/1.4.1
Cc: Janet Morgan <janetmor@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
References: <3FCD4B66.8090905@us.ibm.com> <20040109035510.GA3279@in.ibm.com> <1075945198.7182.46.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1075945198.7182.46.camel@ibm-c.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402041754.48693.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm !! You beat me by few hours :)

It sounds convincing. I am not sure about the fix either.
Let me try the fix and see if really fixes the problem.

Thanks,
Badari

On Wednesday 04 February 2004 05:39 pm, Daniel McNeil wrote:
> I have found (finally) the problem causing DIO reads racing with
> buffered writes to see uninitialized data on ext3 file systems
> (which is what I have been testing on).
>
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
>
> Here is a quick hack that fixes it, but I am not sure if this the
> proper long term fix.
>
> Thoughts?
>
> Daniel

