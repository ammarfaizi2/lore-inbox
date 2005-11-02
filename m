Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVKBOlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVKBOlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVKBOlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:41:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:60880 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965056AbVKBOla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:41:30 -0500
Date: Wed, 2 Nov 2005 20:05:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: bad page state under possibly oom situation
Message-ID: <20051102143502.GE6137@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have discussed this in private previously and I had mentioned
that I see this introduced between 2.6.9-rc1 and 2.6.9-rc2. After
spending some time doing other things, I went back to take a
look at this again and thought I would share this with a wider
audience. The basic problem is that while running the LTP rename14
test with a tmpfs /tmp, I see this -

Bad page state at prep_new_page (in process 'rename14', page ffff810008002aa8)
flags:0x4000000000000090 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff80150388>{bad_page+115} <ffffffff80150bb1>{buffered_rmqueue+438}
       <ffffffff80150da8>{__alloc_pages+251} <ffffffff8022fb10>{_atomic_dec_and_lock+24}
       <ffffffff801535b3>{cache_alloc_refill+581} <ffffffff8015384f>{kmem_cache_alloc+44}
       <ffffffff8017cd55>{d_alloc+33} <ffffffff8017507e>{__lookup_hash+206}
       <ffffffff80176f4e>{sys_rename+245} <ffffffff8010e636>{system_call+126}

Trying to fix it up, but a reboot is needed

Recently, I tested this with 2.6.14 and it worked. I then tried
setting rcupdate.maxbatch=10 as it was before 2.6.14 and the bad
page state problem happened again. Looks like it happens only under
memory pressure and likely have something to do with slab.
I am wondering if that rings a bell with anyone. Manfred ?

Thanks
Dipankar
