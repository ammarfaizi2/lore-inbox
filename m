Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269648AbUJAAuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269648AbUJAAuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbUJAAuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:50:13 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:14457 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269654AbUJAAsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:48:25 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096579503.1938.166.camel@deimos.microgate.com>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
	 <1096571398.1938.112.camel@deimos.microgate.com>
	 <1096569273.19487.46.camel@localhost.localdomain>
	 <1096573912.1938.136.camel@deimos.microgate.com>
	 <20040930205922.F5892@flint.arm.linux.org.uk>
	 <1096574739.1938.142.camel@deimos.microgate.com>
	 <1096576200.1938.154.camel@deimos.microgate.com>
	 <1096575030.19487.50.camel@localhost.localdomain>
	 <1096579503.1938.166.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1096591676.6000.25.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Sep 2004 19:47:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 16:25, Paul Fulghum wrote:
> > flush_to_ldisc was ok, then someone added the low latency
> > flag. In the current 2.6.9rc3 patch flush_to_ldisc honours
> > TTY_DONT_FLIP also
> 
> In the cases I described the low latency flag
> does not come into play because flush_to_ldisc()
> is called directly instead of
> through tty_flip_buffer_push().
> 
> TTY_DONT_FLIP is only set in read_chan().
> If read_chan() is not running, TTY_DONT_FLIP is not
> set and does not prevent buffers from flipping
> if the ISR calls flush_to_ldisc() directly
> while ldisc->receive_buf() is running.
> 
> The answer seems to be: don't call
> flush_to_ldisc directly like the current
> serial driver does.

I've looked at this more on 2.6

If a driver only calls tty_flip_buffer_push(),
with low_latency cleared, it is still possible for
flush_to_ldisc() to run concurrently on SMP machines.

* IRQ on proc 0, flush_to_ldisc work queued for events/0
* events/0 processes work item:
   1) work->pending cleared (work can now be queued again)
   2) work function runs on proc 0

While work function is running on proc 0:

* IRQ on proc 1, flush_to_ldisc work queued for events/1
* events/1 processes work item:
   1) work->pending cleared (work can now be queued again)
   2) work function runs on proc 1

flush_to_ldisc/ldisc->receive_buf do not set TTY_DONT_FLIP
and I see no other mechanism to serialize flush_to_ldisc

That means the buffers can flip while running in
ldisc->receive_buf() which reads from the buffers.

This is contrived, and timing may prevent
this from actually occurring in practice, but it
seems to indicate a hole that needs to be plugged.

I wrong in my reading of the code?

-- 
Paul Fulghum
paulkf@microgate.com


