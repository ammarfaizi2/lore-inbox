Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271824AbTGXXzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTGXXzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:55:11 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:6595 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271824AbTGXXzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:55:02 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Fri, 25 Jul 2003 02:09:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: How is info->cmap supposed to work?
Cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <82F553B0EAD@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 03 at 1:04, James Simmons wrote:
> 
> Hi!

Finally ;-) I just posted on lk that nobody answered...
  
> > (1) FBIOGETCMAP calls fb_copy_cmap(&info->cmap, &cmap, 0);
> >     Should not it use last argument of '2', as &cmap points
> >     to the userspace? It looks to me like that anybody can
> >     overwrite kernel currently... Only positive side is that
> >     there is no way to control info->cmap contents (see (2)),
> >     so you can only crash kernel with random code, you cannot 
> >     stuff some malicious code there.
> 
> I think I posted something about that some time ago and I didn't here 
> anything. Looking at the code I realized that yeap its broke. Its strange
> that both fb_set_cmap and fb_copy_cmap can get data from userland. I would
> think that we either have fb_set_cmap just set the video hardware or 
> have fb_set_cmap be able to grab data from userland and fb_copy_cmap send 
> data to userland. 

It looks reasonable.

> > (2) FBIOPUTCMAP calls fb_set_cmap, which in turn calls
> >     fb_setcolreg. 
> 
> True.
> 
> >     FBIOGETCMAP copies cmap entries from
> >     info->cmap (after fixing (1)). Does it mean that
> >     fb_setcolreg has to fill info->cmap itself? 
> 
> No. At present all the drivers initialize a default cmap. Then it
> doesn't matter which function gets called first. 

Problem is that if you do FBIOPUTCMAP to change (say) entry #0,
FBIOGETCMAP will retrieve default value of entry #0 instead of value
you just set with FBIOPUTCMAP, unless driver updates its info->cmap
itself... 

> > Is not it
> >     a bit ugly? And fb_set_cmap documentation is incorrect:
> >     kspc == 0 means copy from userspace, while
> >     kspc != 0 means copy "local", inside kernel-space. Documentation
> >     says that 0 is local, while 1 is get_user.
> 
> :-( I have to look to see if that has been around for a while. I have a 
> feeling it has been.

2.4.x does same. But I do not think that it is excuse ;-)
 
> The reason for the driver initalizing the default cmap is because 
> we don't know how big the actual colormap will be. I don't know if 
> the generic method of setting to color map to 2^bpp until above 8 bpp 
> mode in which case we only set 16 colors will always work. Perhaps we 
> could just set the cmap.len field and have the upper layer just generate 
> from that.

Ok, then there is a problem - as nothing in matroxfb uses info->cmap,
I did not saw any need to initialize it. I'll fix it.
                                                            Petr
                                                            

