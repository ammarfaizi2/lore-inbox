Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVCNX1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVCNX1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVCNX1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:27:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28178 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262022AbVCNX1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:27:10 -0500
Date: Mon, 14 Mar 2005 23:26:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stefan Roas <sroas@roath.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Fix compiler warning in drivers/scsi/dpt_i2o.c
Message-ID: <20050314232653.B4705@flint.arm.linux.org.uk>
Mail-Followup-To: Stefan Roas <sroas@roath.org>,
	linux-kernel@vger.kernel.org
References: <20050313224351.GA1731@roath.org> <20050314182444.GA6903@home.fluff.org> <20050314200626.GD1733@roath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050314200626.GD1733@roath.org>; from sroas@roath.org on Mon, Mar 14, 2005 at 09:06:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 09:06:26PM +0100, Stefan Roas wrote:
> On Mon Mar 14, 2005 at 18:24:44, Ben Dooks wrote:
> 
> > This patch looks suspiciously like it is sweeping the problem
> > `under the carpet`. Does bus_to_virt() return an `void __iomem *`?
> > 
> > reply should really be an `void __iomem *` 
> 
> bus_to_virt returns void *.
> 
> adpt_isr casts the return value to ulong though and adpt_i2o_to_scsi
> takes an ulong as its first argument and passes it to readl without a
> cast then.
> 
> But I agree, the patch just silences the compiler warning. Maybe it
> would be a better solution to change the types of reply and msg in
> adpt_isr as well as the first argument to adpt_i2o_to_scsi to void
> __iomem *.

However, bus_to_virt() can only be used on addresses which correspond
with system RAM.  readl and friends should not be used on such a memory
space.  So, this driver is doing lots of bogus stuff.

The warnings are perfectly valid and should therefore stay.

If "reply" is actually referring to some system memory, the readl/writel
shouldn't be there, and we should be accessing system memory directly
via a bona-fide structure.  If it isn't, then the bus_to_virt() is
completely bogus and unportable, and that's where we _must_ raise a
warning.

However, I do agree with changing "msg" to be void __iomem *, and
removing the (ulong) cast, since pHba->msg_addr_virt is already
void __iomem *.

(note: I'm just taking a passing interest in this thread, from the
point of view of an architecture maintainer who wants these types of
things to be Correct(tm)...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
