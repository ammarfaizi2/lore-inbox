Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTJ2VuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTJ2VuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:50:17 -0500
Received: from [217.73.128.98] ([217.73.128.98]:8329 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261681AbTJ2VuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:50:14 -0500
Date: Wed, 29 Oct 2003 23:49:54 +0200
Message-Id: <200310292149.h9TLnsNq024151@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
To: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20031028154920.1905.qmail@mailshell.com> <20031028141329.13443875.akpm@osdl.org> <20031029174419.5776.qmail@mailshell.com> <20031029123107.338796a4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Andrew Morton <akpm@osdl.org> wrote:
>> Here are the results (output of dmesg) from booting a kernel with this
>> patch:
>> set_blocksize: size=4096
>> buffer layer error at fs/buffer.c:431
AM> hm, that didn't tell us much :(
AM> Could you add Oleg's patch as well?

Actually it will say that device's block size is 4096 (confirming
last set_blocksize was at least partially succesful), but what
it does not tell us is how those buffers have survived after blocksize
was changed and all buffers were invalidated.
(These buffers are there because reiserfs first reads that offset (in bytes)
with whatever current blocksize is, except they should have been invalidated of
course).
Even if invalidate_bdev() -> invalidate_inode_pages() have not cleaned
everything, truncate_inode_pages() should have done this.
So probably this page means do_invalidate_page() ... -> try_to_free_buffers()
have failed for whatever reason.
We did not write there yet, so this is not PageWriteback case.
But if the read is still going on, I guess we won't free the page/buffers?
Or am I missing some wait_on_buffer()?
But anyway that might explains buffers being still in page, but not such
a page present in a mapping. (except if we have not pickup this page from a list
of free pages not looking that it still have stale buffers)

Bye,
    Oleg
