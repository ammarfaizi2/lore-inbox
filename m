Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272323AbTG3XZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272330AbTG3XZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:25:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5084 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S272323AbTG3XZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:25:42 -0400
Subject: Re: [BUG] 2.6.0-test2 loses time on 486
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200307302252.h6UMq7aw024159@harpo.it.uu.se>
References: <200307302252.h6UMq7aw024159@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1059607019.14771.117.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jul 2003 16:16:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 15:52, Mikael Pettersson wrote:
> On 30 Jul 2003 13:08:44 -0700, john stultz <johnstul@us.ibm.com> wrote:

> >Well, I suspect its just the first. If you're not generating interrupts
> >then I'm doubtful the IDE driver is at fault (although I'd believe it if
> >you were losing time under load). Also the PIT based time source is
> >pretty simple and hasn't functionally changed much (well, it has been
> >moved around a bit). 
> >
> >It may be the timer interrupt has grown in cost since the argument to
> >change HZ to 1000 was made. Although using the PIT there isn't much we
> >do from a time of day perspective. If I can find a second, I'll see if I
> >can compare interrupt overhead between 2.4 and 2.5. But I'd imagine the
> >box would barely be usable if we're wasting all our time handling timer
> >interrupts (is it usable??).
> 
> Well, the test the box was running (recompile 2.4.22-pre) generates
> a lot of disk traffic, including swapping, since the box has so little
> RAM (only 28M). So IDE interrupts are frequent and the box is both
> CPU and I/O bound. I can still log in to it, type shell commands and
> so on, but starting emacs would be a bad idea...

Oh, if you're compiling then IDE is probably contributing to the
problem. However, I thought you said you lost time when idling as well?
 
> To test the "486 can't cope with HZ=1000" thesis I tried a RedHat
> 2.4.18-27.8 kernel which has a CONFIG_HZ option. Using 2.4.18-27.8
> with CONFIG_HZ=1000, the box still lost time during the "recompile
> 2.4.22-pre" test, but only about 15 seconds per hour instead of 2
> minutes per hour as it does with 2.6-test.

Ah, good call testing 2.4 w/ HZ=1000. Yea, as for the difference between
2.4 and 2.6-test, I'm guessing something in do_timer_interrupt_hook()
has grown. Booting a 586+ system w/ "clock=pit" and instrumenting that
function w/ rdtsc calls would probably show what has slowed down. 

Regardless, as you've demonstrated, it seems 486s just can't keep up w/
HZ=1000. Maybe we need to look into some sort of processor specific HZ
config option?

thanks
-john


