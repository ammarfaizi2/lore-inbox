Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSBPJeD>; Sat, 16 Feb 2002 04:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292338AbSBPJdx>; Sat, 16 Feb 2002 04:33:53 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:28863 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S292334AbSBPJdk>; Sat, 16 Feb 2002 04:33:40 -0500
Message-ID: <3C6E26F0.3070808@wanadoo.fr>
Date: Sat, 16 Feb 2002 10:31:28 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.18-rc1 es1370 fix 
In-Reply-To: <20020214161730.A8112@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>   Hi,
> 
> This patch (against 2.5.5-pre1) fixes the es1370 driver (the virt_to_bus thing).

The same applies to 2.4.18-rc1

----------------------------- cut here --------------------------
--- linux.orig/drivers/sound/es1370.c	Sat Feb 16 09:33:37 2002
+++ linux/drivers/sound/es1370.c	Sat Feb 16 09:41:02 2002
@@ -374,6 +374,10 @@
  		unsigned subdivision;
  	} dma_dac1, dma_dac2, dma_adc;

+ 
/* The following buffer is used to point the phantom write channel to. */
+ 
unsigned char *bugbuf_cpu;
+ 
dma_addr_t bugbuf_dma;
+
  	/* midi stuff */
  	struct {
  		unsigned ird, iwr, icnt;
@@ -392,13 +396,6 @@

  static LIST_HEAD(devs);

-/*
- * The following buffer is used to point the phantom write channel to,
- * so that it cannot wreak havoc. The attribute makes sure it doesn't
- * cross a page boundary and ensures dword alignment for the DMA engine
- */
-static unsigned char bugbuf[16] __attribute__ ((aligned (16)));
-
  /* 
--------------------------------------------------------------------- */

  static inline unsigned ld2(unsigned int x)
@@ -2649,8 +2646,9 @@
  	outl(s->ctrl, s->io+ES1370_REG_CONTROL);
  	outl(s->sctrl, s->io+ES1370_REG_SERIAL_CONTROL);
  	/* point phantom write channel to "bugbuf" */
+ 
s->bugbuf_cpu = pci_alloc_consistent(pcidev,16,&s->bugbuf_dma);
  	outl((ES1370_REG_PHANTOM_FRAMEADR >> 8) & 15, s->io+ES1370_REG_MEMPAGE);
- 
outl(virt_to_bus(bugbuf), s->io+(ES1370_REG_PHANTOM_FRAMEADR & 0xff));
+ 
outl(s->bugbuf_dma, s->io+(ES1370_REG_PHANTOM_FRAMEADR & 0xff));
  	outl(0, s->io+(ES1370_REG_PHANTOM_FRAMECNT & 0xff));
  	pci_set_master(pcidev);  /* enable bus mastering */
  	wrcodec(s, 0x16, 3); /* no RST, PD */
@@ -2717,6 +2715,7 @@
  	unregister_sound_mixer(s->dev_mixer);
  	unregister_sound_dsp(s->dev_dac);
  	unregister_sound_midi(s->dev_midi);
+ 
pci_free_consistent(dev, 16, s->bugbuf_cpu, s->bugbuf_dma);
  	kfree(s);
  	pci_set_drvdata(dev, NULL);
}

-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

