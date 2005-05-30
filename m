Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVE3Wuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVE3Wuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVE3Wus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:50:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:485
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261798AbVE3Wro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:47:44 -0400
Date: Mon, 30 May 2005 15:47:33 -0700 (PDT)
Message-Id: <20050530.154733.85411488.davem@davemloft.net>
To: akpm@osdl.org
Cc: Steven.Hand@cl.cam.ac.uk, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.6.11.11 - udp_poll(), fragments + CONFIG_HIGHMEM
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050530141714.44879df5.akpm@osdl.org>
References: <E1DclTK-0002qE-00@mta1.cl.cam.ac.uk>
	<20050530141714.44879df5.akpm@osdl.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 30 May 2005 14:17:14 -0700

> That local_bh_disable() in kmap_skb_frag() looks weird and might be
> unnecessary.  Does anyone know what it's there for?  Replace it with
> local_irq_save()?

The SKB kmap types are to be used only from BH context.
So the local_bh_disable() is really necessary.

This limitation causes problems elsewhere too, for example if the tg3
driver has to do the 4GB DMA boundary workaround on transmit, then it
tries to do a skb_copy() in IRQ disabled context, which thusly also
tries to do some SKB kmapping and triggers the same assertion seen
here.

Both UDP and tg3 need to be fixed to not do these operations from such
illegal contexts.

It really stinks that this error on triggers with highmem enabled.
We would have seen both bugs much earlier on otherwise.
