Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWEEOou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWEEOou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWEEOou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:44:50 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:4070 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751569AbWEEOou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:44:50 -0400
Message-ID: <346840286.22726@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 5 May 2006 22:44:51 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060505144451.GA6134@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Linus Torvalds <torvalds@osdl.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org> <20060503041106.GC5915@mail.ustc.edu.cn> <1146677280.8373.59.camel@dyn9047017100.beaverton.ibm.com> <346733486.30800@ustc.edu.cn> <Pine.LNX.4.64.0605040800080.3908@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605040800080.3908@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 08:03:50AM -0700, Linus Torvalds wrote:
> Actually, I did something even simpler for a totally one-off thing: you 
> don't actually even need to drop caches or track pretty much anything, 
> it's sufficient for most analysis to just have a timestamp on each page 
> cache, and then have some way to read out the current cached contents.
> 
> You can then use the timestamps to get a pretty good idea of what order 
> things happened in.
 
> The really nice thing was that you don't even have to set the timestamp in 
> any complex place: you do it at page _allocation_ time. That automatically 
> gets the right answer for any page cache page, and you can do it in a 
> single place.

Looks nice.  A detailed scheme might be:

1) ctime/atime for each radixtree node(or, cluser of pages)
It seems to be a good accuracy/overhead compromise.
And is perfect for the most common case of sequential accesses.

struct radix_tree_node {
+        unsigned long ctime, atime;
} 

radix_tree_node_alloc()
{
+        node->ctime = some_virtual_time();
}

radix_tree_lookup_slot()
{
+        node->atime = some_virtual_time();
}

2) eviction-time for each recently evicted page
Store eviction-time _in place_ in the slot that used to store the
page's address, with minimal space/time impact.

+#define SLOT_IS_EVICTION_TIME  1
radix_tree_delete()
{
-                pathp->node->slots[pathp->offset] = NULL;
+                pathp->node->slots[pathp->offset] =
+                                 some_virtual_time() | SLOT_IS_EVICTION_TIME;
}

Regards,
Wu
