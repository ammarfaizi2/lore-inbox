Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUENJJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUENJJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUENJJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 05:09:31 -0400
Received: from styx.suse.cz ([82.208.2.94]:55943 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264355AbUENJJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 05:09:29 -0400
Date: Fri, 14 May 2004 11:10:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       eric.valette@free.fr
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
Message-ID: <20040514091013.GA30526@ucw.cz>
References: <40A3C951.9000501@free.fr> <40A3EB84.8020405@free.fr> <200405131745.08973.dtor_core@ameritech.net> <200405140032.52636.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405140032.52636.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 12:32:52AM -0500, Dmitry Torokhov wrote:

> > > 	3) They light up a led on the keyboard,
> > 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > atkbd tries to switch leds but one tasklet can not interrupt another so
> > it deadlocks...
> > 
> > You need to revert just the patch below, not entire bk-input
> 
> Guys,
> 
> I need some guidance. The issue can be resolved in several ways but I am not
> sure which one is better:
> 
> - just revert the patch and continue doing everything in IRQ context;
> - move IRQ/tasklet split higher, into atkbd and psmouse-base respectively.
>   Every device would have it's own ring buffer, tasklet will be fired off
>   for incoming data only (i.e. ACKs and command response will be processed
>   right there in IRQ context);
> - move drivers/char/keyboard.c from tasklet to schedule_work. Need also
>   take care of others who are using keyboard_tasklet (qtronix, scan_keyb,
>   ec3104_keyb);
> - have atkbd use schedule_work to do LED and repeat rate setting.
> 
> What would you suggest?
 
Now that I'm considering it all, I think serio->interrupt function
should indeed be called within an interrupt context. The name should be
a big enough warning not to do too much processing (and definitely no
communication with the device other than doing something with the
received byte) there.

The input core and the handlers were intended to be lightweight enough
so that they could be executed from an interrupt handler as well.

Are we really spending too much time in the interrupt there? It's well
possible, but it'd be good if it could be evaluated. It should be rather
easy to add a rdtsc before an after the invocation of serio->interrupt
from i8042.c.

That should give us the answer about what to do - which parts of the
input processing can stay in the interrupt (because that is simple), and
what needs to be postponed to a tasklet or schedule_work().

Each of your options seems reasonable. I think moving keyboard.c to
schedule_work is a definitely good idea, but we may want to do more than
that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
