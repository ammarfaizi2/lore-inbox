Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWATTnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWATTnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWATTno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:43:44 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:40728 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932087AbWATTnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:43:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hgoVKJqj8EROii6R264ws1uSnbEh3cnygn3wS8jlbYRpgEFfbc7oXCifLC/1R9L1oPfBL+5+Mejs9LgDk7ueH/zJLNIlQDn/vyGM6al8MtxPq5u/QTaRlJvjVrhO19+ov1tbPC+0pFlYzGOkTfbQ+HEHsyunh2ei4461T22Rw2c=
Date: Fri, 20 Jan 2006 23:01:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org
Subject: Re: [PATCH] ext3: Properly report backup blocks present in a group
Message-ID: <20060120200106.GA8707@mipter.zuzino.mipt.ru>
References: <20060120183721.GB25386@br.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120183721.GB25386@br.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 06:37:21PM +0000, Glauber de Oliveira Costa wrote:
> In filesystems with the meta block group flag on, ext3_bg_num_gdb()
> fails to report the correct number of blocks used to store the group
> descriptor backups in a given group. It happens because meta_bg
> follows a different logic from the original ext3 backup placement
> in groups multiples of 3, 5 and 7.

> --- a/fs/ext3/balloc.c
> +++ b/fs/ext3/balloc.c
> @@ -1510,9 +1529,15 @@ int ext3_bg_has_super(struct super_block
>   */
>  unsigned long ext3_bg_num_gdb(struct super_block *sb, int group)
>  {
> -	if (EXT3_HAS_RO_COMPAT_FEATURE(sb,EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER)&&
> -	    !ext3_group_sparse(group))
> -		return 0;
> -	return EXT3_SB(sb)->s_gdb_count;
> +	unsigned long first_meta_bg =
> +		cpu_to_le32(EXT3_SB(sb)->s_es->s_first_meta_bg);
> +	unsigned long metagroup = group / EXT3_DESC_PER_BLOCK(sb);
> +
> +	if (!EXT3_HAS_INCOMPAT_FEATURE(sb,EXT3_FEATURE_INCOMPAT_META_BG)
> +			|| metagroup < first_meta_bg)
			   ^^^^^^^^^^^^^^^^^^^^^^^^^

Comparison between little-endian and host-endian variables.

> +		return ext3_bg_num_gdb_nometa(sb,group);
> +
> +	return ext3_bg_num_gdb_meta(sb,group);

