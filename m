Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264458AbRFORD6>; Fri, 15 Jun 2001 13:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbRFORDs>; Fri, 15 Jun 2001 13:03:48 -0400
Received: from geos.coastside.net ([207.213.212.4]:55733 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S264458AbRFORDc>; Fri, 15 Jun 2001 13:03:32 -0400
Mime-Version: 1.0
Message-Id: <p0510030cb74fef8a9b2a@[207.213.214.37]>
In-Reply-To: <20010615171632.C9522@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0106130044390.942-100000@weyl.math.psu.edu>
 <Pine.GSO.4.21.0106150100210.7244-100000@weyl.math.psu.edu>
 <20010615171632.C9522@parcelfarce.linux.theplanet.co.uk>
Date: Fri, 15 Jun 2001 10:02:55 -0700
To: Matthew Wilcox <matthew@wil.cx>, Alexander Viro <viro@math.psu.edu>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [Final call for testers][PATCH] superblock handling changes
 (2.4.6-pre3)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:16 PM +0100 2001-06-15, Matthew Wilcox wrote:
>I think this could be clearer.
>
>	struct list_head *tmp;
>restart:
>	spin_lock(&sb_lock);
>	list_for_each(tmp, super_blocks) {
>		struct super_block *sb = sb_entry(tmp);
>		if (!sb->s_dirt)
>			continue;
>		spin_unlock(&sb_lock);
>		down_read(&sb->s_umount);
>		write_super(sb);
>		drop_super(sb);
>		goto restart;
>	}
>	spin_unlock(&sb_lock);

A minor improvement, IMO, is:

	struct list_head *tmp;
restart:
	spin_lock(&sb_lock);
	list_for_each(tmp, super_blocks) {
		struct super_block *sb = sb_entry(tmp);
		if (sb->s_dirt) {
			sb->s_count++;
			spin_unlock(&sb_lock);
			down_read(&sb->s_umount);
			write_super(sb);
			drop_super(sb);
			goto restart;
		}
	}
	spin_unlock(&sb_lock);

-- 
/Jonathan Lundell.
