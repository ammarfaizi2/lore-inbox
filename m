Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDQJpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDQJpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 05:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWDQJpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 05:45:06 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:64006 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1750722AbWDQJpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 05:45:04 -0400
Subject: Re: [Alsa-devel] Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa
	AICA on Sega Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060417012913.GA16821@linux-sh.org>
References: <1145232784.12804.2.camel@localhost.localdomain>
	 <20060417012913.GA16821@linux-sh.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 10:44:56 +0100
Message-Id: <1145267096.9238.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 04:29 +0300, Paul Mundt wrote:
> A few quick comments.. though looking at the earlier thread, most of
> these were already pointed out..
> 

> 
> You can't be serious, you're trying to setup, transfer, and wait for
> completion for a DMA transfer while holding a spinlock? The fact this
> hasn't blown up on you is sheer luck. Use dma_wait_for_completion(), it
> does the right thing.
> 
> Additionaly you need a timeout here if you were for some reason intent on
> doing this while working against the DMA subsystem, if your DMA gets
> stuck this will blow up.
> 

As I wrote last week dma_wait_for_completion won't hack G2 DMA:


147 void dma_wait_for_completion(unsigned int chan)
148 {
149         struct dma_info *info = get_dma_info(chan);
150         struct dma_channel *channel = &info->channels[chan];
151 
152         if (channel->flags & DMA_TEI_CAPABLE) {
153                 wait_event(channel->wait_queue,
154                            (info->ops->get_residue(channel) == 0));
155                 return;
156         }
157 
158         while (info->ops->get_residue(channel))
159                 cpu_relax();
160 }

get_residue never returns 0 for G2 DMA. When the dma is complete get_residue returns the size of the total transfer. Therefore I've no choice but to write my own handler (spinlocks question aside).

