Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130824AbRCGKrT>; Wed, 7 Mar 2001 05:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRCGKrJ>; Wed, 7 Mar 2001 05:47:09 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:51910 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130824AbRCGKq4>; Wed, 7 Mar 2001 05:46:56 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27153@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Manoj Sontakke'" <manojs@sasken.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'nigel@nrg.org'" <nigel@nrg.org>, linux-kernel@vger.kernel.org
Subject: RE: spinlock help
Date: Wed, 7 Mar 2001 02:44:30 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spin_lock_bh() won't block interrupts and we need them blocked to prevent
more indications.
spin_lock_irq() could do the trick but it's counterpart spin_unlock_irq()
enables all interrupts by calling sti(), and this is even worse for us.


	Shmulik.

-----Original Message-----
From: Manoj Sontakke [mailto:manojs@sasken.com]
Sent: Wednesday, March 07, 2001 12:27 PM
To: Hen, Shmulik
Cc: 'nigel@nrg.org'; Manoj Sontakke; linux-kernel@vger.kernel.org
Subject: Re: spinlock help


hi

spin_lock_irq()   and    spin_lock_bh() 

can they be of any use to u? 

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
> At that point, for some reason, interrupts were back and the e100.o would
> hang in an infinite loop (we verified it on kernel 2.4.0-test10 +kdb that
> the processor was enabling interrupts and that the e100_isr was called for
> processing an Rx int.).
> 
> How is that possible that a 'spin_unlock_irqrestore(c,d)' would also
restore
> what should have been restored only with a 'spin_unlock_irqrestore(a,b)' ?
> 
>         Thanks in advance,
>         Shmulik Hen
>       Software Engineer
>         Linux Advanced Networking Services
>         Intel Network Communications Group
>         Jerusalem, Israel.
> 
> -----Original Message-----
> From: Nigel Gamble [mailto:nigel@nrg.org]
> Sent: Wednesday, March 07, 2001 1:54 AM
> To: Manoj Sontakke
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: spinlock help
> 
> On Tue, 6 Mar 2001, Manoj Sontakke wrote:
> > 1. when spin_lock_irqsave() function is called the subsequent code is
> > executed untill spin_unloc_irqrestore()is called. is this right?
> 
> Yes.  The protected code will not be interrupted, or simultaneously
> executed by another CPU.
> 
> > 2. is this sequence valid?
> >       spin_lock_irqsave(a,b);
> >       spin_lock_irqsave(c,d);
> 
> Yes, as long as it is followed by:
> 
>         spin_unlock_irqrestore(c, d);
>         spin_unlock_irqrestore(a, b);
> 
> Nigel Gamble                                    nigel@nrg.org
> Mountain View, CA, USA.                         http://www.nrg.org/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Regards,
Manoj Sontakke

