Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVBBS3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVBBS3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVBBS3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:29:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:18310 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262705AbVBBS1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:27:52 -0500
Date: Wed, 2 Feb 2005 10:27:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Lennert Van Alboom <lennert.vanalboom@ugent.be>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       alexn@dsv.su.se, kas@fi.muni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1?
In-Reply-To: <1107366560.5540.39.camel@localhost>
Message-ID: <Pine.LNX.4.58.0502021008350.2362@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz>  <20050124125649.35f3dafd.akpm@osdl.org>
  <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org> 
 <200502021030.06488.lennert.vanalboom@ugent.be>  <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
 <1107366560.5540.39.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Feb 2005, Dave Hansen wrote:
> 
> In any case, I'm running a horribly hacked up kernel, but this is
> certainly a new problem, and not one that I've run into before.  Here's
> output from the new CONFIG_PAGE_OWNER code:

Hmm.. Everything looks fine. One new thing about the pipe code is that it 
historically never allocated HIGHMEM pages, and the new code no longer 
cares and thus can allocate anything. So there's nothing strange in your 
output that I can see.

How many of these pages do you see? It's normal for a single pipe to be 
associated with up to 16 pages (although that would only happen if there 
is no reader or a slow reader, which is obviously not very common). 

Now, if your memory freeing code depends on the fact that all HIGHMEM
pages are always "freeable" (page cache + VM mappings only), then yes, the
new pipe code introduces highmem pages that weren't highmem before.  But
such long-lived and unfreeable pages have been there before too:  kernel
modules (or any other vmalloc() user, for that matter) also do the same
thing.

Now, there _is_ another possibility here: we might have had a pipe leak
before, and the new pipe code would potentially make it a lot more
noticeable, with up to sixteen times as many pages lost if somebody freed
a pipe inode without calling "free_pipe_info()". I don't see where that 
would happen - all the normal "release" functions seem fine.

Hmm.. Adding a 

	WARN_ON(inode->i_pipe);

to "iput_final()" might be a good idea - showing if somebody is releasing 
an inode while it still associated with a pipe-info data structure.

Also, while I don't see how a write could leak, but maybe you could you
add a

	WARN_ON(buf->ops);

to the pipe_writev() case just before we insert a new buffer (ie to just
after the comment that says "Insert it into the buffer array"). Just to
see if the circular buffer handling might overwrite an old entry (although
I _really_ don't see that - it's not like the code is complex, and it
would also be accompanied by data-loss in the pipe, so we'd have seen
that, methinks).

		Linus
