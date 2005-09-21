Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVIUAX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVIUAX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVIUAX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:23:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbVIUAX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:23:58 -0400
Date: Tue, 20 Sep 2005 17:23:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: jayakumar.alsa@gmail.com
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Message-Id: <20050920172309.626db866.akpm@osdl.org>
In-Reply-To: <47f5dce305092017031a2ba375@mail.gmail.com>
References: <200509190639.j8J6dIM4007948@localhost.localdomain>
	<20050920152830.7ef6733b.akpm@osdl.org>
	<47f5dce305092017031a2ba375@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jayakumar alsa <jayakumar.alsa@gmail.com> wrote:
>
> > > +
> > > +static unsigned short snd_cs5535audio_codec_read(cs5535audio_t *cs5535au,
> > 
> > typedefs are unpopular in-kernel.  We generally don't get too fussed if a
> > driver maintainer really wants them there.  The main objection is that we
> > now have two names for the same thing.  Plus they cannot be used when
> > forward-declaring a structure.
> 
> I just used those typedefs in order to match the style in all the
> other alsa drivers. For example:
> 
> % egrep typedef $lintree/sound/pci/*.c
> als4000.c:typedef struct {
> atiixp.c:typedef struct snd_atiixp atiixp_t;
> atiixp.c:typedef struct snd_atiixp_dma atiixp_dma_t;
> atiixp.c:typedef struct snd_atiixp_dma_ops atiixp_dma_ops_t;
> atiixp.c:typedef struct atiixp_dma_desc {
> azt3328.c:typedef struct _snd_azf3328 azf3328_t;
> azt3328.c:typedef struct azf3328_mixer_reg {
> bt87x.c:typedef struct snd_bt87x bt87x_t;
> cmipci.c:typedef struct snd_stru_cmipci cmipci_t;
> <snip>
> 
> I'm not sure what to do. I'd be happy to take them out. But I woudn't
> mind leaving them in if that's what alsa convention is.

I'd be inclined to stick with the alsa style.  That's just an fyi if you
plan on working in other places.

> > We have kzalloc() now.
> 
> Yes, Takashi pointed that out too. But I did the patch against 13.1
> which doesn't have kzalloc. I guess I'll redo the patch against -mm
> and switch to kzalloc.

2.6.14-rc2 has kzalloc().  Generally, patches should only be based on -mm
if there's other stuff in -mm which they depend upon.

> > 
> > > +     addr = (u32)substream->runtime->dma_addr;
> > 
> > Nope, _snd_pcm_runtime.addr has type dma_addr_t, which is an opaque type,
> > 64-bit on some platforms.  I expect this driver will blow up on those
> > platforms.
> 
> The 5535 hw's dma descriptor is only 32 bit capable. I guess I should
> look into informing the dma alloc that the buffers need to be in the
> lower 32. Would it be okay to drop the upper then?

An IOMMU permits 64-bit platforms to use 32-bit PCI devices.

> >From a practical standpoint, the 5535 is only used in x86-32
> embeddeded systems so high mem probably won't occur. But you are
> right, I'll go and try make it right.

Yup, try to honour the provided type system as much as poss.

> > +#define cs_writel(reg, val)    outl(val, (int) cs5535au->port + reg)
> > +#define cs_writeb(reg, val)    outb(val, (int) cs5535au->port + reg)
> > +#define cs_readl(reg)          inl((unsigned short) (cs5535au->port + reg))
> > +#define cs_readw(reg)          inw((unsigned short) (cs5535au->port + reg))
> > +#define cs_readb(reg)          inb((unsigned short) (cs5535au->port + reg))
> > 
> > erk.   subsystem-wide helper macros which reference local variables?
> 
> Ok. I'll change that.

well, again, if that's alsa-style then you might choose to retain it.  But
it'd be an unpopular approach in most other kernel code.

