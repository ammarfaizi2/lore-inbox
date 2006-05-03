Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWECWFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWECWFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWECWFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:05:42 -0400
Received: from kanga.kvack.org ([66.96.29.28]:35530 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751374AbWECWFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:05:41 -0400
Date: Wed, 3 May 2006 18:05:28 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jens Axboe <axboe@suse.de>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503220528.GA19635@kvack.org>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <20060502080935.GS3814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502080935.GS3814@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 10:09:36AM +0200, Jens Axboe wrote:
> Your patch isn't exactly pretty, but that is fixable. I'm more
> interested in how you'd control that sanely.

I have a quick and dirty hack called BootCache (only afterwards did I notice 
that Apple used the same name) that snoops all the read requests during 
startup and uses that to populate a file which gets read in to populate 
the cache on subsequent boots.  The results are impressive: eliminating 
the seeks (since the file is contiguous) results in 15s (out of the 45s 
from init starting to the login prompt) reduction in boot time on ext3.

Prefetch without reordering isn't particularly effective, as the cost of 
the seeks to read in the inodes and file data tend to block critical path 
io in the startup scripts.

I hope to release the code sometime soon and rework it to be a better fit 
for merging with the kernel -- it should be possible to use the block io 
tracing facility to log the blocks required and then feed that back into 
the filesystem to reallocate blocks in the filesystem.  That would eliminate 
the messy part of bootcache that has to snoop block writes to maintain the 
cache.  This is all part of what I'm aiming to present at OLS.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
