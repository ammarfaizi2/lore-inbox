Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135918AbRATC6w>; Fri, 19 Jan 2001 21:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135412AbRATC6n>; Fri, 19 Jan 2001 21:58:43 -0500
Received: from [129.94.172.186] ([129.94.172.186]:12796 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135918AbRATC6b>; Fri, 19 Jan 2001 21:58:31 -0500
Date: Sat, 20 Jan 2001 13:58:38 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>,
        Rajagopal Ananthanarayanan <ananth@sgi.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [RFC] generic IO write clustering 
In-Reply-To: <Pine.LNX.4.21.0101192142060.6167-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0101201355560.1071-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2001, Marcelo Tosatti wrote:

> The write clustering issue has already been discussed (mainly at Miami)
> and the agreement, AFAIK, was to implement the write clustering at the
> per-address-space writepage() operation.
>
> IMO there are some problems if we implement the write clustering in this
> level:
>
>   - The filesystem does not have information (and should not have) about
>     limiting cluster size depending on memory shortage.

Is there ever a reason NOT to do the best possible IO
clustering at write time ?

Remember that disk writes do not cost memory and have
no influence on the resident set ... completely unlike
read clustering, which does need to be limited.

>   - By doing the write clustering at a higher level, we avoid a ton of
>     filesystems duplicating the code.
>
> So what I suggest is to add a "cluster" operation to struct address_space
> which can be used by the VM code to know the optimal IO transfer unit in
> the storage device. Something like this (maybe we need an async flag but
> thats a minor detail now):
>
>         int (*cluster)(struct page *, unsigned long *boffset,
> 		unsigned long *poffset);

Makes sense, except that I don't see how (or why) the _VM_
should "know the optimal IO transfer unit". This sounds more
like a job for the IO subsystem and/or the filesystem, IMHO.

> "page" is from where the filesystem code should start its search
> for contiguous pages. boffset and poffset are passed by the VM
> code to know the logical "backwards offset" (number of
> contiguous pages going backwards from "page") and "forward
> offset" (cont pages going forward from "page") in the inode.

Yes, this makes a LOT of sense. I really like a pagecache
helper function so the filesystems can build their writeout
clusters easier.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
