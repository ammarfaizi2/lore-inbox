Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314151AbSDLVyj>; Fri, 12 Apr 2002 17:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314153AbSDLVyi>; Fri, 12 Apr 2002 17:54:38 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:58634 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S314151AbSDLVyh>; Fri, 12 Apr 2002 17:54:37 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A777D@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Guennadi Liakhovetski'" <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org,
        "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: serial driver question
Date: Fri, 12 Apr 2002 14:54:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> Hello all
> 
> The function
> static int size_fifo(struct async_struct *info)
> {
> ...
> ends as follows:
> 	serial_outp(info, UART_LCR, UART_LCR_DLAB);
> 	serial_outp(info, UART_DLL, old_dll);
> 	serial_outp(info, UART_DLM, old_dlm);
> 
> 	return count;
> }
> 
> Which means, that DLAB is not re-set, and, in particular, all 
> subsequent read/write operations on offsets 0 and 1 will not 
> affect the data and interrupt enable registers, but the divisor 
> latch register... Or is this register somehow magically restored 
> elsewhere or by the hardware (say, on an interrupt)? This 
> function seems to be only called for startech UARTs.

Hi Guennadi,

It is somehow magically restored elsewhere. The divisor latch bit (DLAB)
does remain set when size_fifo() returns, but the state does not persist.
Here is why the code works anyway, albeit with a trap or two for the
insufficiently paranoid ... and it can be explained without magic. :)

Notice that function size_fifo() does not save the LCR value before changing
it. Static function size_fifo() is called only from the very end of static
function autoconfig_startech_uarts(). Notice that function
autoconfig_startech_uarts() never returns with state->type set to
PORT_16550A. All code paths change state->type to something else. Static
function autoconfig_startech_uarts() is only called from the middle of
static function autoconfig(). Function autoconfig() saves the LCR value
before the testing of the alleged UART, which may include calling
autoconfig_startech_uarts(). When autoconfig_startech_uarts() returns to
autoconfig(), state->type cannot be PORT_16550A so the bodies of the next
two "if" statements that check state->type are skipped. The next line of
UART touching code that runs after size_fifo() and
autoconfig_startech_uarts() return to autoconfig(), is at about 50 lines
after the call to autoconfig_startech_uarts(), just before the check for
state->type == PORT_16450:

	serial_outp(info, UART_LCR, save_lcr);

which restores autoconfig()'s saved LCR value, including the DLAB bit. 

Yeah, I agree that size_fifo() should clean up after itself, but it doesn't
break anything as the code currently sits. Care to submit a one-line patch
for size_fifo() to clean up the UART state? 

Best regards,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
