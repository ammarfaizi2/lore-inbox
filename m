Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWFAPth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWFAPth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWFAPth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:49:37 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:8890 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030208AbWFAPtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:49:36 -0400
Subject: Re: 2.6.17-rc5-mm2
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       scjody@modernduck.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <447F0905.8020600@gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <447F0905.8020600@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 17:49:05 +0200
Message-Id: <1149176945.3115.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 17:34 +0159, Jiri Slaby wrote:
> Andrew Morton napsal(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > 
> Hello,
> 
> just another locking bug, I wonder if this wasn't discussed yet, but I can't
> find it.
> 

this appears to be a genuine bug:

> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {hardirq-on-W} -> {in-hardirq-R} usage.
> events/0/8 [HC1[1]:SC0[0]:HE0:SE1] takes:
>  (hl_irqs_lock){--+.}, at: [<f88e4e09>] highlevel_host_reset+0x15/0x63 [ieee1394]
> {hardirq-on-W} state was registered at:
>   [<c013e3af>] lockdep_acquire+0x59/0x6e
>   [<c03a982c>] _write_lock+0x3e/0x4c
>   [<f88e5772>] hpsb_register_highlevel+0xe1/0x123 [ieee1394]


hpsb_register_highlevel() does
	        write_lock(&hl_irqs_lock);
which is not irq safe
yet

> stack backtrace:
>  [<c03a94a3>] _read_lock+0x3e/0x4c
>  [<f88e4e09>] highlevel_host_reset+0x15/0x63 [ieee1394]

the highlevel_host_reset function

>  [<f88e27f3>] hpsb_selfid_complete+0x222/0x2fe [ieee1394]
>  [<f895fe83>] ohci_irq_handler+0x705/0x9d2 [ohci1394]
>  [<c014b30d>] handle_IRQ_event+0x31/0x65
>  [<c014c52f>] handle_fasteoi_irq+0x6f/0xc8
>  [<c0105b3a>] do_IRQ+0x61/0x87
>  =======================

calls read_lock() from irq context.

this appears to be a genuine and real deadlock 

