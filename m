Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbUACT2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUACT2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:28:33 -0500
Received: from cpe.atm2-0-1071046.0x50a5258e.abnxx8.customer.tele.dk ([80.165.37.142]:51345
	"EHLO starbattle.com") by vger.kernel.org with ESMTP
	id S263922AbUACT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:28:29 -0500
Message-ID: <3FF717BA.2000205@starbattle.com>
Date: Sat, 03 Jan 2004 20:27:54 +0100
From: Daniel Tram Lux <daniel@starbattle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Rob Love <rml@ximian.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       steve@drifthost.com, James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>  <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>  <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>  <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>  <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>  <1072823015.4350.40.camel@fur>  <Pine.LNX.4.58.0312301452370.2065@home.osdl.org> <1072825101.4350.55.camel@fur> <3FF6A612.90708@starbattle.com> <Pine.LNX.4.58.0401031024090.20823@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401031024090.20823@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sat, 3 Jan 2004, Daniel Tram Lux wrote:
>  
>
>>I tried setting the timeout up as a first fix, it also decreased the 
>>frequency of the error,
>>however it did not get rid of the error.
>>    
>>
>
>That is scary beyond belief.
>
>Basically you doubled your timeout, and you certainly _should_ have seen 
>at least one more status read from the extra 50 msec you waited. And since 
>your patch (which fixes it) only adds _one_ status read, that implies that 
>the extra 50 msec timeout didn't get a single time through the loop.
>
>  
>
>>The device the error occurs with is a cf card. The error also occurs
>>much more frequently in 2.4.23 than in 2.4.20 (but it can be provoked in
>>2.4.20). Neither use the preemption patch and both are from kernel.org.
>>The platform is based on an AMD Elan processor which is a 486 compatible
>>processor, running at 133 Mhz. The IDE subsytem does not use any extra
>>drivers and is not a PCI ide chipset.
>>    
>>
>
>Yes, that path is only used for PIO writes, so it's clearly not a 
>high-performance IDE setup. Adn yes, I guess with a slow enough CPU and 
>enough interrupt load, you literally could spend 50ms just handling irqs. 
>Still, that is pretty damn scary. But I guess the load:
>
>  
>
>> ... there is a flood ping running and the machine is being 
>>flood pinged + there is traffic on three serial ports (RS485).
>>    
>>
>
>is pretty extreme.
>
These systems are going to Texas and I am in Denmark, so I wanted to be 
sure that the
system also works under heavy load. This is not the typical use however ;-).

>
>  
>
>>I saw two possibilities, either disabeling the interrupts while first
>>reading the status and then checking the timeout, after which the
>>interrupts would be enabled again. Or to just make one extra check after
>>the timout has expired because that is cheaper than returning, failing
>>and then resetting the drive. After I applied my patch (using the
>>5*HZ/100 timeout) my test ran for a full weekend without giving the
>>timeout error.
>>    
>>
>
>Ok, I think I'm convinced. That loop and the IDE usage of interrupt
>enables is just crap. I don't think your addition is very pretty, but the 
>alternative is to rewrite the loop to be sane, which isn't going to happen 
>in a stable kernel.
>
>How about a slightly more minimal patch, though? Ie does this work for 
>you?
>
>		Linus
>
>----
>===== drivers/ide/ide-iops.c 1.18 vs edited =====
>--- 1.18/drivers/ide/ide-iops.c	Wed Jun 11 18:23:09 2003
>+++ edited/drivers/ide/ide-iops.c	Sat Jan  3 10:54:21 2004
>@@ -647,6 +647,15 @@
> 		timeout += jiffies;
> 		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
> 			if (time_after(jiffies, timeout)) {
>+				/*
>+				 * One last read after the timeout in case
>+				 * heavy interrupt load made us not make any
>+				 * progress during the timeout..
>+				 */
>+				stat = hwif->INB(IDE_STATUS_REG);
>+				if (!(stat & BUSY_STAT))
>+					break;
>+
> 				local_irq_restore(flags);
> 				*startstop = DRIVER(drive)->error(drive, "status timeout", stat);
> 				return 1;
>  
>
The patch seems functionally to be equivalent, I can test it first thing 
on monday. I agree that the loop
should be rewritten too, it is neither clear for reading nor very 
accurate when it comes to measuring
the timeout.
I also was planning to test this patch with a reduced timeout of 
3*HZ/100, do you think that is worth
testing?

             Daniel
P.S.
I will try to make my patches more minimal in future ;-).

