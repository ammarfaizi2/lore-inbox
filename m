Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWB0AWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWB0AWh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWB0AWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:22:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750923AbWB0AWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:22:36 -0500
Date: Sun, 26 Feb 2006 16:20:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: largret@gmail.com
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       ak@muc.de
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060226162040.cb72bc31.akpm@osdl.org>
In-Reply-To: <1140994821.5522.9.camel@shogun.daga.dyndns.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	<20060226102152.69728696.akpm@osdl.org>
	<1140988015.5178.15.camel@shogun.daga.dyndns.org>
	<20060226133140.4cf05ea5.akpm@osdl.org>
	<1140994821.5522.9.camel@shogun.daga.dyndns.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Largret <largret@gmail.com> wrote:
>
> On Sun, 2006-02-26 at 13:31 -0800, Andrew Morton wrote:
> > > Sorry, this didn't help on my machine. I am running that latest kernel
> > > pre-patch (2.6.16-rc4) for testing right now and had to modify the
> > > offsets a little. If there's any output that would help, please let me
> > > know.
> >
> > hm, OK.  I suppose we can hit it with the big hammer, but I'd be reluctant
> > to merge this patch because it has the potential to hide problems, such as
> > the as-yet-unfixed bio-uses-ZONE_DMA one.
> > 
> > --- devel/mm/page_alloc.c~a	2006-02-26 13:26:56.000000000 -0800
> > +++ devel-akpm/mm/page_alloc.c	2006-02-26 13:28:58.000000000 -0800
> > @@ -1003,7 +1003,8 @@ rebalance:
> 
> I reversed the previous patch before applying this one. If they were
> supposed to be used together, let me know.

No, that's right.

> >From the initial results it looks like the OOM Killer is not being used
> now, Unfortunately I can't check with dmesg because right after login is
> initiated (but before I get a chance to type anything) there is a
> "Kernel BUG" message. This is all that is is printed when a serial
> console is in use. If you need the rest of the information, let me know
> and I'll see about typing it up.
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at mm/vmalloc.c:352
> invalid opcode: 0000 [1] SMP 
> CPU 1 
> Modules linked in: snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
> ipt_REJECT xt_state xt_tcpudp iptable_filter ip_tables x_tables nfs
> lockd nfs_acl sunrpc uhci_hcd r8169 ohci1394 ieee1394 emu10k1_gp
> gameport snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm
> snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd
> tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
> v4l1_compat v4l2_common btcx_risc videodev forcedeth usblp ohci_hcd
> i2c_nforce2 ehci_hc

Sigh.  The floppy driver's just a jpke.  Looks like the failed allocation
fell back to vmalloc then screwed it up.

I rather doubt whether x86_64 needs to be constraining itself to the ISA
DMA region anyway - something for Andi to look at please?

You could try this one instead, although I guess I'll need to fire up the
test box for this bug.


--- devel/include/asm-x86_64/floppy.h~b	2006-02-26 16:15:44.000000000 -0800
+++ devel-akpm/include/asm-x86_64/floppy.h	2006-02-26 16:16:21.000000000 -0800
@@ -40,7 +40,7 @@
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_free_irq()		free_irq(FLOPPY_IRQ, NULL)
 #define fd_get_dma_residue()    SW._get_dma_residue(FLOPPY_DMA)
-#define fd_dma_mem_alloc(size)	SW._dma_mem_alloc(size)
+#define fd_dma_mem_alloc(size)	__alloc_pages(GFP_KERNEL|__GFP_DMA32, get_order(size))
 #define fd_dma_setup(addr, size, mode, io) SW._dma_setup(addr, size, mode, io)
 
 #define FLOPPY_CAN_FALLBACK_ON_NODMA
_

