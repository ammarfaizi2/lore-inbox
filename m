Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTANJJi>; Tue, 14 Jan 2003 04:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTANJJi>; Tue, 14 Jan 2003 04:09:38 -0500
Received: from AMarseille-201-1-3-195.abo.wanadoo.fr ([193.253.250.195]:25969
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261854AbTANJJh>; Tue, 14 Jan 2003 04:09:37 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E23696A.9040006@google.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>
	 <1042484609.30837.31.camel@zion.wanadoo.fr>  <3E23114E.8070400@google.com>
	 <1042491409.586.4.camel@zion.wanadoo.fr> <3E233160.3040901@google.com>
	 <3E23696A.9040006@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042535903.586.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Jan 2003 10:18:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 02:35, Ross Biro wrote:
> Ross Biro wrote:
> 
> >>>
> >>> This is technically a spec violation, but it's probably safe.  I'm 
> >>> going to send an email to a couple of the drive manufacturers and 
> >>> see what they think.
> >>>   
> >>
> I just heard back from one ide controller chip vendor and they think we 
> should disable PCI write posting.  From the tone of the response, I 
> believe that they may not have thought of this before and it may be a 
> problem in their non-opensource drivers as well.

Argh... Well, I don't think that's a solution unfortunately. The
"posting" can be done at various level down the path to the device and
we don't always know how to (or want to) tweak it to disable any kind of
posting. It can be done on P2P bridges, it can be done in the host
bridge (for which we may have no specs in some cases) and it can be done
at the CPU level (not couting the IDE chipset itself that might want to
play tricks).

So what can we do at this point ? I beleive the only sane solution is to
provide that hwif->IOSYNC. Normal PCI-DMA controllers setting it to
dma_base by default, I know what to do for ide-pmac, others will have to
find some way to get it right for their platform (legacy x86 IO ports
might not be a problem as Alan pointed those IOs are fully synchronous).
Maybe we shall initialize that to some default provided by asm/ide.h (I
don't like that much though).

Ben.


