Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUHaSrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUHaSrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUHaSrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:47:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4044 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266616AbUHaSrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:47:39 -0400
Date: Tue, 31 Aug 2004 20:48:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831184846.GB25485@elte.hu>
References: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com> <1093972819.5403.8.camel@krustophenia.net> <s5hllfvyxuf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hllfvyxuf.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Takashi Iwai <tiwai@suse.de> wrote:

> Does the attached patch fix this problem?
> 
> 
> Takashi
> 
> --- linux/sound/pci/ens1370.c	25 Aug 2004 09:57:03 -0000	1.64
> +++ linux/sound/pci/ens1370.c	31 Aug 2004 18:17:45 -0000
> @@ -513,6 +513,7 @@
>  		r = inl(ES_REG(ensoniq, 1371_SMPRATE));
>  		if ((r & ES_1371_SRC_RAM_BUSY) == 0)
>  			return r;
> +		cond_resched();

but ... snd_es1371_wait_src_ready() is being called with
ensoniq->reg_lock held and you must not reschedule with a spinlock held. 
cond_resched_lock(&ensoniq->req_lock) might not crash immediately, but 
is it really safe to release the driver lock at this point?

	Ingo
