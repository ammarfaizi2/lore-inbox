Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315841AbSEGOkX>; Tue, 7 May 2002 10:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315842AbSEGOkW>; Tue, 7 May 2002 10:40:22 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:21956 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S315841AbSEGOkU>; Tue, 7 May 2002 10:40:20 -0400
From: <benh@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.13 IDE 54
Date: Tue, 7 May 2002 16:40:27 +0200
Message-Id: <20020507144027.11544@mailhost.mipsys.com>
In-Reply-To: <3CD7C360.6050002@evision-ventures.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK I see I have "forced" you to take care of this.
>My problem previously was the simple fact that in esp.
>the pmac code was sidestepping the generic code and providing his
>own mechanisms for handling chipset specific dma transfer methods.
>
>As you can see now it's possible to have overloaded most
>of the "virtuaized" udma_xxx channel methods.
>
>Now you request me to virtualize the udma_enable stuff.
>Nothing easier then this.

I haven't looked closely at your new stuff yet, but here's what
we need for ide-pmac (and similarily, on a whole bunch of embedded
IDE controllers that do not behave like a legacy controller).

 - hook on enabling/disabling DMA & setting up timing stuffs. Due to
   some weird HW, we must be in control of the actual sending of the
   feature setting command to the drive
 - hook on creating/disposing the DMA related data structures (lists
   etc...)
 - hook on setting up the DMA SG list as PRDs are really only
   specific to the legacy PCI controllers, we deal with all sort
   of different DMA controllers here in the outside world ;)
 - hook on starting the DMA transfer
 - hook on stopping the DMA transfer
 - hook on knowing if the DMA is done and/or letting it drain
   completely upon reception of the last interrupt.

Ideally, in order to properly deal with some HW details, the hook on
starting the DMA transfer should also be the one ultimately issuing
the command to the taskfile register, as depending on the HW, it may
have to be done either prior or after starting the DMA channel.

So instead of having a ton of hook, I'd rather see all of this be
properly abstracted by default, the legacy IDE beeing only one
of the possible set of callbacks, instead of having the default code
in ide.c with hooks for different chipsets.

Regards,
Ben.



