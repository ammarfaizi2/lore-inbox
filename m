Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131041AbRCGM1t>; Wed, 7 Mar 2001 07:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131053AbRCGM1j>; Wed, 7 Mar 2001 07:27:39 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:43205 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131041AbRCGM11>; Wed, 7 Mar 2001 07:27:27 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27157@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Andrew Morton'" <andrewm@uow.edu.au>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: spinlock help
Date: Wed, 7 Mar 2001 04:26:03 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kdb trace was accurate, we could actually see the e100 ISR pop from no
where right in the middle of our ans_notify every time the TX queue would
fill up. When we commented out the call to spin_*_irqsave(), it worked fine
under heavy stress for days.

Is it possible it was something wrong with 2.4.0-test10 specifically ?

We had to drop the locks in the final release and never got around to
checking it on other kernel releases (it went on the TO_DO list ;-).

	Shmulik.

-----Original Message-----
From: Andrew Morton [mailto:andrewm@uow.edu.au]
Sent: Wednesday, March 07, 2001 1:43 PM
To: Hen, Shmulik
Subject: Re: spinlock help


"Hen, Shmulik" wrote:
> 
> How about if the same sequence occurred, but from two different drivers ?
> 
> We've had some bad experience with this stuff. Our driver, which acts as
an
> intermediate net driver, would call the hard_start_xmit in the base
driver.
> The base driver, wanting to block receive interrupts would issue a
> 'spin_lock_irqsave(a,b)' and process the packet. If the TX queue is full,
it
> could call an indication entry point in our intermediate driver to signal
it
> to stop sending more packets. Since our indication function handles many
> types of indications but can process them only one at a time, we wanted to
> block other indications while queuing the request.
> 
> The whole sequence would look like that:
> 
> [our driver]
>         ans_send() {
>                 .
>                 .
>                 e100_hard_start_xmit(dev, skb);
>                 .
>                 .
>         }
> 
> [e100.o]
>         e100_hard_start_xmit() {
>                 .
>                 .
>                 spin_lock_irqsave(a,b);
>                 .
>                 .
>                 if(tx_queue_full)
>                         ans_notify(TX_QUEUE_FULL);      <--
>                 .
>                 .
>                 spin_unlock_irqrestore(a,b);
>         }
> 
> [our driver]
>         ans_notify() {
>                 .
>                 .
>                 spin_lock_irqsave(c,d);
>                 queue_request(req_type);
>                 spin_unlock_irqrestore(c,d);    <--
>                 .
>                 .
>         }
> 
> At that point, for some reason, interrupts were back

Sorry, that can't happen.

Really, you must have made a mistake somewhere.

