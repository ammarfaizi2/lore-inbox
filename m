Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJAPWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJAPWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJAPWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:22:44 -0400
Received: from ns.visionsystems.de ([62.145.30.242]:46493 "EHLO
	hhlx01.visionsystems.de") by vger.kernel.org with ESMTP
	id S261239AbUJAPWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:22:39 -0400
From: Roland =?utf-8?q?Ca=C3=9Febohm?= 
	<roland.cassebohm@VisionSystems.de>
Organization: Vision Systems GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Serial driver hangs
Date: Fri, 1 Oct 2004 17:22:28 +0200
User-Agent: KMail/1.6.2
Cc: Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <1096575030.19487.50.camel@localhost.localdomain> <1096579503.1938.166.camel@deimos.microgate.com>
In-Reply-To: <1096579503.1938.166.camel@deimos.microgate.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410011722.28877.roland.cassebohm@visionsystems.de>
X-OriginalArrivalTime: 01 Oct 2004 15:22:29.0823 (UTC) FILETIME=[77323CF0:01C4A7CA]
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.83
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. September 2004 23:25 schrieb Paul Fulghum:
> On Thu, 2004-09-30 at 15:10, Alan Cox wrote:
> > On Iau, 2004-09-30 at 21:30, Paul Fulghum wrote:
> > > tty->flip.work.func and tty->flip.tqueue.routine
> > > are set to flush_to_ldisc()
> >
> > flush_to_ldisc was ok, then someone added the low latency
> > flag. In the current 2.6.9rc3 patch flush_to_ldisc
> > honours TTY_DONT_FLIP also
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

Yes, I think you are right, if the system is to slow to fetch 
the data fast enough the buffer will be sometime full. And if 
it would be possible to use the second flip buffer then, this 
buffer would be full too sometime.
It would just take a little longer till data got lost. But if 
I want that I could just make the buffers larger.

...

I have just tested it, but unfortunately I've got a very bad 
result. :-( In my test case (2 port with 921600 baud) I get 
very much data loss.

I think I will stay now by the solution of just trow away the 
characters from the FIFO if flip buffer is full and 
TTY_DONT_FLIP is set. I will test now the patch Paul has 
made.

Roland
