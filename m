Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWA3RGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWA3RGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWA3RGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:06:45 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:6669 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964792AbWA3RGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:06:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.60.0601301726190.9429@kepler.fjfi.cvut.cz>
X-OriginalArrivalTime: 30 Jan 2006 17:06:42.0441 (UTC) FILETIME=[8ACE8790:01C625BF]
Content-class: urn:content-classes:message
Subject: Re: DMA Transfer problem
Date: Mon, 30 Jan 2006 12:06:41 -0500
Message-ID: <Pine.LNX.4.61.0601301148360.30040@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DMA Transfer problem
Thread-Index: AcYlv4rVEGc6JaIfQ6G20wFPfSLBbw==
References: <43D5B473.3060006@arl.amrita.edu> <43D624B4.5070300@superbug.co.uk> <43D62989.3070108@arl.amrita.edu> <Pine.LNX.4.60.0601301726190.9429@kepler.fjfi.cvut.cz>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Cc: "Harish K Harshan" <harish@arl.amrita.edu>,
       "James Courtier-Dutton" <James@superbug.co.uk>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Jan 2006, Martin Drab wrote:

> On Tue, 24 Jan 2006, Harish K Harshan wrote:
>
>> Thank You, James,
>>
>>   But the problem with sound card drivers are that they dont have a
>> configurable clock on them, do they??? and as far as i know, this ADC card
>> involves a lot of register writings for the counter ICs that help configuring
>> the clock speed for the DMA transfer.... First we set the control properties,
>> which involves the IRQ, start channel, stop channel, etc (the card is an
>> 8-channel ADC), (the jumper settings configure the DMA channels that should be
>> used, 1 or 3). Now we initialize the DMA controller, so that it throws an
>> interrupt once the transfer of DMA_COUNT samples of data. The interrupt
>> service routine for this interrupt can handle the data transfer to the user
>> program. Roughly thats how the driver works... Now, the problem is that, when
>> running on the Chino-Laxsons board PCs, the DMA transfers take varying time to
>> complete (say, if one transfer takes one second, the next might take one and a
>
> I'm not really sure what do you mean by that, but there may be lots of
> reasons for this. Bad bus latencies, other devices blocking the bus, bad
> chipset, bad PCI/DMA controller on the device (this happend to me with
> an AMCC S5933 MatchMaker PCI chip, since it has about 16 HW construction
> bugs within it which makes it nearly impossible to reliably use it with
> any reaonably new chipset - with very old chipsets the bugs didn't
> demonstrate themselfs that much), etc. And you may also consider a hard
> real-time system if it's really time critical and intensive.
>
> Martin

If you are configuring a bus-master for DMA transfer across the
PCI/Bus, you need to make sure that all the messages got to the
device. The PCI/Bus is a FIFO. If you are writing a lot of stuff
to your board, it may wait, depending upon where it is "parked"
for more data to be written. To make sure that everything gets
to your hardware NOW, execute a dummy READ in your hardware's
address space immediately after the last instruction that is
supposed to start the DMA. Also, you need to make that READ
in some way that the 'C' compiler won't delete it as an unnecessary
instruction, i.e., (void)readl(addr) may not work! You need to
make an assignment to something that could get accessed like
junk = readl(status), where junk is global! The "volatile-ness"
of the readl() macro won't protect you from having the instruction
deleted entirely when the 'C' compiler determines that the
code "does nothing"!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
