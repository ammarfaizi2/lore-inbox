Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbTEHTAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTEHTAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:00:11 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:28818 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262039AbTEHS7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:59:53 -0400
Message-ID: <3EBAAC12.F4EA298D@hp.com>
Date: Thu, 08 May 2003 13:12:18 -0600
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans-Georg Thien <1682-600@onlinehome.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh 
 aPS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it impossible to perform any operation that requires
pressing a key on the keyboard while clicking a mouse button - for
example bringing up X-terminal menu with CTRL-<middle button>. I am sure
there are other similar combination used by other software. You would
think 1 second after the CTRL key is pressed (which is when a keyboard
event is generated), mouse will be re-enabled and you should be able to
click mouse buttons as long as you do not let go of the key. Does not
seem to work that way. Mouse stays disabled as long as the key is
pressed.

--
Khalid

Hans-Georg Thien wrote:
> 
> Sorry for this long text and my bad english. And please be kind to me -
> it is my very first posting to this mailing list ...
> 
> I have written a *very small* patch against the linux 2.4.20 kernel and
> I want to submit it now.
> 
> The short story
> ---------------
> The trackpad on the MacIntosh iBook Notebooks have a feature that
> prevents unintended trackpad input while typing on the keyboard. There
> are no mouse-moves or mouse-taps for a short period of time after each
> keystroke.
> 
> I believe that many people with i386 notebooks would like this feature
> and I want to give it to the linux community.
> 
> First I had the idea of writing a loadable kernel module "trackpad" that
> implements that feature and is loadable via
> 
> insmod keybd_irq=? mouse_irq=? delay=?
> 
> The long story
> --------------
> My first approach was - because I came from the bad old M$-DOS times -
> write something like a "terminate and stay resident program"
> 
>       Procedure LoadModule
>         Save the currentlly installed handlers for keyboard and mouse.
>         Install your own interrupt handlers for keyboard and mouse.
>       End
> 
>       Procedure UnloadModule
>         Stop and remove "reset-timer" if necessary
>         Restore the saved interrupt handlers for keyboard and mouse
>       End
> 
>       Procedure KbdHandler
>         Stop or modify "reset-timer" if necessary
>         Set global variable block_mouse_events=1
>         Start a timer that resets block_mouse_events=0 after ??? mSec
>         Call the old keyboard interrupt handler
>       End
> 
>       Proceure MouseHandler
>         if block_mouse_events>0 then
>           call ACK(mouse irq) if necessary
>           do nothing
>         else
>           call old mouse interrupt handler
>       End
> 
> So I bought the book "Linux Device Drivers" written by Alessandro Rubini
> & Jonathan Corbert. It is an excellent book about LKM, but I couldn't
> find a way  to "save and restore" irq-handlers as in the design
> described above.
> 
> That's why I requested a little help in the newsgroup at
> comp.os.linux.development.system. This ended up with some people who
> said "don't mess around with irq-handlers in that way".
> 
> While trying to gain a deeper understanding of irq-handling - espically
> for mouse and keyboard handlers - I found out that the keyboard and
> mouse interrupts are handled *both* in
> /usr/src/linux/drivers/char/pc_keyb.c.
> 
> Ok, that is only true for PS/2 mice, but the majority of notebooks on
> the market have a PS/2 trackpad. On modifiying the pc_keyb.c file there
> is no longer a need to save/restore Interrupt handlers or to call them
> indirecty via a function pointer. Unfortunatly it has to be compiled in
> the kernel and cannot be written as a LKM module.
> 
> But anyway - I sad down and got a working solution very quickly! I'm
> very glad with it! I needed not more than 45 minutes to get this
> working! Works in textmode (gpm) and under X11 as expected!
> 
> Testing
> -------
> I have tested my patch only on my own notebook (Compaq M300). It would
> help a lot if there are some volunteers...
> 
> Future Plans
> ------------
> [x] make the "disable trackpad time" configurable via the /proc
> filesystem. Do you think that /proc/sys/kernel/trackpad is a good place
> for it? There are other files under the /proc/sys/kernel directory that
> fall in the category "keyboard handling", e.g. ctrl-alt-del or sysrq.
> 
> [x] make a /proc entry to allow "disable trackpad" and "enable
> trackpad". That would allow to turn the builtin trackpad off when an
> external mouse is pluged in, and to re-enable it when an external mouse
> is unplugged again.
> 
-- 

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini
