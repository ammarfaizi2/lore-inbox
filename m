Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274213AbRISU1f>; Wed, 19 Sep 2001 16:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274214AbRISU10>; Wed, 19 Sep 2001 16:27:26 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:40443 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274213AbRISU1P>; Wed, 19 Sep 2001 16:27:15 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 14:26:51 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Swanson <swansma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition locking
Message-ID: <20010919142651.O14526@turbolinux.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Swanson <swansma@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BA7FF92.D6477904@yahoo.com> <E15jn1X-0003cU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15jn1X-0003cU-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2001  20:28 +0100, Alan Cox wrote:
> > [Re: removing the fs union from struct inode]
> 
> However you don't need to remove anything for that

No, but there are other things which will probably remove the union from
struct inode in 2.5.  Since it is starting to get so huge, it is a penalty
for filesystems that don't need all of this space in each inode.  Al Viro
has patches already to move some of the fs types into their own slab cache.

It may make sense to leave a small number of bytes inside the inode struct
(they would be used anyways for alignment/padding in the inode slab) for
filesystems that only have very small space requirements.

If you move the union to an external declaration, you can do things like:

static inline struct fs_inode_info *FSI(inode)
{
	if (sizeof(union inode_fs_data) >= sizeof(struct fs_inode_info))
		return (struct fs_inode_info *)&inode->u.generic_ip;
	else
		return (struct fs_inode_info *)inode->u.generic_ip;
}

and the compiler should pick one or the other by virtue of the fact that
it is comparing constants which can be resolved at compile time.  Sadly
sizeof cannot be handled by the preprocessor so the following does not work:

#if sizeof(union inode_fs_data) >= sizeof(struct fs_inode_info)
#define FSI(inode) ((struct fs_inode_info *)&(inode)->u.generic_ip);
#else
#define FSI(inode) ((struct fs_inode_info *)(inode)->u.generic_ip);
#endif

which would guarantee that we do not bloat the code or impose run-time
overhead.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

