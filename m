Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVBBTQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVBBTQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVBBTKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:10:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:19192 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262649AbVBBTHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:07:11 -0500
Subject: Re: Memory leak in 2.6.11-rc1?
From: Dave Hansen <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lennert Van Alboom <lennert.vanalboom@ugent.be>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       alexn@dsv.su.se, kas@fi.muni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502021008350.2362@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz>
	 <20050124125649.35f3dafd.akpm@osdl.org>
	 <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
	 <200502021030.06488.lennert.vanalboom@ugent.be>
	 <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
	 <1107366560.5540.39.camel@localhost>
	 <Pine.LNX.4.58.0502021008350.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 11:07:01 -0800
Message-Id: <1107371221.5540.81.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 10:27 -0800, Linus Torvalds wrote:
> How many of these pages do you see? It's normal for a single pipe to be 
> associated with up to 16 pages (although that would only happen if there 
> is no reader or a slow reader, which is obviously not very common). 

Strangely enough, it seems to be one single, persistent page.  

> Now, if your memory freeing code depends on the fact that all HIGHMEM
> pages are always "freeable" (page cache + VM mappings only), then yes, the
> new pipe code introduces highmem pages that weren't highmem before.  But
> such long-lived and unfreeable pages have been there before too:  kernel
> modules (or any other vmalloc() user, for that matter) also do the same
> thing.

That might be it.  For now, I just change the GFP masks for vmalloc() so
that I don't have to deal with it, yet.  But, I certainly can see that
how this is a new user of highmem.

I did go around killing processes like mad to see if any of them still
had a hold of the pipe, but the shotgun approach didn't seem to help.

> Now, there _is_ another possibility here: we might have had a pipe leak
> before, and the new pipe code would potentially make it a lot more
> noticeable, with up to sixteen times as many pages lost if somebody freed
> a pipe inode without calling "free_pipe_info()". I don't see where that 
> would happen - all the normal "release" functions seem fine.
> 
> Hmm.. Adding a 
> 
> 	WARN_ON(inode->i_pipe);
> 
> to "iput_final()" might be a good idea - showing if somebody is releasing 
> an inode while it still associated with a pipe-info data structure.
> 
> Also, while I don't see how a write could leak, but maybe you could you
> add a
> 
> 	WARN_ON(buf->ops);
> 
> to the pipe_writev() case just before we insert a new buffer (ie to just
> after the comment that says "Insert it into the buffer array"). Just to
> see if the circular buffer handling might overwrite an old entry (although
> I _really_ don't see that - it's not like the code is complex, and it
> would also be accompanied by data-loss in the pipe, so we'd have seen
> that, methinks).

I'll put the warnings in, and see if anything comes up.

-- Dave

