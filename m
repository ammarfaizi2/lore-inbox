Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbUKJVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUKJVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUKJVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:37:11 -0500
Received: from ozlabs.org ([203.10.76.45]:5267 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262122AbUKJVfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:35:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16786.35271.622222.193502@cargo.ozlabs.ibm.com>
Date: Thu, 11 Nov 2004 08:36:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041110083629.A17555@flint.arm.linux.org.uk>
References: <1099346276148@kroah.com>
	<10993462773570@kroah.com>
	<20041102223229.A10969@flint.arm.linux.org.uk>
	<20041107152805.B4009@flint.arm.linux.org.uk>
	<20041110013700.GF9496@kroah.com>
	<16785.33677.704803.889900@cargo.ozlabs.ibm.com>
	<20041110083629.A17555@flint.arm.linux.org.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> On Wed, Nov 10, 2004 at 01:57:17PM +1100, Paul Mackerras wrote:
> > So we can get a driver's probe method called concurrently with its
> > bus's suspend or resume method.
> 
> If correct, we probably have rather a lot of buggy drivers, because
> I certainly was not aware that this could happen.  I suspect the
> average driver writer also would not be aware of that.

No doubt.  I'd still like to hear from Greg or Pat about what the
concurrency rules are supposed to be, or were intended to be.

Note also that I said the *bus's* suspend/resume method.  For PCI, we
have some protection since the PCI suspend/resume methods won't call
the individual pci driver's suspend/resume until pci_dev->driver is
set, which happens after the pci driver's probe routine has returned
(but of course the store to pci_dev->driver can get reordered on
some architectures since there is no barrier).

However, pci_dev->driver only gets cleared *after* the driver's remove
method returns.  Thus it would be quite possible for a PCI device to
have its suspend/resume methods called while another CPU is in its
remove method.

I think that what has saved us to some extent is that we only do
suspend/resume on UP machines so far.

Regards,
Paul.

