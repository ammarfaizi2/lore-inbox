Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWDCEyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWDCEyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDCEyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:54:09 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63653 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932346AbWDCEyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:54:07 -0400
Message-ID: <4430AA99.4090208@jp.fujitsu.com>
Date: Mon, 03 Apr 2006 13:54:49 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/6] PCIERR : interfaces for synchronous I/O error detection
 on driver
References: <44210D1B.7010806@jp.fujitsu.com> <20060322210157.GH12335@kroah.com> <4423A40D.3080906@jp.fujitsu.com> <20060324234306.GC21895@austin.ibm.com> <44274FF0.406@jp.fujitsu.com> <20060331220117.GB23872@austin.ibm.com>
In-Reply-To: <20060331220117.GB23872@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Mon, Mar 27, 2006 at 11:37:36AM +0900, Hidetoshi Seto wrote:
>>  - State check would be architecture dependent routine work.
> 
> I read through your patches.  You are proposing a very different
> way of handling PCI errors than the pci_error_handlers API.
> It seems to be much more invasive, and I don't understand why
> its needed or how its better.  Let me be specific:
> 
> In the mpt code you have a function called pciras_readl()
> that tries to perform an error-free read by retrying the read:
> 
>   do {
>     pcierr_clear(&cookie, ioc->pcidev);
>     val = ioread32(addr);
>     status = pcierr_read(&cookie);
>   } while(status && (--retries > 0));
> 
> Why not create special arch/ia_64 readl routine to do this?
> In that case, other device drivers would get the benefit of
> the retry-on-error type read.
> 
> Now, you probably shouldn't put this into the default readl
> routine, since some devices do peculiar things if the same
> register is read repeatedly.

My first proposal of readX_check() about 2 years ago was
already rejected by Linus. I think there were some problem
that let this style slip from linux ... :

  - To Make drivers to be more RAS-aware, rewriting large
    portion of the codes to be able to respond to errors would
    be inevitable anyway.
    It would be better to have generic interfaces wrap
    arch-specific codes because such error status check would
    require some kind of synchronization with arch-specific
    hardware or firmware etc.
    Even if dividing normal-drivers and RAS-hardened-drivers
    is inevitable, still it is better than having many
    arch-specific drivers.

  - Since such synchronized error check could be heavy time
    consumer, it would be better the ratio of actual I/O to
    error check is N:1, i.e. an error check can examine more
    than one I/O.
    Of course it is ideal if one check can examine all I/O,
    however it is always possible that using a broken data
    from earlier read brings the device or whole system to
    fatal situation. Therefore, it would be realistic that
    splitting driver's code to some possible stages and putting
    an error check for each stage.

It is possible to define more interfaces such as readX_check()
and/or readX_retry_on_error(), however they will be just
wrappers of actual readX and pcierr_clear/read(), what everyone
can imagine easily.

What style of check is convenient is depend on the device and
driver. Maybe sample mpt driver could be optimized.
I guess that readX_check() style will convenient on many cases,
but not all cases. That was maybe what Linus said.

> Next, I notice that if the repeated read fails, then
> 
>    schedule_work(&mptbase_rstTask);
> 
> is called. This seems to be exactly the kind of action
> that the pci_error_handlers API was meant to provide:
> if there is a pci read error that cannot be trivially
> recovered, then the error_detected() &c. routines would
> be called. The mpt device driver would then initiate
> a mptbase_rstTask upon one of these callbacks.
> 
> Thus, in the ia64 code, if a repeated readl fails,
> then the ia64 reset task calls the device drivers
> error_detected() routine, followed by the drivers's 
> link_reset() routine, followed by the resume() routine.
> 
> For the mpt, it would probably be resume() that was
> a wrapper around mptbase_rstTask(). Wouldn't this 
> work just as well? 

Yes, this part can be exactly replaced by callback API,
because the reset can be performed asynchronously.
Why this is here is simply ia64 have not implement it yet.

To make callback APIs work on ia64, at least it is required
that ia64 system can continue after a bus error.
This sensitive arch can catch a bus error synchronously
by its arch-specific way, but at this time there is no way
to forward the error to drivers and to know which driver can
deal the error, so it chooses system reset.

If I disable all such sensitive thing and make callback APIs
to work on ia64, drivers still need synchronous error check for
each I/O to prevent user data from pollution by error, but the
coverage of errors will be limited to only what mpt can detect.
No one care about pollution by non-aware drivers in this situation.

Now I'm watching the problems to be solved before the asynchronous
reset. Maybe my next work after this will be implement of ia64's
callback API...

If you have any better idea than this pcierr_* (and its possible
wrapper, ex. readX_check()) to keep or get high data integrity,
please tell me.

Thanks,
H.Seto

