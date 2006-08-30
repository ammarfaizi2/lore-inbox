Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWH3GEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWH3GEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWH3GEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:04:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45952 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751541AbWH3GEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:04:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dhw7vP7EGeo7z4K0yGiPBeIrBKuE0zWz5ZzjDEcK46rPWNGiHSAHTZEwynwb11S8nIe9o8aVDFfYovGKPhwZFWGAreREmiHifhh1UoV/kJ+r9PNXgORAILjNhRFpyC4LgB6xAJLW7KNDGpYSr+kDq/zjki4O+tOJjOS8mgHPOPc=
Message-ID: <1dec7da80608292304x1389b6d3w8cef1223af6688d7@mail.gmail.com>
Date: Wed, 30 Aug 2006 11:34:02 +0530
From: Vin <pane.vinayak@gmail.com>
To: "Rajat Jain" <rajat.noida.india@gmail.com>
Subject: Re: Spinlock query
Cc: "Rik van Riel" <riel@surriel.com>, "Rick Brown" <rick.brown.3@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <b115cb5f0608292231r1a3c47c8r8980b32e838ff964@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>
	 <44F501B3.9070200@surriel.com>
	 <b115cb5f0608292231r1a3c47c8r8980b32e838ff964@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/30/06, Rajat Jain <rajat.noida.india@gmail.com> wrote:
> On 8/30/06, Rik van Riel <riel@surriel.com> wrote:
> > Rick Brown wrote:
> > > Hi,
> > >
> > > In my driver (Process context), I have written the following code:
> > >
> > > --------------------------------------------
> > > spin_lock(lock)
> > > ...
> > > //Critical section to manipulate driver data
> >
> > ... interrupt hits here
> >     interrupt handler tries to grab the spinlock, which is already taken
> >     *BOOM*
> >
> > > spin_u lock(lock)
> > > ---------------------------------------------
> > >
>
> The interrupt handler TRIES to grab the spinlock, which is already
> taken. Why will it "BOOM"? Wouldn't the interrupt handler busy wait,
> waiting for the lock?
>
If you take spin_lock in interrupt as well as in process context then-:
1. On UP non-preempt kernel: There will be no locks taken, so nothing
is gonna protect the shared data between the interrupt handler &
process context thread.
2. On the UP preempt kernel: The lock has been taken by the process
context, and now if the interrupts is issued, it will try to grab the
same lock, but it will never get it ... and nobody is going to leave
that lock. boom* - Deadlock.
3. On SMP machine non-preempt kernel: The locks will be taken but no
protection against the interrupt as such.
4. On SMP preempt kernel: process context threads are synchronised but
not the interrupts.

> > > I have written similar code in my interrupt handler (Interrupt
> > > context). The driver data is not accessed from anywhere else. Is my
> > > code safe from any potential concurrency issues? Is there a need to
> > > use spin_lock_irqsave()? In both the places?
> >
> > You need to use spin_lock_irqsave() from process context.
> >  From the interrupt handler itself it doesn't hurt, but it
> > shouldn't matter much since interrupt handlers should not
> > get preempted.

Yes, AFAIK the correct idea is to take spin_lock() in interrupt
handler (Here I consider that your interrupt is already disabled.)
And take spin_lock_irq() or spin_lock_irqsave() lock from the process
context.

--v
