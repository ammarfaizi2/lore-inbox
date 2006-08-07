Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWHGWpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWHGWpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHGWpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:45:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41905 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932313AbWHGWpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:45:22 -0400
Message-ID: <44D7C26F.1040609@sandeen.net>
Date: Mon, 07 Aug 2006 17:45:03 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: dan@pwienterprises.com
CC: linux-kernel@vger.kernel.org, bfennema@falcon.csc.calpoly.edu
Subject: Re: [PATCH]: initialize parts of udf inode earlier in create
References: <44D36E60.2020006@sandeen.net> <1154934860.6783.267775866@webmail.messagingengine.com>
In-Reply-To: <1154934860.6783.267775866@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan@pwienterprises.com wrote:
> I ran into the same issue today, but when listing a directory with
> invalid/corrupt entries:

...

> The following patch to udf_alloc_inode() should take care of both (and
> other similar) cases, but I've only tested it with udf_lookup().
> 
> Dan
> 
> --
> 
> Signed-off-by: Dan Bastone <dan@pwienterprises.com>
> 
> --- linux-2.6.17.7/fs/udf/super.c.orig
> +++ linux-2.6.17.7/fs/udf/super.c
> @@ -116,6 +116,13 @@
>         ei = (struct udf_inode_info *)kmem_cache_alloc(udf_inode_cachep,
>         SLAB_KERNEL);
>         if (!ei)
>                 return NULL;
> +
> +       ei->i_unique = 0;
> +       ei->i_lenExtents = 0;
> +       ei->i_next_alloc_block = 0;
> +       ei->i_next_alloc_goal = 0;
> +       ei->i_strat4096 = 0;
> +
>         return &ei->vfs_inode;
>  }

That looks fine to me, but I wonder if there's a cleaner way, rather 
than sprinkling these initializations in the code.  If __udf_read_inode 
fails, then it calls mark_bad_inode; maybe the code should check for 
that before trying to discard prealloced blocks?  I don't really know 
enough about all the UDF codepaths (by far!) to know for sure what the 
best solution is, here.

I do notice that for example ext2_put_inode() checks for bad_inode 
before calling ext2_discard_prealloc.  And it looks like the udf code 
may have a little ext2 history in it :)

-Eric

(hm, just realized that my original patch in this thread isn't strictly 
necessary for the reasons I originally proposed; udf_clear_inode checks 
for MS_RDONLY before discarding the prealloc, and my first UDF patch set 
the MS_RDONLY flag on these read-only-marked filesystems... ah well)
