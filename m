Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTELNol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTELNol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:44:41 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:22568 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261262AbTELNok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:44:40 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
In-Reply-To: <20030509142828.59552d0a.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com>
	 <1052402187.1995.13.camel@diemos> <20030508122205.7b4b8a02.akpm@digeo.com>
	 <1052503920.2093.5.camel@diemos> <1052512235.2997.8.camel@diemos>
	 <20030509142828.59552d0a.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052747862.1996.9.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 May 2003 08:57:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 16:28, Andrew Morton wrote:

> This code was added to wakeup_hc().  It is called from uhci_irq():
> 
> +	/* Global resume for 20ms */
> +	outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
> +	wait_ms(20);
> 
> The changelog just says "Minor patch for uhci-hcd.c"
> 
> Can you delete the wait_ms() and see if that is our culprit?

This is the culprit.

Removing this line corrects the latency problems on
the server. A 20ms delay seems pretty excessive for an
interrupt handler. I'm not sure what it is supposed to
accomplish, but this seems like something that should
be scheduled to run outside of the ISR.

I must have messed up a test on the laptop that is
also showing latency problems. On the laptop the
problem *is* in both 2.5.68/2.5.69 and *is not*
eliminated by turning off USB. The laptop uses the
ohci driver anyways which is not effected by this patch.
The laptop does not show latency problems on 2.4.20.

So the patch above is definately a problem,
but the problem I am seeing on the laptop
is something unrelated, but part of 2.5.x
(which I will investigate further).

Thanks,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


