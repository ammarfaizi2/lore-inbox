Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVC3N63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVC3N63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVC3N63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:58:29 -0500
Received: from alog0622.analogic.com ([208.224.223.159]:62609 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261901AbVC3N6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:58:21 -0500
Date: Wed, 30 Mar 2005 08:57:59 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
cc: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Delay in a tasklet.
In-Reply-To: <424A7C58.7040105@roma1.infn.it>
Message-ID: <Pine.LNX.4.61.0503300840260.17388@chaos.analogic.com>
References: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
 <424A7C58.7040105@roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Davide Rossetti wrote:

> Bouchard, Sebastien wrote:
>
>> Hi,
>>
>> I'm in the process of writing a linux driver and I have a question in
>> regards to tasklet :
>>
>> Is it ok to have large delay "udelay(1000);" in the tasklet?
>>
>> If not, what should I do?
>>
>> Please send the answer to me personally (I'm not subscribe to the mailling
>> list) :
>>
>>
> I'd be interested in the answer as well. I have a driver which does
> udelay(100), so no 1000 but anyway, and of course I end up having the
> X86_64 kernel happily crying. I'm moving to a little state-machine to
> allow for a multi-pass approach instead of busy-polling..
> regards
>

Any time you are waiting with the interrupts off, you prevent
anything else from happening during that interval except,
perhaps some DMA operation previously started. This seriously
affects latency for other interrupt handlers.

If you are waiting with interrupts enabled, then you are
almost guaranteed to wait much longer than you expect because
there will most always be a higher-priority interrupt that
gets the CPU. In fact, you might have to disconnect your
network wire to be able to regain control!!

You mention the tasklet so I figure you are waiting for
something that was started as a result of an interrupt
then handed-off to a tasklet.

Even making a state-machine that gets control several times,
checks for the completed event, then returns, will not solve
the problem of such a defective hardware design because you
might not get the CPU back for several seconds! Hardware
needs to be designed so that you get an interrupt when
something completes. Failure to do this means that the
hardware design is defective and can't be used in a multi-
tasking environment running multiple applications.

Of course you could use such a defective design if you
also had some dedicated 8-bit processor to play secretary
and busy-wait on hardware. I encounter more-and-more
defective hardware designs where all the designer needed
to do was OR another bit into the interrupt pin and
everybody would be happy. Talk to the hardware designer
and see if you can't get the bit you are waiting for to
also generate an interrupt. Sometimes these people just
don't know any better and they will re-do their FPGA
in a few minutes if you bring these kinds of problems to
them. Others will just ignore "software" as a lower
form of life. In that case, document the hardware failures
and the software work-arounds necessary to make the
device "function", with the resulting trade-offs of
performance.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
