Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSIWVuC>; Mon, 23 Sep 2002 17:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261500AbSIWVuC>; Mon, 23 Sep 2002 17:50:02 -0400
Received: from magic.adaptec.com ([208.236.45.80]:32988 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261499AbSIWVuA>; Mon, 23 Sep 2002 17:50:00 -0400
Date: Mon, 23 Sep 2002 15:54:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
Message-ID: <2640410816.1032818062@aslan.btc.adaptec.com>
In-Reply-To: <3D8F874B.3070301@mandrakesoft.com>
References: <20020923180017.GA16270@sexmachine.doom>
 <2539730816.1032808544@aslan.btc.adaptec.com>
 <3D8F874B.3070301@mandrakesoft.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin T. Gibbs wrote:
>> On some motherboards with some chipsets, you can get these messages if
>> another busmaster (say an IDE drive or a sound card) is hogging the bus.
>> Usually this is with a VIA chipset.  Its not clear why the aic7xxx_old
>> driver would behave differently other than it disables memory write
>> and invalidate PCI transactions on this chip.  The new driver doesn't
>> need that work around.
> 
> 
> Justin,
> 
> One thing I notice is at least one PCI posting bug.  When using MMIO
> (write[bwlq] under Linux), you _must_ use a read[bwlq] to flush the write
> to PCI, if you wish to ensure the write posts at a certain point in the
> code.

> 
> Here is the example PCI posting bug, in ahc_clear_critical_section:
>>                 ahc_outb(ahc, HCNTRL, ahc->unpause);
>>                 do {
>>                         ahc_delay(200);
>>                 } while (!ahc_is_paused(ahc));
> 
> As you can see, there is no read before the udelay(), which is very wrong
> on modern CPUs with write posting...  that's definitely a driver bug that
> will bite you on modern x86 motherboards [and is totally broken on ia64
> and other platforms].
> 
> Please let me know if you have further questions on PCI write posting...

I somewhat doubt that any CPU would hold onto a posted write for 200us
since you are not guaranteed that a read will occur quickly and you want
those write buffers to be availble for other clients, but regardless, the
code has not been as you describe since November of last year.  The
CHANGELOG reads:

                Always perform a bus read prior to waiting in
                a delay loop waiting for a bus write to take
                effect.  This ensures that the first time
                through the loop the delay occurs after the
                write has taken effect.

Of course, the "bug" was benign since the loop does perform a read
so the write is guaranteed to post during the first itteration through
the loop.

--
Justin
