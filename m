Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbQLHB7f>; Thu, 7 Dec 2000 20:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131894AbQLHB7Z>; Thu, 7 Dec 2000 20:59:25 -0500
Received: from k2.llnl.gov ([134.9.1.1]:34238 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S129725AbQLHB7M>;
	Thu, 7 Dec 2000 20:59:12 -0500
From: Reto Baettig <baettig@k2.llnl.gov>
Message-Id: <200012080127.RAA13144@k2.llnl.gov>
Subject: Re: io_request_lock question (2.2)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 7 Dec 2000 17:27:56 -0800 (PST)
Cc: baettig@scs.ch, linux-kernel@vger.kernel.org
In-Reply-To: <E144BKn-0003EO-00@the-village.bc.nu> from "Alan Cox" at Dec 08, 2000 12:24:18 AM
Reply-To: Reto Baettig <baettig@scs.ch>
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I looked at the implementation of the nbd which just calls 
> > 
> > 	spin_unlock_irq(&io_request_lock);
> > 	... do network io ...
> > 	spin_lock_irq(&io_request_lock);
> > 
> > This seems to work but it looks very dangerous to me (and ugly, too). Isn't there a better way to do this?
> 
> It is only dangerous if you unlock it in the wrong place, unlocking it as much
> as possible is good behaviour. You need it locked until you get the actual
> request off the queue, you need it locked when you complete the request. The
> rest of the time you can be polite
> 
> 

I'm sorry but I still have some doubts:

The add_request function calls 
	spin_lock_irqsave(&io_request_lock,flags); 
and then calls our request_fn which does 
	spin_unlock_irq(&io_request_lock);

	...do network I/O ...

	spin_lock_irq(&io_request_lock);
we finish the request and return to the add_request function which calls
	spin_unlock_irqrestore(&io_request_lock,flags);
and restores the flags.     

Isn't it possible now that the flags which we restore are out of date now?

Is this idiom the right one to use for 2.2?

Thanks,

Reto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
