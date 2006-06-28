Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWF1U1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWF1U1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWF1U1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:27:55 -0400
Received: from mail.gmx.net ([213.165.64.21]:38353 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751343AbWF1U1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:27:54 -0400
Cc: linuxppc-dev@ozlabs.org, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 28 Jun 2006 22:27:53 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20060628202753.198630@gmx.net>
MIME-Version: 1.0
Subject: Re: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc
 architecture and ALSA?
To: Takashi Iwai <tiwai@suse.de>
X-Authenticated: #6097454
X-Flags: 0001
X-GMX-UID: ig7HNNA2ZCEEekBwOGwhlVV4IGhpZUZV
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It took a little bit longer to integrate the patch, as I didn't figure out  first how to implement the __dma_mmap_coherent() function for PPC systems with CONFIG_NOT_COHERENT_CACHE defined. :)

Unfortunately my system still crashes within snd_pcm_mmap_data_nopage() 
(sound/core/pcm_native.c), as you can see below. I guess it tries to remap 
a DMA buffer allocated by the not cache coherent DMA memory allocation 
function in arch/ppc/kernel/dma-mapping.c.

Jun 28 21:59:30 localhost kernel: [  199.869609] Using dma_mmap_coherent for mmaping DMA buffer!
Jun 28 21:59:30 localhost kernel: [  199.925075] Oops: kernel access of bad area, sig: 11 [#1]
Jun 28 21:59:30 localhost kernel: [  199.925106] NIP: E226FF44 LR: E226FF94 CTR: E226FEA4
Jun 28 21:59:30 localhost kernel: [  199.925116] REGS: d2577d30 TRAP: 0600   Not tainted  (2.6.16.16-a1-2)
Jun 28 21:59:30 localhost kernel: [  199.925121] MSR: 00009032 <EE,ME,IR,DR>  CR: 44048444  XER: 00000000
Jun 28 21:59:30 localhost kernel: [  199.925134] DAR: 99A9999D, DSISR: 00000120
Jun 28 21:59:30 localhost kernel: [  199.925140] TASK = d242cd10[4338] 'totem' THREAD: d2576000
Jun 28 21:59:30 localhost kernel: [  199.925144] GPR00: 99A9999D D2577DE0 D242CD10 C0C826A0 00000000 D2577E08 D275F000 D36DC328
Jun 28 21:59:30 localhost kernel: [  199.925158] GPR08: 02000000 00004000 00000000 99A99999 84048444 10054698 00000000 10196A58
Jun 28 21:59:30 localhost kernel: [  199.925172] GPR16: 00000000 00000000 00000000 D36DC328 02000000 329FE000 00000000 00000000
Jun 28 21:59:30 localhost kernel: [  199.925184] GPR24: DE5A6B20 DFA63C80 329FE000 DFA63C80 D20AD804 D275F7F8 D2576000 D2577E08
Jun 28 21:59:30 localhost kernel: [  199.925199] NIP [E226FF44] snd_pcm_mmap_data_nopage+0xa0/0x12c [snd_pcm]
Jun 28 21:59:30 localhost kernel: [  199.925300] LR [E226FF94] snd_pcm_mmap_data_nopage+0xf0/0x12c [snd_pcm]
Jun 28 21:59:30 localhost kernel: [  199.925325] Call Trace:
Jun 28 21:59:30 localhost kernel: [  199.925330] [D2577DE0] [C0010050] update_mmu_cache+0xe4/0xf4 (unreliable)
Jun 28 21:59:30 localhost kernel: [  199.925361] [D2577E00] [C004F1D8] do_no_page+0xa4/0x6a4
Jun 28 21:59:30 localhost kernel: [  199.925387] [D2577E60] [C004FA24] __handle_mm_fault+0x12c/0x328
Jun 28 21:59:30 localhost kernel: [  199.925398] [D2577E90] [C000F740] do_page_fault+0x140/0x384
Jun 28 21:59:30 localhost kernel: [  199.925407] [D2577F40] [C0004AC0] handle_page_fault+0xc/0x80
Jun 28 21:59:30 localhost kernel: [  199.925423] Instruction dump:
Jun 28 21:59:30 localhost kernel: [  199.925427] 812a0218 3d60c038 800b938c 7d292214 3d294000 5529c9f4 7c604a14 80030000
Jun 28 21:59:30 localhost kernel: [  199.925441] 7c6b1b78 70094000 40820044 380b0004 <7d200028> 31290001 7d20012d 40a2fff4

Comments?

Thanks!

Gerhard

-------- Original-Nachricht --------
Datum: Wed, 14 Jun 2006 16:42:48 +0200
Von: Takashi Iwai <tiwai@suse.de>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
Betreff: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?

> At Mon, 12 Jun 2006 16:42:54 +0200,
> Gerhard Pircher wrote:
> > 
> > > > But as far as I understand this would require a rewrite of all the
> > > > ALSA drivers (or at least a rewrite of the ALSA's DMA helper
> > > > functions).
> > > 
> > > Yes.  The change of ALSA side has been also on my tree.  But it was
> > > still pending since I'm not satisfied with the design yet.
> > > If you're interested in it, let me know.  I'll post the patch.
> > 
> > Yes, please! Then I can test, if the dma_mmap_coherent() patch works on
> > my non cache coherent powerpc machine.
> 
> For using dma_mmap_coherent(), the patch below should suffice.
> (Also you need to enable HAVE_DMA_MMAP_COHERENT there not only for
>  ARM.)
> 
> > Do you think the DMA Layer/ALSA patches will go upstream in one of
> > the next ALSA/Linux kernel versions? 
> 
> Definitely no 2.6.18 material yet.
> 
> 
> Takashi

-- 


Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
