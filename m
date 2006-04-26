Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWDZUJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWDZUJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWDZUJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:09:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932397AbWDZUJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:09:37 -0400
Date: Wed, 26 Apr 2006 13:12:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-Id: <20060426131200.516cbabc.akpm@osdl.org>
In-Reply-To: <20060426191557.GA9211@suse.de>
References: <20060426135310.GB5083@suse.de>
	<20060426095511.0cc7a3f9.akpm@osdl.org>
	<20060426174235.GC5002@suse.de>
	<20060426111054.2b4f1736.akpm@osdl.org>
	<Pine.LNX.4.64.0604261144290.3701@g5.osdl.org>
	<20060426191557.GA9211@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> With a 16-page gang lookup in splice, the top profile for the 4-client
> case (which is now at 4GiB/sec instead of 3) are:
> 
> samples  %        symbol name
> 30396    36.7217  __do_page_cache_readahead
> 25843    31.2212  find_get_pages_contig
> 9699     11.7174  default_idle

__do_page_cache_readahead() should use gang lookup.  We never got around to
that, mainly because nothing really demonstrated a need.

It's a problem that __do_page_cache_readahead() is being called at all -
with everything in pagecache we should be auto-turning-off readahead.  This
happens because splice is calling the low-level do_pagecache_readahead(). 
If you convert it to use page_cache_readahead(), that will all vanish if
readahead is working right.
