Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbRBXByQ>; Fri, 23 Feb 2001 20:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130344AbRBXByF>; Fri, 23 Feb 2001 20:54:05 -0500
Received: from [209.81.55.2] ([209.81.55.2]:4624 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S130272AbRBXBxw>;
	Fri, 23 Feb 2001 20:53:52 -0500
Date: Fri, 23 Feb 2001 17:53:39 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.2.18: weird eepro100 msgs
In-Reply-To: <Pine.LNX.4.10.10102021719120.3255-100000@main.cyclades.com>
Message-ID: <Pine.LNX.4.10.10102231738400.32459-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, Ivan Passos wrote:
> 
> On Fri, 2 Feb 2001, Ion Badulescu wrote:
> 
> > On Fri, 2 Feb 2001 15:01:05 -0800 (PST), Ivan Passos <lists@cyclades.com> wrote:
> > 
> > > Sometimes when I reboot the system, as soon as the eepro100 module is
> > > loaded, I start to get these msgs on the screen:
> > > 
> > > eth0: card reports no resources.
> > > eth0: card reports no RX buffers.
> > > eth0: card reports no resources.
> > > eth0: card reports no RX buffers.
> > > eth0: card reports no resources.
> > > eth0: card reports no RX buffers.
> > > (...)
> > 
> > Does the following patch, taken from 2.4.1, help?
> 
> I'm currently testing. I'll get back to you soon (have to reboot the
> system a lot to make sure it's really solved ... :)).

Yes, the patch did solve the problem.

Alan, could you please include this patch on your 2.2.19pre series (if
it's not already included)??

Ion, thanks again for your help!!

Later,
Ivan

--- linux-2.2.18/drivers/net/eepro100-old.c	Fri Feb  2 15:30:23 2001
+++ linux-2.2.18/drivers/net/eepro100.c	Fri Feb  2 15:33:19 2001
@@ -751,6 +751,7 @@
 	   This takes less than 10usec and will easily finish before the next
 	   action. */
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	/* Honor PortReset timing. */
 	udelay(10);
 
@@ -839,6 +840,7 @@
 #endif  /* kernel_bloat */
 
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	/* Honor PortReset timing. */
 	udelay(10);
 
@@ -1062,6 +1064,9 @@
 	/* Set the segment registers to '0'. */
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outl(0, ioaddr + SCBPointer);
+	/* impose a delay to avoid a bug */
+	inl(ioaddr + SCBPointer);
+	udelay(10);
 	outb(RxAddrLoad, ioaddr + SCBCmd);
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outb(CUCmdBase, ioaddr + SCBCmd);

