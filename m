Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVAYFEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVAYFEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 00:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVAYFEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 00:04:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:24759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbVAYFD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 00:03:58 -0500
Date: Mon, 24 Jan 2005 21:03:53 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Chris Wright <chrisw@osdl.org>, <rddunlap@osdl.org>
cc: <dev@osdl.org>, <stp-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <hanrahat@osdl.org>
Subject: Re: [torvalds@osdl.org: Re: Memory leak in 2.6.11-rc1?]
In-Reply-To: <20050124145920.X469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0501242056220.616-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

I applied the patch and reran the test on a RH 9.0 system.  LTP is
continuing past where it failed before, and processes are not getting
killed, so I assume the OOM killer is no longer getting activated.

There is a new behavior, though.  Now the test is hanging indefinitely
on the nptl01 test.  I am assuming that since it passed the spot that it
had failed before, that this is an unrelated issue.

Bryce


On Mon, 24 Jan 2005, Chris Wright wrote:
> Any chance you could re-try with this patch applied?
>
> ----- Forwarded message from Linus Torvalds <torvalds@osdl.org> -----
>
> Date: 	Mon, 24 Jan 2005 14:35:47 -0800 (PST)
> From: Linus Torvalds <torvalds@osdl.org>
> To: Andrew Morton <akpm@osdl.org>
> cc: Jens Axboe <axboe@suse.de>, alexn@dsv.su.se, kas@fi.muni.cz,
>    linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
> Subject: Re: Memory leak in 2.6.11-rc1?
>
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
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> ----- End forwarded message -----
>
>



