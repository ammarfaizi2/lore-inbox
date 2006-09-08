Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWIHWSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWIHWSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWIHWSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:18:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:17179 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751129AbWIHWSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:18:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dPbM3Ja+2fuIFkj11Afrkg7QPWjMqSfINsry0S4ET+eMIpd1VRrJ6JghIkfh31P4q9hAVWBE1CCMBEuYLhuSPXCohWNkc3uUaW/kMpypCDUj/udWmLyuwRcQ9dWUS1l0r65WgsqTayrBdoMZQSPewZPScItpOW452j+ejcK+2SA=
Date: Sat, 9 Sep 2006 02:17:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC:PATCH 002/002] EXT3: Fix sparse warnings
Message-ID: <20060908221756.GB5192@martell.zuzino.mipt.ru>
References: <20060908213914.11498.3272.sendpatchset@kleikamp.austin.ibm.com> <20060908213927.11498.18166.sendpatchset@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908213927.11498.18166.sendpatchset@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 03:39:30PM -0600, Dave Kleikamp wrote:
> EXT3: Fix sparse warnings

> --- linux001/fs/ext3/resize.c
> +++ linux002/fs/ext3/resize.c

> @@ -380,7 +380,7 @@ static int add_new_gdb(handle_t *handle,
>  	struct buffer_head *dind;
>  	int gdbackups;
>  	struct ext3_iloc iloc;
> -	__u32 *data;
> +	__le32 *data;
>  	int err;
>  
>  	if (test_opt(sb, DEBUG))
> @@ -410,14 +410,14 @@ static int add_new_gdb(handle_t *handle,
>  		goto exit_bh;
>  	}
>  
> -	data = EXT3_I(inode)->i_data + EXT3_DIND_BLOCK;
> +	data = (__le32 *)(EXT3_I(inode)->i_data + EXT3_DIND_BLOCK);

Why cast is needed? i_data is __le32 * already.

> -	data = (__u32 *)dind->b_data;
> +	data = (__le32 *)dind->b_data;
>  	if (le32_to_cpu(data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)]) != gdblock) {
>  		ext3_warning(sb, __FUNCTION__,
>  			     "new group %u GDT block "E3FSBLK" not reserved",
> @@ -519,7 +519,7 @@ static int reserve_backup_gdb(handle_t *
>  	struct buffer_head *dind;
>  	struct ext3_iloc iloc;
>  	ext3_fsblk_t blk;
> -	__u32 *data, *end;
> +	__le32 *data, *end;
>  	int gdbackups = 0;
>  	int res, i;
>  	int err;
> @@ -528,7 +528,7 @@ static int reserve_backup_gdb(handle_t *
>  	if (!primary)
>  		return -ENOMEM;
>
> -	data = EXT3_I(inode)->i_data + EXT3_DIND_BLOCK;
> +	data = (__le32 *)(EXT3_I(inode)->i_data + EXT3_DIND_BLOCK);

Ditto.

> --- linux001/fs/ext3/super.c
> +++ linux002/fs/ext3/super.c
> @@ -2330,13 +2330,14 @@ static int ext3_remount (struct super_bl
>  
>  			ext3_mark_recovery_complete(sb, es);
>  		} else {
> -			__le32 ret;
> -			if ((ret = EXT3_HAS_RO_COMPAT_FEATURE(sb,
> +			int ret;
> +			__le32 ret_le;
> +			if ((ret_le = EXT3_HAS_RO_COMPAT_FEATURE(sb,
>  					~EXT3_FEATURE_RO_COMPAT_SUPP))) {
>  				printk(KERN_WARNING "EXT3-fs: %s: couldn't "
>  				       "remount RDWR because of unsupported "
>  				       "optional features (%x).\n",
> -				       sb->s_id, le32_to_cpu(ret));
> +				       sb->s_id, le32_to_cpu(ret_le));
>  				err = -EROFS;
>  				goto restore_opts;
>  			}

Get rid of "err = ret;" assignment below. It would be cleaner than
introducing new var.

