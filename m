Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271815AbTGXXtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271817AbTGXXtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:49:43 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:49157 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271815AbTGXXtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:49:41 -0400
Date: Fri, 25 Jul 2003 01:04:48 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.org>
Subject: Re: How is info->cmap supposed to work?
In-Reply-To: <20030721152646.GA14520@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0307250052070.7845-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi James,
>   I have few problems with understanding how
> info->cmap is supposed to work:

Hi!
 
> (1) FBIOGETCMAP calls fb_copy_cmap(&info->cmap, &cmap, 0);
>     Should not it use last argument of '2', as &cmap points
>     to the userspace? It looks to me like that anybody can
>     overwrite kernel currently... Only positive side is that
>     there is no way to control info->cmap contents (see (2)),
>     so you can only crash kernel with random code, you cannot 
>     stuff some malicious code there.

I think I posted something about that some time ago and I didn't here 
anything. Looking at the code I realized that yeap its broke. Its strange
that both fb_set_cmap and fb_copy_cmap can get data from userland. I would
think that we either have fb_set_cmap just set the video hardware or 
have fb_set_cmap be able to grab data from userland and fb_copy_cmap send 
data to userland. 

> (2) FBIOPUTCMAP calls fb_set_cmap, which in turn calls
>     fb_setcolreg. 

True.

>     FBIOGETCMAP copies cmap entries from
>     info->cmap (after fixing (1)). Does it mean that
>     fb_setcolreg has to fill info->cmap itself? 

No. At present all the drivers initialize a default cmap. Then it
doesn't matter which function gets called first. 

> Is not it
>     a bit ugly? And fb_set_cmap documentation is incorrect:
>     kspc == 0 means copy from userspace, while
>     kspc != 0 means copy "local", inside kernel-space. Documentation
>     says that 0 is local, while 1 is get_user.

:-( I have to look to see if that has been around for a while. I have a 
feeling it has been.

> (3) And who is supposed to initialize info->cmap, and to
>     what value? It looks to me like that fbdev driver is
>     supposed to do:
> 
>       memset(&info->cmap, 0, sizeof(info->cmap));
>       fb_alloc_cmap(&info->cmap, 256, 1);
> 
>     Is it right? What about fb_init_cmap() then? And why
>     fbdev has to play with info->cmap, cannot generic
>     layer take a care of this, if all info->cmap accesses
>     go through generic layer, and fbdev driver itself has
>     no need for this field?

The reason for the driver initalizing the default cmap is because 
we don't know how big the actual colormap will be. I don't know if 
the generic method of setting to color map to 2^bpp until above 8 bpp 
mode in which case we only set 16 colors will always work. Perhaps we 
could just set the cmap.len field and have the upper layer just generate 
from that.

