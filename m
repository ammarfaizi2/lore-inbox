Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRCGJas>; Wed, 7 Mar 2001 04:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRCGJai>; Wed, 7 Mar 2001 04:30:38 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:50128 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S130454AbRCGJaZ>; Wed, 7 Mar 2001 04:30:25 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27152@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'nigel@nrg.org'" <nigel@nrg.org>, Manoj Sontakke <manojs@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: spinlock help
Date: Wed, 7 Mar 2001 01:21:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about if the same sequence occurred, but from two different drivers ?

We've had some bad experience with this stuff. Our driver, which acts as an
intermediate net driver, would call the hard_start_xmit in the base driver.
The base driver, wanting to block receive interrupts would issue a
'spin_lock_irqsave(a,b)' and process the packet. If the TX queue is full, it
could call an indication entry point in our intermediate driver to signal it
to stop sending more packets. Since our indication function handles many
types of indications but can process them only one at a time, we wanted to
block other indications while queuing the request.

The whole sequence would look like that:

[our driver]
	ans_send() {
		.
		.
		e100_hard_start_xmit(dev, skb);
		.
		.
	}

[e100.o]
	e100_hard_start_xmit() {
		.
		.
		spin_lock_irqsave(a,b);
		.
		.
		if(tx_queue_full)
			ans_notify(TX_QUEUE_FULL);	<--
		.
		.
		spin_unlock_irqrestore(a,b);
	}
	
[our driver]
	ans_notify() {
		.
		.
		spin_lock_irqsave(c,d);
		queue_request(req_type);
		spin_unlock_irqrestore(c,d);	<--
		.
		.
	}

At that point, for some reason, interrupts were back and the e100.o would
hang in an infinite loop (we verified it on kernel 2.4.0-test10 +kdb that
the processor was enabling interrupts and that the e100_isr was called for
processing an Rx int.).

How is that possible that a 'spin_unlock_irqrestore(c,d)' would also restore
what should have been restored only with a 'spin_unlock_irqrestore(a,b)' ?


	Thanks in advance,
	Shmulik Hen      
      Software Engineer
	Linux Advanced Networking Services
	Intel Network Communications Group
	Jerusalem, Israel.

-----Original Message-----
From: Nigel Gamble [mailto:nigel@nrg.org]
Sent: Wednesday, March 07, 2001 1:54 AM
To: Manoj Sontakke
Cc: linux-kernel@vger.kernel.org
Subject: Re: spinlock help


On Tue, 6 Mar 2001, Manoj Sontakke wrote:
> 1. when spin_lock_irqsave() function is called the subsequent code is
> executed untill spin_unloc_irqrestore()is called. is this right?

Yes.  The protected code will not be interrupted, or simultaneously
executed by another CPU.

> 2. is this sequence valid?
> 	spin_lock_irqsave(a,b);
> 	spin_lock_irqsave(c,d);

Yes, as long as it is followed by:

	spin_unlock_irqrestore(c, d);
	spin_unlock_irqrestore(a, b);

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

