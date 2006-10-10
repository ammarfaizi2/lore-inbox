Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWJJUhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWJJUhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWJJUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:37:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030305AbWJJUhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:37:55 -0400
Date: Tue, 10 Oct 2006 13:36:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Bryan Henderson <hbryan@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       "H. Peter Anvin" <hpa@zytor.com>
Cc: sct@redhat.com, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] ext3: fsid for statvfs
Message-Id: <20061010133636.6217a11b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610101131001.10574@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0610101131001.10574@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 11:32:13 +0300 (EEST)
Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Update ext3_statfs to return an FSID that is a 64 bit XOR of the 128 bit
> filesystem UUID as suggested by Andreas Dilger. See the following Bugzilla
> entry for details:
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=136
> 
> Cc: Andreas Dilger <adilger@clusterfs.com>
> Cc: Stephen Tweedie <sct@redhat.com>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Deja vu.  Gosh, has it really been four years?

Combatants cc'ed ;)

> 
>  fs/ext3/super.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: 2.6/fs/ext3/super.c
> ===================================================================
> --- 2.6.orig/fs/ext3/super.c
> +++ 2.6/fs/ext3/super.c
> @@ -2385,6 +2385,7 @@ static int ext3_statfs (struct dentry * 
>  	struct ext3_super_block *es = sbi->s_es;
>  	ext3_fsblk_t overhead;
>  	int i;
> +	u64 fsid;
>  
>  	if (test_opt (sb, MINIX_DF))
>  		overhead = 0;
> @@ -2431,6 +2432,10 @@ static int ext3_statfs (struct dentry * 
>  	buf->f_files = le32_to_cpu(es->s_inodes_count);
>  	buf->f_ffree = percpu_counter_sum(&sbi->s_freeinodes_counter);
>  	buf->f_namelen = EXT3_NAME_LEN;
> +	fsid = le64_to_cpup((void *)es->s_uuid) ^
> +	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
> +	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
> +	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
>  	return 0;
>  }
>  

ext2 and ext4 would need patching too...
