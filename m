Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287173AbSAGVhw>; Mon, 7 Jan 2002 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSAGVhd>; Mon, 7 Jan 2002 16:37:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45068 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287156AbSAGVhX>;
	Mon, 7 Jan 2002 16:37:23 -0500
Message-ID: <3C3A150E.EA2F403F@mandrakesoft.com>
Date: Mon, 07 Jan 2002 16:37:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <Pine.GSO.4.21.0201071401450.6842-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> Now, the problems I see with Jeff's variant:
> 
> a) if you make struct inode a part of ext2_inode - WTF bother with pointer?

You mean the typed pointer inside struct inode's union?  Because I
needed a way to go from struct inode to struct ext2_inode_info,
-without- a nasty cast.  inode->u.ext2_ip maintains the type information
without resorting to a nastier solution like an OFFSET_OF macro. 
Suggestions for improvement welcome.


> b) ->destroy_inode() / ->clear_inode().  Merge them - that way it's one
> method.

Agreed.  That would be [not yet written] patch8 in my plan.


> c) get_empty_inode() must die.  Make it new_inode() and be done with that.
> And have socket.c explicitly set ->i_dev to NODEV afterwards.

In my patch get_empty_inode and new_inode are completely identical. 
This is easy.


> d) ext2/balloc.c cleanup probably should be merged before.

I don't have an opinion on this one way or the other...


> I can live with "maintain refcounts in common part and leave allocation/freeing
> to filesystem".  It's definitely better than allocating/freeing opaque objects
> in VFS using numeric fields in fs_type.

Yes... the opacity factor in the other patch bothers me.


> We will need to set very strict rules on passing around/storing pointers to
> ext2_inode and its ilk, though.  There will be bugs when somebody just decides
> that keeping such pointers might be a good idea and forgets to be nice with
> ->i_count.  Or decrement it manually instead of calling iput(), etc.

Not doing so now is a shoot-on-sight offense, I thought...

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
