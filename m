Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUE2NMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUE2NMd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUE2NMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:12:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26500 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264719AbUE2NMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:12:16 -0400
Date: Sat, 29 May 2004 15:12:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040529131233.GA6185@ucw.cz>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de> <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 07:37:57PM +0200, Sau Dan Lee wrote:

> I also agree the  new system has its merits. 

Thanks.

> What I  hate is only the
> part  where  mouse/keyboard drivers  are  now  in  kernel space.   The
> translation of  raw byte  streams into input  events should  be better
> done in userland.  One important  argument is: userland program may be
> swapped out.  Kernel modules can't.

Well, keyboard support was always in the kernel - you need it there,
because you need the keyboard always to work - even in the case of a
crash, when all userspace programs may already be dead.

That's also the reason why keyboard processing is done in the interrupt
context - even if nothing else works in the kernel but interrupts, you
still can get a register dump for example, using the keyboard.

Regarding mice: Yes, PS/2 and serial mice can be in userspace, as is
proven by reality. With USB mice it's much tougher, and busmice and
many other mice on non-PC platforms need their drivers to be in the
kernel, as they access hardware directly and not via a byte stream
abstraction.

Although PS/2 mice are very common, they're just one case in many. Thus
it was easier to put the processing of them in the kernel, too. It gives
us good advantages, like the support for AUX multiplexing (where you
have more mice connected to one system), synaptics passthrough (where
you have a mouse connected to a touchpad, with the data being embedded
in the touchpad protocol), and other stuff.

For serial mice, doing the processing in the kernel brought us a 4 times
better response rate for the mousesystems kind of them and 2 times
better for microsoft mice. That actually makes both useable.

And here are the two main reasons to keep mouse and keyboard processing
in the kernel:

1) Latency. The time it takes from keypress to giving it to an
application. Adding intermediate programs inbetween doesn't help this at
all.

2) Unified interface. If an application (X, QtEmbedded, SDL ...) needs
to talk to a mouse or keyboard, it can use the event interface instead
of knowing a gazillion of different protocols. This is a kernel job.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
