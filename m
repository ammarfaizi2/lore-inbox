Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274881AbRIVAxY>; Fri, 21 Sep 2001 20:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274883AbRIVAxP>; Fri, 21 Sep 2001 20:53:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:474 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274881AbRIVAxC>;
	Fri, 21 Sep 2001 20:53:02 -0400
Date: Fri, 21 Sep 2001 20:53:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: swapoff() behaviour
In-Reply-To: <Pine.GSO.4.21.0109212033470.9760-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109212046570.9760-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Alexander Viro wrote:

> 	Guys, do we want
> 
> swapon /dev/sda6
> cp -a /dev/sda6 /tmp
> swapoff /tmp/sda6
> 
> to work?  Code in sys_swapoff() looks like an attempt to make it work.
> However, it doesn't -
>                 if ((p->flags & SWP_WRITEOK) == SWP_WRITEOK) {
>                         if (p->swap_file) {
>                                 if (p->swap_file == nd.dentry)
>                                   break;
>                         } else {
>                                 if (S_ISBLK(nd.dentry->d_inode->i_mode)
>                                     && (p->swap_device == nd.dentry->d_inode->i_
> rdev))
>                                   break;
>                         }
> 		}
> 
> _never_ hits the second break since we have ->swap_file set for all
> active swap components, be they swap files or swap partitions.
> 
> Comments?  The same goes for 2.2, BTW.

After a look through the CVS, it seems that prior to 2.1.45 we actually
had that behaviour - for swap partitions swapoff() cared only about
major:minor.  Since 2.1.45 we really need the same dentry - not even
the same inode (i.e.
swapon /dev/sda6 && ln /dev/sda6 /dev/foo && swapoff /dev/foo
is guaranteed to fail; prior to 2.1.45 it used to work).

In other words, during the last 4 years quite a few pieces of mm/swapfile.c
had been a dead code.  Looks like we either need to restore old behaviour
or perform the amputation.  Snippet above is not the only place of that
kind.

Linus, it's your call.

