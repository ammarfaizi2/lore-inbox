Return-Path: <linux-kernel-owner+w=401wt.eu-S1758847AbWLIWPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847AbWLIWPI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758839AbWLIWPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:15:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54299 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758847AbWLIWPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:15:05 -0500
Date: Sat, 9 Dec 2006 14:14:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Greg KH <greg@kroah.com>,
       USB Development List <linux-usb-devel@lists.sourceforge.net>,
       Kernel Development List <linux-kernel@vger.kernel.org>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] USB: u132-hcd/ftdi-elan: add support for Option GT 3G
 Quad card
Message-Id: <20061209141428.2ef3bfb5.akpm@osdl.org>
In-Reply-To: <200612071504.kB7F4C5D026327@imap.elan.private>
References: <200612071504.kB7F4C5D026327@imap.elan.private>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2006 13:16:22 +0000
Tony Olech <tony.olech@elandigitalsystems.com> wrote:

> From: Tony Olech <tony.olech@elandigitalsystems.com>
> 
> ELAN's U132 is a USB to CardBus OHCI controller adapter,
>     designed specifically for CardBus 3G data cards to
>     function in machines without a CardBus slot.
> The "ftdi-elan" module is a USB client driver, that detects
>     a supported CardBus OHCI controller plugged into the
>     U132 adapter and thereafter provides the conduit for
>     for access by the "u132-hcd" module.
> The "u132-hcd" module is a (cut-down OHCI) host controller
>     that supports a single OHCI function of the CardBus 
>     card inserted into the U132 adapter.
> 
> ...
>

Several coding style issues here.


>          struct usb_hcd *hcd;
> +        int retval;
> +        u32 control;
> +        u32 rh_a = -1;
> +        u32 num_ports;
>          msleep(100);

We usually put a blank line between the end of the auto definitions and the
start of the code.

>          if (u132_exiting > 0) {
>                  return -ENODEV;
> -        }                        /* refuse to confuse usbcore */
> +        }

Unneeded braces.

> +        retval = ftdi_write_pcimem(pdev, intrdisable, OHCI_INTR_MIE);

THis entire patch uses spaces where it should be using tabs!

> +        if (hc_fminterval != FI) {
> +        }

?

> +        if (retval)
> +                return retval;
> +      retry:retval = ftdi_read_pcimem(ftdi, cmdstatus, &status);
> +        if (retval)
> +                return retval;

No, labels are done line this:

	if (retval)
		return retval;
retry:
	retval = ftdi_read_pcimem(ftdi, cmdstatus, &status);
	if (retval)
		return retval;

(the driver appears to already use the wrong style - just fix it up as you
go).


> +        retval = ftdi_write_pcimem(ftdi, cmdstatus, OHCI_HCR);
> +        if (retval)
> +                return retval;
> +      extra:{
> +                retval = ftdi_read_pcimem(ftdi, cmdstatus, &status);
> +                if (retval)
> +                        return retval;
> +                if (0 != (status & OHCI_HCR)) {
> +                        if (--reset_timeout == 0) {
> +                                dev_err(&ftdi->udev->dev, "USB HC reset timed o"
> +                                        "ut!\n");
> +                                return -ENODEV;
> +                        } else {
> +                                msleep(5);
> +                                goto extra;
> +                        }
> +                }
> +        }

The extra set of braces around this block is unnecessary.  Remove that,
save a tbstop, then un-break that string.

> +        if (0 == (fminterval & 0x3fff0000) || 0 == periodicstart) {

This trick makes people's brains explode.  Please just do

	if (foo == 0)

> +        mdelay((roothub_a >> 23) & 0x1fe);

mdelay is a busy-wait.  It needs super-special jsutification.  Certainly a
comment explaining why it is really necessary, and perhaps some soothing
words about the expected upper-bound.

> +static int ftdi_elan_enumeratePCI(struct usb_ftdi *ftdi)
> +{
> +        u32 controlreg;
> +        u8 sensebits;
> +        int UxxxStatus;
> +        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000000L);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        msleep(750);
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000200L | 0x100);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000200L | 0x500);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020CL | 0x000);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020DL | 0x000);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        msleep(250);
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020FL | 0x000);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000025FL | 0x800);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
> +        if (UxxxStatus)
> +                return UxxxStatus;
> +        msleep(1000);
> +        sensebits = (controlreg >> 16) & 0x000F;
> +        if (0x0D == sensebits)
> +                return 0;
> +        else
> +		return - ENXIO;
> +}

Well it's certainly rigorous about error-checking.

I suspect a lot of this could become table-driven.


