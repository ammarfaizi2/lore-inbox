Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263631AbTCXI4H>; Mon, 24 Mar 2003 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263644AbTCXI4H>; Mon, 24 Mar 2003 03:56:07 -0500
Received: from gate.perex.cz ([194.212.165.105]:48133 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S263631AbTCXI4F>;
	Mon, 24 Mar 2003 03:56:05 -0500
Date: Mon, 24 Mar 2003 10:07:07 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Junfeng Yang <yjf@stanford.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "mc@cs.stanford.edu" <mc@cs.stanford.edu>
Subject: Re: [CHECKER] potential dereference of user pointer errors
In-Reply-To: <Pine.GSO.4.44.0303231506070.21702-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0303241004100.1189-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003, Junfeng Yang wrote:

> ---------------------------------------------------------
> [BUG] snd_sb_csp_ioctl -> snd_sb_csp_riff_load ->snd_sb_csp_load.
> /home/junfeng/linux-2.5.63/sound/isa/sb/sb16_csp.c:647:snd_sb_csp_load:
> ERROR:tainted:647:647:deferencing buf++ tainted by
> [dist=-1][(null)][TRANS: buf++, $stop$->tainted,
> /home/junfeng/linux-2.5.63/sound/isa/sb/sb16_csp.c, snd_sb_csp_load, 647]
> 
> 		}
> 		kfree (_kbuf);
> 	} else {
> 		/* load from kernel space */
> 		while (size--) {
> 
> Error --->
> 			if (!snd_sbdsp_command(p->chip, *buf++))
> 				goto __fail;
> 		}
> 	}

This code is ok. The source (user or kernel space) is checked a few lines 
before.

> ---------------------------------------------------------
> [BUG] copy function can take tainted inputs
> /home/junfeng/linux-2.5.63/sound/pci/es1938.c:833:snd_es1938_capture_copy:
> ERROR:tainted:835:833: passing dst into deref cal __constant_memcpy
> [dist=1][thru snd_pcm_ops_t:copy
> /home/junfeng/linux-2.5.63/sound/pci/cmipci.c:snd_cmipci_ac3_copy:parm3
> copy_from_user:parm1][START: dst, unknown->tainted,
> /home/junfeng/linux-2.5.63/sound/pci/es1938.c, snd_es1938_capture_copy,
> 833]
> 
> 	es1938_t *chip = snd_pcm_substream_chip(substream);
> 	pos <<= chip->dma1_shift;
> 	count <<= chip->dma1_shift;
> 	snd_assert(pos + count <= chip->dma1_size, return -EINVAL);
> 	if (pos + count < chip->dma1_size)
> Error --->
> 		memcpy(dst, runtime->dma_area + pos + 1, count);
> 	else {
> Start --->
> 		memcpy(dst, runtime->dma_area + pos + 1, count - 1);
> 		((unsigned char *)dst)[count - 1] = runtime->dma_area[0];
> 	}
> 	return 0;

Fixed. Replaced memcpy with copy_to_user(). Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

