Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSFRWSy>; Tue, 18 Jun 2002 18:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSFRWSx>; Tue, 18 Jun 2002 18:18:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28572 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317636AbSFRWSw>;
	Tue, 18 Jun 2002 18:18:52 -0400
Date: Tue, 18 Jun 2002 18:18:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: Shrinking ext3 directories
In-Reply-To: <20020618225005.A7897@redhat.com>
Message-ID: <Pine.GSO.4.21.0206181812220.13571-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Jun 2002, Stephen C. Tweedie wrote:

> Hi,
> 
> On Tue, Jun 18, 2002 at 06:08:28PM +0200, DervishD wrote:
>  
> >     All of you know that if you create a lot of files or directories
> > within a directory on ext2/3 and after that you remove them, the
> > blocks aren't freed (this is the reason behind the lost+found block
> > preallocation). If you want to 'shrink' the directory now that it
> > doesn't contain a lot of leafs, the only solution I know is creating
> > a new directory, move the remaining leafs to it, remove the
> > 'big-unshrinken' directory and after that renaming the new directory
> 
> Right.  Shrinking directories is not implemented for ext2 or ext3 at
> the moment.  However, I know that Daniel Phillips has been thinking
> about adding that for his HTree extensions which add fast directory
> indexing to ext2/3.

<shrug> for ext2 a limited form of "shrinking" is easy to implement.
ext2_delete_entry() can easily notice that it's about to create an
empty entry spanning entire last block.  In that case it should
just walk back and check beginnings of previous blocks, as long
as they are empty (inode = 0, len = block size).  Then it's vmtruncate()
time - all IO on directories is protected by i_sem, so we are safe.

IOW, making sure that empty blocks in the end of directory get freed
is a matter of 10-20 lines.  If you want such patch - just tell, it's
half an hour of work...

