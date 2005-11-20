Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVKTXpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVKTXpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVKTXpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:45:18 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:31888 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932137AbVKTXpR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:45:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bXkKnHerwKRcBEw+avIV9OUvv9SB6S1suiHcYaSGzU7Ki8m/hcs4B4bmL+z8/fBHI0uZksf2M5OLMDwemp85gQNQcI1wxrvLGOqh+a4fSycHXpzW3m+sJk+tT7nhtLMK6pfFOP4D74U9kp/WiKJ8clOD29gbI0oDhz6xq3iRoNs=
Message-ID: <9a8748490511201545n70e0e6fftd0f1aaf748abe05@mail.gmail.com>
Date: Mon, 21 Nov 2005 00:45:14 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Cc: bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20051120232009.GH16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051120232009.GH16060@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Adrian Bunk <bunk@stusta.de> wrote:
> The coverity checker spotted that this was a NULL pointer dereference in
> the "if (copy_from_user(...))" case.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old    2005-11-20 22:08:57.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c        2005-11-20 22:09:34.000000000 +0100
> @@ -2166,7 +2166,8 @@
>                         }
>                 }
>         }
> -       kfree(cache->filled_head);
> +       if(cache->filled_head)
> +               kfree(cache->filled_head);
>         kfree(cache);
>
Hmmm,  kfree() deals with NULL pointers just fine, so there's no
problem if cache->filled_head is NULL. There is, however, a NULL
pointer deref problem if `cache' is NULL, but that's not what your
patch checks for.

Shouldn't your patch be doing something like this (that is if cache
can ever be NULL at this point)?  :

--- linux-2.6.15-rc2-orig/drivers/ieee1394/raw1394.c    2005-11-20
22:25:27.000000000 +0100
+++ linux-2.6.15-rc2/drivers/ieee1394/raw1394.c 2005-11-21
00:33:34.000000000 +0100
@@ -2171,8 +2171,10 @@ static int modify_config_rom(struct file
                        }
                }
        }
-       kfree(cache->filled_head);
-       kfree(cache);
+       if (cache) {
+               kfree(cache->filled_head);
+               kfree(cache);
+       }

        if (ret >= 0) {
                /* we have to free the request, because we queue no response,


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
