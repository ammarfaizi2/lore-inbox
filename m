Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269360AbUI3VZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269360AbUI3VZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbUI3VZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:25:39 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:2677 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269360AbUI3VZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:25:28 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096575030.19487.50.camel@localhost.localdomain>
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
Content-Type: text/plain
Message-Id: <1096579503.1938.166.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 16:25:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 15:10, Alan Cox wrote:
> On Iau, 2004-09-30 at 21:30, Paul Fulghum wrote:
> > tty->flip.work.func and tty->flip.tqueue.routine
> > are set to flush_to_ldisc()
> 
> flush_to_ldisc was ok, then someone added the low latency
> flag. In the current 2.6.9rc3 patch flush_to_ldisc honours
> TTY_DONT_FLIP also

In the cases I described the low latency flag
does not come into play because flush_to_ldisc()
is called directly instead of
through tty_flip_buffer_push().

TTY_DONT_FLIP is only set in read_chan().
If read_chan() is not running, TTY_DONT_FLIP is not
set and does not prevent buffers from flipping
if the ISR calls flush_to_ldisc() directly
while ldisc->receive_buf() is running.

The answer seems to be: don't call
flush_to_ldisc directly like the current
serial driver does.

-- 
Paul Fulghum
paulkf@microgate.com

