Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSKGDGT>; Wed, 6 Nov 2002 22:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266309AbSKGDGT>; Wed, 6 Nov 2002 22:06:19 -0500
Received: from n1x6.imsa.edu ([143.195.1.6]:11241 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S266308AbSKGDGS>;
	Wed, 6 Nov 2002 22:06:18 -0500
Date: Wed, 6 Nov 2002 21:12:56 -0600
From: Maciej Babinski <maciej@imsa.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: Jens Axboe <axboe@suse.de>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 ext3 errors
Message-ID: <20021106211256.A5330@imsa.edu>
References: <20021106075406.GC1137@suse.de> <20021106175542.A8364@imsa.edu> <3DC9B2D9.1081249C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC9B2D9.1081249C@digeo.com>; from akpm@digeo.com on Wed, Nov 06, 2002 at 04:24:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've applied this patch, I can't reproduce the problem. Thanks!

                                             Maciej

> 
> Looks like we had some overeager cut-n-paste in the Orlov
> conversion.
> 
> The per-blockgroup inode and directory accounting is being
> double-accounted for, and we're not journalling the updates...
> 
> This should fix it up, but it is untested.
> 
> 
> --- 25/fs/ext3/ialloc.c~ext3-inodes-count-fix	Wed Nov  6 16:16:55 2002
> +++ 25-akpm/fs/ext3/ialloc.c	Wed Nov  6 16:24:20 2002
> @@ -227,11 +227,6 @@ static int find_group_dir(struct super_b
>  	}
>  	if (!best_desc)
>  		return -1;
> -	best_desc->bg_free_inodes_count =
> -		cpu_to_le16(le16_to_cpu(best_desc->bg_free_inodes_count) - 1);
> -	best_desc->bg_used_dirs_count =
> -		cpu_to_le16(le16_to_cpu(best_desc->bg_used_dirs_count) + 1);
> -	mark_buffer_dirty(best_bh);
>  	return best_group;
>  }
>  
> @@ -355,14 +350,7 @@ fallback:
>  	}
>  
>  	return -1;
> -
>  found:
> -	desc->bg_free_inodes_count =
> -		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
> -	desc->bg_used_dirs_count =
> -		cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
> -	sbi->s_dir_count++;
> -	mark_buffer_dirty(bh);
>  	return group;
>  }
>  
> @@ -410,9 +398,6 @@ static int find_group_other(struct super
>  	return -1;
>  
>  found:
> -	desc->bg_free_inodes_count =
> -		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
> -	mark_buffer_dirty(bh);
>  	return group;
>  }
>  
> @@ -521,9 +506,11 @@ repeat:
>  	if (err) goto fail;
>  	gdp->bg_free_inodes_count =
>  		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
> -	if (S_ISDIR(mode))
> +	if (S_ISDIR(mode)) {
>  		gdp->bg_used_dirs_count =
>  			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) + 1);
> +		EXT3_SB(sb)->s_dir_count++;
> +	}
>  	BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
>  	err = ext3_journal_dirty_metadata(handle, bh2);
>  	if (err) goto fail;
> 
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
