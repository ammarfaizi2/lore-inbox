Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVEMCmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVEMCmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 22:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVEMCmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 22:42:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:48348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262133AbVEMCmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 22:42:51 -0400
Date: Thu, 12 May 2005 19:42:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: linda.dunaphant@ccur.com
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: NFS: msync required for data writes to server?
Message-Id: <20050512194210.10a9dc93.akpm@osdl.org>
In-Reply-To: <1115950903.6319.25.camel@lindad>
References: <1115925686.6319.3.camel@lindad>
	<20050512175720.74ea6a3e.akpm@osdl.org>
	<1115950903.6319.25.camel@lindad>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Dunaphant <linda.dunaphant@ccur.com> wrote:
>
> The behavior that you describe is what I expected to see. However, with
>  my test program that mmap's the NFS file on the client, writes the data,
>  and then munmap's the file, this wasn't the case with the 2.6.9 based
>  kernel I was using. The file data was NEVER being written to the server.

There's something very wrong with that.

>  This afternoon I downloaded and built several later kernels. I found
>  that with 2.6.11, the problem still occurred. With 2.6.12-rc1, the
>  problem did not occur. I could see the proper data on the server. 
> 
>  Looking at the differences in fs/nfs between these trees I found a
>  change to nfs_file_release() in fs/nfs/file.c. When I applied this
>  change to my 2.6.9 tree, the data was written out to the server.
> 
>  @@ -105,6 +108,9 @@
>   static int
>   nfs_file_release(struct inode *inode, struct file *filp)
>   {
>  +       /* Ensure that dirty pages are flushed out with the right creds
>  */
>  +       if (filp->f_mode & FMODE_WRITE)
>  +               filemap_fdatawrite(filp->f_mapping);
>          return NFS_PROTO(inode)->file_release(inode, filp);
>   }

Well yes, that'll sync the file on close, but it doesn't explain the
original problem.

