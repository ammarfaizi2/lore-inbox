Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312810AbSCYXBu>; Mon, 25 Mar 2002 18:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312831AbSCYXBa>; Mon, 25 Mar 2002 18:01:30 -0500
Received: from pc-80-195-35-27-ed.blueyonder.co.uk ([80.195.35.27]:36239 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S312829AbSCYXB1>; Mon, 25 Mar 2002 18:01:27 -0500
Date: Mon, 25 Mar 2002 23:01:14 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [Ext2-devel] [patch] speed up ext3 synchronous mounts
Message-ID: <20020325230114.N4328@redhat.com>
In-Reply-To: <3C9E4A18.7DDC68AB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 24, 2002 at 01:50:16PM -0800, Andrew Morton wrote:
 
> Again, we don't need to sync indirects as we dirty them because
> we run a commit if IS_SYNC(inode) prior to returning to the
> caller of write(2).
> 
> Writing a 10 meg file in 0.1 meg chunks is sped up by, err,
> a factor of fifty.  That's a best case.
> 
> --- linux-2.4.18-pre8/fs/ext3/inode.c	Tue Feb  5 00:33:05 2002
> +++ linux-akpm/fs/ext3/inode.c	Wed Feb  6 23:40:48 2002
> @@ -581,8 +581,6 @@ static int ext3_alloc_branch(handle_t *h
>  			
>  			parent = nr;
>  		}
> -		if (IS_SYNC(inode))
> -			handle->h_sync = 1;
>  	}
>  	if (n == num)
>  		return 0;

OK.  This was just a relic of ages back when we had an overarching
transaction spanning multiple writepages in ext3_file_write().  In
that case, setting that transaction to be synchronous multiple times
was no extra cost.  Doing it just once at the end should be fine.

Cheers,
 Stephen
