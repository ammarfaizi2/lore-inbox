Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSEXIA1>; Fri, 24 May 2002 04:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317111AbSEXIA0>; Fri, 24 May 2002 04:00:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40715 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317110AbSEXIAZ>;
	Fri, 24 May 2002 04:00:25 -0400
Message-ID: <3CEDF413.34B1B649@zip.com.au>
Date: Fri, 24 May 2002 01:04:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, kuznet@ms2.inr.ac.ru,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: inode highmem imbalance fix [Re: Bug with shared memory.]
In-Reply-To: <OF6D316E56.12B1A4B0-ONC1256BB9.004B5DB0@de.ibm.com> <3CE16683.29A888F8@zip.com.au> <20020520043040.GA21806@dualathlon.random> <20020524073341.GJ21164@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, May 20, 2002 at 06:30:40AM +0200, Andrea Arcangeli wrote:
> > As next thing I'll go ahead on the inode/highmem imbalance repored by
> > Alexey in the weekend.  Then the only pending thing before next -aa is
> 
> Here it is, you should apply it together with vm-35 that you need too
> for the bh/highmem balance (or on top of 2.4.19pre8aa3).

Looks OK to me.  But I wonder if it should be inside some config
option - I don't think machines with saner memory architectures
would want this?

> ...
> +                                        * in practice. Also keep in mind if somebody
> +                                        * keeps overwriting data in a flood we'd
> +                                        * never manage to drop the inode anyways,
> +                                        * and we really shouldn't do that because
> +                                        * it's an heavily used one.
> +                                        */

Can anyone actually write to an inode which is on the unused
list?

> +                                       wakeup_bdflush();
> +                               else if (inode->i_data.nrpages)
> +                                       /*
> +                                        * If we're here it means the only reason
> +                                        * we cannot drop the inode is that its
> +                                        * due its pagecache so go ahead and trim it
> +                                        * hard. If it doesn't go away it means
> +                                        * they're dirty or dirty/pinned pages ala
> +                                        * ramfs.
> +                                        *
> +                                        * invalidate_inode_pages() is a non
> +                                        * blocking operation but we introduce
> +                                        * a dependency order between the
> +                                        * inode_lock and the pagemap_lru_lock,
> +                                        * the inode_lock must always be taken
> +                                        * first from now on.
> +                                        */
> +                                       invalidate_inode_pages(inode);

It seems that a call to try_to_free_buffers() has snuck into
invalidate_inode_pages().  That means that clean ext3 pages
which are on the checkpoint list won't be released.  Could you
please change that to try_to_release_page()?


-
