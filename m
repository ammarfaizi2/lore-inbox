Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTIXWkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTIXWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:40:35 -0400
Received: from ftpbox.mot.com ([129.188.136.101]:51103 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S261600AbTIXWkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:40:15 -0400
Date: Wed, 24 Sep 2003 17:40:04 -0500
Subject: Re: [PATCH] Make the Startech UART detection 'more correct'.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-serial@vger.kernel.org>, <gallen@arlut.utexas.edu>,
       Tom Rini <trini@kernel.crashing.org>
To: <tytso@mit.edu>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <20030909235153.GB4559@ip68-0-152-218.tc.ph.cox.net>
Message-Id: <0A8F6030-EEE0-11D7-AA35-000393DBC2E8@motorola.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering what the status of this patch was for the 2.4 side?

thanks

- kumar

On Tuesday, September 9, 2003, at 06:51 PM, Tom Rini wrote:

> On Tue, Sep 09, 2003 at 05:18:59PM +0100, Russell King wrote:
>
>> On Mon, Sep 08, 2003 at 01:54:31PM -0700, Tom Rini wrote:
>>> Hello.  The following patches (vs 2.4 and 2.6) make the Startech UART
>>> detection 'more correct'  The problem is that on with the Motorola
>>> MPC82xx line (8245 for example) it has an internal DUART that it 
>>> claims
>>> to be PC16550D compatible, and it has an additional EFR (Enhanced
>>> Feature Register) at offset 0x2, like on the Startech UARTS.  
>>> However,
>>> it is not a Startech, and when it's detected as such, FIFOs don't 
>>> work.
>>> The fix for this is that the Startech UARTs have a 32 byte FIFO [1] 
>>> and
>>> the MPC82xx DUARTs have a 16-byte FIFO [2], to check that the FIFO 
>>> size
>>> is correct for a Startech.
>>
>> size_fifo() is claimed to be unreliable at detecting the FIFO size,
>> so I don't feel safe about using it here.
>>
>> I'd suggest something like:
>>
>> 	serial_outp(port, UART_LCR, UART_LCR_DLAB);
>> 	efr = serial_in(port, UART_EFR);
>> 	if ((efr & 0xfc) == 0) {
>> 		serial_out(port, UART_EFR, 0xac | (efr & 3));
>> 		/* if top 6 bits return zero, its motorola */
>> 		if (serial_in(port, UART_EFR) == (efr & 3)) {
>> 			/* motorola port */
>> 		} else {
>> 			/* ST16C650V1 port */
>> 		}
>> 		/* restore old value */
>> 		serial_outb(port, UART_EFR, efr);
>> 	}
>
> Okay, from Kumar Gala (cc'ed) I've got the following patch for 2.4:
> ===== drivers/char/serial.c 1.34 vs edited =====
> --- 1.34/drivers/char/serial.c	Sun Jul  6 22:33:28 2003
> +++ edited/drivers/char/serial.c	Tue Sep  9 16:50:22 2003
> @@ -3741,7 +3741,10 @@
>  		/* Check for Startech UART's */
>  		serial_outp(info, UART_LCR, UART_LCR_DLAB);
>  		if (serial_in(info, UART_EFR) == 0) {
> -			state->type = PORT_16650;
> +			serial_outp(info, UART_EFR, 0xA8);
> +			if (serial_in(info, UART_EFR) != 0)
> +				state->type = PORT_16650;
> +			serial_outp(info, UART_EFR, 0);
>  		} else {
>  			serial_outp(info, UART_LCR, 0xBF);
>  			if (serial_in(info, UART_EFR) == 0)
>
> And I forward ported this up to 2.6 as:
> ===== drivers/serial/8250.c 1.36 vs edited =====
> --- 1.36/drivers/serial/8250.c	Tue Sep  9 07:22:12 2003
> +++ edited/drivers/serial/8250.c	Tue Sep  9 16:49:07 2003
> @@ -469,8 +469,13 @@
>  	 */
>  	serial_outp(up, UART_LCR, UART_LCR_DLAB);
>  	if (serial_in(up, UART_EFR) == 0) {
> -		DEBUG_AUTOCONF("EFRv1 ");
> -		up->port.type = PORT_16650;
> +		serial_outp(up, UART_EFR, 0xA8);
> +		if (serial_in(up, UART_EFR) != 0) {
> +			DEBUG_AUTOCONF("EFRv1 ");
> +			up->port.type = PORT_16650;
> +		} else
> +			DEBUG_AUTOCONF("Motorola 8xxx DUART ");
> +		serial_outp(up, UART_EFR, 0);
>  		return;
>  	}
>
> Better?
>
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
> <mime-attachment>

