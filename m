Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUK1QdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUK1QdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUK1Qaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:30:30 -0500
Received: from mailhub.hp.com ([192.151.27.10]:27805 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261518AbUK1Q0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:26:32 -0500
Subject: Re: Exar ST16C2550 rev A2 bug
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041128111047.A10807@flint.arm.linux.org.uk>
References: <1100716008.32679.55.camel@tdi>
	 <20041128111047.A10807@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 28 Nov 2004 09:26:20 -0700
Message-Id: <1101659181.2838.41.camel@mythbox>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 11:10 +0000, Russell King wrote:
> On Wed, Nov 17, 2004 at 11:26:47AM -0700, Alex Williamson wrote:
> >    There seem to be an increasing number of the above UARTs floating
> > around and I'm wondering if we can do something to better detect and
> > work around their flaw.  Exar has documented the problem and their
> > proposed serial driver changes to work around the issue here:
> > 
> > http://www.exar.com/info.php?pdf=dan180_oct2004.pdf
> 
> Can you check whether this patch solves it?  I'd rather not rely on
> size_fifo() to do the right thing in every circumstance.

  I have a system on order with one of these bad UARTs.  I'll be happy
to check the patch when it arrives (hopefully this week).

> Essentially, if we find an EFR, we check whether the UART reports
> DVID/DREV values corresponding to the known problem scenario, and
> if so, we essentially ignore the EFR.
> 
> What I don't know is whether these DVID/DREV values correspond to
> a real device which does have an EFR.  Maybe Exar people can shed
> some light on this?

   I'll see if I can get an engineering contact from Exar to confirm.

> (Also, one has to wonder what information Exar has about what we're
> working on, which we don't know ourselves about... check out the
> above link, FAQ question 6. 8))

  ;^)  Thanks,

	Alex

> ===== drivers/serial/8250.c 1.92 vs edited =====
> --- 1.92/drivers/serial/8250.c	2004-11-19 07:03:10 +00:00
> +++ edited/drivers/serial/8250.c	2004-11-28 11:02:32 +00:00
> @@ -479,6 +479,34 @@
>  }
>  
>  /*
> + * Read UART ID using the divisor method - set DLL and DLM to zero
> + * and the revision will be in DLL and device type in DLM.  We
> + * preserve the device state across this.
> + */
> +static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
> +{
> +	unsigned char old_dll, old_dlm, old_lcr;
> +	unsigned int id;
> +
> +	old_lcr = serial_inp(p, UART_LCR);
> +	serial_outp(p, UART_LCR, UART_LCR_DLAB);
> +
> +	old_dll = serial_inp(p, UART_DLL);
> +	old_dlm = serial_inp(p, UART_DLM);
> +
> +	serial_outp(p, UART_DLL, 0);
> +	serial_outp(p, UART_DLM, 0);
> +
> +	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> +
> +	serial_outp(p, UART_DLL, old_dll);
> +	serial_outp(p, UART_DLM, old_dlm);
> +	serial_outp(p, UART_LCR, old_lcr);
> +
> +	return id;
> +}
> +
> +/*
>   * This is a helper routine to autodetect StarTech/Exar/Oxsemi UART's.
>   * When this function is called we know it is at least a StarTech
>   * 16650 V2, but it might be one of several StarTech UARTs, or one of
> @@ -490,7 +518,7 @@
>   */
>  static void autoconfig_has_efr(struct uart_8250_port *up)
>  {
> -	unsigned char id1, id2, id3, rev, saved_dll, saved_dlm;
> +	unsigned int id1, id2, id3, rev;
>  
>  	/*
>  	 * Everything with an EFR has SLEEP
> @@ -540,21 +568,13 @@
>  	 *  0x12 - XR16C2850.
>  	 *  0x14 - XR16C854.
>  	 */
> -	serial_outp(up, UART_LCR, UART_LCR_DLAB);
> -	saved_dll = serial_inp(up, UART_DLL);
> -	saved_dlm = serial_inp(up, UART_DLM);
> -	serial_outp(up, UART_DLL, 0);
> -	serial_outp(up, UART_DLM, 0);
> -	id2 = serial_inp(up, UART_DLL);
> -	id1 = serial_inp(up, UART_DLM);
> -	serial_outp(up, UART_DLL, saved_dll);
> -	serial_outp(up, UART_DLM, saved_dlm);
> -
> -	DEBUG_AUTOCONF("850id=%02x:%02x ", id1, id2);
> -
> -	if (id1 == 0x10 || id1 == 0x12 || id1 == 0x14) {
> -		if (id1 == 0x10)
> -			up->rev = id2;
> +	id1 = autoconfig_read_divisor_id(up);
> +	DEBUG_AUTOCONF("850id=%04x ", id1);
> +
> +	id2 = id1 >> 8;
> +	if (id2 == 0x10 || id2 == 0x12 || id2 == 0x14) {
> +		if (id2 == 0x10)
> +			up->rev = id1 & 255;
>  		up->port.type = PORT_16850;
>  		return;
>  	}
> @@ -634,8 +654,16 @@
>  	serial_outp(up, UART_LCR, 0xBF);
>  	if (serial_in(up, UART_EFR) == 0) {
>  		DEBUG_AUTOCONF("EFRv2 ");
> -		autoconfig_has_efr(up);
> -		return;
> +
> +		/*
> +		 * Exar ST16C2550 "A2" devices incorrectly detect as
> +		 * having an EFR, and report an ID of 0x0201.  See
> +		 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf
> +		 */
> +		if (autoconfig_read_divisor_id(up) != 0x0201) {
> +			autoconfig_has_efr(up);
> +			return;
> +		}
>  	}
>  
>  	/*
> 


