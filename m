Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVIUADl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVIUADl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVIUADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:03:41 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:30823 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbVIUADl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:03:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=olCQhbbUJxAwryxPInph/UcekmARrKLLna5pRwKXEZdr+xzsWZPAVG4lm0uet74k0yYCr5hBtuHh0dM2kCD8q0hZoQeeydG8qYHW17fYrtxWEt0U5Hdtq+rxbs9YUeENTJJH6sDkyruyoiYwCw1L2ec3BKEcqeg0h4tj7VEshVg=
Message-ID: <47f5dce305092017031a2ba375@mail.gmail.com>
Date: Tue, 20 Sep 2005 20:03:40 -0400
From: jayakumar alsa <jayakumar.alsa@gmail.com>
Reply-To: jayakumar.alsa@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050920152830.7ef6733b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509190639.j8J6dIM4007948@localhost.localdomain>
	 <20050920152830.7ef6733b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Andrew Morton <akpm@osdl.org> wrote:
> By convention we put the asm/ includes after the linux/ includes.

Will do. Thanks for the detailed review!

> 
> > +
> > +static unsigned short snd_cs5535audio_codec_read(cs5535audio_t *cs5535au,
> 
> typedefs are unpopular in-kernel.  We generally don't get too fussed if a
> driver maintainer really wants them there.  The main objection is that we
> now have two names for the same thing.  Plus they cannot be used when
> forward-declaring a structure.

I just used those typedefs in order to match the style in all the
other alsa drivers. For example:

% egrep typedef $lintree/sound/pci/*.c
als4000.c:typedef struct {
atiixp.c:typedef struct snd_atiixp atiixp_t;
atiixp.c:typedef struct snd_atiixp_dma atiixp_dma_t;
atiixp.c:typedef struct snd_atiixp_dma_ops atiixp_dma_ops_t;
atiixp.c:typedef struct atiixp_dma_desc {
azt3328.c:typedef struct _snd_azf3328 azf3328_t;
azt3328.c:typedef struct azf3328_mixer_reg {
bt87x.c:typedef struct snd_bt87x bt87x_t;
cmipci.c:typedef struct snd_stru_cmipci cmipci_t;
<snip>

I'm not sure what to do. I'd be happy to take them out. But I woudn't
mind leaving them in if that's what alsa convention is.

> This isn't right.  `timeout' will have a value of -1 if we timed out.
> (several instances).

How embarrassing. Will fix. :-)

> Ditto.  Plus we prefer to not put braces around a single statement like this.

Will fix.

> Again.  Perhaps a helper function so this code (and its bug) don't get
> duplicated so much?

Will do.

> 
> We normally put a space after commas.
> 
> Unneeded typecast.

Will fix.

> 
> > +             dma->index = (++(dma->index)) % dma->periods;
> 
> Is no locking needed for dma->index?

Looks like I stopped using index after I found I don't need to track
the individual descriptors. I'll take it out.

> 
> Just to save a tabstop.

Will do.

> > +     }
> > +     return IRQ_HANDLED;
> > +}
> 
> Perhaps the default case should return IRQ_NONE.

In this case I think the code is correct as it is. I check that in the
top level irq status register if the irq was from the cs5535 audio. I
return NONE if it wasn't there. Then I proceed to read a bunch of
other registers, all with the assumption that the irq was from us. I
return HANDLED at that point since reading those other registers has
cleared any irq from us even if it was from an unexpected src.

> > +     cs5535au = kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);
> 
> We have kzalloc() now.

Yes, Takashi pointed that out too. But I did the patch against 13.1
which doesn't have kzalloc. I guess I'll redo the patch against -mm
and switch to kzalloc.

> Please consider reworking functions such as the above so as to have a
> single `reutrn' statement.  Or one `return' for success and just one for
> the error paths.  Reason: a) it's easier to chack that all resources are
> being freed on the error paths and b) It's easier to add new stuff which
> allocates new resources which need to be released on error paths.  Involves
> goto spaghetti.

Will do.

> 
> The handling of `dev' is racy ;)

Ok. Will look at that.

> 
> > +     addr = (u32)substream->runtime->dma_addr;
> 
> Nope, _snd_pcm_runtime.addr has type dma_addr_t, which is an opaque type,
> 64-bit on some platforms.  I expect this driver will blow up on those
> platforms.

The 5535 hw's dma descriptor is only 32 bit capable. I guess I should
look into informing the dma alloc that the buffers need to be in the
lower 32. Would it be okay to drop the upper then?

>From a practical standpoint, the 5535 is only used in x86-32
embeddeded systems so high mem probably won't occur. But you are
right, I'll go and try make it right.

> +#define cs_writel(reg, val)    outl(val, (int) cs5535au->port + reg)
> +#define cs_writeb(reg, val)    outb(val, (int) cs5535au->port + reg)
> +#define cs_readl(reg)          inl((unsigned short) (cs5535au->port + reg))
> +#define cs_readw(reg)          inw((unsigned short) (cs5535au->port + reg))
> +#define cs_readb(reg)          inb((unsigned short) (cs5535au->port + reg))
> 
> erk.   subsystem-wide helper macros which reference local variables?

Ok. I'll change that.

Thanks,
jk
