Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSEPWzB>; Thu, 16 May 2002 18:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSEPWzA>; Thu, 16 May 2002 18:55:00 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:29203 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S315182AbSEPWzA>;
	Thu, 16 May 2002 18:55:00 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205162254.g4GMsiP07608@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: From "(env:" "ptb)" at "May 16, 2002 10:49:15 am"
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Fri, 17 May 2002 00:54:44 +0200 (MET DST)
Cc: Steve Whitehouse <Steve@ChyGwyn.com>, alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I didn't pick this up earlier ..

"Steven Whitehouse wrote:"
> we don't want to alter that. The "priority inversion" that I mentioned occurs
> when you get processes without PF_MEMALLOC set calling nbd_send_req() as when

There aren't any processes that call nbd_send_req except the unique
nbd client process stuck in the protocol loop in the kernel ioctl
that it entered at startup.

> they call through to page_alloc.c:__alloc_pages() they won't use any memory
> once the free pages hits the min mark even though there is memory available
> (see the code just before and after the rebalance label).

So I think the exact inversion you envisage cannot happen, but ...

I think that the problem is that the nbd-client process doesn't have
high memory priority, and high priority processes can scream and holler
all they like and will claim more memory, but won't make anythung better
because the nbd process can't run (can't get tcp buffers), and so
can't release the memory pressure.

So I think that your PF_MEMALLOC idea does revert the inversion.

Would it also be good to prevent other processes running? or is it too
late. Yes, I think it is too late to do any good, by the time we feel
this pressure.

Peter
