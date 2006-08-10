Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWHJGkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWHJGkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWHJGkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:40:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161088AbWHJGkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:40:37 -0400
Date: Wed, 9 Aug 2006 23:40:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/9] support >32 bit ext4 filesystem block type in
 kernel
Message-Id: <20060809234033.4681017b.akpm@osdl.org>
In-Reply-To: <1155172860.3161.82.camel@localhost.localdomain>
References: <1155172860.3161.82.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:21:00 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> 
> Redefine ext4 in-kernel filesystem block type (ext4_fsblk_t) from unsigned
> long to sector_t, to allow kernel to handle  >32 bit ext4 blocks.
> 

I don't get it.

Randomly-chosen snippet:

> @@ -274,7 +274,8 @@ static int find_group_orlov(struct super
>  	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
>  	avefreei = freei / ngroups;
>  	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
> -	avefreeb = freeb / ngroups;
> +	avefreeb = freeb;
> +	sector_div(avefreeb, ngroups);
>  	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
>  
>  	if ((parent == sb->s_root->d_inode) ||

Here, `avefreeb' is still a 32-bit type.  Why feed it into sector_div()?

> @@ -303,13 +304,15 @@ static int find_group_orlov(struct super
>  		goto fallback;
>  	}
>  
> -	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) - freeb) / ndirs;
> +	blocks_per_dir = le32_to_cpu(es->s_blocks_count) - freeb;
> +	sector_div(blocks_per_dir, ndirs);

And here le32_to_cpu() is very much a 32-bit type.  Why sector_div()?

And I agree with me: we want to get all the sector_t's out of this
filesystem.  unsigned long long, do_div()?

