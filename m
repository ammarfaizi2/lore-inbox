Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRGOQDr>; Sun, 15 Jul 2001 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266669AbRGOQDh>; Sun, 15 Jul 2001 12:03:37 -0400
Received: from [195.211.46.202] ([195.211.46.202]:30792 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S266662AbRGOQDZ>;
	Sun, 15 Jul 2001 12:03:25 -0400
Date: Sun, 15 Jul 2001 17:40:23 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: <linux-irda@pasta.cs.UiT.No>
Subject: [PATCH] Re: [CHECKER] 52 probable security holes in 2.4.6 and
 2.4.6-ac2
In-Reply-To: <Pine.GSO.4.31.0107131616290.8768-100000@myth9.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0107141239420.6232-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dag, Jean, LKML!

On Fri, 13 Jul 2001, Kenneth Michael Ashcraft wrote:

> These errors occur because user input (data from copy_from_user, get_user,
> etc.) is used without being checked in the following ways:
...
> 1	|	/home/kash/linux/2.4.6-ac2/net/irda/af_irda.c/
...
> ---------------------------------------------------------
> [BUG] looks like it
> /home/kash/linux/2.4.6-ac2/net/irda/af_irda.c:2064:irda_getsockopt: ERROR:RANGE:2063:2064: Using user length "(null)" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] [linkages -> 2063:len:start] [distance=3]
> 			sizeof(struct irda_device_info);
>
> 		/* Copy the list itself */
> 		total = offset + (list.len * sizeof(struct irda_device_info));
> 		if (total > len)
> Start --->
> 			total = len;
> Error --->
> 		if (copy_to_user(optval+offset, discoveries, total - offset))
> 			err = -EFAULT;
>
> 		/* Write total number of bytes used back to client */
> ---------------------------------------------------------

Here's the pacth for review: The old check look's quiet bogus, because
optlen is a pointer.

The check was plain wrong.
--- /usr/src/linux-2.4.7/net/irda/af_irda.c~	Thu Jul 12 14:21:06 2001
+++ /usr/src/linux-2.4.7/net/irda/af_irda.c	Sat Jul 14 12:36:07 2001
@@ -2035,7 +2035,7 @@
 	if (get_user(len, optlen))
 		return -EFAULT;

-	if(optlen < 0)
+	if(len < 0)
 		return -EINVAL;

 	switch (optname) {

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


