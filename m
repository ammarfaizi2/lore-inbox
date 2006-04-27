Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWD0PMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWD0PMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWD0PMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:12:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965148AbWD0PMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:12:35 -0400
Date: Thu, 27 Apr 2006 08:12:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
In-Reply-To: <44505B59.1060308@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0604270804420.3701@g5.osdl.org>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org>
 <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
 <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <44505B59.1060308@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Apr 2006, Nick Piggin wrote:
> > 
> > Of course, with small files, the actual filename lookup is likely to be the
> > real limiter.
> 
> Although that's lockless so it scales. find_get_page will overtake it
> at some point.

filename lookup is only lockless for independent files. You end up getting 
the "dentry->d_lock" for a successful lookup in the lookup path, so if you 
have multiple threads looking up the same files (or - MUCH more commonly - 
directories), you're not going to be lockless.

I don't know how we could improve it. I've several times thought that we 
_should_ be able to do the directory lookups under the rcu read lock and 
never touch their d_count or d_lock at all, but the locking against 
directory renaming depends very intimately on d_lock.

It is _possible_ that we should be able to handle it purely with just 
memory ordering rather than depending on d_lock. That would be wonderful.

Of course, we do actually scale pretty damn well already. I'm just saying 
that it's not perfect.

See __d_lookup() for details.

			Linus
