Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRDHSPQ>; Sun, 8 Apr 2001 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132581AbRDHSPG>; Sun, 8 Apr 2001 14:15:06 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:27144 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132578AbRDHSPE>; Sun, 8 Apr 2001 14:15:04 -0400
Date: Sun, 8 Apr 2001 22:11:23 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010408221123.A22893@jurassic.park.msu.ru>
In-Reply-To: <20010406140920.A4866@jurassic.park.msu.ru> <Pine.GSO.3.96.1010406190813.15958H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010406190813.15958H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Apr 06, 2001 at 07:13:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 07:13:21PM +0200, Maciej W. Rozycki wrote:
>  You do.  PCI-space registers are volatile and they may change depending
> on what was written (or read) previously.  A memory barrier before a PCI
> read will ensure you get a value that is relevant to previous code
> actions.  Without a barrier you may get pretty anything, depending on
> which of previous writes managed to complete before. 

Of course. I meant that if you are reading, for example, some status register
in a loop waiting for "ready bit" set, the memory barrier won't help you
to notice this event any faster. Actually you'll notice that *later*, as
"mb" is expensive.

Well, here is some info on ev6 IO write buffers - they are a bit different
than ev4/ev5 ones.
Merging rules:
 - byte/word stores aren't allowed to merge into a write buffer;
 - different size stores (32- and 64-bit) aren't allowed to merge;
 - addresses must be in ascending order and non-overlapping,
   but not necessarily consecutive.
The I/O register merge window close (ie write-buffer flushing) occurs after
 - mb and wmb instructions;
 - IO-space load instruction (!);
 - after 1024 cycles if there were no IO-space stores.
Store requests are sent offchip in program order (!).

All this explains, in particular, why XFree86-4.0 worked on ev6 without
memory barriers of any kind, while it crashed badly on ev4/ev5.

Ivan.
