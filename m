Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129357AbQJ0Hqd>; Fri, 27 Oct 2000 03:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQJ0HqY>; Fri, 27 Oct 2000 03:46:24 -0400
Received: from Cantor.suse.de ([194.112.123.193]:32005 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129357AbQJ0HqQ>;
	Fri, 27 Oct 2000 03:46:16 -0400
Date: Fri, 27 Oct 2000 09:46:13 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, kumon@flab.fujitsu.co.jp,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Negative scalability by removal of lock_kernel()?(Was: Strange performance behavior of 2.4.0-test9)
Message-ID: <20001027094613.A18382@gruyere.muc.suse.de>
In-Reply-To: <39F92187.A7621A09@timpanogas.org> <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Oct 27, 2000 at 03:13:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 03:13:33AM -0400, Alexander Viro wrote:
> I didn't look into recent changes in fs/locks.c, but I have quite problem
> inventing a scenario when _adding_ BKL (without reverting other changes)
> might give an absolute improvement. Well, I see a couple of really perverted
> scenarios, but... Seriously, folks, could you compare the 4 variants above
> and gather the contention data for the -test9 on your loads? That would help
> a lot.

I think it is easy to see.  Switching between CPUs for criticial section
always has an latency because the lock/data update needs some time to cross
the bus

When you have two CPUs contending on common paths it is better to do: 

	CPU #0                               CPU #1

	grab big lock                        spin
        do thing 
	release big lock ----> latency --->  grab big lock
					     do thing
        do other things                      ....


than to do 

 	grab small lock 1                    spin
	do small thing	
	release small lock 1 --> latency --> get small lock
                                             do small thing
                                             release lock
                            <--- latency --- 
        get small lock, fetch data
        do small thing
        release lock
                            ---> latency ---> get small lock
                                              do small thing
                                              release lock
                            <--- latency ----

etc. The latencies add up and they're long because they're bus limited.
For common paths it is definitely useful to have bigger lock sections. 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
