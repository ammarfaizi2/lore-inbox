Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbUJ1TdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUJ1TdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUJ1TdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:33:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39431 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262123AbUJ1TcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:32:01 -0400
Date: Thu, 28 Oct 2004 20:31:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Serial 8250 OMAP support, take 2
Message-ID: <20041028203157.B11436@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20041028191826.GG14884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041028191826.GG14884@atomide.com>; from tony@atomide.com on Thu, Oct 28, 2004 at 12:18:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 12:18:27PM -0700, Tony Lindgren wrote:
> Here's an updated version of an earlier patch [1] to add OMAP support to
> the serial 8250 driver.
> 
> The new patch has been updated to use early_serial_setup() instead of
> register_serial(). This leaves out the earlier additional patch needed 
> to serial_core.c [2], which caused a problem on PCI modems [3].

One of the things which previous changes have done is to move us away
from "port types" towards "capabilities" for serial ports, so things
like the FIFO, hardware flow control and so forth can be individually
controlled, rather than having to rely on a table of features.

So, it appears that OMAP ports are like a TI752 port, but with a couple
of extra features.  Can we use the existing TI75x feature support code
for these ports?

Also, these ports seem to use extra address space which isn't covered by
a request_region/request_mem_region... that's something which should be
fixed.

> --- linus/include/linux/serial_reg.h	2004-10-25 10:33:36.000000000 -0700
> +++ linux-omap-dev/include/linux/serial_reg.h	2004-10-28 11:50:15.000000000 -0700
> @@ -79,6 +79,15 @@
>  #define UART_FCR6_T_TRIGGER_8	0x10 /* Mask for transmit trigger set at 8 */
>  #define UART_FCR6_T_TRIGGER_24  0x20 /* Mask for transmit trigger set at 24 */
>  #define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
> +/* 16C752 definitions */
> +#define UART_FCR7_R_TRIGGER_8	0x00 /* Mask for receive trigger set at 8 */
> +#define UART_FCR7_R_TRIGGER_16	0x40 /* Mask for receive trigger set at 16 */
> +#define UART_FCR7_R_TRIGGER_56	0x80 /* Mask for receive trigger set at 56 */
> +#define UART_FCR7_R_TRIGGER_60	0xC0 /* Mask for receive trigger set at 60 */
> +#define UART_FCR7_T_TRIGGER_8	0x00 /* Mask for transmit trigger set at 8 */
> +#define UART_FCR7_T_TRIGGER_16	0x10 /* Mask for transmit trigger set at 16 */
> +#define UART_FCR7_T_TRIGGER_32	0x20 /* Mask for transmit trigger set at 32 */
> +#define UART_FCR7_T_TRIGGER_56	0x30 /* Mask for transmit trigger set at 56 */

The set of UART_FCR6_xxx definitions are only left here for compatibility -
there are others which use this file.  Because the trigger levels is very
dependent on the chip and sometimes which other features are enabled, I
decided to provide new definitions:

#define UART_FCR_R_TRIG_00      0x00
#define UART_FCR_R_TRIG_01      0x40
#define UART_FCR_R_TRIG_10      0x80
#define UART_FCR_R_TRIG_11      0xc0
#define UART_FCR_T_TRIG_00      0x00
#define UART_FCR_T_TRIG_01      0x10
#define UART_FCR_T_TRIG_10      0x20
#define UART_FCR_T_TRIG_11      0x30

with a table above which detail their effects.  I think it's silly creating
lots of definitions for these bits, and then ending up with lots of macros
definiting the same sort of thing.  Please use the above only.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
