Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261543AbREOVN2>; Tue, 15 May 2001 17:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbREOVNS>; Tue, 15 May 2001 17:13:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:56585 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261540AbREOVNJ>; Tue, 15 May 2001 17:13:09 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Getting FS access events
Date: 15 May 2001 14:12:44 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9ds64c$2k0$1@penguin.transmeta.com>
In-Reply-To: <3B0190F6.9D08D9CE@transmeta.com> <Pine.GSO.4.21.0105151628340.21081-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0105151628340.21081-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>> 
>> How would you know what datatype it is?  A union?  Making "struct
>> block_device *" a "struct inode *" in a nonmounted filesystem?  In a
>> devfs?  (Seriously.  Being able to do these kinds of data-structural
>> equivalence is IMO the nice thing about devfs & co...)
>
>void *.

No. It used to be that way, and it was a horrible mess.

We _need_ to know that it's an inode, because the generic mapping
functions basically need to do things like

	mark_inode_dirty_pages(mapping->host);

which in turn needs the host to be an inode (otherwise you don't know
how and where to write the dang things back again).

There's no question that you can avoid it being an inode by virtualizing
more of it, and adding more virtual functions to the mapping operations
(right now the only one you'd HAVE to add is the "mark_page_dirty()"
operation), but the fact is that code gets really ugly by doing things
like that.

It was an absolute pleasure to remove all the casts of "mapping->host".
With "void *" it needed to be cast to the right type (and you had to be
able to _prove_ that you knew what the right type was). With "inode *",
the type is statically known, and you don't actually lose anything (at
worst, you'd have a virtual inode and then do an extra layer of
indirection there).

I really don't think we want to go back to "void *". 

		Linus
