Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUFYJOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUFYJOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUFYJOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:14:31 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13580 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265590AbUFYJO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:14:28 -0400
Message-ID: <40DBED77.6090704@hist.no>
Date: Fri, 25 Jun 2004 11:16:39 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net>
In-Reply-To: <40DB605D.6000409@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I know this has been mentioned before, or at least I *hope* it has.
>
Take a look at history.  Linus said that creating a journalled fs was
fine, but they had to make it a new fs so as to not make ext2 unstable
while working on it.  Therefore - ext3.  Now ext3 was based on ext2
so it basically started out as a copy.

> ext2 and ext3 are essentially the same, aren't they?  I'm looking at a
> diff, and other than ext2->ext3, I'm seeing things like:
>
> - -              mark_inode_dirty(inode);
> +              ext3_mark_inode_dirty(handle, inode);
>
> and thinking
>
> - -              mark_inode_dirty(inode);
> +#ifdef CONFIG_EXT2_JOURNALED
> +              if (fs->journaled)
> +                 extjnl_mark_inode_dirty(handle, inode);
> +              else
> +#endif
> +                 mark_inode_dirty(inode);
>
> would have been so much more appropriate.  

No, because:
1. Code withg lots of #ifdefs isn't popular here.  So don't suggest it,
    because no argument will win this one.
2. Did it ever occur to you that some people want to support both
    ext2 and ext3 with the same kernel.  Impossible with your scheme,
    and don't say "nobody needs that".
3. ext3 may evolve differently from ext2 with time.  Common code
    makes people do things in suboptimal ways in order to keep
    commonality.  There is _no_ commonality pressure when the
    sources are separate.  ext3 developers are free to change their
    code in ways that could break operation of the non-journalling ext2.
    And vice-versa- ext2 is free do use ordering optimizations incompatible
    with journalling.
4. "Appropriate" doesn't matter.  Readability and maintainability does.
5. Linus demanded two fs'es in this case, so there is no discussion.

> I see entire functions that
> are dropped and added; the dropped can stay, the added can be added,
> they can be used conditionally.  I also see mostly code that just was
> copied verbatim, or was s/EXT2/EXT3/ or s/ext2/ext3/ .  That's just not
> appropriate.

This is not much of a problem - a few kB wasted on keeping some
identical copies of code.  You might be able to establish a
ext23_common.c, _if_ you can prove that the stuff therein really
won't ever be different in ext2 and ext3.


>
> The ext2 driver can even load up ext3 partitions without using the
> journal, if it still behaves like it did in 2.4.20.  I say collapse them
> in on eachother.

This was very useful during initial development, when ext3 couldn't
really be trusted.  It is still useful because it allows easy conversion
of existing filesystems, and a single fsck. 
Compatibility might break someday though.
The fs code may take very different approaches with time anyway,
even if the disk layout remains compatible. 

Helge Hafting
