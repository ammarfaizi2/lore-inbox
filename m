Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTEMRQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTEMRQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:16:47 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:35625 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261678AbTEMRQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:16:40 -0400
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on
	card release while shutting down
From: Paul Fulghum <paulkf@microgate.com>
To: alexander.riesen@synopsys.COM
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513172114.GH32559@Synopsys.COM>
References: <20030513135759.GG32559@Synopsys.COM>
	 <1052837896.1000.2.camel@teapot.felipe-alfaro.com>
	 <1052839860.2255.19.camel@diemos>  <20030513172114.GH32559@Synopsys.COM>
Content-Type: text/plain
Organization: 
Message-Id: <1052846891.2255.31.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 12:28:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 12:21, Alex Riesen wrote:
> Paul Fulghum, Tue, May 13, 2003 17:31:01 +0200:
> > Similar to this patch for synclink_cs.c:
> ...
> > -		    mod_timer(&link->release, jiffies + HZ/20);
> > +		    mgslpc_release((u_long)link);
> 
> Tried that. This time the trace looks different:
> 
> Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
> Call Trace:
>  [<c0118bc8>] __might_sleep+0x58/0x70
>  [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
>  [<c6a2d193>] undo_irq+0x23/0x90 [pcmcia_core]
>  [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
>  [<c6a302f8>] pcmcia_release_irq+0xb8/0xe0 [pcmcia_core]
>  [<c6a25e00>] pcnet_release+0x0/0x80 [pcnet_cs]
>  [<c6a312d5>] CardServices+0x155/0x260 [pcmcia_core]
>  [<c6a312c9>] CardServices+0x149/0x260 [pcmcia_core]
>  [<c6a25e56>] pcnet_release+0x56/0x80 [pcnet_cs]
>  [<c01224a4>] run_timer_softirq+0xc4/0x1a0
>  [<c010a8b3>] handle_IRQ_event+0x33/0xf0
>  [<c011e889>] do_softirq+0xa9/0xb0
>  [<c010abb5>] do_IRQ+0x125/0x150
>  [<c01093a8>] common_interrupt+0x18/0x20

Hmmm... the pcnet_release() function is still being called
from a timer context.

Looking at pcnet_cs.c I see that in function pcnet_close()
that the release function is being being run from
a timer. Try changing that instance to calling pcnet_release()
directly as you did in the CS_EVENT handler.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


