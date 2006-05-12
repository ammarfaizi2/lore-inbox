Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWELRiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWELRiB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWELRiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:38:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbWELRiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:38:00 -0400
Date: Fri, 12 May 2006 10:40:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 002 of 8] md/bitmap: Remove bitmap writeback daemon.
Message-Id: <20060512104035.5fee4e66.akpm@osdl.org>
In-Reply-To: <1060512060736.8006@suse.de>
References: <20060512160121.7872.patches@notabene>
	<1060512060736.8006@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
>  ./drivers/md/bitmap.c         |  115 ++----------------------------------------

hmm.  I hope we're not doing any of that filesystem I/O within the context
of submit_bio() or kblockd or anything like that.  Looks OK from a quick
scan.

a_ops->commit_write() already ran set_page_dirty(), so you don't need that
in there.

I assume this always works in units of a complete page?  It's strange to do
prepare_write() followed immediately by commit_write().  Normally
prepare_write() will do some prereading, but it's smart enough to not do
that if the caller is preparing to write the whole page.

We normally use PAGE_CACHE_SIZE for these things, not PAGE_SIZE.  Same diff.

If you have a page and you want to write the whole thing out then there's
really no need to run prepare_write or commit_write at all.  Just
initialise the whole page, run set_page_dirty() then write_one_page().

Perhaps it should check that the backing filesystem actually implements
commit_write(), prepare_write(), readpage(), etc.  Some might not, and the
user will get taught not to do that via an oops.


