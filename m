Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSENM2C>; Tue, 14 May 2002 08:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSENM2B>; Tue, 14 May 2002 08:28:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7684 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315214AbSENM2A>; Tue, 14 May 2002 08:28:00 -0400
Subject: Re: [PATCH] 2.5.15 IDE 61
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Tue, 14 May 2002 13:47:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        nconway.list@ukaea.org.uk (Neil Conway), linux-kernel@vger.kernel.org
In-Reply-To: <3CE0F0D0.7050404@evision-ventures.com> from "Martin Dalecki" at May 14, 2002 01:11:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177bhp-0007qR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its possible it can be done with a semaphore but the whole business is
> > pretty tricky. IDE command processing occurs a fair bit at interrupt level
> > and you definitely don't want to block interrupts for long periods.
> 
> ... Becouse the chances are fscking high - that you will miss command
> completion interrupts for the "other drive" on the same channel.

The shared IRQ capable IDE ards I am aware of all do have proper tristates
 but you still have to handle the edge trigger very carefully.

If you can miss a command completion interrupt you have a bug. Since you
know each drive on the bus you can poll each afflicted device for interrupts
until you reach a point where you completed an entire poll loop and nobody
had an IRQ pending.

At that point you know an edge transition has occurred and that a real
IRQ will be posted when the next event occurs because that too will cause
an edge.

A good place for examples of this in the DOS world is things like serial
drivers, many of which could handle broken shared IRQ ISA setups correctly
using this technique.

In the case without tristates the stronger driver tends to win the argument
about the line in either direction and nothing works at all.
