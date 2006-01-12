Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWALNrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWALNrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWALNrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:47:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7432 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932173AbWALNrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:47:39 -0500
Date: Thu, 12 Jan 2006 13:47:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       oliver@neukum.org
Subject: Re: need for packed attribute
Message-ID: <20060112134729.GB5700@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	oliver@neukum.org
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601121227.k0CCRCB8016162@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 01:27:12PM +0100, Mikael Pettersson wrote:
> On Fri, 6 Jan 2006 18:38:46 +0000, Russell King wrote:
> >> is there any architecture for which packed is required in structures like this:
> >> 
> >> /* All standard descriptors have these 2 fields at the beginning */
> >> struct usb_descriptor_header {
> >> 	__u8  bLength;
> >> 	__u8  bDescriptorType;
> >> };
> >
> >sizeof(struct usb_descriptor_header) will be 4 on ARM.
> 
> I found this surprising, but gcc-3.4.5 for ARM seems to agree with you.
> 
> As fas as I can tell, the AAPCS document (v2.03 7th Oct 2005) requires
> that a simple "struct foo { unsigned char c; };" should have both size
> and alignment equal to 1, but gcc makes them both 4. Do you have any
> information about why gcc is doing this on ARM/Linux? Is there an accurate
> ABI document for ARM/Linux somewhere?

That's the new EABI, which is a major change to the existing ABI which
the kernel and all of userspace is currently built using.

The old ABI has it's roots in 1993 when the kernel and userland was
initially built using an ANSI C compiler, and the work being done to
port GCC was to make it compliant with that version of the ABI.  This
ABI is documented only in dead-tree form.

Due to lack of manpower on the Linux side (iow, more or less just me)
this became the ABI of the early ARM Linux a.out toolchain.  At that
time, I did not consider this to be a problem - it wasn't a problem
as far as the kernel was concerned.

When ELF came along, other folk worked on the toolchain, but they stuck
with that ABI - you could not transition between the a.out ABI to the
ELF ABI without breaking the kernel - structure layouts would change.

Hence, this is the existing ABI we have.  Changing the padding or
alignment of structures changes the kernel ABI, making it incompatible
with current userland.

We're working on a set of patches to bring ARM Linux to be compatible
with the new EABI (which you've found above).  This involves adding a
compatibility layer to the kernel to convert structures between the
old layouts and the new layouts.

I'm sure you can appreciate the size of this problem given the issues
with running 32-bit apps on 64-bit machines - it's the same kind of
issue.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
