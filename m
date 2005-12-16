Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVLPBVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVLPBVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVLPBVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:21:23 -0500
Received: from loopy.telegraphics.com.au ([202.45.126.152]:62165 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S1751239AbVLPBVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:21:22 -0500
Date: Fri, 16 Dec 2005 12:21:17 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
In-Reply-To: <20051215174725.GZ27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0512161158580.9726@loopy.telegraphics.com.au>
References: <20051215085516.GU27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk>
 <20051215174725.GZ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Dec 2005, Al Viro wrote:

> With some archaeology...  It looks like drivers/macintosh part is from
> Geert (with chunks from benh? not sure) circa Dec 2000; adb.h is a missing
> piece of earlier patch (one that had leaked in Feb 2000, $DEITY knowns how
> much older it is)...


> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -476,13 +476,15 @@ adb_request(struct adb_request *req, voi
>                 use_sreq = 1;
>         } else
>                 use_sreq = 0;
> -       req->nbytes = nbytes+1;
> +       i = (flags & ADBREQ_RAW) ? 0 : 1;
> +       req->nbytes = nbytes+i;
>         req->done = done;
>         req->reply_expected = flags & ADBREQ_REPLY;
>         req->data[0] = ADB_PACKET;
>         va_start(list, nbytes);
> -       for (i = 0; i < nbytes; ++i)
> -               req->data[i+1] = va_arg(list, int);
> +       while (i < req->nbytes) {
> +               req->data[i++] = va_arg(list, int);
> +       }

According to the the Linx-mac68k repo, one line of that change belongs to 
Joshua M. Thompson, while the rest of that code was committed by Ray 
Knight, (the changelog says it was a merge from 2.4.0).

http://cvs.sourceforge.net/viewcvs.py/linux-mac68k/linux-mac68k/drivers/macintosh/adb.c?annotate=1.25


>         va_end(list);
>  
>         if (flags & ADBREQ_NOSEND)
> diff --git a/include/linux/adb.h b/include/linux/adb.h
> index e9fdc63..aad7b1c 100644
> --- a/include/linux/adb.h
> +++ b/include/linux/adb.h
> @@ -76,6 +76,7 @@ struct adb_driver {
>  #define ADBREQ_REPLY   1       /* expect reply */
>  #define ADBREQ_SYNC    2       /* poll until done */
>  #define ADBREQ_NOSEND  4       /* build the request, but don't send it */
> +#define ADBREQ_RAW     8       /* send raw packet (don't prepend 
> ADB_PACKET) */
> 

Credit for that change is due to Joshua M. Thompson.

http://cvs.sourceforge.net/viewcvs.py/linux-mac68k/linux-mac68k/include/linux/adb.h?annotate=1.7

-f
