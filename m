Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVAZICM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVAZICM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVAZICM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:02:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38373 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262378AbVAZICH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:02:07 -0500
Date: Wed, 26 Jan 2005 09:01:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050126080152.GA2751@suse.de>
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2005, Linus Torvalds wrote:
> 
> 
> On Mon, 24 Jan 2005, Andrew Morton wrote:
> > 
> > Would indicate that the new pipe code is leaking.
> 
> Duh. It's the pipe merging.
> 
> 		Linus
> 
> ----
> --- 1.40/fs/pipe.c	2005-01-15 12:01:16 -08:00
> +++ edited/fs/pipe.c	2005-01-24 14:35:09 -08:00
> @@ -630,13 +630,13 @@
>  	struct pipe_inode_info *info = inode->i_pipe;
>  
>  	inode->i_pipe = NULL;
> -	if (info->tmp_page)
> -		__free_page(info->tmp_page);
>  	for (i = 0; i < PIPE_BUFFERS; i++) {
>  		struct pipe_buffer *buf = info->bufs + i;
>  		if (buf->ops)
>  			buf->ops->release(info, buf);
>  	}
> +	if (info->tmp_page)
> +		__free_page(info->tmp_page);
>  	kfree(info);
>  }

It's better now, no leak anymore. But the 2.6.11-rcX vm is still very
screwy, to get something close to nice and smooth behaviour I have to
run a fillmem every now and then to reclaim used memory.

-- 
Jens Axboe

