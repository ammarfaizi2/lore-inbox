Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUACLXi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 06:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUACLXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 06:23:37 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:35464
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S265978AbUACLXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 06:23:30 -0500
Message-ID: <3FF6A612.90708@starbattle.com>
Date: Sat, 03 Jan 2004 12:22:58 +0100
From: Daniel Tram Lux <daniel@starbattle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Love <rml@ximian.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, steve@drifthost.com,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set	released
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>	 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>	 <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>	 <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>	 <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>	 <1072823015.4350.40.camel@fur>	 <Pine.LNX.4.58.0312301452370.2065@home.osdl.org> <1072825101.4350.55.camel@fur>
In-Reply-To: <1072825101.4350.55.camel@fur>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love wrote:

>On Tue, 2003-12-30 at 17:54, Linus Torvalds wrote:
>
>  
>
>>Interrupts are _not_ disabled here, very much on purpose. If they were, 
>>then "jiffies" wouldn't update, and the timeouts wouldn't work.
>>
>>This is what that _stupid_ "local_irq_set()" function does: it saves the 
>>old irq masking state, and then it enables it.
>>
>>The whole concept doesn't make any sense. If you enable interrupts, there 
>>is little point in saving the callers irq mask, since it already got 
>>deflated.
>>    
>>
>
>Ah, OK.  local_irq_set() is worthless, then.
>
>Curious to see the results of upping the timeout.
>
>	Rob Love
>
>  
>
I tried setting the timeout up as a first fix, it also decreased the 
frequency of the error,
however it did not get rid of the error.
I used:

#define WAIT_DRQ        (10*HZ/100)      /* 100msec - spec allows up to 20ms */

in stead of:

#define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms */


The device the error occurs with is a cf card. The error also occurs 
much more frequently in
2.4.23 than in 2.4.20 (but it can be provoked in 2.4.20). Neither use 
the preemption patch
and both are from kernel.org. The platform is based on an AMD Elan 
processor which is
a 486 compatible processor, running at 133 Mhz. The IDE subsytem does 
not use any extra
drivers and is not a PCI ide chipset.

The test I use to provoke the error is moving a directory tree from hdc 
(a normal harddisk)
to hda (the cf card), removing the dir on hdc, copy it back from hda to 
hdc, and remove it
from hda, then start all over.....
While doing this there is a flood ping running and the machine is being 
flood pinged + there
is traffic on three serial ports (RS485).

The way the code works right now there is no way you can tell how much 
time has passed
since the status register last got read out due to a possible interrupt. 
So when I made the patch
I saw two possibilities, either disabeling the interrupts while first 
reading the status and then
checking the timeout, after which the interrupts would be enabled again.
Or to just make one extra check after the timout has expired because 
that is cheaper
than returning, failing and then resetting the drive. After I applied my 
patch (using the
5*HZ/100 timeout) my test ran for a full weekend without giving the 
timeout error.
Before the error would occur about every 3 minutes with 2.4.23 and every 
couple of
hours on 2.4.20. (I didn't try to patch 2.4.20).

The ide standard gives a timeout for the busy wait of 20 ms which should 
not be exceeded
and the documentation from sandisk (the cf card is from sandisk) claims 
to conform to this.

If anybody has any other suggestions/tests I can try these out on monday 
when I am back
at work.

Regards

       Daniel Tram Lux


