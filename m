Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVCHSZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVCHSZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVCHSZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:25:18 -0500
Received: from [195.23.16.24] ([195.23.16.24]:35749 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261494AbVCHSZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:25:04 -0500
Message-ID: <422DEDA0.7080308@grupopie.com>
Date: Tue, 08 Mar 2005 18:23:28 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans-Christian Egtvedt <hc@mivu.no>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>	 <200503041403.37137.adobriyan@mail.ru>	 <d120d50005030406525896b6cb@mail.gmail.com>	 <1109953224.3069.39.camel@charlie.itk.ntnu.no>	 <d120d50005030408544462c9ea@mail.gmail.com> <1110297660.3198.15.camel@server.customer.mivu.no>
In-Reply-To: <1110297660.3198.15.camel@server.customer.mivu.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Christian Egtvedt wrote:
> [...]
> Any tips are welcome. Is this done before with a touchscreen?

Just a minor nitpick, not really related to the mouse problem. More of 
coding style problem.

IMHO the UCP and UCOM macros just obfuscate the code. If you do not want 
to write "((unsigned char *) urb->transfer_buffer)[0]" every time (I can 
perfectly understand that), maybe using a local "u8 *" var would do the 
trick.

Something like this:

> static void itmtouch_irq(struct urb *urb, struct pt_regs *regs)
> {
> 	struct itmtouch_dev * itmtouch = urb->context;
> 	int retval;
> 	u8 *tbuf;
> 
> 	....
> 
> 	input_regs(&itmtouch->inputdev, regs);
> 
> 	tbuf = (u8 *)(urb->transfer_buffer);
> 
> 	/* if pressure has been released, then don't report X/Y */
> 	if (!(tbuf[7] & 0x20)) {
> 		input_report_abs(&itmtouch->inputdev, ABS_X,
> 				(tbuf[0] & 0x1F) << 7 | (tbuf[3] & 0x7F));
> 		input_report_abs(&itmtouch->inputdev, ABS_Y,
> 				(tbuf[1] & 0x1F) << 7 | (tbuf[4] & 0x7F));
> 	}
> 	
> 	input_report_abs(&itmtouch->inputdev, ABS_PRESSURE,
> 			(tbuf[2] & 0x1) << 7 | (tbuf[5] & 0x7F));
> 	input_report_key(&itmtouch->inputdev, BTN_TOUCH, !(tbuf[7] & 0x20));
> 	/* TODO: Do we need to use input_sync() ? */
> 	/* input_sync(&itmtouch->inputdev); */
> 
> 	......

This is perfectly readable without one having to find out what those 
macros mean, and it is even easier for the compiler to optimize (even 
though gcc will probably optimize both versions just fine).

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
