Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSASRXt>; Sat, 19 Jan 2002 12:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSASRXj>; Sat, 19 Jan 2002 12:23:39 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:13716 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S286207AbSASRX2>; Sat, 19 Jan 2002 12:23:28 -0500
Date: Sat, 19 Jan 2002 09:21:53 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_alloc_consistent from interrupt == BAD
To: Russell King <rmk@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <000701c1a10d$cae90480$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"> > " == David Miller
"> " == Russell King

> > BTW, the USB host controller drivers do this (allocate potentially
> > from interrupts) so anyone using USB on ARM...
> 
> Well, I've got a BUG() in there that'll trigger when pci_alloc_consistent()
> is called from IRQ, and so far no one has reported an incidence of
> that occuring, despite there being USB OHCI controllers available on ARM.

Yes, that'd be rare -- but legal.

The USB host controller drivers would do that primarily in the
case where (a) some driver submitted a new URB in_interrupt(),
so the HCD needed to queue new requests to the hardware,
and (b) the pools of endpoint or transfer descriptors didn't have
enough free entries.

The main reason for (a) is that the last URB just completed, and
freed its resources, and a new request for that endpoint needs to
get submitted.  As for (b), endpoint descriptors are normally
preserved until the device is disconnected.  That leaves transport
descriptors (TDs).  OHCI (and EHCI) don't need many of those;
typically one per request.  So if one was just put back into the pool,
it'd typically still be available.  UHCI needs more memory, but
the same general rules apply.

- Dave


