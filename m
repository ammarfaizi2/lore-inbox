Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRA3PKQ>; Tue, 30 Jan 2001 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRA3PJ4>; Tue, 30 Jan 2001 10:09:56 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:15493 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129790AbRA3PJq>; Tue, 30 Jan 2001 10:09:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A74462A.80804@redhat.com> 
In-Reply-To: <3A74462A.80804@redhat.com>  <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; from Nigel Gamble on Sun, Jan 21, 2001 at 06:21:05PM -0800 <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> 
To: Joe deBlaquiere <jadb@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, yodaiken@fsmlabs.com,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 15:08:04 +0000
Message-ID: <30682.980867284@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jadb@redhat.com said:
> A recent example I came across is in the MTD code which invokes the
> erase algorithm for CFI memory. This algorithm spews a command
> sequence  to the flash chips followed by a list of sectors to erase.
> Following  each sector adress, the chip will wait for 50usec for
> another address,  after which timeout it begins the erase cycle. With
> a RTLinux-style  approach the driver is eventually going to fail to
> issue the command in  time.

That code is within spin_lock_bh(), isn't it? So with the current 
preemption approach, it's not going to get interrupted except by a real 
interrupt, which hopefully won't take too long anyway. 

spin_lock_bh() is used because eventually we're intending to stop the erase 
routine from waiting for completion, and make it poll for completion from a 
timer routine. We need protection against concurrent access to the chip 
from that timer routine. 

But perhaps we could be using spin_lock_irq() to prevent us from being
interrupted and failing to meet the timing requirements for subsequent 
commands to the chip if IRQ handlers really do take too long. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
