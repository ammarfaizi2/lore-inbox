Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262761AbSI1Jz5>; Sat, 28 Sep 2002 05:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262767AbSI1Jz5>; Sat, 28 Sep 2002 05:55:57 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:19195 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262761AbSI1Jz5>; Sat, 28 Sep 2002 05:55:57 -0400
Subject: Re: Sleeping function called from illegal context...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@digeo.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209272013370.13669-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10209272013370.13669-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 11:06:23 +0100
Message-Id: <1033207583.17777.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 04:21, Andre Hedrick wrote:
> There is an issue of interrupt acknowledgement and when one can pre-empt.
> I would like to resolve the issue, but I need a global caller/notifier api
> from you so I can block IO in a safe spot on the 'data transfer' state
> bar.  Yeah, blah blah on underfined terms.
> 
> Some how I need to figure out how to address the pre-empt and keep the
> driver data stable.  Initially I would suggest throttling back on the
> request size to maybe 4k or 8k regardless.  I may not sound right but it
> will serve the purpose.

For things like old old broken PIO where interrupting the data stream
screws up the data thats actually already covered. Pre-empt does
actually do some things sensibly, and one of them is that when you hold
a lock or disable irq you also disable pre-empt. That means hdparm -u0
PIO interface code is still going to do the right thing

Reminds me though Robert (and Jeff)

drivers/net/8390.c still needs ei_start_xmit fixing

pre-emption should be disabled between

       /* Mask interrupts from the ethercard.
           SMP: We have to grab the lock here otherwise the IRQ handler

and
       disable_irq_nosync(dev->irq);

        spin_lock(&ei_local->page_lock);


So that we don't leave the IRQ disabled due to pre-emption

(that code is wonderfully deranged but its the only way to make 8390
based chips not screw up things like serial I/O on a SMP box)



