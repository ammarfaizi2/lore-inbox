Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264442AbRFOQQ5>; Fri, 15 Jun 2001 12:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264439AbRFOQQr>; Fri, 15 Jun 2001 12:16:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59140 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264437AbRFOQQe>;
	Fri, 15 Jun 2001 12:16:34 -0400
Date: Fri, 15 Jun 2001 17:16:32 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Final call for testers][PATCH] superblock handling changes (2.4.6-pre3)
Message-ID: <20010615171632.C9522@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0106130044390.942-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0106150100210.7244-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0106150100210.7244-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jun 15, 2001 at 01:10:00AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 01:10:00AM -0400, Alexander Viro wrote:
> +static inline void write_super(struct super_block *sb)
> +{
> +	lock_super(sb);
> +	if (sb->s_root && sb->s_dirt)
				^^^^
When I first looked at this, I thought it was a typo.  I don't think we
should have s_dirty and s_dirt as fields of the superblock.  how about
s_dirty_inodes and s_isdirty, respectively?

> +restart:
> +	spin_lock(&sb_lock);
> +	sb = sb_entry(super_blocks.next);
> +	while (sb != sb_entry(&super_blocks))
> +		if (sb->s_dirt) {
> +			sb->s_count++;
> +			spin_unlock(&sb_lock);
> +			down_read(&sb->s_umount);
> +			write_super(sb);
> +			drop_super(sb);
> +			goto restart;
> +		} else
> +			sb = sb_entry(sb->s_list.next);
> +	spin_unlock(&sb_lock);

I think this could be clearer.

	struct list_head *tmp;
restart:
	spin_lock(&sb_lock);
	list_for_each(tmp, super_blocks) {
		struct super_block *sb = sb_entry(tmp);
		if (!sb->s_dirt)
			continue;
		spin_unlock(&sb_lock);
		down_read(&sb->s_umount);
		write_super(sb);
		drop_super(sb);
		goto restart;
	}
	spin_unlock(&sb_lock);

> @@ -773,16 +810,16 @@
>  				       void *data, int silent)
>  {
>  	struct super_block * s;
> -	s = get_empty_super();
> +	s = alloc_super();
>  	if (!s)
>  		goto out;
>  	s->s_dev = dev;
>  	s->s_bdev = bdev;
>  	s->s_flags = flags;
> -	s->s_dirt = 0;
>  	s->s_type = type;
> -	s->s_dquot.flags = 0;
> -	s->s_maxbytes = MAX_NON_LFS;
> +	spin_lock(&sb_lock);
> +	list_add (&s->s_list, super_blocks.prev);

I'd use list_add_tail(&s->s_list, super_blocks);

> -	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
> +	if (atomic_read(&sb->s_active) > 1) {

I'm happy to see that line disappear.  It was mightily confusing.

-- 
Revolutions do not require corporate support.
