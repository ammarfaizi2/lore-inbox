Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVJ1BWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVJ1BWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 21:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVJ1BWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 21:22:40 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:19085 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965031AbVJ1BWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 21:22:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fzyZ4VLZhqrD7zVdrfzpIa7To+hZ5fuv2YU1YuFsbpj8RWw+L3fK6PDDYWb0LDA7LvHIEby+B+6D2OFTEwT7i/OBsUwUS60Rgh/siFZbnK+f7tc4mgXdG/s85x4ZQELJza4nKUklyK0imizJFyRMaUPmDnaZXqJpLIs1DjydP5o=
Message-ID: <1e62d1370510271822l2e521023lb43403d401b6f6b5@mail.gmail.com>
Date: Fri, 28 Oct 2005 06:22:38 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Paulo da Silva <psdasilva@esoterica.pt>
Subject: Re: Learning ext2 fs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43616512.7010704@esoterica.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436116DC.6030104@esoterica.pt>
	 <1e62d1370510271126i73cd94ebwc66f8d7583fa75c2@mail.gmail.com>
	 <43616512.7010704@esoterica.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Paulo da Silva <psdasilva@esoterica.pt> wrote:
> Fawad Lateef wrote:
>
> >On 10/27/05, Paulo da Silva <psdasilva@esoterica.pt> wrote:
> >
> >
> >>Is there a lower level where I can read/write blocks
> >>of data from/to hd instead of full pages?
> >>
> >>
> >>
> >
> >I think at the lower-level you can deal with the block-layer but at
> >this layer AFAIK you won't be able to distinguish between file data
> >and file system data/structures because you will be dealing with just
> >the blocks/chunks of data for block devices.
> >
> >
> Yes, but it could be useful for another purpose I have
> in mind.
> So far, I have found sb_read that allows for blocks
> reading using a buffer_head. Does all block readings
> use it? What about writes?
>

sb_bread is used to read the blocks containing file-system data not
the files, and for writing file-system data blocks back to storage
mark_buffer_dirty and sync_dirty_buffer functions are used as you can
see in the function ext2_sync_super (I am not FS expert, rather just
worked on it for understanding because i am going to use file-system's
stuff in my current project). sb_bread is actually reading the data
from the storage directly means with-out going through the
buffer_cache layer.


> >
> >
> >>How do I tell the really file data from other data?
> >>
> >>
> >>
> >
> >the functions readpage/writepage deals with the file data only not
> >with the file-system data/structures. Here I am considering by saying
> >other data you mean file-system data/structures
> >
> >
> >
> >
> May I conclude that all pages refer to data from/to the file?
> I am not sure here, because I noticed that writepages
> gets called when I unmounted the device!
>

I am pretty sure that pages here will be refering to the file data,
and as far as unmounting case is concern, synching of the file data
might be done so you are noticing them called by the VFS layer for
writing the un-synched data of file to storage.

> >>I traced these functions but I only got
> >>"ext2-writepages" to be called. "ext2-writepage"
> >>was never called using the programs
> >>I wrote to test this. When is "ext2-writepage" called?
> >>
> >
> >I think it doesn't matter that writepage or writepages are called
> >because both almost do the same thing and the writepages version deals
> >with more data and in your case the data may be big enough to handle
> >by the writepages.
> >
> >
> >
> Not at all. I just used a python program to create a file
> with less than 1kb and then I wrote a few bytes mixing
> "write" and "mmap". That's why I found strange
> writepage not being called. Only writepages.
>

I can't say much about this, but I think writepages are called by VFS
layer might be with nr_pages=1, so that a single page can be written
with small data ! Have you checked the nr_pages field when it is
called ?

>
> It would be nice if someone could write information about FSs.
> I could find lots of information about VFS level, even a
> small fs example with only 1 file. Unfortunately it works
> in memory and makes no access to the disc. So,
> the lower level remains obscure ...
>

AFAIR there are books which contain chapters explaining the
file-systems like EXT2/3 and you can also search for "Simple File
System" or "sfs" on the google for the code of small file-system which
works upto 64MB storage but on the real device not on the memory !


--
Fawad Lateef
