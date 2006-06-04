Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932202AbWFDIui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWFDIui (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWFDIui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:50:38 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:62404 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932202AbWFDIui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:50:38 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        "Barry K. Nathan" <barryn@pobox.com>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags bug 
In-reply-to: Your message of "Sun, 04 Jun 2006 10:30:17 +0200."
             <20060604083017.GA8241@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Jun 2006 18:50:27 +1000
Message-ID: <16537.1149411027@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar (on Sun, 4 Jun 2006 10:30:17 +0200) wrote:
>2) allowing the nesting of hardware interrupts only 'spreads out'
>the handling of the current ISR, causing extra cachemisses that would
>otherwise not happen. Furthermore, on architectures where ISRs share
>the kernel stacks, enabling interrupts in ISRs introduces a much
>higher kernel-stack-nesting and thus kernel-stack-overflow risk.

It is worse than you think.  A third party network driver enabled
interrupts in its irq handler.  For reasons that are still not clear,
that allowed recursive interrupts from the same device.  Unexpected I
know, because the card's ISR should still have been masked, but the
stack trace said otherwise.  When multiple packets arrived for the same
driver it drove multiple levels of kernel functions to handle them and
completely blew the kernel stack, even though it was using a separate
IRQ stack.

