Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWHJGl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWHJGl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWHJGlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:41:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161098AbWHJGlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:41:52 -0400
Date: Wed, 9 Aug 2006 23:41:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 9/9]ext4 super block changes for >32 bit blocks numbers
Message-Id: <20060809234105.67414f03.akpm@osdl.org>
In-Reply-To: <1155172945.3161.88.camel@localhost.localdomain>
References: <1155172945.3161.88.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:22:25 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> In-kernel and on-disk super block changes to support >32 bit blocks numbers.
> 
> +static inline u32 EXT4_RELATIVE_ENCODE(ext4_fsblk_t group_base,
> +				       ext4_fsblk_t fs_block)
> +{
> +	s32 gdp_block;
> +
> +	if (fs_block < (1ULL<<32) && group_base < (1ULL<<32))
> +		return fs_block;
> +
> +	gdp_block = (fs_block - group_base);
> +	BUG_ON ((group_base + gdp_block) != fs_block);
> +
> +	return gdp_block;
> +}
> +
> +static inline ext4_fsblk_t EXT4_RELATIVE_DECODE(ext4_fsblk_t group_base,
> +						u32 gdp_block)
> +{
> +	if (group_base >= (1ULL<<32))
> +		return group_base + (s32) gdp_block;
> +
> +	if ((s32) gdp_block >= 0 && gdp_block < group_base &&
> +		  group_base + gdp_block >= (1ULL<<32))
> +		return group_base + gdp_block;
> +
> +	return gdp_block;
> +}

These seem far too large and far too commonly called to be inlined.

>  
> +
> +#define EXT4_BLOCKS_COUNT(s)	\
> +	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_blocks_count_hi) << 32) |	\
> +	 	(__u64)le32_to_cpu((s)->s_blocks_count))
> +#define EXT4_BLOCKS_COUNT_SET(s,v)	do {				\
> +	(s)->s_blocks_count = cpu_to_le32((v));				\
> +	(s)->s_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
> +} while (0)
> +
> +#define EXT4_R_BLOCKS_COUNT(s)	\
> +	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_r_blocks_count_hi) << 32) |	\
> +		 (__u64)le32_to_cpu((s)->s_r_blocks_count))
> +#define EXT4_R_BLOCKS_COUNT_SET(s,v)	do {				\
> +	(s)->s_r_blocks_count = cpu_to_le32((v));			\
> +	(s)->s_r_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
> +} while (0)
> +
> +#define EXT4_FREE_BLOCKS_COUNT(s)					\
> +	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_free_blocks_count_hi) << 32) | \
> +		 (__u64)le32_to_cpu((s)->s_free_blocks_count))
> +#define EXT4_FREE_BLOCKS_COUNT_SET(s,v)	do {				\
> +	(s)->s_free_blocks_count = cpu_to_le32((v));			\
> +	(s)->s_free_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
> +} while (0)

Can these not be implemented as C functions?

