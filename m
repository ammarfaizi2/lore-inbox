Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSGBT5x>; Tue, 2 Jul 2002 15:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSGBT5w>; Tue, 2 Jul 2002 15:57:52 -0400
Received: from aboukir-101-1-23-willy.adsl.nerim.net ([62.212.114.60]:46866
	"EHLO www.home.local") by vger.kernel.org with ESMTP
	id <S316889AbSGBT5v>; Tue, 2 Jul 2002 15:57:51 -0400
Date: Tue, 2 Jul 2002 22:00:05 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: willy tarreau <wtarreau@yahoo.fr>, Willy TARREAU <willy@w.ods.org>,
       willy@meta-x.org, linux-kernel@vger.kernel.org,
       Ronald.Wahl@informatik.tu-chemnitz.de
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Message-ID: <20020702200005.GA29557@pcw.home.local>
References: <20020701130327.38962.qmail@web20506.mail.yahoo.com> <200207011316.g61DGxT18808@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207011316.g61DGxT18808@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you code up a "dummy" emulator (which just ignores
> any invalid opcode by doing eip+=3) and compare trap times
> of your emulator and dummy one for, say, CMOVC AL,AL?
> (with carry flag cleared)

The dummy emulator costs exactly 296 cycles (stable) on my
k6-2/450. It only adds 3 to eip then returns.

To check this, I compared 1 million iteriations of 10
consecutive cmove %eax,%eax with as much lea 0(%eax),%eax
(1 cycle, RAW dependancy, not parallelizable), and the
difference was exactly 660 ns/inst (297 cycles).

That said, I agree with you that it's worth optimizing a
bit, at least to stay closer to 300 cycles than to 450.
But that won't make emulated machines fast anyway.

One interesting note: I tested the prog on a VIA C3/533
Mhz. One native cmove %eax,%eax costs 56 cycles here ! (at
first, I even thought it was emulated). It's a shame to see
how these instructions have been implemented. May be they
flush the pipelines, write-backs, ... before the instruction.
BTW, cmov isn't reported in cpu_flags, perhaps to discourage
progs from using it ;-)

I will recode the stuff, and add two preventive messages:
 - at boot time : "warning: this kernel may emulate unsupported instructions. If you
   find it slow, please do dmesg."
 - at first emulation : "trap caught for instruction XXX, program XXX."

Cheers,
Willy

