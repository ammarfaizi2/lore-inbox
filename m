Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTLQCCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTLQCCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 21:02:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:37264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263221AbTLQCCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 21:02:50 -0500
Date: Tue, 16 Dec 2003 18:03:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: janetmor@us.ibm.com, suparna@in.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20031216180319.6d9670e4.akpm@osdl.org>
In-Reply-To: <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
References: <3FCD4B66.8090905@us.ibm.com>
	<1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	<1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> I have found something else that might be causing the problem.
> filemap_fdatawait() skips pages that are not marked PG_writeback.
> However, when a page is going to be written, PG_dirty is cleared
> before PG_writeback is set (while the PG_locked is set).  So it
> looks like filemap_fdatawait() can see a page just before it is
> going to be written and not wait for it.  Here is a patch that
> makes filemap_fdatawait() wait for locked pages as well to make
> sure it does not missed any pages.

This filemap_fdatawait() behaviour is as-designed.  That function is only
responsible for waiting on I/O which was initiated prior to it being
invoked.  Because it is designed for fsync(), fdatasync(), O_SYNC, msync(),
sync(), etc.

Now, it could be that this behaviour is not appropriate for the O_DIRECT
sync function - the result of your testing will be interesting.


