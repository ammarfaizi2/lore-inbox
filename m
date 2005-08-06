Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVHFAlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVHFAlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVHFAlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:41:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54945 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262280AbVHFAlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:41:36 -0400
Date: Sat, 6 Aug 2005 02:40:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <1123240325.3239.62.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0508060151330.3728@scrub.home>
References: <1123219747.20398.1.camel@localhost>  <20050804223842.2b3abeee.akpm@osdl.org>
  <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> 
 <20050804233634.1406e92a.akpm@osdl.org>  <Pine.LNX.4.61.0508051132540.3743@scrub.home>
  <1123235219.3239.46.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051202520.3728@scrub.home>
  <1123236831.3239.55.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051225270.3743@scrub.home>
  <1123238289.3239.57.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051254010.3743@scrub.home>
 <1123240325.3239.62.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Aug 2005, Arjan van de Ven wrote:

> Maybe it helps if I give the basic bug scenario first (pseudo C)
> 
> void some_ioctl_func(...)
> {
>   int count, i;
>   struct foo *ptr;
> 
>   copy_from_user(&count,...);
> 
>   ptr = kmalloc(sizeof(struct foo) * count);
> 
>   if (!ptr)
>      return -ENOMEM;
> 
>   for (i=0; i<count; i++) {
>       initialize(ptr+i);
>   }
> }
> 
> 
> if the user picks count such that the multiplication overflows, the
> kmalloc will actually *succeed* in getting a chunk between 0 and 128Kb.
> The subsequent "fill the array up" will overwrite a LOT of kernel memory
> though.
> 
> Fixing the hole of course involves checking "count" for too high a
> value. Using kcalloc() will check for this same overflow inside kcalloc
> and prevent it (eg return NULL) if one of these slips through.

What prevents a rogue user to call this function a number of times to 
waste resources?
kcalloc() covers only small part of what is needed to make an interface 
secure, once one checked everything else, the safety provided by kcalloc() 
is pretty much redundant.
Relying on the current allocation limits would be rather foolish as these 
can change anytime and hardcoding such assumptions is a really bad idea. 
Kernel coding requires a careful use of the memory resource, so it's the 
job of the driver to define reasonable limits, e.g. such arrays don't make 
much sense if they require too much space and the driver should define a 
limit like (PAGESIZE/sizeof(struct foo)). If the driver writer doesn't 
think about memory usage, then kcalloc() will do pretty much nothing too 
improve the driver, it may avoid a few problem cases, but there will be 
certainly more than enough problems left.
I actually looked at the current kcalloc users and besides a few unchecked 
module parameters, the arguments were either constant or had to be checked 
anyway. I didn't find a single example which required the "safety" of 
kcalloc().

bye, Roman
