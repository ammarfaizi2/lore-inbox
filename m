Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265117AbUDUGv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUDUGv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265077AbUDUGv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:51:29 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:34494 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265117AbUDUGvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:51:09 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: /dev/psaux-Interface
Date: Wed, 21 Apr 2004 01:51:06 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <200404200756.08672.dtor_core@ameritech.net> <xb71xmhhmej.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb71xmhhmej.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210151.06636.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 April 2004 01:31 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     Dmitry> It seems that the driver allows non-exclusive access to
>     Dmitry> the port - multiple users may fight to set up the
>     Dmitry> mode.
> 
> That's wrong.   The driver is  written so that multiple  processes can
> hold the device node open at the same time, in the same way /dev/psaux
> in pre2.6 kernels was.
> 

Don't we say the same thing?

> 
>     Dmitry> How they will agree on which one to set?  
> 
> GPM and XFree86 have been  coordinating themselves well on this on all
> my Linux systems since 1993.  And  this has continued to be so with my
> psaux Module on Linux 2.6.

Not all the world is GPM and XFree.

> 
> 
>     Dmitry> On the other hand I do not want psaux to give me only
>     Dmitry> exclusive access as I have had emough of GPM repeater
>     Dmitry> feeding X feeding Y ... etc.
> 
> Both GPM and XFree86 are aware of vc switching, I suppose.

Not all the world is GPM and XFree.

> 
> 
>     Dmitry> It does not support active multiplexing controller (4 AUX
>     Dmitry> ports) which becomes quite common and is the only sane
>     Dmitry> option when you have several mice of different types.
> 
> That's because I don't have such a thing, and the interface of serio.c
> is not documented.  Instead of  guessing how the interface is supposed
> to work, I think it's better to leave it to the kernel developers.

The question was whether to include it in the kernel as it is. If it is not
compled work then it should wait a bit.

> 
> 
>     Dmitry> Also I do not see where the code makes sure that it does
>     Dmitry> not bind to keyboard's port (so keyboard driver has to be
>     Dmitry> loaded first).
> 
> Ask  the  people  who  wrote  i8042.c  and  serio.c  to  document  the
> interface.  I  simply copied the necessary  stuff from psmouse-base.c.
> If that psmouse.ko works, then why should my psaux fail?
>
 
Because if you look in psmouse_probe we actually check if there is a mouse
behing the port.

> 
>     Dmitry> I think the right way is to fix the issues with psmouse
>     Dmitry> driver and use input system to tie all hardware together.
> 
> But  how can  you  add support  of  new protocols  and hardware?   Not
> everyone want to reimplement GPM  and XFree86 drivers in kernel space.
> It's much  easier to do  it in user  space.  Adding the  complexity of
> various devices and protocols into kernelspace is insane.
>

The thing is that processing in kernel space is not that complex. The only
thing kernel has to do is to parse raw data and convert to events. The events
are parsed by user space daemon with all required bells and whistles. See
for example Synaptics driver for Xfree86 by Peter Osterlund, or my GPM
patches for that matter.

Mousedev is a transitional thing, it will go away eventually or will have a
very limited use by legacy applications.
 
> The only  sane way to  do it, IMO,  is to restructure the  input layer
> slightly, so  that mouse protocols  are handled by  userspace daemons.
> The daemon(s) are  responsible for talking to the  device directly via
> device  nodes such  as /dev/misc/psaux_direct,  and  translating these
> into the  common protocol  (IMPS2?) and hand  it back to  kernel space
> (via a  special device  node).  The kernel  can then combine  the data
> from all daemons and repeat it on /dev/input/mice.
>
 
We have such thing - look at uinput module - it can be used to feed events
back into the kernel. 

-- 
Dmitry
