Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263680AbVBEXAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbVBEXAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 18:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272058AbVBEXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 18:00:53 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:39558 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262558AbVBEXAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 18:00:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] adding the ICS MK712 touchscreen driver to 2.6
Date: Sat, 5 Feb 2005 18:00:33 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.de>, Richard Koch <n1gp@hotmail.com>,
       linux-kernel@vger.kernel.org
References: <BAY16-F34ACC3DA65154E040BEC5987800@phx.gbl> <20050205210203.GX2711@ucw.cz>
In-Reply-To: <20050205210203.GX2711@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051800.33621.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 16:02, Vojtech Pavlik wrote:
v> On Wed, Jan 19, 2005 at 04:18:49PM -0500, Richard Koch wrote:
> > Please include the patch below to bring the ICS MK712 touchscreen controller
> > support, which is in kernel 2.4, in to kernel 2.6.
> > 
> > This patch was constructed and applied to kernel version 2.6.10 and tested
> > successfully on several Gateway AOL Connected Touchpad computers.
> > 
> > This was based on the mk712.c 2.4.28 version. No functional changes applied 
> > only minor
> > changes to conform to the 2.6 build structure. I choose to place the driver 
> > under
> > input/touchscreen as this seemed most appropriate.
> > 
> > By making a contribution to this project, I certify that:
> > 
> > The contribution is based upon previous work that, to the best
> > of my knowledge, is covered under an appropriate open source
> > license and I have the right under that license to submit that
> > work with modifications, whether created in whole or in part
> > by me, under the same open source license (unless I am
> > permitted to submit under a different license), as indicated
> > in the file.
> > 
> > Signed-off-by: Rick Koch <n1gp@hotmail.com>
> > 
> > patch also available at: http://home.comcast.net/~n1gp/mk712_2.6_patch
> 
> I converted it to a proper input driver for you. ;) Can you check it if
> it still works?
> 
> +static irqreturn_t mk712_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +        unsigned char status;
> +        static int debounce = 1;
> +	static unsigned short last_x;
> +	static unsigned short last_y;
> +
> +	input_regs(&mk712_dev, regs);
> +
> +        status = inb(mk712_io + MK712_STATUS);
> +
> +	if (~status & MK712_CONVERSION_COMPLETE) {
> +                debounce = 1;
> +		goto end;
> +	}
> +
> +	if (~status & MK712_STATUS_TOUCH)
> +	{
> +                debounce = 1;
> +		input_report_key(&mk712_dev, BTN_TOUCH, 0);
> +		goto end;
> +	}
> +
> +        if (debounce)
> +        {
> +		debounce = 0;
> +		goto end;
> +        }
> +
> +	input_report_key(&mk712_dev, BTN_TOUCH, 1);
> +	input_report_abs(&mk712_dev, ABS_X, last_x);
> +	input_report_abs(&mk712_dev, ABS_Y, last_y);

Severe TAB vs. space damage...

> +static int mk712_open(struct input_dev *dev)
> +{
> +	
> +	if (mk712_used++)
> +		return 0;
> +
> +	outb(0, mk712_io + MK712_CONTROL); /* Reset */
> +

We really should stop ignoring races and locking issues. Atomic perhaps?


-- 
Dmitry
