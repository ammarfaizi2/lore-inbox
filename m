Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUBPWbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUBPWbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:31:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:26849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265921AbUBPWa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:30:59 -0500
Date: Mon, 16 Feb 2004 14:30:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
In-Reply-To: <1076969892.3649.66.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
  <1076904084.12300.189.camel@gaston>  <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
  <1076968236.3648.42.camel@gaston>  <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
 <1076969892.3649.66.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > That would just make the code more logical, and it should fix your 
> > concerns, no?
> 
> Yes, I was looking into this at the moment. Who else but fbcon and
> vgacon will need fixing ? I suppose all the xxxxcon in
> drivers/video/console, do you "see" any other ?

I don't see that anybody else can possibly care. In fact, I doubt even 
vgacon actually cares. It's just a regular unblank, but with the 
information that we came from graphics mode. I think it would be cleaner 
to add a new parameter to the "con_blank()" function, which would also 
cause compiler warnings for non-converted consoles, which is good.

Right now we encode multiple things into the one existing "blank"
parameter, which is just confusing. We have

   -1: /* enter graphics mode (just save whatever state we need to save, 
          possibly clear state to be polite) */
    0: /* regular unblank (restore screen contents, enable backlight) */
    1: /* regular blank */
    2..x: VESA blank type x-1.

and I'd suggest that the new case would be the "regular unblank", but with 
the new parameter saying that we're coming from graphics mode. For 
example, I don't think the vgacon_blank() function would change at _all_ 
(except for the new parameter that it would just ignore).

As far as I can tell, fbcon is the _only_ thing that wouldn't ignore the 
new information, exactly because fbcon might want to reset things like the 
graphics engine.

		Linus
