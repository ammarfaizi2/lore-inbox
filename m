Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130874AbRCGK14>; Wed, 7 Mar 2001 05:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRCGK1r>; Wed, 7 Mar 2001 05:27:47 -0500
Received: from samar.sasken.com ([164.164.56.2]:25570 "EHLO samar.sasi.com")
	by vger.kernel.org with ESMTP id <S130824AbRCGK13>;
	Wed, 7 Mar 2001 05:27:29 -0500
Message-ID: <3AA60CEE.AD9F2102@sasken.com>
Date: Wed, 07 Mar 2001 15:56:54 +0530
From: Manoj Sontakke <manojs@sasken.com>
Organization: Sasken Communication Technologies Limited.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'nigel@nrg.org'" <nigel@nrg.org>, Manoj Sontakke <manojs@sasken.com>,
        linux-kernel@vger.kernel.org
Subject: Re: spinlock help
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27152@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

spin_lock_irq()   and    spin_lock_bh() 

can they be of any use to u? 

"Hen, Shmulik" wrote:
> 
> How about if the same sequence occurred, but from two different drivers ?
> 
> We've had some bad experience with this stuff. Our driver, which acts as an
> intermediate net driver, would call the hard_start_xmit in the base driver.
> The base driver, wanting to block receive interrupts would issue a
> 'spin_lock_irqsave(a,b)' and process the packet. If the TX queue is full, it
> could call an indication entry point in our intermediate driver to signal it
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
> How is that possible that a 'spin_unlock_irqrestore(c,d)' would also restore
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
