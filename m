Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbRENA5c>; Sun, 13 May 2001 20:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262026AbRENA5V>; Sun, 13 May 2001 20:57:21 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:24143
	"EHLO jet.il.steeleye.com") by vger.kernel.org with ESMTP
	id <S262021AbRENA5N>; Sun, 13 May 2001 20:57:13 -0400
Message-Id: <200105140055.TAA00817@jet.il.steeleye.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4 
In-Reply-To: Message from Andries.Brouwer@cwi.nl 
   of "Mon, 14 May 2001 01:57:33 +0200." <UTC200105132357.BAA40155.aeb@vlet.cwi.nl> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Sun, 13 May 2001 19:55:55 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl said:
> If I am not mistaken, Richard Hirst has also done work on this thing.
> The Panther/lp486e/PWS/... has on-board ethernet (82596) and this now
> works under both 2.2 and 2.4. It also has on-board SCSI (NCR
> 53c700-66), maybe memory mapped, I forget. Maybe nobody knows the
> addresses. It would be somewhat interesting to get that thing to work
> as well. 

You're likely to trip across the part of the driver I skimped on:  The clock divider section.  Usually you want the async core to run just under 25Mhz and the sync core to run just under 50Mhz.  Therefore, you ususally clock the 700-66 chip at 50Mhz and put 1 into the sync and 2 into the async divider (which is all I do---although you probably clock a non -66 chip at 25Mhz).  However, a combo card may have a rather different clock speed.  I can work on this some more if you want to try to get the card running.  Do you know what the clock speed is?

alan@lxorguk.ukuu.org.uk said:
> According to http://www.murphy.nl/~ard/systems/pws/pws/node18.html the
> NCR 53c700/66 is mapped at 0xCC0-0xCFF.

That would be io mapped?  then the 53c700.c chip driver should plug almost straight in.

Andries.Brouwer@cwi.nl said:
> Yes. But long ago he wrote:
>  --- 
> You need quite a different driver from the 53c710 drivers that exist,
> because 53c700 doesn't have DSA register.  I've attached a diff for
> 2.4.0-test9 which adds sim700.{c,h,scr}.  That driver is supposed to
> handle 53c700 and 53c710 and be a replacement for sim710.c.

There are several other differences, although the lack of DSA register is the most annoying:

- They can't manipulate the chip registers in the script.
- Their SCSI-DMA fifo core is only 32 bits (you need to compute the datapath residue differently)
- The selection model is completely different.  You can put the 710 into 700 compatibility mode and run the same selection model, but that's probably not what you want: the 700 needs two interrupts to resume after a reselection, one to see the selection and the other to collect the lun and tag.  The 710 can wait for the reselection grab the lun and tag and then interrupt.  You can also dispense with the elaborate selection interrupt section I have to have.  I thought of doing a probabalistic selection for the 700:  given the PUN, you guess the lun and tag (probably use the oldest) and set the script up for these.  You take a "wrong guess" interrupt if you got it incorrect.  However, with 8 tags outstanding per device, you'd probably only see a 13% correct guess, which didn't seem worth it.

I thought, based on these differences, that it made more sense to keep the 700 driver separate from the 710 one.

The next chip core I'm considering is the 720/770 (I have a nice microchannel card with 4 of these and 2MB of onboard memory), unless you know of someone who has already done the extra work (the 53c7xx and 53c7,8xx don't do the wide/ultra features).

James


