Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSE2MKv>; Wed, 29 May 2002 08:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSE2MKu>; Wed, 29 May 2002 08:10:50 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:37388 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S315192AbSE2MKr>;
	Wed, 29 May 2002 08:10:47 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205291210.g4TCAgh32404@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <20020529112137.GA397@elf.ucw.cz> from Pavel Machek at "May 29,
 2002 01:21:37 pm"
To: Pavel Machek <pavel@suse.cz>
Date: Wed, 29 May 2002 14:10:42 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Steve Whitehouse <Steve@ChyGwyn.com>,
        linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Pavel Machek wrote:"
> > > Init routine is called from insmod context or at kernel bootup (from pid==1).
> > 
> > That's nitpicking!  
> 
> I did not want to be nitpicking. init() really is considered process

Well, OK.

> context, and it looks to me like unplug is *blocking* operation so it
> really needs proceess context.

unplug unsets the plugged flag and calls the request function. The
question is whether the request function is allowed to block. I argue
that it is not, on several grounds:

    1) it's also - and principally - been called from various task
    queues, which aren't really associated with a process context, and
    certainly not with the process context that set the task

    2) blocking is really bad news depending on how we got to the
    request function, which is not a really predictable thing, since
      i) it can change with every kernel version
      ii) it depends on what somebody else does

   3) if we block against memory for buffers, in particular, the 
   the system is now very likely to be dead, since VM just went
   synchronous.

and probably you know lots better arguments!


Peter
