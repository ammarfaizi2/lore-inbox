Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVGTLZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVGTLZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVGTLZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:25:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39607 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261165AbVGTLZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:25:22 -0400
Message-ID: <1121858719.42de349feb815@imap.linux.ibm.com>
Date: Wed, 20 Jul 2005 07:25:19 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, bharata@in.ibm.com,
       "Wade, Roy" <Roy.Wade@lsil.com>, "Hayes, Jared" <Jared.Hayes@lsil.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [IBM] RE: [BUG] Fusion MPT Base Driver initialization failure wit h kdum p
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.184.230.110
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Bottomley <James.Bottomley@SteelEye.com>:

> On Fri, 2005-07-15 at 09:46 +0530, Vivek Goyal wrote:
> > Kdump does not require any special support from the driver. After a
> reboot
> > a fresh kernel is booted and drivers are initialized again. The only 
> > difference here is that underlying devices are not shutdown or reset so
> > when driver is initializing, associated device might very well be sending
> > the interrupts. Driver should be hardened to handle this situation.
> 
> This doesn't sound very safe to me.  Lots of drivers (of which SCSI is
> only a minority) have large DMA transaction engines which continue
> automatically after they're initially programmed.
> 
> If you don't stop the DMA engines before you boot the new kernel, the
> addresses they have to send data to will now be random points in that
> kernel's memory, leading to potential corruption of the new kernel
> image.

[Copying it to fastboot and linux-kernel mailing lists]

We are booting second kernel (capture kernel) from a reserved memory location
to take care of on-going DMA issues. So even if some DMA transactions are going
on after the crash they will not corrupt the new kernel.

> 
> The interrupt panic of the fusion is probably a symptom of this: I bet a
> DMA transfer has just completed and the interrupt is to inform us of
> this (however, in the new kernel we're not expecting any transfers).

That might very well be the case. So driver should simply ignore the interrupt
when it is not expecting it or it should reset the device if it finds that 
some interrupts are pending when it should not have been there.

Basically it is a matter of hardening the driver so that it can handle/
initialize the device even if the device is not in reset state. 

> 
> But the problem isn't really in the fusion driver, it's in Kdump.  You
> have to shut down active drivers before you boot to a new kernel.

After a crash (panic) we can not shutdown the devices. It is not reliable
and new kernel might not boot at all. We have had plenty of discussions on
this in the past on fastboot and linux-kernel mailing list.

It is not about problem being on kdump part or Fusion MPT driver part. This
is a new scenario for drivers after the introduction of kdump. Previously 
drivers could safely assume that BIOS had put the device in reset state but
after kdump it assumption is not valid.

Thanks
Vivek


