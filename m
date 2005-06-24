Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbVFXW4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbVFXW4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVFXW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:56:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262601AbVFXWyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:54:31 -0400
Date: Fri, 24 Jun 2005 15:55:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: sct@redhat.com, adilger@clusterfs.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH] Fix the error handling in direct I/O
Message-Id: <20050624155504.20b7a51e.akpm@osdl.org>
In-Reply-To: <6.0.0.20.2.20050622211238.03e6ba30@mailsv2.y.ecl.ntt.co.jp>
References: <6.0.0.20.2.20050622211238.03e6ba30@mailsv2.y.ecl.ntt.co.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp> wrote:
>
> 	Hello.
> 
> 	I fixed a bug on error handling in the direct I/O function.
> Currenlty, if a file is opened with the O_DIRECT|O_SYNC flag,
>   write() syscall cannot receive the EIO error just after
> I/O error(SCSI cable is disconnected etc.) occur.
> 
> 	Return values of other points that call generic_osync_inode()
> are treated appropriately.
> 
> 	With the following patch, this problem was fixed.
> 	Please apply this patch.
> 
> 	Thanks,
> 
> 
> Signed-off-by: Hisashi Hifumi  <hifumi.hisashi@lab.ntt.co.jp>
> 
> diff -Nru linux-2.6.12/mm/filemap.c linux-2.6.12_fix/mm/filemap.c
> --- linux-2.6.12/mm/filemap.c	2005-06-22 17:21:21.000000000 +0900
> +++ linux-2.6.12_fix/mm/filemap.c	2005-06-22 20:26:34.000000000 +0900
> @@ -1927,8 +1927,12 @@
>   	 * i_sem is held, which protects generic_osync_inode() from
>   	 * livelocking.
>   	 */
> -	if (written >= 0 && file->f_flags & O_SYNC)
> -		generic_osync_inode(inode, mapping, OSYNC_METADATA);
> +	if (written >= 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
> +		int err;
> +		err = generic_osync_inode(inode, mapping, OSYNC_METADATA);
> +		if (err < 0)
> +			written = err;
> +	}
>   	if (written == count && !is_sync_kiocb(iocb))
>   		written = -EIOCBQUEUED;
>   	return written; 

Yes, I suppose so.

I note that generic_file_aio_write_nolock() for O_SYNC or IS_SYNC will end
up calling generic_osync_inode() twice.  Once in sync_page_range_nolock()
and once in __generic_file_aio_write_nolock->generic_file_direct_write or
in __generic_file_aio_write_nolock->generic_file_buffered_write

It's all a bit of a mess.  I guess we should sit down and work out where we
actually want to do all this syncing and get it done consistently and
completely, all at the same level.  A filemap.c call graph would be needed :(
