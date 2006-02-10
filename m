Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWBJW00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWBJW00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBJW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:26:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751385AbWBJW00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:26:26 -0500
Date: Fri, 10 Feb 2006 14:25:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jim Crilly" <jim@why.dont.jablowme.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.16-rc2-mm1
Message-Id: <20060210142502.2fd320ff.akpm@osdl.org>
In-Reply-To: <20060210213058.GE11297@voodoo>
References: <20060207220627.345107c3.akpm@osdl.org>
	<20060210213058.GE11297@voodoo>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:
>
> On 02/07/06 10:06:27PM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> >
> 
> I got the following BUG with the tulip driver because there's a mdelay(1)
> at the end of the tulip_media_select() function. Removing the mdelay(1)
> is trivial so I've attached a patch, but I'm not sure if it's the
> correct fix so I've CC'd Jeff Garzik.
> 
> BUG: warning at drivers/net/tulip/media.c:402/tulip_select_media()
> <f0c8e288> tulip_select_media+0x7b8/0x7db [tulip]   <b02103ac> dma_pool_free+0xc4/0x10e
> <f0c9130b> t21142_lnk_change+0x1af/0x4f4 [tulip]   <f0c7c490> finish_urb+0x98/0xc0 [ohci_hcd]
> <f0c8d374> tulip_interrupt+0x65f/0x803 [tulip]   <f0c7e153> ohci_irq+0x148/0x16d [ohci_hcd]
> <b013cb3f> handle_IRQ_event+0x20/0x4c   <b013cbf7> __do_IRQ+0x8c/0xdd
> <b0105250> do_IRQ+0x3c/0x54
>   =======================
> <b0103662> common_interrupt+0x1a/0x20   <b0101aa6> default_idle+0x0/0x55
> <b0101ad2> default_idle+0x2c/0x55   <b0101b8a> cpu_idle+0x8f/0xae
> <b02f8707> start_kernel+0x37f/0x386
> 
> Signed-off-by: Jim Crilly <jim@why.dont.jablowme.net>
> 
> ---
> drivers/net/tulip/media.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- linux-2.6.16-rc2-mm1/drivers/net/tulip/media.c  2006-02-09 22:13:36.403653502 -0500
> +++ linux-2.6.16-rc2-mm1-new/drivers/net/tulip/media.c  2006-02-10 15:51:41.821983228 -0500
> @@ -399,8 +399,6 @@ void tulip_select_media(struct net_devic
> 
>   tp->csr6 = new_csr6 | (tp->csr6 & 0xfdff) | (tp->full_duplex ? 0x0200 : 0);
> 
> - mdelay(1);
> -
>   return;
>  }

It might not be.  And the knowledge of which cards this will bust and why
may be lost in the mists of time.

So I suspect we're stuck with this irqs-off latency in here.

(The warning patch in -mm is only permitted once per callsite, so it's a
harmless irritant).

