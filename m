Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUBRBlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBRBlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:41:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:59810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265691AbUBRBlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:41:18 -0500
Date: Tue, 17 Feb 2004 17:43:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.3-rc2-mm1] address_space_serialize_writeback patch
Message-Id: <20040217174300.4b94981e.akpm@osdl.org>
In-Reply-To: <1077066147.1956.136.camel@ibm-c.pdx.osdl.net>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	<1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	<20040213143836.0a5fdabb.akpm@osdl.org>
	<1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
	<20040213154815.42e74cb5.akpm@osdl.org>
	<1077066147.1956.136.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Here is the patch that does what you suggested.  It adds a rwsema to
> the address_space and do_writepages() uses it serialize writebacks.

OK, but we're only holding the rwsem across filemap_fdatawrite().  What
happens after we've dropped the rwsem and we are running
filemap_fdatawait()?  Cannot kupdate come in and start moving pages onto
the wrong address_space lists while filemap_fdatawait() is trying to wait
on them?

I think so.  Possibly your test just doesn't cover this case.

If so then we need to hold the rwsem for writing across the entire
write-and-wait.  And that is going to rather suck if and when we bring back
the sync_page_range() patch, which permitted concurrent fsync() against
different fd's which cover different parts of the file.

We need to check that we're bypassing all this stuff for access to
blockdevs too - we have no security issues to worry about there.
