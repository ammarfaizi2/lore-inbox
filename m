Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFTKiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFTKix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:38:53 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:1524 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262714AbTFTKiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:38:51 -0400
Subject: Re: matroxfb console oops in 2.4.2x
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
In-Reply-To: <4E2D2240020@vcnet.vc.cvut.cz>
References: <4E2D2240020@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1056106370.27851.365.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Fri, 20 Jun 2003 11:52:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 20:45, Petr Vandrovec wrote:
> On 19 Jun 03 at 14:47, David Woodhouse wrote:
> > On Thu, 2003-06-19 at 13:21, Petr Vandrovec wrote:
> 
> > take_over_console() attempts to redraw the screen.
> 
> It is not take_over_console... It does init first. 

Hmmm yes. The 'Pixel PLL not locked' message happens in the middle of
take_over_console(), so if I do something stupid like trying to debug
using printk instead of GDB, I get...

<7>take_over_console starts
<7>take_over_console calls save_screen()
 <crash>

... but if I make the Pixel PLL message KERN_DEBUG too, it continues...

<7>matroxfb: Pixel PLL not locked after 5 secs
<7>take_over_console calls update_screen()...
<4>Console: switching to colour frame buffer device 160x64
<7>take_over_console ends

> This one is culprit. If you'll comment this message out, it will not
> crash.

Indeed -- it won't crash _today_ if I do that.

But the problem is not recursion -- the problem is that there is a time
window during which _any_ printk (which could be from a timer or
interrupt) would kill the box, because it seems the console is getting
registered and allowing output before the hardware is fully initialised
and ready to accept it.

I don't know whether you consider this a bug in the generic console
code, or a bug in matroxfb -- but removing the 'Pixel PLL not locked'
message is only a workaround which serves to mask the real problem, so
I'd advocate leaving it in for now until the problem is fixed correctly.

> Ok. It means that hardware is completely uninitialized when this happens.
> Probably accelerator clocks are stopped (== message about pixclocks was
> right...) Bad.

The hardware _was_ completely uninitialised before matroxfb started,
certainly. 

I'd sort of expect it to have been initialised before we attempt to
register it as a console device though -- and even if it's OK to
register a partially-initialised device because the console registration
is supposed to perform the final initialisation by setting modes, etc.,
then I'd _still_ expect it to be initialised before the console code
actually lets any printk() through...

> Does driver work with your change without problems? It looks strange
> to me that PLL did not stabilized in 5 seconds. Do you get same message
> when you change videomode with fbset, or happens this only once during
> boot, and never again?

Once during boot and never again.

-- 
dwmw2

