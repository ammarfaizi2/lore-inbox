Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVHYJEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVHYJEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVHYJEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:04:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18623 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964884AbVHYJEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:04:40 -0400
Date: Thu, 25 Aug 2005 11:04:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@www.linux.org.uk>
cc: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (1/22) lvalues abuse in dmasound
In-Reply-To: <E1E8ADJ-0005a8-SN@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508251103160.24552@scrub.home>
References: <E1E8ADJ-0005a8-SN@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Al Viro wrote:

> diff -urN RC13-rc7/sound/oss/dmasound/dmasound_paula.c RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound_paula.c
> --- RC13-rc7/sound/oss/dmasound/dmasound_paula.c	2005-06-17 15:48:29.000000000 -0400
> +++ RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound_paula.c	2005-08-25 00:54:04.000000000 -0400
> @@ -253,8 +253,9 @@
>  		count = min_t(size_t, userCount, frameLeft)>>1 & ~1;	\
>  		used = count*2;						\
>  		while (count > 0) {					\
> -			if (get_user(data, ((u_short *)userPtr)++))	\
> +			if (get_user(data, (u_short *)userPtr))		\
>  				return -EFAULT;				\
> +			userPtr += 2;					\
>  			data = convsample(data);			\
>  			*high++ = data>>8;				\
>  			*low++ = (data>>2) & 0x3f;			\
> @@ -268,13 +269,15 @@
>  		count = min_t(size_t, userCount, frameLeft)>>2 & ~1;	\
>  		used = count*4;						\
>  		while (count > 0) {					\
> -			if (get_user(data, ((u_short *)userPtr)++))	\
> +			if (get_user(data, (u_short *)userPtr))		\
>  				return -EFAULT;				\
> +			userPtr += 2;					\
>  			data = convsample(data);			\
>  			*lefth++ = data>>8;				\
>  			*leftl++ = (data>>2) & 0x3f;			\
> -			if (get_user(data, ((u_short *)userPtr)++))	\
> +			if (get_user(data, (u_short *)userPtr))		\
>  				return -EFAULT;				\
> +			userPtr += 2;					\
>  			data = convsample(data);			\
>  			*righth++ = data>>8;				\
>  			*rightl++ = (data>>2) & 0x3f;			\

Please replace this with the patch from CVS:

Index: sound/oss/dmasound/dmasound_paula.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/sound/oss/dmasound/dmasound_paula.c,v
retrieving revision 1.1.1.7
retrieving revision 1.6
diff -u -p -r1.1.1.7 -r1.6
--- sound/oss/dmasound/dmasound_paula.c	15 Aug 2004 14:21:28 -0000	1.1.1.7
+++ sound/oss/dmasound/dmasound_paula.c	29 May 2005 18:01:55 -0000	1.6
@@ -244,6 +244,7 @@ static ssize_t funcname(const u_char *us
 			u_char frame[], ssize_t *frameUsed,		\
 			ssize_t frameLeft)				\
 {									\
+	const u_short *ptr = (const u_short *)userPtr;			\
 	ssize_t count, used;						\
 	u_short data;							\
 									\
@@ -253,7 +254,7 @@ static ssize_t funcname(const u_char *us
 		count = min_t(size_t, userCount, frameLeft)>>1 & ~1;	\
 		used = count*2;						\
 		while (count > 0) {					\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, ptr++))			\
 				return -EFAULT;				\
 			data = convsample(data);			\
 			*high++ = data>>8;				\
@@ -268,12 +269,12 @@ static ssize_t funcname(const u_char *us
 		count = min_t(size_t, userCount, frameLeft)>>2 & ~1;	\
 		used = count*4;						\
 		while (count > 0) {					\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, ptr++))			\
 				return -EFAULT;				\
 			data = convsample(data);			\
 			*lefth++ = data>>8;				\
 			*leftl++ = (data>>2) & 0x3f;			\
-			if (get_user(data, ((u_short *)userPtr)++))	\
+			if (get_user(data, ptr++))			\
 				return -EFAULT;				\
 			data = convsample(data);			\
 			*righth++ = data>>8;				\


bye, Roman
