Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAJVbv>; Wed, 10 Jan 2001 16:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136595AbRAJVbg>; Wed, 10 Jan 2001 16:31:36 -0500
Received: from [213.8.206.36] ([213.8.206.36]:10770 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S136576AbRAJVbS>;
	Wed, 10 Jan 2001 16:31:18 -0500
Date: Wed, 10 Jan 2001 23:30:17 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Thiago Rondon <maluco@mileniumnet.com.br>
cc: dahinds@users.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ds patch
In-Reply-To: <Pine.LNX.4.21.0101101623150.4170-100000@freak.mileniumnet.com.br>
Message-ID: <Pine.LNX.4.21.0101102313310.27620-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Thiago Rondon wrote:

> Check kmalloc().

In case where kmalloc() failed we shouldn't increase driver->use_count,
because we wouldn't be able to decrease it at unbind_request(), since we
got no matching socket_bind_t in the list.

Prehaps the increase of the use count should be moved after the 
check. Like:

--- linux/drivers/pcmcia/ds.c	Sat Sep  2 10:13:49 2000
+++ linux/drivers/pcmcia/ds.c	Wed Jan 10 23:23:10 2001
@@ -412,8 +412,11 @@
     }
 
     /* Add binding to list for this socket */
-    driver->use_count++;
     b = kmalloc(sizeof(socket_bind_t), GFP_KERNEL);
+    if (!b)
+    	return -ENOMEM;
+
+    driver->use_count++;
     b->driver = driver;
     b->function = bind_info->function;
     b->instance = NULL;

 

> -Thiago Rondon
> 
> --- linux-2.4.0-ac5/drivers/pcmcia/ds.c	Sat Sep  2 04:13:49 2000
> +++ linux-2.4.0-ac5.maluco/drivers/pcmcia/ds.c	Wed Jan 10 16:20:53 2001
> @@ -414,6 +414,8 @@
>      /* Add binding to list for this socket */
>      driver->use_count++;
>      b = kmalloc(sizeof(socket_bind_t), GFP_KERNEL);
> +    if (!b) 
> +      return -ENOMEM;    
>      b->driver = driver;
>      b->function = bind_info->function;
>      b->instance = NULL;

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
