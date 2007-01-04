Return-Path: <linux-kernel-owner+w=401wt.eu-S932283AbXADFl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbXADFl1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbXADFl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:41:27 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:49465 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283AbXADFl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:41:26 -0500
Date: Wed, 3 Jan 2007 21:41:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-Id: <20070103214121.997be3e6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
References: <200612291859.kBTIx2kq031961@hera.kernel.org>
	<20061229224309.GA23445@gelma.net>
	<459734CE.1090001@yahoo.com.au>
	<20061231135031.GC23445@gelma.net>
	<459C7B24.8080008@yahoo.com.au>
	<Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 20:44:36 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Actually, I think 2.6.18 may have a subtle variation on it. 
> 
> In particular, I look back at the try_to_free_buffers() thing that I hated 
> so much, and it makes me wonder.. It used to do:
> 
> 	spin_lock(&mapping->private_lock);
> 	ret = drop_buffers(page, &buffers_to_free);
> 	spin_unlock(&mapping->private_lock);
> 	if (ret) {
> 		.. crappy comment ..
> 		if (test_clear_page_dirty(page))
> 			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
> 	}
> 
> and I think that at least on SMP, we had a race with another CPU doing the 
> "mark page dirty if it was dirty in the PTE" at the same time. Because the 
> marking dirty would come in, find no buffers (they just got dropped), and 
> then mark the page dirty (ignoring the lack of any buffers), but then the 
> above would do the "test_clear_page_dirty()" thing on it.
> 

That bug was introduced in 2.6.19, with the dirty page tracking patches.

2.6.18 and earlier used ->private_lock coverage in try_to_free_buffers() to
prevent it.

> Ie the race, I think, existed where that crappy comment was.

The comment was complete, accurate and needed.
