Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbULCVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbULCVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 16:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbULCVG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 16:06:56 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:55189 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262386AbULCVGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 16:06:15 -0500
Subject: Re: Exar ST16C2550 rev A2 bug
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, michael.knight@exar.com
In-Reply-To: <1101659181.2838.41.camel@mythbox>
References: <1100716008.32679.55.camel@tdi>
	 <20041128111047.A10807@flint.arm.linux.org.uk>
	 <1101659181.2838.41.camel@mythbox>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 03 Dec 2004 14:06:11 -0700
Message-Id: <1102107971.7078.34.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Sun, 2004-11-28 at 09:26 -0700, Alex Williamson wrote:
> On Sun, 2004-11-28 at 11:10 +0000, Russell King wrote:
> > On Wed, Nov 17, 2004 at 11:26:47AM -0700, Alex Williamson wrote:
> > 
> > Can you check whether this patch solves it?  I'd rather not rely on
> > size_fifo() to do the right thing in every circumstance.
> 
>   I have a system on order with one of these bad UARTs.  I'll be happy
> to check the patch when it arrives (hopefully this week).

   No system yet, hopefully soon :^(

> > Essentially, if we find an EFR, we check whether the UART reports
> > DVID/DREV values corresponding to the known problem scenario, and
> > if so, we essentially ignore the EFR.
> > 
> > What I don't know is whether these DVID/DREV values correspond to
> > a real device which does have an EFR.  Maybe Exar people can shed
> > some light on this?
> 
>    I'll see if I can get an engineering contact from Exar to confirm.

   Michael Knight from Exar is CC'd.  Unfortunately it sounds like the
DVID/DREV registers are the same as another Exar product that does have
a valid EFR.  So this would restrict functionality on that part as well.
Perhaps a hybrid test, something like:

static int broken_efr(struct uart_8250_port *p)
{
	/*
	 * Exar ST16C2550 "A2" devices incorrectly detect as
	 * having an EFR, and report an ID of 0x0201.  See
	 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf
	 */
	if (autoconfig_read_divisor_id(p) == 0x0201 && size_fifo(p) == 16)
		return 1;

	return 0;
}

...

	if (!broken_efr(up)) {
		autoconfig_has_efr(up);
		return;
	}
...

   I think we know size_fifo() works on these parts, so we'd limit our
reliance on size_fifo().  If any more UARTs come alone with this issue
we could add them to the test.  Thoughts?  I can incorporate this into
your patch and test it when I get a system with these parts.  Thanks,

	Alex


> > ===== drivers/serial/8250.c 1.92 vs edited =====
> > --- 1.92/drivers/serial/8250.c	2004-11-19 07:03:10 +00:00
> > +++ edited/drivers/serial/8250.c	2004-11-28 11:02:32 +00:00
> > @@ -479,6 +479,34 @@
> >  }
> >  
> >  /*
> > + * Read UART ID using the divisor method - set DLL and DLM to zero
> > + * and the revision will be in DLL and device type in DLM.  We
> > + * preserve the device state across this.
> > + */
> > +static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
> > +{
> > +	unsigned char old_dll, old_dlm, old_lcr;
> > +	unsigned int id;
> > +
> > +	old_lcr = serial_inp(p, UART_LCR);
> > +	serial_outp(p, UART_LCR, UART_LCR_DLAB);
> > +
> > +	old_dll = serial_inp(p, UART_DLL);
> > +	old_dlm = serial_inp(p, UART_DLM);
> > +
> > +	serial_outp(p, UART_DLL, 0);
> > +	serial_outp(p, UART_DLM, 0);
> > +
> > +	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> > +
> > +	serial_outp(p, UART_DLL, old_dll);
> > +	serial_outp(p, UART_DLM, old_dlm);
> > +	serial_outp(p, UART_LCR, old_lcr);
> > +
> > +	return id;
> > +}
> > +
> > +/*
> >   * This is a helper routine to autodetect StarTech/Exar/Oxsemi UART's.
> >   * When this function is called we know it is at least a StarTech
> >   * 16650 V2, but it might be one of several StarTech UARTs, or one of
> > @@ -490,7 +518,7 @@
> >   */
> >  static void autoconfig_has_efr(struct uart_8250_port *up)
> >  {
> > -	unsigned char id1, id2, id3, rev, saved_dll, saved_dlm;
> > +	unsigned int id1, id2, id3, rev;
> >  
> >  	/*
> >  	 * Everything with an EFR has SLEEP
> > @@ -540,21 +568,13 @@
> >  	 *  0x12 - XR16C2850.
> >  	 *  0x14 - XR16C854.
> >  	 */
> > -	serial_outp(up, UART_LCR, UART_LCR_DLAB);
> > -	saved_dll = serial_inp(up, UART_DLL);
> > -	saved_dlm = serial_inp(up, UART_DLM);
> > -	serial_outp(up, UART_DLL, 0);
> > -	serial_outp(up, UART_DLM, 0);
> > -	id2 = serial_inp(up, UART_DLL);
> > -	id1 = serial_inp(up, UART_DLM);
> > -	serial_outp(up, UART_DLL, saved_dll);
> > -	serial_outp(up, UART_DLM, saved_dlm);
> > -
> > -	DEBUG_AUTOCONF("850id=%02x:%02x ", id1, id2);
> > -
> > -	if (id1 == 0x10 || id1 == 0x12 || id1 == 0x14) {
> > -		if (id1 == 0x10)
> > -			up->rev = id2;
> > +	id1 = autoconfig_read_divisor_id(up);
> > +	DEBUG_AUTOCONF("850id=%04x ", id1);
> > +
> > +	id2 = id1 >> 8;
> > +	if (id2 == 0x10 || id2 == 0x12 || id2 == 0x14) {
> > +		if (id2 == 0x10)
> > +			up->rev = id1 & 255;
> >  		up->port.type = PORT_16850;
> >  		return;
> >  	}
> > @@ -634,8 +654,16 @@
> >  	serial_outp(up, UART_LCR, 0xBF);
> >  	if (serial_in(up, UART_EFR) == 0) {
> >  		DEBUG_AUTOCONF("EFRv2 ");
> > -		autoconfig_has_efr(up);
> > -		return;
> > +
> > +		/*
> > +		 * Exar ST16C2550 "A2" devices incorrectly detect as
> > +		 * having an EFR, and report an ID of 0x0201.  See
> > +		 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf
> > +		 */
> > +		if (autoconfig_read_divisor_id(up) != 0x0201) {
> > +			autoconfig_has_efr(up);
> > +			return;
> > +		}
> >  	}
> >  
> >  	/*
> > 
> 
-- 
Alex Williamson                             HP Linux & Open Source Lab

