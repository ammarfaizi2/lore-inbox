Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSJXVju>; Thu, 24 Oct 2002 17:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSJXVju>; Thu, 24 Oct 2002 17:39:50 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:64498 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265669AbSJXVjr>; Thu, 24 Oct 2002 17:39:47 -0400
Message-ID: <3DB86AC4.1010004@mvista.com>
Date: Thu, 24 Oct 2002 14:48:52 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: James Bottomley <James.Bottomley@steeleye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
References: <Pine.LNX.4.33L2.0210241350230.20950-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:

>On Thu, 24 Oct 2002, Steven Dake wrote:
>
>| James
>| Some responses below:
>|
>| James Bottomley wrote:
>|
>| >sdake@mvista.com said:
>
>| >I don't really think it's the job of the kernel to conatin usage information.
>| >That's the job of the user level documentation.
>| >
>| >
>| I've gotten mixed feedback on this.  I'll add you to the list that
>| doesn't like this.
>
>add me to that list also.
>
>| perhaps it should be removed (even though it takes up minimal memory).
>yes, i agree.
>
>| >>Imagine scanning each disk in driverfs looking at its WWN attribute
>| >>(if  it has one) until a match is found.  Assume there are 16 FC
>| >>devices.  That is  several hundred syscalls just to complete one
>| >>hotswap operation.
>| >>
>| >>
>| >
>| >Why is speed so important?
>| >
>| >
>| Telecoms and Datacoms have told me in numerous conversations that a hotswap
>| operation should occur in 20msec.  I've arbitrarily set 10msec as my
>| target to
>| ensure that I meet the worse-case bus-is-loaded responses during scans, etc.
>|
>| I can't mention the names of the telecoms, but several with 10000+ employees
>| have mentioned it.
>
>| >>I think this would be too slow.  10 msec for my entire hotswap is
>| >>available.  If you calculate 2msec for the actual hotswap disk
>| >>operation, that leaves 8 msec for the rest of the mess.  Scanning
>| >>through tables or scanning tens or hundreds of files through hundreds
>| >>of  syscalls may betoo slow.
>| >>
>| >
>| >Where does the 10ms figure come from?
>| >
>| See above
>
>I've already ask Steve about this and received his answers.
>Can't say that I agree with them though, so I asked someone from
>a Telecom Equipment Mfr. about this.  He said that it's just for
>equipment testing, where technicians verify that hotswap works,
>and they are impatient to wait, so they practice surprise removal
>instead of coordinated removal.  He doesn't think that's how it's
>actually done out in the field, just in test labs.
>
>Preface question:  does cPCI support surprise removal (in the
>PICMG specs, not in some implementation)?  I know that PCI hotplug
>doesn't support surprise removal, only "coordinated" removal.
>  
>
PICMG 2.12 doesn't support surprise removal (the hardware does, the 
software doesn't).
The latch must first be popped, then the user must wait for the blue 
led.  If the blue led
isn't lit, the operating system isn't ready for the board to be removed.  

This said, operators are paid 10 bucks an hour to replace boards and you 
know how that goes. :)

For Compact PCI, the surprise removal rate is about 100 msec.  This is 
as fast as the user can
rip the board out of a chassis, meaning if you can light the blue led in 
less then 100 msec
it doesn't matter if the extraction is a surprise or not.

>So the question that has to be answered IMO is:  do we want to
>support surprise removal for something like manufacturing test,
>which doesn't abide by the coordinated removal protocol?
>
>or:  Do we have to support surprise removal, only because it can't
>be prevented?  I expect that this is the case, but I still don't
>see or understand the 20 ms time requirement.
>  
>
For Advanced TCA, there isn't a "latch" required to unpop before 
removing the board.  For
Compact PCI, the latch must be popped, allowing a signal to be sent to 
the board.  For ATCA,
a button is pressed (which is a major complaint of Advanced TCA, boards 
can be removed without
any signaling to the OS that the board is being removed).  I'm not sure 
what the PICMG3 foks
are going to do about that problem.  I'm assuming they are going to 
rework the enumeration of
the hotswap event to be driven by extracting the board instead of by a 
button.

In this case, extremely fast hotswap times are required, because the 
board can be removed
very fast in Advanced TCA (vs the latched method of Compact PCI).

Perhaps this is where the timing constraints originate.

>  
>

