Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbTC3Rbk>; Sun, 30 Mar 2003 12:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbTC3Rbk>; Sun, 30 Mar 2003 12:31:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14598 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261504AbTC3Rbj>; Sun, 30 Mar 2003 12:31:39 -0500
Date: Sun, 30 Mar 2003 09:41:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <dri-devel@lists.sourceforge.net>
Subject: Re: Update direct-rendering to current DRI CVS tree.
In-Reply-To: <20030330114544.GB16060@suse.de>
Message-ID: <Pine.LNX.4.44.0303300934220.2826-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Mar 2003, Dave Jones wrote:
> 
> This bit seems to be backing out a memleak fix..

Well, yes and no. I looked at the code, and decided that the memleak fix 
was hottibly bogus.

Look at how the allocations are done inside the loop: they are INSIDE A 
LOOP.

Look at what happens with the memory leak fix if the loop fails after
having done <n> iterations: it will only unregister the last (failing)
iteration, but it will then free stuff that the earlier (successful)
iterations still depend on.

>  > @@ -41,7 +42,7 @@
>  >  
>  >  /* malloc/free without the overhead of DRM(alloc) */
>  >  #define DRM_MALLOC(x) kmalloc(x, GFP_KERNEL)
>  > -#define DRM_FREE(x) kfree(x)
>  > +#define DRM_FREE(x,size) kfree(x)
> 
> eww. wtf is this for ? Some cross-OS compataiblity gunk ?

I assume it's for *BSD.

>  >  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,2)
>  >  #define down_write down
>  >  #define up_write up
> 
> #if can go, like it did in other parts of the patch.

Only if _you_ are willing to sync the DRM tree. 

Since I'm only doing the DRM syncs occasionally, I want to keep 
unnecessary differences between the kernel and DRM to a minimum. Which 
means that I do remove gunk that I find stupid and ugly (I've removed 
#ifdef's in the code before), but not stuff that looks like reasonable 
compatibility stuff.

> I would read through the other 10 billion lines, but I lost
> enthusiasm..

Ehh.. I _did_ go through the other lines, and was actually involved with 
one of the more spread-out changes (ie suggesting the fixed locking 
context thing). As far as I can tell the patch is good. I'd still like 
more eyes on the result, but the eyes should look a bit more closely..

		Linus

