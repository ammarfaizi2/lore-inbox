Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbQLIAmz>; Fri, 8 Dec 2000 19:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbQLIAmp>; Fri, 8 Dec 2000 19:42:45 -0500
Received: from k2.llnl.gov ([134.9.1.1]:19196 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S131200AbQLIAmb>;
	Fri, 8 Dec 2000 19:42:31 -0500
From: Reto Baettig <baettig@k2.llnl.gov>
Message-Id: <200012090010.QAA28833@k2.llnl.gov>
Subject: Re: io_request_lock question (2.2)
To: mjacob@feral.com
Date: Fri, 8 Dec 2000 16:10:38 -0800 (PST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), baettig@scs.ch,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.21.0012081603110.72881-100000@beppo.feral.com> from "Matthew Jacob" at Dec 08, 2000 04:03:58 PM
Reply-To: Reto Baettig <baettig@scs.ch>
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> 
> On Fri, 8 Dec 2000, Alan Cox wrote:
> 
> > > Yes, and I believe that this is what's broken about the SCSI midlayer. The the
> > > io_request_lock cannot be completely released in a SCSI HBA because the flags
> > 
> > You can drop it with spin_unlock_irq and that is fine. I do that with no
> > problems in the I2O scsi driver for example
> 
> I am (like, I think I *finally* got locking sorta right in my QLogic driver),
> but doesn't this still leave ints blocked for this CPU at least?
> 
> -matt
> 
> 
> 

I am actually concerned about the following case:

The add_request ON CPU_1 function calls 
        spin_lock_irqsave(&io_request_lock,flags); 

Our I/O Function unlocks the spinlock and goes to sleep.

Finally, the add_request function, NOW ON CPU_2 calls
        spin_unlock_irqrestore(&io_request_lock,flags);
and restores the flags of CPU_1 on CPU_2.    

What am I missing? Are the flags which we restore valid for all the CPU's the same?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
