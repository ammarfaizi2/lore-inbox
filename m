Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267836AbTAMLAI>; Mon, 13 Jan 2003 06:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbTAMLAI>; Mon, 13 Jan 2003 06:00:08 -0500
Received: from mario.gams.at ([194.42.96.10]:39014 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S267836AbTAMLAG> convert rfc822-to-8bit;
	Mon, 13 Jan 2003 06:00:06 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: How to avoid the woord 'goto' (was Re: any chance of 2.6.0-test*?)
References: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> 
In-reply-to: Your message of "Sun, 12 Jan 2003 16:27:30 EST."
             <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 13 Jan 2003 12:08:55 +0100
Message-ID: <2825.1042456135@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Wilkens <robw@optonline.net> wrote:
[...]
>Here's the patch if you want to apply it (i have only compile tested it,
>I haven't booted with it).. This patch applied to the 2.5.56 kernel.
>
>--- open.c.orig	2003-01-12 16:17:01.000000000 -0500
>+++ open.c	2003-01-12 16:22:32.000000000 -0500
>@@ -100,44 +100,58 @@
> 
> 	error = -EINVAL;
> 	if (length < 0)	/* sorry, but loff_t says... */
>-		goto out;
>+		return error;
> 
> 	error = user_path_walk(path, &nd);
> 	if (error)
>-		goto out;
>+		return error;
> 	inode = nd.dentry->d_inode;
[ snipped the rest ]

You just copied the logic to "cleanup and leave" the function several 
times. The (current, next and subsequent) maintainers at the next 
change in that function simply _have_ to check all cases as if they 
are different.
Yes, _now_ you (and all others) know that they are identical. But in 6 
month after tons of patches?

Perhaps you want to avoid goto's with:
----  snip (yes, it is purposely not a `diff -urN`)  ----
switch(0==0) {
default:
    error = -EINVAL;
    if (length < 0) /* sorry, but loff_t says... */
        break;
    error = user_path_walk(path, &nd);
    if (error)
        break;
    inode = nd.dentry->d_inode;

    switch(0==0) {
    default:
        /* For directories it's -EISDIR, for other non-regulars - -EINVAL */
        error = -EISDIR;
        if (S_ISDIR(inode->i_mode))
	    break;
        error = -EINVAL;
        if (!S_ISREG(inode->i_mode))
            break;

        error = permission(inode,MAY_WRITE);
        if (error)
            break;

        error = -EROFS;
        if(IS_RDONLY(inode))
            break;

        /* the rest omitted - the pattern should be clear */

        put_write_access(inode);
        break;
    }
    path_release(&nd);
    break;
}
return error;
----  snip  ----

FYI, backward goto's can be rewritten with:
----  snip  ----

    for(;;) {
        <do something>
        if(i_want_to_go_back)
            continue;
        <do something_else>
        break;
    }
----  snip  ----

Are these two more understandable because the avoid the 'goto'?
And try to see it not from the viewpoint of a first time reader, but
from the viewpoint of a/the maintainer/developer (who reads this code
probably quite often)?

	Bernd

-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


