Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVKTXwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVKTXwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKTXwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:52:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932141AbVKTXwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:52:43 -0500
Date: Mon, 21 Nov 2005 00:52:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051120235242.GR16060@stusta.de>
References: <20051120232009.GH16060@stusta.de> <20051120234055.GF28918@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120234055.GF28918@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 06:40:55PM -0500, Dave Jones wrote:
> On Mon, Nov 21, 2005 at 12:20:09AM +0100, Adrian Bunk wrote:
>  > The coverity checker spotted that this was a NULL pointer dereference in 
>  > the "if (copy_from_user(...))" case.
>  > 
>  > 
>  > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>  > 
>  > --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old	2005-11-20 22:08:57.000000000 +0100
>  > +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c	2005-11-20 22:09:34.000000000 +0100
>  > @@ -2166,7 +2166,8 @@
>  >  			}
>  >  		}
>  >  	}
>  > -	kfree(cache->filled_head);
>  > +	if(cache->filled_head)
>  > +		kfree(cache->filled_head);
>  >  	kfree(cache);
>  >  
>  >  	if (ret >= 0) {
>  > 
> 
> How do we get that far with a NULL filled_head ?
> If the kmalloc that fills cache->filled_head fails, we bail out early above.

The problem is not a NULL filled_head.

The problem is that in the "if (copy_from_user(...))" case, cache has 
already been freed.

But thinking about this, my patch is also wrong and creates a memory 
leak and the real bug is the freeing of cache above.

What about the patch below?

> 		Dave

cu
Adrian


<--  snip  -->


The coverity checker spotted that this was a NULL pointer dereference in 
the "if (copy_from_user(...))" case since the next step is to 
kfree(cache->filled_head).

There's no need to free cache at this point, and it's getting free'd 
later.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old	2005-11-20 22:08:57.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c	2005-11-21 00:49:38.000000000 +0100
@@ -2131,7 +2131,6 @@
 			   req->req.length)) {
 		csr1212_release_keyval(fi->csr1212_dirs[dr]);
 		fi->csr1212_dirs[dr] = NULL;
-		CSR1212_FREE(cache);
 		ret = -EFAULT;
 	} else {
 		cache->len = req->req.length;

