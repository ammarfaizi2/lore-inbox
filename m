Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUBZXTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUBZXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:18:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:19391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261216AbUBZWyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:54:44 -0500
Date: Thu, 26 Feb 2004 15:00:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add getdents32t syscall
In-Reply-To: <403E7348.60503@redhat.com>
Message-ID: <Pine.LNX.4.58.0402261438470.7830@ppc970.osdl.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
 <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
 <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org> <403E7348.60503@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Ulrich Drepper wrote:
> Linus Torvalds wrote:
> 
> >  - pre-fill the dirent area with 0xff or something
> 
> fill whole temporary buffer allocated by opendir() for every call to
> getdents(2)?

No no.

You only need to do this _once_. Once you know that the kernel is ok, you 
never ever need to do it again.

It's not even "once per file descriptor" or anything like that. It's 
literally _once_. 

And you don't need to fill the whole buffer even that first time. You 
only need to fill enough to guarantee that the _first_ entry is filled 
up.

In fact, if you're willing to have an algorithm that always works, but
might under some circumstances be a bit conservative, you can avoid
filling entirely, and just have a static flag that says "newformat", you
can do the following:

 - assume old format
 - if you ever see a reclen that is "too big" for the name length, you 
   know you have a new-format case (this will happen with any name that is 
   of length 1 modulo 4 on a 32-bit architecture).

For old-format stuff, you return DT_UNKNOWN, or you do your old existing 
song and dance. For new-format stuff you do the trivial thing.

And guess what? The entry "." will give you the information abotu whether 
it is old-format or not. On an old-format thing, "." will look like this:

	offset
	 0:	32-bit d_ino
	 4:	32-bit d_offset = 12
	 8:     16-bit d_namelen = 1
	10:	string ".\0"

	12:	32-bit d_ino for the next entry
	...

while with a new-format readdir you will get

	offset
	 0:	32-bit d_ino
	 4:	32-bit d_offset = 16
	 8:	16-bit d_namelen = 1
	10:	string ".\0"
	12-14:	three bytes of garbage
	15:	8-bit d_type

	16:	32-bit d_ino for the next entry..
	...

Notice? You are guaranteed to find out really quickly whether it's old- or 
new-format unless the user is doing something really really strange, and 
even if the user is doing something strange, returning D_UNKNOWN is always 
"correct".

So not only is my solution simple in kernel space, it allows you to 
simplify glibc too, if you are willing to make the old case go slower.

			Linus
