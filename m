Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWJFXJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWJFXJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWJFXJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:09:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422741AbWJFXJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:09:49 -0400
Message-ID: <4526E229.2020707@RedHat.com>
Date: Fri, 06 Oct 2006 19:09:29 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Trond Myklebust <Trond.Myklebust@netapp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
References: <1160170629.5453.34.camel@lade.trondhjem.org>	<4526CF6F.9040006@RedHat.com>	<1160172990.12253.14.camel@lade.trondhjem.org>	<1160173167.12253.17.camel@lade.trondhjem.org> <20061006154058.4190075f.akpm@osdl.org>
In-Reply-To: <20061006154058.4190075f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 06 Oct 2006 18:19:27 -0400
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> 
> 
>>On Fri, 2006-10-06 at 18:16 -0400, Trond Myklebust wrote:
>>
>>>Yeah using mapping_gfp_mask(mapping) sounds like a better option.
>>
>>Revised patch is attached...
> 
> 
> Well, it wasn't attached, but I can simulate it.
> 
> invalidate_complete_page() wants to be called from inside spinlocks by
> drop_pagecache(), so if we wanted to pull the same trick there we'd need to
> pass a new flag into invalidate_inode_pages().
That seems abit broken (wrt performance) that drop_pagecache_sb() holds
the fairly popular inode_lock while it invalidate pages...
Nobody else seem to...

> 
> It's not 100% clear what the gfp_t _means_ in the try_to_release_page()
> context.  Callees will rarely want to allocate memory (true?).  So it
> conveys two concepts: 
> 
> a) can sleep. (__GFP_WAIT).  That's fairly straightforward
> 
> b) can take fs locks (__GFP_FS).  This is less clear.  By passing down
>    __GFP_FS we're telling the callee that it's OK to take i_mutex, even
>    lock_page().  That sounds pretty unsafe in this context, particularly
>    the latter, as we're already holding a page lock.
> 
> So perhaps the safer and more appropriate solution here is to pass in a
> bare __GFP_WAIT.
I agree... __GFP_WAIT does seem to be a bit more straightforward...
either way is find.. as long as it cause NFS to flush its pages...

steved.

