Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283230AbRK2OAw>; Thu, 29 Nov 2001 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283229AbRK2OAd>; Thu, 29 Nov 2001 09:00:33 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:18360 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S283230AbRK2OA2>; Thu, 29 Nov 2001 09:00:28 -0500
Message-ID: <3C063CB3.4090708@wipro.com>
Date: Thu, 29 Nov 2001 19:18:35 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
In-Reply-To: <20011129131059.A6214@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-17489d5e-e4c2-11d5-a216-0000e22173f5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-17489d5e-e4c2-11d5-a216-0000e22173f5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Russell King wrote:

>Hi,
>
>The existing serial.c contains a nice module use count bug which is easily
>triggerable.  Without anything connected to ttyS0, do:
>
> stty -clocal -F /dev/ttyS0
> stty -aF /dev/ttyS0
>
>Hit ^c, lsmod shows use count of -1.  Repeat to decrement further.
>
>Here's a patch that fixes this bogosity - please see the comment within
>the patch for the reason.
>
>Marcelo, please apply to both 2.4.
>Linus, please apply to 2.5 as a stop-gap until my new serial drivers are
>ready to be merged.
>
>Thanks.
>
>--- linux-orig/drivers/char/serial.c	Tue Nov 13 12:37:12 2001
>+++ linux/drivers/char/serial.c	Thu Nov 29 13:07:52 2001
>@@ -3133,6 +3133,10 @@
>  * enables interrupts for a serial port, linking in its async structure into
>  * the IRQ chain.   It also performs the serial-specific
>  * initialization for the tty structure.
>+ *
>+ * Note that on failure, we don't decrement the module use count - the tty
>+ * later will call rs_close, which will decrement it for us as long as
>+ * tty->driver_data is set non-NULL. --rmk
>  */
> static int rs_open(struct tty_struct *tty, struct file * filp)
> {
>@@ -3153,10 +3157,8 @@
> 	}
> 	tty->driver_data = info;
> 	info->tty = tty;
>-	if (serial_paranoia_check(info, tty->device, "rs_open")) {
>-		MOD_DEC_USE_COUNT;		
>+	if (serial_paranoia_check(info, tty->device, "rs_open"))
> 		return -ENODEV;
>-	}
> 
> #ifdef SERIAL_DEBUG_OPEN
> 	printk("rs_open %s%d, count = %d\n", tty->driver.name, info->line,
>@@ -3171,10 +3173,8 @@
> 	 */
> 	if (!tmp_buf) {
> 		page = get_zeroed_page(GFP_KERNEL);
>-		if (!page) {
>-			MOD_DEC_USE_COUNT;
>+		if (!page)
> 			return -ENOMEM;
>-		}
>

The current code on my system 2.5.0 looks like

                if (!page) {
                        MOD_DEC_USE_COUNT;
                        return -ENOMEM;
                }


I was wondering that if the open failed with something like this

    open(/dev/ttyS0, args) = -ENOMEM;

why would somebody call close on /dev/ttyS0? If you call close on
a descriptor that failed to open, it is *BAD* code. I am assuming
that the tty layer that talks to the serial driver calls rs_close().

The same thing applies to the code below. I think that the open routine
should instead set tty->driver_data to NULL upon failure.


Comments,
Balbir Singh.




>
> 		if (tmp_buf)
> 			free_page(page);
> 		else
>@@ -3188,7 +3188,6 @@
> 	    (info->flags & ASYNC_CLOSING)) {
> 		if (info->flags & ASYNC_CLOSING)
> 			interruptible_sleep_on(&info->close_wait);
>-		MOD_DEC_USE_COUNT;
> #ifdef SERIAL_DO_RESTART
> 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
> 			-EAGAIN : -ERESTARTSYS);
>@@ -3201,10 +3200,8 @@
> 	 * Start up serial port
> 	 */
> 	retval = startup(info);
>-	if (retval) {
>-		MOD_DEC_USE_COUNT;
>+	if (retval)
> 		return retval;
>-	}
> 
> 	retval = block_til_ready(tty, filp, info);
> 	if (retval) {
>@@ -3212,7 +3209,6 @@
> 		printk("rs_open returning after block_til_ready with %d\n",
> 		       retval);
> #endif
>-		MOD_DEC_USE_COUNT;
> 		return retval;
> 	}
> 
>
>
>--
>Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>             http://www.arm.linux.org.uk/personal/aboutme.html
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



------=_NextPartTM-000-17489d5e-e4c2-11d5-a216-0000e22173f5
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-17489d5e-e4c2-11d5-a216-0000e22173f5--
