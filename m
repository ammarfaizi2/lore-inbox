Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbUDBAhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUDBAhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:37:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:21202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263385AbUDBAfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:35:52 -0500
Date: Thu, 1 Apr 2004 16:37:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: weigand@i1.informatik.uni-erlangen.de, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-Id: <20040401163715.3592cedc.akpm@osdl.org>
In-Reply-To: <20040401220957.5f4f9ad2.ak@suse.de>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> he solution from back then I actually liked best was to just round
> up to the next second instead of rounding down when going from 1s 
> resolution to ns.
> 
> -Andi
> 
> e.g. like this for ext3 (untested). Does that fix your problem?
> 
> diff -u linux-2.6.5rc3-work/fs/ext3/inode.c-o linux-2.6.5rc3-work/fs/ext3/inode.c
> --- linux-2.6.5rc3-work/fs/ext3/inode.c-o	2004-04-01 22:07:43.000000000 +0200
> +++ linux-2.6.5rc3-work/fs/ext3/inode.c	2004-04-01 22:08:49.000000000 +0200
> @@ -2624,9 +2624,11 @@
>  	}
>  	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
>  	raw_inode->i_size = cpu_to_le32(ei->i_disksize);
> -	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
> -	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
> -	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
> +	/* round up because we cannot store nanoseconds. This avoids
> +	   the time jumping back when the inode is loaded again. */
> +	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec + 1);
> +	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec + 1);
> +	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec + 1);
>  	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
>  	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
>  	raw_inode->i_flags = cpu_to_le32(ei->i_flags);

I think this will cause the inode timestamps to keep on creeping forwards.

How about in ext3_read_inode() you do:

	inode->i_atime.tv_sec = le32_to_cpu(raw_inode->i_atime);
	inode->i_ctime.tv_sec = le32_to_cpu(raw_inode->i_ctime);
	inode->i_mtime.tv_sec = le32_to_cpu(raw_inode->i_mtime);
-	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_mtime.tv_nsec = 0;
+	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_mtime.tv_nsec = 999999999;

?

It still has problems, but I think they're smaller ones.
