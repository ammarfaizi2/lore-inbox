Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131312AbRCHLJC>; Thu, 8 Mar 2001 06:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRCHLIv>; Thu, 8 Mar 2001 06:08:51 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:53491 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131312AbRCHLIf>; Thu, 8 Mar 2001 06:08:35 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2715F@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Andrew Morton'" <andrewm@uow.edu.au>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: spinlock help
Date: Thu, 8 Mar 2001 03:07:48 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK guys, you were right. The bug was in our code - sorry for trouble.
Turns out that while I was away, the problem was solved by someone else. The
problem is probably related to the fact that when we did
'spin_lock_irqsave(c,d)', 'd' was a global variable. The fix was to wrap the
call with another function and declare 'd' as local. I can't quite explain,
but I think that changing from a static to automatic variable made the
difference. My best guess is that since 'd' is passed by value and not by
reference, the macro expansion of spin_lock_irqsave() relies on the location
of 'd' in the stack and if 'd' was on the heap instead, it might get
trashed.

I would really like to hear your expert opinion on my assumption.


	Thanks,
	Shmulik.

-----Original Message-----
From: Andrew Morton [mailto:andrewm@uow.edu.au]
Sent: Wednesday, March 07, 2001 2:54 PM
To: Hen, Shmulik
Cc: 'LKML'
Subject: Re: spinlock help


"Hen, Shmulik" wrote:
> 
> The kdb trace was accurate, we could actually see the e100 ISR pop from no
> where right in the middle of our ans_notify every time the TX queue would
> fill up. When we commented out the call to spin_*_irqsave(), it worked
fine
> under heavy stress for days.
> 
> Is it possible it was something wrong with 2.4.0-test10 specifically ?
> 

Sorry, no.  If spin_lock_irqsave()/spin_unlock_irqrestore()
were accidentally reenabling interrupts then it would be
the biggest, ugliest catastrophe since someone put out a kernel
which forgot to flush dirty inodes to disk :)

Conceivably it was a compiler bug.  Were you using egcs-1.1.2/x86?

-

