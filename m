Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUD1VUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUD1VUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUD1VTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:19:09 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:20486 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261248AbUD1VOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:14:23 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: REMINDER: 2.4.25 and 2.6.x yenta detection issue
Date: Wed, 28 Apr 2004 23:10:28 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0403191509280.2227-100000@dmt.cyclades> <20040319210720.J14431@flint.arm.linux.org.uk> <20040428195434.GA27783@jsambrook>
In-Reply-To: <20040428195434.GA27783@jsambrook>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404282310.28403.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 21:54, Jonathan Sambrook wrote:
> At 21:07 on Fri 19/03/04, rmk+lkml@arm.linux.org.uk masquerading as 'Russell King' wrote:
> > On Fri, Mar 19, 2004 at 03:14:54PM -0300, Marcelo Tosatti wrote:
> > > It seems the problem reported by Silla Rizzoli is still present in 2.6.x
> > > and 2.4.25 (both include the voltage interrogation patch by rmk).
> > > 
> > > Daniel Ritz made some efforts to fix it, but did not seem to get it right. 
> > 
> > And that effort is still going on.  Daniel and Pavel have been trying
> > to find a good algorithm for detecting and fixing misconfigured TI
> > interrupt routing, and this effort is still on-going.
> > 
> > What would be useful is if Silla could test some of Daniel's patches
> > and provide feedback.
> > 
> > The latest 2.6 patch from Daniel is at:
> 
> Any movement on 2.4.x w.r.t this?
> Even a patch to get back 2.4.23 functionality whihc worked fine here
> would be good (need > 2.4.25 for XFS).
> 

well, the 2.4 of the TI interrupt routing that is merged in 2.6 is is here since april 6:
http://ritz.dnsalias.org/linux/pcmcia-ti-routing-9_v24.patch
(yes, the 2.6 version is nicer 'cos of the nicer override handling there)

the problem silla rizzoli has is different. the patch that solved it:

--- snip ---
the CB_CDETECT1 and CB_CDETECT2 bits both needs to be 0 for the card being
recognized correctly (and one of the voltage bits need to be set).

with the patch we always redo the interrogation as longs as we're not sure
a card is really there (it would be bad to do so on some bridges). this solves
hangs of the bridge seen at least on one TI1520.

the if-statement was originally added 'cos some bridges misbehave if the
interrogation is done when a card is already correctly recognised. this is
still true with the patch.

the ti1520 that silla rizzoli has shoots itself in the head (read: hangs) and does not
regognise card insert/removal event. the card only works there if it was inserted on
boot. redoing the interrogation when there's no card kicks the bridge back into the
right state making it work...

--- 1.15/drivers/pcmcia/yenta.c	Tue Jan  6 11:55:05 2004
+++ edited/drivers/pcmcia/yenta.c	Fri Feb 20 23:17:54 2004
@@ -677,10 +677,9 @@
 
 	/* Redo card voltage interrogation */
 	state = cb_readl(socket, CB_SOCKET_STATE);
-	if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
-			CB_3VCARD | CB_XVCARD | CB_YVCARD)))
-		
-	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
+	if (!(state & (CB_5VCARD | CB_3VCARD | CB_XVCARD | CB_YVCARD)) ||
+	    (state & (CB_CDETECT1 | CB_CDETECT2)))
+		cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 }
 
 /* Called at resume and initialization events */

