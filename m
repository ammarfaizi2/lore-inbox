Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWCBBuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCBBuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCBBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:50:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWCBBuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:50:08 -0500
Date: Wed, 1 Mar 2006 17:52:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pass b_size to ->get_block()
Message-Id: <20060301175218.6360cf7f.akpm@osdl.org>
In-Reply-To: <1141075413.10542.23.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	<1141075413.10542.23.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Pass amount of disk needs to be mapped to get_block().
> This way one can modify the fs ->get_block() functions 
> to map multiple blocks at the same time.

I can't say I terribly like this patch.  Initialising b_size all over the
place seems fragile.

We're _already_ setting bh.b_size to the right thing in
alloc_page_buffers(), and for a bh which is attached to
pagecache_page->private, there's no reason why b_size would ever change.

So what I think I'll do is to convert those places where you're needlessly
assigning to b_size into temporary WARN_ON(b_size != blocksize).

The only place where we need to initialise b_size is where we've got a
non-pagecache bh allocated on the stack.

We need to be sure that no ->get_block() implementations write garbage into
bh->b_size if something goes wrong.  b_size on a pagecache-based
buffer_head must remain inviolate.

