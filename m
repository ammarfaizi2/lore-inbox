Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbTCZH4p>; Wed, 26 Mar 2003 02:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbTCZH4p>; Wed, 26 Mar 2003 02:56:45 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:61071 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S261499AbTCZH4o>; Wed, 26 Mar 2003 02:56:44 -0500
From: Herbert Rosmanith <herp@wildsau.idv.uni.linz.at>
Message-Id: <200303260807.h2Q87O4l024956@wildsau.idv.uni.linz.at>
Subject: Re: linux->real mode-> boot other OS in protected mode
In-Reply-To: <200303070847.h278lmu07835@Port.imtp.ilyichevsk.odessa.ua>
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Wed, 26 Mar 2003 09:07:24 +0100 (MET)
CC: kasperd@daimi.au.dk, kernel@wildsau.idv.uni.linz.at,
       linux-kernel@vger.kernel.org, root@chaos.analogic.com
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I boot Linux via BIOS, then boot DOS via LINUX
> > when I boot linux again via LINLD, the "Uncompressing Linux ..."
> > takes a lot longer as compared to doing a LINLD from a DOS which
> > was booted by BIOS. I think this has something to do with
> > switching.... oh! I know .... machine_real_start() from linux turns
> > off the cache, so this could be the reason. Ok, so I'll check this
> > out by chaning CR0.
> 
> It is utterly strange that you can boot DOS from Linux at all.
> 

well, not really.

machine_real_start() from process.c switches into 16 bit mode. you can pass
arbitrary code to that function. this code has to:
reset some hardware ---
  - reset 8259 interrupt controller, that is, IRQ mapping (IRQ0->INT8)
  - reset 8253 timer to 18,2 ticks per second (I think)
and then:
  - correctly initialize EBP, ESP to 0x7c0, SS to 0.
  - also clear bits 16-31 of EAX, EBX ....
and as a last step:
  - reset harddisk via int10
  - read sector 0 to 0x7c0
  - copy sector 0 to 0x600
  - far jmp to 0:0x7c0

with this, I can boot DOS with EMM (goes into protected mode) or even
boot Windows2k-server. the latter only on my EPIA-ITX board, on another
board, it unfortunately crashes as soon as it goes into protected mode,
that is, the machine looks like its performing a cold-start (warm-start?).
seems like a double- or triple-fault. any idea on how this can be debugged?

thanks in advance,
herbert


