Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVBVOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVBVOld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVBVOld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:41:33 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:56038 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262316AbVBVOlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:41:05 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Feb 2005 09:41:04 -0500
In-Reply-To: <20050222020309.4289504c.akpm@osdl.org>
Message-ID: <yq0ekf8lksf.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> jes@trained-monkey.org (Jes Sorensen) wrote:
>>  Hi,
>> 
>> This patch introduces ia64 specific read/write handlers for
>> /dev/mem access which is needed to avoid uncached pages to be
>> accessed through the cached kernel window which can lead to random
>> corruption. It also introduces a new page-flag PG_uncached which
>> will be used to mark the uncached pages. I assume this may be
>> useful to other architectures as well where the CPU may use
>> speculative reads which conflict with uncached access. In addition
>> I moved do_write_mem to be under ARCH_HAS_DEV_MEM as it's only ever
>> used if that is defined.

Andrew> Is it possible to avoid consuming a page flag?

Andrew> If this is an ia64-only (or 64-bit-only) thing I guess we
Andrew> could use bit 32.

Hi Andrew,

I don't think we can get away with it, I think most modern
architectures have this problem. I've been trying to avoid it for
several iterations but I kept getting pushed towards this.

>> + if (page->flags & PG_uncached)

Andrew> dude.  That ain't gonna work ;)

Pardon my lack of clue, but why not?

Maybe I should explain how I use it - in the mspec driver I pull a
chunk of pages out using alloc_pages and convert them all to uncached
(I need to do a chunk due to the speculation restrictions on ia64) and
then stick them into a special allocator and set page->PG_uncached
when doing so (the allocator is not tied to the uncached so I posted
the patch to Tony Luck). Ie. once the pages have been grabbed with
alloc_pages() and converted to uncached, they are never put back into
the generic pool.

It may be there are other places which needs to learn to respect the
flag?

Cheers,
Jes

