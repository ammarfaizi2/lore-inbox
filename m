Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTAMOtV>; Mon, 13 Jan 2003 09:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbTAMOtV>; Mon, 13 Jan 2003 09:49:21 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:39611 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267366AbTAMOtP>; Mon, 13 Jan 2003 09:49:15 -0500
Date: Mon, 13 Jan 2003 09:56:11 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: How to avoid the woord 'goto' (was Re: any chance of	2.6.0-test*?)
In-reply-to: <2825.1042456135@frodo.gams.co.at>
To: Bernd Petrovitsch <bernd@gams.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042469771.846.5.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <2825.1042456135@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, but..

My changes won't actually be incorporated (i hope) into the kernel. 
I've since learned that a goto will optimize to be just as quick as what
I wrote (by studying the optimized assembler output at other
suggestion).  Therefore, it was silly and pointless for me to spend the
10-12 minutes I did changing the code and testing it and e-mailing back
the changes.

So, there's nothing to worry about.  Goto's are here forever.

-Rob

On Mon, 2003-01-13 at 06:08, Bernd Petrovitsch wrote:
> Rob Wilkens <robw@optonline.net> wrote:
> [...]
> >Here's the patch if you want to apply it (i have only compile tested it,
> >I haven't booted with it).. This patch applied to the 2.5.56 kernel.
> >
> >--- open.c.orig	2003-01-12 16:17:01.000000000 -0500
> >+++ open.c	2003-01-12 16:22:32.000000000 -0500
> >@@ -100,44 +100,58 @@
> > 
> > 	error = -EINVAL;
> > 	if (length < 0)	/* sorry, but loff_t says... */
> >-		goto out;
> >+		return error;
> > 
> > 	error = user_path_walk(path, &nd);
> > 	if (error)
> >-		goto out;
> >+		return error;
> > 	inode = nd.dentry->d_inode;
> [ snipped the rest ]
> 
> You just copied the logic to "cleanup and leave" the function several 
> times. The (current, next and subsequent) maintainers at the next 
> change in that function simply _have_ to check all cases as if they 
> are different.
> Yes, _now_ you (and all others) know that they are identical. But in 6 
> month after tons of patches?
> 
> Perhaps you want to avoid goto's with:
> ----  snip (yes, it is purposely not a `diff -urN`)  ----
> switch(0==0) {
> default:
>     error = -EINVAL;
>     if (length < 0) /* sorry, but loff_t says... */
>         break;
>     error = user_path_walk(path, &nd);
>     if (error)
>         break;
>     inode = nd.dentry->d_inode;
> 
>     switch(0==0) {
>     default:
>         /* For directories it's -EISDIR, for other non-regulars - -EINVAL */
>         error = -EISDIR;
>         if (S_ISDIR(inode->i_mode))
> 	    break;
>         error = -EINVAL;
>         if (!S_ISREG(inode->i_mode))
>             break;
> 
>         error = permission(inode,MAY_WRITE);
>         if (error)
>             break;
> 
>         error = -EROFS;
>         if(IS_RDONLY(inode))
>             break;
> 
>         /* the rest omitted - the pattern should be clear */
> 
>         put_write_access(inode);
>         break;
>     }
>     path_release(&nd);
>     break;
> }
> return error;
> ----  snip  ----
> 
> FYI, backward goto's can be rewritten with:
> ----  snip  ----
> 
>     for(;;) {
>         <do something>
>         if(i_want_to_go_back)
>             continue;
>         <do something_else>
>         break;
>     }
> ----  snip  ----
> 
> Are these two more understandable because the avoid the 'goto'?
> And try to see it not from the viewpoint of a first time reader, but
> from the viewpoint of a/the maintainer/developer (who reads this code
> probably quite often)?
> 
> 	Bernd

