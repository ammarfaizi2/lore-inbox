Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSFPLiC>; Sun, 16 Jun 2002 07:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSFPLiB>; Sun, 16 Jun 2002 07:38:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53678 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316182AbSFPLiA>;
	Sun, 16 Jun 2002 07:38:00 -0400
Date: Sun, 16 Jun 2002 07:38:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206161056.g5GAuaS29554.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206160705290.3507-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

>     First of all, _that_ is still recursive.  And it's not easy to deal with -
>     you need to release the object holding the link body (BTW, that can
>     be almost anything - page, inode, kmalloc'ed area, vmalloc'ed area, etc.)
>     after __vfs_follow_link() is done.  And that means (at the very least)
>     a stack of such objects, along with the information about their nature.
> 
> Yes. But in the current tree only the cases page and kmalloc'ed area
> occur, and it is easy to transform the single occurrence of kmalloc'ed area
> (jffs2) into a use of page.

That's simply not true.  Of the top of my head - /proc/self.

Look, it's getting ridiculous - you've already got a method that sometimes
follows link, sometimes leaves a bunch of stuff for callers to handle
(BTW, we'll have to duplicate that fun in another caller of ->follow_link()
and that, thanks to usual POSIX elegance, is already butt-ugly).  You've
got (at the very least) 3 stacks of objects - dentry, link and page.
And that - saying "that happens to cover all current cases, except for one
but we can shoehorn it".  Aside of the fact that statement is false,
you are making a lot of assumptions about what's natural for code - both
out-of-tree and in-tree (see above).

And then you'll need to shove said stacks into struct nameidata.  Which
means either a static limit again or all sorts of fun with "allocate
externally if it gets bigger than...".

Face it, it _is_ ugly.  Been there, done that - if you want to repeat
the exercise, more power to you, but it won't be any prettier.

Sure thing, everything is equivalent to Turing Machine and with sufficient
amount of brute force and kludges everything that can be done at all can be
done in any given way.  In this particular case that amount will be
prohibitively painful.  You don't believe me - try it yourself and see how
gross it will get...

