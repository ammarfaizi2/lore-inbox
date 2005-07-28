Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVG1Vwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVG1Vwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVG1Vwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:52:34 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:2690 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261531AbVG1Vuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:50:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.13-rc3: swsusp works (TP 600X)
Date: Thu, 28 Jul 2005 23:55:48 +0200
User-Agent: KMail/1.8.1
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-kernel@vger.kernel.org
References: <20050723003544.GC1988@elf.ucw.cz> <E1DyEok-0000pa-SX@approximate.corpus.cam.ac.uk> <20050728213650.GA1872@elf.ucw.cz>
In-Reply-To: <20050728213650.GA1872@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lRV6CipUE9lyd8M"
Message-Id: <200507282355.49356.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_lRV6CipUE9lyd8M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, 28 of July 2005 23:36, Pavel Machek wrote:
> Hi!
> 
> > >>If I don't eject the pcmcia card (usually a prism54 wireless card),
> > >>swsusp begins the process of hibernation, but never gets to the
> > >>writing pages part.
> > 
> > > Well, it really may be the firmware loading. Add some printks to
> > > confirm it, then fix it.
> > 
> > I did more tests, this time with 2.6.13-rc3-mm2 (machine is a TP 600X),
> > and I don't think the problem is related to firmware loading.  If I
> > first physically eject the card (an Intersil wireless card), swsusp
> > prints
> > 
> ..
> > 
> > then it writes pages to swap and all is well.  Well, almost 100%; the
> > one glitch is that sometimes X comes back blank and I have to
> > ctrl-alt-F7 to bring back the display; or X comes back with the keyboard
> > acting strange (<ENTER> shifts the display left by a few hundred
> > pixels), and again ctrl-alt-F7 fixes it.  This is with XFree86
> > 4.3.0.dfsg.1-14, and maybe after I upgrade (?) to the xorg server, that
> > glitch will go away.  Anyway, it's easy to work around.
> 
> So, in short, problem is that if you leave prism54 card in, even with
> module removed, swsusp hangs, right?
> 
> Okay then, start looking into pcmcia layer ;-).

Perhaps the patch from Daniel Ritz to free the yenta IRQ on suspend (attached)
will help?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_lRV6CipUE9lyd8M
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.13-rc3-git5-yenta-suspend_resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.13-rc3-git5-yenta-suspend_resume.patch"

--- linux-2.6.13-rc3-git5/drivers/pcmcia/yenta_socket.c	2005-07-23 19:26:30.000000000 +0200
+++ patched/drivers/pcmcia/yenta_socket.c	2005-07-24 11:44:04.000000000 +0200
@@ -1107,6 +1107,8 @@ static int yenta_dev_suspend (struct pci
 		pci_read_config_dword(dev, 17*4, &socket->saved_state[1]);
 		pci_disable_device(dev);
 
+		free_irq(dev->irq, socket);
+
 		/*
 		 * Some laptops (IBM T22) do not like us putting the Cardbus
 		 * bridge into D3.  At a guess, some other laptop will
@@ -1132,6 +1134,13 @@ static int yenta_dev_resume (struct pci_
 		pci_enable_device(dev);
 		pci_set_master(dev);
 
+		if (socket->cb_irq)
+			if (request_irq(socket->cb_irq, yenta_interrupt,
+			                SA_SHIRQ, "yenta", socket)) {
+				printk(KERN_WARNING "Yenta: request_irq() failed on resume!\n");
+				socket->cb_irq = 0;
+			}
+
 		if (socket->type && socket->type->restore_state)
 			socket->type->restore_state(socket);
 	}

--Boundary-00=_lRV6CipUE9lyd8M--
