Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVGYWLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVGYWLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVGYWLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:11:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbVGYWLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:11:47 -0400
Date: Mon, 25 Jul 2005 15:10:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: James.Bottomley@SteelEye.com, Eric.Moore@lsil.com, bharata@in.ibm.com,
       Roy.Wade@lsil.com, Jared.Hayes@lsil.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [IBM] RE: [BUG] Fusion MPT Base Driver initialization failure
 wit h kdum p
Message-Id: <20050725151033.25196965.akpm@osdl.org>
In-Reply-To: <1121858719.42de349feb815@imap.linux.ibm.com>
References: <1121858719.42de349feb815@imap.linux.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> > If you don't stop the DMA engines before you boot the new kernel, the
>  > addresses they have to send data to will now be random points in that
>  > kernel's memory, leading to potential corruption of the new kernel
>  > image.
> 
>  [Copying it to fastboot and linux-kernel mailing lists]
> 
>  We are booting second kernel (capture kernel) from a reserved memory location
>  to take care of on-going DMA issues. So even if some DMA transactions are going
>  on after the crash they will not corrupt the new kernel.
> 
>  > 
>  > The interrupt panic of the fusion is probably a symptom of this: I bet a
>  > DMA transfer has just completed and the interrupt is to inform us of
>  > this (however, in the new kernel we're not expecting any transfers).
> 
>  That might very well be the case. So driver should simply ignore the interrupt
>  when it is not expecting it or it should reset the device if it finds that 
>  some interrupts are pending when it should not have been there.
> 
>  Basically it is a matter of hardening the driver so that it can handle/
>  initialize the device even if the device is not in reset state. 

I'd expect that a lot of these problems could be reduced by simply pausing
for a while in the crash handler, wait for I/O to complete.

Other times these failures point at flaws and dubious assumptions in
drivers themselves, fixing of which tends to collaterally help platform
power mangement operations.

However, I expect that it will always be the case that setups which try to
perform crashdumps to their main production disks will be less reliable
than setups which set aside hardware for the dumping.

If it was me, and if I really cared about reliable dumps, I'd make sure
that each machine had a $6 NIC set aside for crashdumping, and the dump
kernel uses that NIC for an NFS dump and has no other device drivers
configured.
