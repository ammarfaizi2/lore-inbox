Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTDWOv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTDWOv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:51:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264066AbTDWOvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:51:55 -0400
Date: Wed, 23 Apr 2003 11:06:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stored data missed in setup.S
In-Reply-To: <200304231750.50553.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304231057380.23670@chaos>
References: <200304231617.23243.icedank@gmx.net> <200304231639.57148.icedank@gmx.net>
 <Pine.LNX.4.53.0304231028270.23276@chaos> <200304231750.50553.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

> Hello!
> >
> > [SNIPPED...]
> >
> > > OK. And now code looks like:
> > > -->
> > > start_of_setup: # line 160
> > > 	# bla bla bla - some checking code
> > >         movb    $1, %al
> > >         movb    %al, (0x100)
> > > ....
> > > ....
> > > 	cmpb    $1, (0x100)
> > > 	je bail820 # and it DON'T jump here
> > > <--
> > >
> > >
> > > I'm sure, I'm doing something wrong. But what???
> >
> > The only possibiity is that the code you just showed is not
> > being executed. Absolute location 0x100 is not being overwritten
> > by some timer-tick (normally) so whatever you write there should
> > remain. You just put a byte of 1 in that location and then
> > you compared against a byte of 1. If the CPU was broken, you
> > wouldn't have even loaded your code.
> >
> > It is quite likely that the IP is being diverted around your code
> > by some previous code.
> >
> > FYI, you can check the progress of your code by 'printing' on
> > the screen. Set up ES to point to the screen segment, and write
> > letters there:
> >
> > 	movw	$0xb800, %ax
> > 	movb	%ax, %es
> > 	movb	$'A', %es:(0)
> >
> > This 'prints' an 'A' at the first location on the screen.
>
> Ha! I don't have video adapter not keyboard on that PC :)
> And, when I change je to jmp it works perfectly.
>

Then the only possibility is that your DS segment has not been set
to somewhere that's writable so that your `movb $1, (0x100)` didn't
"take". The BIOS normally sets DS to 0x40, but if you want to read/write
at offset 0x100, it's probably better to set DS to 0. You do this
as :
	xorw	%ax,%ax
	movw	%ax,%ds

You need to put the value into a register, then from the register
into a data segment. In real-mode, the absolute memory location
is the segment (address * 16) + the offset. If you left it at
0x40, you have (0x40 * 0x10) + 0x100 = 0x500 which is truly
writable if you got through POST.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

