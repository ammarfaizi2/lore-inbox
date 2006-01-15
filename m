Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWAOWs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWAOWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWAOWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:48:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51897 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750941AbWAOWs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:48:28 -0500
Date: Mon, 16 Jan 2006 09:48:17 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-xfs@oss.sgi.com
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
Message-ID: <20060116094817.A8425113@wobbly.melbourne.sgi.com>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060115221458.GA3521@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060115221458.GA3521@inferi.kami.home>; from malattia@linux.it on Sun, Jan 15, 2006 at 11:14:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 11:14:58PM +0100, Mattia Dongili wrote:
> [CC-in relevant people/ML]
> 
> Hello!
> 
> second bisection result!
> 
> On Tue, Jan 10, 2006 at 05:00:37PM -0800, Andrew Morton wrote:
> > Mattia Dongili <malattia@linux.it> wrote:
> [...]
> > > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
> > >    reproducible (have some activity on the fs and suspend)
> > 
> > No significant reiser3 changes in there, so I'd be suspecting something
> > else has gone haywire.
> 
> you're right: git-xfs.patch is the bad guy.
> 
> Unfortunately netconsole isn't helpful in capturing the oops (no serial
> ports here) but I have two more shots (more readable):
> http://oioio.altervista.org/linux/dsc03148.jpg
> http://oioio.altervista.org/linux/dsc03149.jpg

Hmm, thats odd.  It seems to be coming from:
reiserfs_commit_page -> reiserfs_add_ordered_list -> __add_jh(inline)

I guess XFS may have left a buffer_head in an unusual state (with some
private flag/b_private set), somehow, and perhaps that buffer_head has
later been allocated for a page in a reiserfs write.  Does this patch,
below, help at all?

I see one BUG check in __add_jh for non-NULL b_private, but can't see
the top of your console output from the photos - is there a preceding
line with "kernel BUG at ..." in it?

cheers.

-- 
Nathan


--- fs/buffer.c.orig	2006-01-16 10:15:01.332010750 +1100
+++ fs/buffer.c	2006-01-16 10:18:15.276131500 +1100
@@ -1027,7 +1027,7 @@ try_again:
 		/* Link the buffer to its page */
 		set_bh_page(bh, page, offset);
 
-		bh->b_end_io = NULL;
+		init_buffer(bh, NULL, NULL);
 	}
 	return head;
 /*
