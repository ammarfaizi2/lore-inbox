Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUJYUsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUJYUsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUJYUs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:48:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2566 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262043AbUJYUrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:47:04 -0400
Date: Mon, 25 Oct 2004 21:47:01 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels
In-Reply-To: <20041025201758.GG9142@wotan.suse.de>
Message-ID: <Pine.LNX.4.58L.0410252143530.10974@blysk.ds.pg.gda.pl>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
 <20041025201758.GG9142@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Andi Kleen wrote:

> >  It's not the dummy read that causes the problem.  It's the index write
> > that does.  It can be solved pretty easily by not changing the index.  It
> 
> True. It has to be cached once.

 You mean once per write, don't you?  The index is w/o, unfortunately.

> >  The use is correct.  Bit #7 at I/O port 0x70 controls the NMI line
> > pass-through flip-flop.  "0" means "pass-through" and "1" means "force
> > inactive."  As the NMI line is level-driven and the NMI input is
> > edge-triggered, the sequence is needed to regenerate an edge if another
> > NMI arrives via the line (not via the APIC) while the handler is running.
> 
> At least in the datasheet I'm reading (AMD 8111) it is just a global
> enable/disable bit.

 The flip-flop is expected to be connected to the NMI input of the
processor, which for systems using local APICs means their LINT1 inputs (I
think it's broadcasted for all existing systems, although in principle
only the BSP needs to be connected).  But from the local APIC's point of
view LINT1 is just another local interrupt line which may or may not be
programmed for the NMI delivery mode and moreover, NMIs may arrive via the
LINT0 input or from the performance counter interrupt if programmed so
(this is the case with the NMI watchdog) or from another APIC as an IPI or
an ordinary interrupt.  These alternative sources are of course unaffected
by the flip-flop unless you have a strange implementation of the local
APIC.

  Maciej
