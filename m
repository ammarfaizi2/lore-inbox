Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291661AbSBNOCc>; Thu, 14 Feb 2002 09:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSBNOCX>; Thu, 14 Feb 2002 09:02:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51412 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291661AbSBNOCL>; Thu, 14 Feb 2002 09:02:11 -0500
Date: Thu, 14 Feb 2002 14:58:32 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] compile fixes
In-Reply-To: <3C6A2F86.E5C322D4@zip.com.au>
Message-ID: <Pine.NEB.4.44.0202141452240.9063-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Andrew Morton wrote:

> This patch should fix all the remaining .text.exit problems
> which have resulted from recent binutils changes.   For all
> files which are accessible to an x86 build.
>...
> --- linux-2.4.18-pre9/drivers/sound/cs4232.c	Sun Sep 30 12:26:08 2001
> +++ linux-akpm/drivers/sound/cs4232.c	Tue Feb 12 23:47:28 2002
> @@ -277,7 +277,7 @@ void __init attach_cs4232(struct address
>  	}
>  }
>
> -void __exit unload_cs4232(struct address_info *hw_config)
> +void unload_cs4232(struct address_info *hw_config)
>  {
>  	int base = hw_config->io_base, irq = hw_config->irq;
>  	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
>...

unload_cs4232 is __exit
the only non-__exit caller of unload_cs4232 is cs4232_isapnp_remove
the only caller of cs4232_isapnp_remove (cleanup_cs4232) is __exit

Am I right to assume that the following alternative patch is correct, too?

--- drivers/sound/cs4232.c.old	Wed Feb  6 15:23:55 2002
+++ drivers/sound/cs4232.c	Wed Feb  6 17:48:35 2002
@@ -460,7 +460,7 @@
 	return 0;
 }

-int cs4232_isapnp_remove(struct pci_dev *dev, const struct isapnp_device_id *id)
+int __exit cs4232_isapnp_remove(struct pci_dev *dev, const struct isapnp_device_id *id)
 {
 	struct address_info *cfg = (struct address_info*)pci_get_drvdata(dev);
 	if (cfg) unload_cs4232(cfg);


cu
Adrian


