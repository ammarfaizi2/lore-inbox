Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSLNSUM>; Sat, 14 Dec 2002 13:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSLNSUM>; Sat, 14 Dec 2002 13:20:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:31162 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265773AbSLNSUL>;
	Sat, 14 Dec 2002 13:20:11 -0500
Message-ID: <3DFB7826.D2EF0263@digeo.com>
Date: Sat, 14 Dec 2002 10:27:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214144437.B13549@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 18:27:56.0893 (UTC) FILETIME=[860CA0D0:01C2A39E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> > > +   if ( from != 0 ) {/* First page needs to be partially zeroed */
> > > +       char *kaddr = kmap_atomic(prepared_pages[0], KM_USER0);
> > > +       memset(kaddr, 0, from);
> > > +       kunmap_atomic( kaddr, KM_USER0);
> > > +       SetPageUptodate(prepared_pages[0]);
> > > +   }
> > > +   if ( to != PAGE_CACHE_SIZE ) { /* Last page needs to be partially zeroed */
> > > +       char *kaddr = kmap_atomic(prepared_pages[num_pages-1], KM_USER0);
> > > +       memset(kaddr+to, 0, PAGE_CACHE_SIZE - to);
> > > +       kunmap_atomic( kaddr, KM_USER0);
> > > +       SetPageUptodate(prepared_pages[num_pages-1]);
> > > +   }
> > This seems wrong.  This could be a newly-allocated pagecache page.  It is not
> > yet fully uptodate.  If (say) the subsequent copy_from_user gets a fault then
> > it appears that this now-uptodate pagecache page will leak uninitialised stuff?
> 
> No, I do not see it. Even if we have somebody already mmapped this part of file,
> and he got enough of luck that subsequent copy_from_user gets a fault and then
> this someone gets to CPU and tries to access the page, the SIGBUS should happen
> because of access to mmaped area beyond end of file as we have not yet updated
> the file size note that we have this check before this code you pointed out:
>     if ( (pos & ~(PAGE_CACHE_SIZE - 1)) > inode->i_size ) {
> 

It is not related to mmap.  The exploit would be to pass a partially
(or fully?) invalid (address, length) pair into the write() system call.

Something like:

	fd = creat(...);
	write(fd, 0, 4095);		/* efault, instantiate 0'th page */
	lseek(fd, 4096, SEEK_SET);
	write(fd, "", 1);		/* place the 0'th page inside i_size */
	lseek(fd, 0, SEEK_SET);
	read(fd, my_buffer, 4095);	/* now what do we have? */
