Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTBKV0O>; Tue, 11 Feb 2003 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTBKV0O>; Tue, 11 Feb 2003 16:26:14 -0500
Received: from mailc.telia.com ([194.22.190.4]:32506 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S266310AbTBKV0M> convert rfc822-to-8bit;
	Tue, 11 Feb 2003 16:26:12 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] jiffies wrap fixes for 2.5.60
Date: Tue, 11 Feb 2003 22:31:40 +0100
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.33.0302112145290.15563-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0302112145290.15563-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200302112231.41592.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 February 2003 21:50, Tim Schmielau wrote:
> On Tue, 4 Feb 2003, Denis Vlasenko wrote:
> 
> > However, this is a bit cosmetic. There is a much more serious problem:
> >
> > 		Jiffy Wrap Bugs
> >
> > There were reports of machines hanging on jiffy wrap.
> > This is typically a result of incorrect jiffy use in some driver.
> > Ask Tim - he is hunting those problems regularly, but he is outnumbered
> > by buggy driver authors. :(
> 
> Speaking of which - here are my fixes for 2.5.60.
> Will take some sleep (and maybe even try to compile them) before feeding
> the patch monkey.
> 
> Tim
> 
> 
> --- linux-2.5.60/arch/cris/drivers/usb-host.c	Fri Jan 17 03:21:51 2003
> +++ linux-2.5.60-jfix/arch/cris/drivers/usb-host.c	Mon Feb 10 23:07:11 2003
> @@ -459,7 +459,7 @@
>  	*R_DMA_CH8_SUB2_CMD = IO_STATE(R_DMA_CH8_SUB2_CMD, cmd, stop);
>  	/* Somehow wait for the DMA to finish current activities */
>  	i = jiffies + 100;
> -	while (jiffies < i);
> +	while (time_before(jiffies, i));

Busy wait? For several jiffies! Please...
I hope that interrupts are not disabled.


> --- linux-2.5.60/drivers/char/moxa.c	Fri Jan 17 03:22:44 2003
> +++ linux-2.5.60-jfix/drivers/char/moxa.c	Mon Feb 10 23:01:59 2003
> @@ -2832,7 +2832,7 @@
> 
>  	st = jiffies;
>  	et = st + tick;
> -	while (jiffies < et);
> +	while (time_before(jiffies, et));
>  }

This is the function before the patch:

/*
 * moxadelay - delays a specified number ticks
 */
static void moxadelay(int tick)
{
	unsigned long st, et;

	st = jiffies;
	et = st + tick;
	while (jiffies < et);
}

And this is how it is used. In several places...

	moxadelay(1);		/* delay 10 ms */
Either the parameter or the comment are wrong - probably both... :-)
Since this does not guarantee anything! Jiffies might tick on the first
check...

But even worse useage is:

void MoxaPortSendBreak(int port, int ms100)
{
	unsigned long ofsAddr;

	ofsAddr = moxaTableAddr[port];
	if (ms100) {
		moxafunc(ofsAddr, FC_SendBreak, Magic_code);
		moxadelay(ms100 * (HZ / 10));
	} else {
		moxafunc(ofsAddr, FC_SendBreak, Magic_code);
		moxadelay(HZ / 4);	/* 250 ms */
	}
	moxafunc(ofsAddr, FC_StopBreak, Magic_code);
}

And this is not enough - the parameter comes from user space...
(it is said to be in units between 250 ... 500 ms, the code above uses
 100 ms...)

And there are more uses like this...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

