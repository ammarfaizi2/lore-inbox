Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264444AbRFOQfN>; Fri, 15 Jun 2001 12:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264441AbRFOQfD>; Fri, 15 Jun 2001 12:35:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60575 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264439AbRFOQeq>;
	Fri, 15 Jun 2001 12:34:46 -0400
Date: Fri, 15 Jun 2001 12:34:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Final call for testers][PATCH] superblock handling changes
 (2.4.6-pre3)
In-Reply-To: <20010615171632.C9522@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0106151221190.8909-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Matthew Wilcox wrote:

> > +	while (sb != sb_entry(&super_blocks))
> > +		if (sb->s_dirt) {
> > +			sb->s_count++;
			^^^^^^^^^^^^^^
> > +			spin_unlock(&sb_lock);
> > +			down_read(&sb->s_umount);
> > +			write_super(sb);
> > +			drop_super(sb);
> > +			goto restart;
> > +		} else
> > +			sb = sb_entry(sb->s_list.next);
> > +	spin_unlock(&sb_lock);
> 
> I think this could be clearer.
> 
> 	struct list_head *tmp;
> restart:
> 	spin_lock(&sb_lock);
> 	list_for_each(tmp, super_blocks) {
> 		struct super_block *sb = sb_entry(tmp);
> 		if (!sb->s_dirt)
> 			continue;
> 		spin_unlock(&sb_lock);
> 		down_read(&sb->s_umount);
> 		write_super(sb);
> 		drop_super(sb);
> 		goto restart;
> 	}
> 	spin_unlock(&sb_lock);

Aside of the missing ->s_count++ - no arguments.

> > @@ -773,16 +810,16 @@
> >  				       void *data, int silent)
> >  {
> >  	struct super_block * s;
> > -	s = get_empty_super();
> > +	s = alloc_super();
> >  	if (!s)
> >  		goto out;
> >  	s->s_dev = dev;
> >  	s->s_bdev = bdev;
> >  	s->s_flags = flags;
> > -	s->s_dirt = 0;
> >  	s->s_type = type;
> > -	s->s_dquot.flags = 0;
> > -	s->s_maxbytes = MAX_NON_LFS;
> > +	spin_lock(&sb_lock);
> > +	list_add (&s->s_list, super_blocks.prev);
> 
> I'd use list_add_tail(&s->s_list, super_blocks);

Umm... Why? I've no problems with either variant, but I really see no
clear win (or loss) in list_add_tail here. If there is some code that
relies on the order in that list it's badly broken - remember, we used
to reuse unmounted superblocks, so order might be almost arbitrary.
Not even "root is first", whatever value that might have - FS_SINGLE
filesystems ended up before the root.

