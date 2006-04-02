Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWDBXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWDBXRw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWDBXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 19:17:52 -0400
Received: from smtpout.mac.com ([17.250.248.88]:13533 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751530AbWDBXRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 19:17:51 -0400
In-Reply-To: <1144013084.31123.14.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0604021508540.2653-100000@coffee.psychology.mcmaster.ca> <0FE43D5B-B25D-45C7-83ED-4DE1552EC9DB@mac.com> <1144013084.31123.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <67935AB3-842F-4344-ABAB-E65205C28E4C@mac.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       John Livingston <jujutama@comcast.net>,
       "Eric D. Mudama" <edmudama@gmail.com>,
       Robert Hancock <hancockr@shaw.ca>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Sun, 2 Apr 2006 19:17:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 2, 2006, at 17:24:43, Alan Cox wrote:
> On Sul, 2006-04-02 at 15:55 -0400, Kyle Moffett wrote:
>> (2)  It's extremely unlikely that the card itself is faulty; it  
>> exhibits identical symptoms on both drives and has ever since I  
>> originally purchased the card and installed 2.4.X on the system.
>
> If it has always shown those symptoms then I'd say its quite likely  
> the card if the crystals/PLLs on it are out. It looks like the  
> timing is wrong, which means either the input clocks (eg PCI clock)  
> are wrong (eg 37.5Mhz not 33 due to BIOS overclock settings or just  
> plain out), the card has a dodgy crystal/PLL or the kernel set it  
> up wrong.
>
> PCI timings won't move between motherboards, PLL faults wont move  
> between cards.
>
> Unless anyone else is seeing the same problem with the same card  
> variant or you have two cards that do it then there isn't much that  
> can be done I suspect other than assume the hardware is iffy,  
> rightly or wrongly. I'd have expected a lot more reports if it were  
> the controller.

Hmm, okm thanks for the information.  If it was possible, I'd be  
extremely suspicious that the card's firmware was either buggy or  
Linux didn't know how to repsond to the odd hardware variant; I don't  
recall them producing that model of card for very long, so it's quite  
possible there aren't many of them around and they have some kind of  
timing quirk nobody knows about.

CRC issues aside, there is that other MULTWRITE_EXT error that only  
occurs on hdi (and if I swap hdi and hdg, the error follows the  
drive).  The error also is specific to 2.6.15+, it does not occur on  
the 2.6.12+patch that I switched from a month ago.  I'm assuming that  
since the drive/card stop giving BadCRC errors that they're able to  
communicate successfully at the extremely low speed.

With a little more tinkering with hdparm I was able to determine that  
the drives on the built-in controller and the primary bus of the PCI  
controller were both in DMA mode, the former in udma4 and the latter  
in udma3.  The originally problematic drive (the one giving the  
MULTWRITE_EXT errors) was in PIO mode, though "hdparm -d1 /dev/hdi"  
"fixed" that problem and resulted in a drastic increase in drive bus  
speed as measured  by "hdparm -tT".  (from 2MB/sec to around 23MB/sec  
or so).  hdi ended up in udma2 according to "hdparm -i"

Just for clarity, I'm repeating the _new_ error below.  This one  
recurs about once or twice an hour, but only on the samsung drive.   
If the answer is (as it seems likely) "Your drive has bad firmware  
but the error is totally harmless", then I'll be perfectly happy,  
although I'd kind of prefer if the kernel could detect the buggy  
firmware and work around it (maybe by switching back to whatever the  
old behavior was, whenever changed).  I'd otherwise be happy to git- 
bisect except for the fact that a number of people rely on this  
system for day-to-day activities.

> Mar 28 03:15:13 penelope kernel: hdi: status timeout: status=0xd0  
> { Busy }
> Mar 28 03:15:13 penelope kernel: PDC202XX: Secondary channel reset.
> Mar 28 03:15:13 penelope kernel: hdi: no DRQ after issuing  
> MULTWRITE_EXT
> Mar 28 03:15:13 penelope kernel: ide4: reset: success

The drive on the built-in controller is correctly set to udma4 mode,  
though if I attempt to bump that up to udma5 (which is listed as  
supported in "hdparm -i /dev/hda"), then the drive becomes completely  
unresponsive until the next reboot.  I'm waiting for the RAID to  
finish rebuilding before I try increasing the UDMA speed on the other  
drives to see what happens.

Thanks again for the help and consideration!

Cheers,
Kyle Moffett

