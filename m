Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSHTRvo>; Tue, 20 Aug 2002 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSHTRvo>; Tue, 20 Aug 2002 13:51:44 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:4402 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316070AbSHTRvn>;
	Tue, 20 Aug 2002 13:51:43 -0400
Date: Tue, 20 Aug 2002 19:55:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: Rob Myers <rob.myers@gtri.gatech.edu>, l <linux-kernel@vger.kernel.org>
Subject: Re: need contact of via-rhine developers
Message-ID: <20020820175507.GA19273@k3.hellgate.ch>
Mail-Followup-To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
	Rob Myers <rob.myers@gtri.gatech.edu>,
	l <linux-kernel@vger.kernel.org>
References: <1029854455.10084.136.camel@ransom> <200208201639.g7KGddXl020053@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208201639.g7KGddXl020053@wildsau.idv.uni.linz.at>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002 18:39:38 +0200, H.Rosmanith (Kernel Mailing List) wrote:
> thanks! that fixed the transmit-timeouts! they happened quite frequently.
> the more traffic you'd submit, the more timeouts. e.g. , when viewing
> icture over the net (e.g. xv running on a different host), I'd see about
> 12 timeouts per minute(raw estimation).
> 
> any idea what's confusing the chip in the first place?

After a transmission error (e.g. excessive collisions) the chip stops to
let the driver handle it. The driver does its thing and restarts the
transmission engine. Problem is, the ring buffer pointer on the chip
skidded too far and hence takes up work from the wrong entry.

If an error occured on entry n, the chip continues on n+2. The driver stops
harvesting transmitted buffers because the next entry in the ring (n+1)
remains marked as owned by the driver. A few more packets may be sent after
the restart, then the card stalls. After a while the watchdog kicks in to
resets chip and buffers. Transmission continues.

You can verify this easily by dumping ring pointer information and the
status bits associated with the ring buffer.

The fix is to have the interrupt handler set the ring buffer pointer to
what the driver knows to be the current entry.

Btw: The stalling you've seen, was that at 10 or 100 Mbps? Hub or Switch?
With debug level 2 (and fixed driver), do you find Abort or Underrun errors
in your log in situations where stalling occured with the old driver?

Roger
