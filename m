Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131321AbRCHLkW>; Thu, 8 Mar 2001 06:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbRCHLkM>; Thu, 8 Mar 2001 06:40:12 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:63366 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131321AbRCHLkG>; Thu, 8 Mar 2001 06:40:06 -0500
Message-Id: <5.0.2.1.2.20010308110922.00a41a60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 08 Mar 2001 11:39:27 +0000
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Questions - Re: [PATCH] documentation for mm.h
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010308115137.M27675@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
 <Pine.LNX.4.33.0103071931400.1409-100000@duckman.distro.con ectiva>
 <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:51 08/03/01, Ingo Oeser wrote:
>On Thu, Mar 08, 2001 at 10:11:50AM +0000, Anton Altaparmakov wrote:
> > At 22:33 07/03/2001, Rik van Riel wrote:
> > [snip]
> > >  typedef struct page {
> > >+       struct list_head list;          /* ->mapping has some page 
> lists. */
> > >+       struct address_space *mapping;  /* The inode (or ...) we 
> belong to. */
> > >+       unsigned long index;            /* Our offset within mapping. */
> >
> > Assuming index is in bytes (it looks like it is):
>
>isn't. To get the byte offset, you have to multiply it by PAGE_{CACHE_,}SIZE.

Hi, first of all, thanks for the reply!

How do you reconcile that statement with the following comment from mm.h?

 > * A page may belong to an inode's memory mapping. In this case,
 > * page->mapping is the pointer to the inode, and page->offset is the
 > * file offset of the page (not necessarily a multiple of PAGE_SIZE).

Surely, if you have to multiply index by PAGE_{CACHE_}SIZE, page->offset 
would be a multiple of PAGE_{CACHE_}SIZE?

And even if it really is PAGE_{CACHE_}SIZE units, this still doesn't solve 
the problem, it just defers it to 16Tib (on ia32 arch with 4kib 
PAGE_{CACHE_}SIZE). With NTFS 3.0's use of sparse files, for the usn 
journal for example, even this will be overflowed at some point on a 
busy/large server. The only proper solution AFAICS is to allow the full 
64-bits.

> > [snip]
> > >+ * During disk I/O, PG_locked is used. This bit is set before I/O
> > >+ * and reset when I/O completes. page->wait is a wait queue of all
> > >+ * tasks waiting for the I/O on this page to complete.
> >
> > Is this physical I/O only or does it include a driver writing/reading 
> the page?
>
>Depends on the method of the driver, that is getting called.

Sorry, I should have been more detailed in my question, so let me try 
again: When the NTFS file system driver needs to modify the meta data, 
which will be in the page cache (meta data is stored in normal files on 
NTFS, hence the page cache is very well suited to storing it with it's 
page->mapping and page->offset fields), does the NTFS driver need to set 
PG_locked while writing to the page?

And what about reading for that matter? What is the access serialization here?

Obviously I can have several readers on the same metadata at the same time, 
and that's fine, but if someone is writing, then allowing anyone to read 
the data at the same time would result in corrupt meta data being read 
(this is because I am only going to use the page cache, i.e. there will be 
no copying of the data at all, except for: user space <-> page cache <-> 
disk). I am thinking that a read/write semaphore would be the perfect 
solution for this here, but it would be nice, if this could be handled on a 
per page basis rather than a per file basis, at the very least so for meta 
data files.

Thanks,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

