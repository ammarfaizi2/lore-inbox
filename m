Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbTGVSJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270981AbTGVSJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:09:21 -0400
Received: from linux8.bluehill.com ([128.121.244.233]:54171 "EHLO
	mach8.bluehill.com") by vger.kernel.org with ESMTP id S270980AbTGVSJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:09:19 -0400
Message-ID: <3F1D8159.4060209@inmotiontechnology.com>
Date: Tue, 22 Jul 2003 11:24:25 -0700
From: Larry LeBlanc <leblanc@inmotiontechnology.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Power Management/PCMCIA conflict causes system freeze
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hinted at this issue when I asked about PCI IRQs yesterday but I've 
received some feedback that indicates IRQs aren't my problem so I'll 
post the basic problem I'm trying to solve and see if anyone has any ideas.

I am running Linux (RH 8.0, upgraded to kernel 2.4.20) on a Kontron 
Envoy mobile data server - essentially a ruggedized PIII-700 MHz PC 
designed to be installed in the trunk of a car. It comes with a 5 minute 
UPS that issues power state change notifications so that it is possible 
to gracefully shutdown the system when the car power is turned off. If 
the power is restored within 30 seconds, the shutdown should abort and 
the system should continue running (or the shutdown should complete and 
then the system will auto-restart).

My problem is that as soon as the state change notification arrives, the 
system freezes. If the power remains off for more than 30 seconds, the 
UPS turns off and the system goes down hard. I'm using ext3 and I don't 
do a lot of writing so this hasn't caused me any trouble - yet. The big 
problem is that if the car power is restored within 30 seconds, the 
system remains frozen until you once again turn the car off for more 
than 30 seconds. Since the system is mounted in the trunk, it may not be 
obvious that this problem has occurred.

This problem also manifests itself when I attempt to do a shutdown (-h 
or -r). Everything shuts down properly but then hangs after the "Power 
down" or "Restarting system" message is printed on the console. I don't 
expect to have to reboot this system very often since it will naturally 
reboot every time the car turns off and back on again, but there may be 
occasions where I want to trigger a reboot and I won't be able to.

So how does PCMCIA relate to all of this? What we discovered after 
gradually stripping things out of the system is that everything works 
fine as long as the pcmcia modules (pcmcia_core, yenta_socket) are not 
loaded into the kernel. Once they are loaded, I see the above behaviour, 
regardless of whether any cards are in the CardBus adapter. Even if I 
subsequently unload the pcmcia modules the problem persists. 
Unfortunately I need PCMCIA support for my application, so leaving the 
modules unloaded is not an option.

My system is using a Texas Instruments PCI1450 CardBus adapter, if that 
helps. On boot yenta assigns IRQs 9 and 15 for the two sockets. 9 is 
also used by my VGA adapter and 15 is used by my audio controller, but I 
understand (now) that PCI is made to handle this kind of sharing and it 
should not, in and of itself, be a problem. In fact /proc/interrupts 
does not show the VGA and audio controller assignments - I found those 
via lspci -vv. I believe that means that the drivers have not actually 
requested them yet (not surprising since I don't really use either the 
VGA or the audio controller).

Any ideas? I've tried turning on debug in apm but all that happens is 
the debug messages freeze with the rest of the system. Is there any 
other location I should turn on debug messages to try to get an idea of 
where the system is hanging?

Thanks,

Larry

P.S. The system ships by default with Windows XP and everything works 
fine including PCMCIA. So from a hardware perspective I think everything 
is OK. I refuse to believe that I have to move to Windows in order to 
make this work...there has to be a Linux answer...





