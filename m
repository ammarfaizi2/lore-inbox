Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313321AbSDJQvg>; Wed, 10 Apr 2002 12:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313336AbSDJQvf>; Wed, 10 Apr 2002 12:51:35 -0400
Received: from fungus.teststation.com ([212.32.186.211]:59146 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313321AbSDJQve>; Wed, 10 Apr 2002 12:51:34 -0400
Date: Wed, 10 Apr 2002 18:51:30 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "Ivan G." <ivangurdiev@yahoo.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Via-Rhine stalls - transmit errors
In-Reply-To: <02040623430505.00818@cobra.linux>
Message-ID: <Pine.LNX.4.33.0204101809010.7762-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Apr 2002, Ivan G. wrote:

> frame number is evidence that my frame-1 fix is working.

Which frame-1 fix?

> this log seems normal, except
> 1) are the addresses supposed to be initialized ? rx addresses are ...

They are written in start_tx when used. The buffer with data comes from
the higher levels so it can't be initialised here.

> 2) what exactly do addr and next_desc point to? how can i check those 
> addresses.

The addr points to the data to transmit. The next_desc simply makes the
entries form a ring. I think you can assume that they are ok. But
otherwise check what is written in via_rhine_start_tx.


> Look at txstatus - notice one 0002 interrupt (tx done) removes 2 ownership 
> bits, after which another interrupt removes 0, transmit stops soon, and the 
> queue keeps going on until timeout. In another log, I recorded many 
> exit_status interrupts between the ownership lock
> and the NETDEV timeout. After the timeout, addr fields are marked bad.

It is intentional that one interrupt can remove more than one used buffer.
via_rhine_tx has a loop that tries to clean up all "dirty" tx descriptors.
I think that one is ok.

I wonder about the one that removes zero. Why that interrupt happened.
Maybe it just happened while the previous interrupt was being handled.


> Notice the cur->tx and dirty->tx reported after timeout.

You don't print cur_tx and dirty_tx, but the slots they point to are
strange. You should check what they point to after the tx_timeout routine
has completed, they should both be 0 by then.

/Urban

