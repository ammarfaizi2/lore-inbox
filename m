Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRCOLcu>; Thu, 15 Mar 2001 06:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbRCOLck>; Thu, 15 Mar 2001 06:32:40 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:61128 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S131672AbRCOLch>; Thu, 15 Mar 2001 06:32:37 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Date: Thu, 15 Mar 2001 12:31:37 +0100
Message-Id: <20010315113137.28820@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.31.0103141251590.779-100000@linux.local>
In-Reply-To: <Pine.LNX.4.31.0103141251590.779-100000@linux.local>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Now for fbcon its simpler. Things get writing to the shadow buffer
>(vc_screenbuf). When the console gets woken up update_screen is called.
>While power down the shadow buffer can be written to which is much faster
>than saving a image of the framebuffer. Of course if you still want to do
>this such in the case of the X server then copy the image of the
>framebuffer to regular ram. Then power down /dev/fb using some ioctl calls
>provide.

Ok, I see. Currently, the sleep process is started from an ioctl sent to
another
driver, which will in turn call various notifier functions to shut down
bits of
hardware and finally put the machine to sleep. It's not a direct ioctl to
the /dev/fb (which may not be opened). 

One problem I have is that my fbdev sleep routine will restore the mode
on wakeup,
but that of course doesn't work with X when not using useFBDev as fbdev
have no
knowledge of the current mode or register settings used by X.

I'm wondering if it would be possible to make X think there's a console switch
(without actually switching to an active console, as we don't know if we
even have
one of those available for us), wait for it to reply, and then start the sleep
process.

One other possibility would be to implement APM-like events, I still have
to study
those more in details as our sleep process is currently quite different
from APM
(and definitely not BIOS-based).

For now, I have my hooks in fbcon that suspend/restart the cursor timer,
that's
enough to make sleep stable on 2.4 since we take care of shutting down
the display
very last (after any other driver) to make sure no printk will end up
trying to
display something while the chip is powered down.
I'll digest your various comments look into all this in more depth with
2.5 console
codebase. I beleive some solution must be found for x86 laptops too.

Ben.




