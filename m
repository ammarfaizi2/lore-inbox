Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317987AbSGZSk5>; Fri, 26 Jul 2002 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317989AbSGZSk5>; Fri, 26 Jul 2002 14:40:57 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4992 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317987AbSGZSk4>; Fri, 26 Jul 2002 14:40:56 -0400
Date: Fri, 26 Jul 2002 11:44:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: silvio.cesare@hushmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 bugs
Message-ID: <20020726184403.GA1389@opus.bloom.county>
References: <200207251902.g6PJ2bc01956@mailserver4.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207251902.g6PJ2bc01956@mailserver4.hushmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 12:02:37PM -0700, silvio.cesare@hushmail.com wrote:

> below are a few bugs leading to reading kernel memory using some of the usb
> drivers.
[snip]
> static int se401_set_size(struct usb_se401 *se401, int width, int height)
[snip]
> width / height can be modified (to a negative for instance) - something
> might break though with this though --> (will check more later).

Well, it's easy enough to check for this tho.  How does the following
look? Jeroen?

> static long se401_read(struct video_device *dev, char *buf, unsigned long count, int noblock)
[snip]
>         if (realcount > se401->cwidth*se401->cheight*3)
>                 realcount=se401->cwidth*se401->cheight*3;
> 
> [ skip ]
> 
>         if (copy_to_user(buf, se401->frame[0].data, realcount))
>                 return -EFAULT;
>  
> sign and overflow problem, leading to unbounded copy_to_user.

But since width and height are bouned (by the max the camera supports,
and w/ the following by the min) isn't this problem impossible to hit,
without some additional breakage ?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

Index: se401.c
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/drivers/usb/se401.c,v
retrieving revision 1.2
diff -u -u -r1.2 se401.c
--- se401.c	2002/06/17 17:30:22	1.2
+++ se401.c	2002/07/26 17:43:18
@@ -699,11 +699,11 @@
 	/* Check for a valid mode */
 	if (!width || !height)
 		return 1;
 	if ((width & 1) || (height & 1))
 		return 1;
-	if (width>se401->width[se401->sizes-1])
+	if ((width>se401->width[se401->sizes-1]) || (width<se401->width[0]))
 		return 1;
-	if (height>se401->height[se401->sizes-1])
+	if ((height>se401->height[se401->sizes-1]) || (height<se401->width[0]))
 		return 1;
 
 	/* Stop a current stream and start it again at the new size */
