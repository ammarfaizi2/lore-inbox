Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSH3Wur>; Fri, 30 Aug 2002 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSH3Wuq>; Fri, 30 Aug 2002 18:50:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:50698 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312558AbSH3Wuq>; Fri, 30 Aug 2002 18:50:46 -0400
Message-ID: <3D6FF752.B2BDDC66@zip.com.au>
Date: Fri, 30 Aug 2002 15:53:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Biurrun <diego@biurrun.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops after removing PCMCIA modem with low latency patch
References: <20020830223913.GB412@maxx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Biurrun wrote:
> 
> Hello!
> 
> I just tried your 2.4.19-low-latency patch on a stock 2.4.19 kernel and
> my box oopses when I manually remove my PCMCIA modem.

Yup.  The pcmcia drivers like to call sleeping devfs functions
from within a timer handler.  The kernel tries to perform a
context switch in interrupt context and bugs out.  This can happen
without the low-latency patch, but doesn't.

The fix for that is to change the (strange) deferred deregister thing
in several of the CardServices drivers to punt the activity up to
process context via schedule_task(), but nobody has done that yet.

Probably, you can add

	if (in_interrupt())
		return;

to schedule() to make the BUGs go away.   Not using devfs makes
them go away too - but it is not a devfs bug.
