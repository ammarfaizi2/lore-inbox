Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262431AbRENTsw>; Mon, 14 May 2001 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbRENTsm>; Mon, 14 May 2001 15:48:42 -0400
Received: from inet.connecttech.com ([206.130.75.2]:13768 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S262431AbRENTsb>; Mon, 14 May 2001 15:48:31 -0400
Message-ID: <033101c0dcaf$10557f40$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Val Henson" <val@nmt.edu>, "Theodore Tso" <tytso@valinux.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010511182723.M18959@boardwalk>
Subject: Re: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Date: Mon, 14 May 2001 15:50:01 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Val Henson" <val@nmt.edu>
> This fixes a bug in the autoconfig_startech_uarts function in
> serial.c.  The problem is that 0's are written to the baud rate
> registers in order to detect an XR16C850 or XR16C854.  This makes the
> Exar ST16C654 go kablooey.  Saving and restoring the baud rate
> registers after the test fixes it.

What version of serial.c? I'm assuming 5.05.

Define "go kablooey". We haven't noticed any problems, and we supplied
this bit of code.

The size_fifo() routine supplies its own baud rate divisor, and
on any rs_open() change_speed() sets the baud rate properly.
I can't figure what you might be seeing.

> I'm assuming that the XR16C85[04] detection works as is and doesn't
> need the original baud rate restored.  If I'm wrong, I'll rewrite the
> patch.

You're correct that the detection works as is, except that you
broke it in your patch. See below.

> --- linux-2.4.5-pre1/drivers/char/serial.c Thu Apr 19 00:26:34 2001
> +++ linux/drivers/char/serial.c Sat May 12 05:19:26 2001
> @@ -3507,7 +3507,7 @@
>         struct serial_state *state,
>         unsigned long flags)
>  {
> - unsigned char scratch, scratch2, scratch3;
> + unsigned char scratch, scratch2, scratch3, scratch4;
>
>   /*
>   * First we check to see if it's an Oxford Semiconductor UART.
> @@ -3551,17 +3551,32 @@
>   * XR16C854.
>   *
>   */
> +
> + /* Save the DLL and DLM */
> +
>   serial_outp(info, UART_LCR, UART_LCR_DLAB);
> + scratch3 = serial_inp(info, UART_DLL);
> + scratch4 = serial_inp(info, UART_DLM);
> +
>   serial_outp(info, UART_DLL, 0);
>   serial_outp(info, UART_DLM, 0);
> - state->revision = serial_inp(info, UART_DLL);
> + scratch2 = serial_inp(info, UART_DLL);

This isn't necessary. The revision field is only checked
for 950s, so setting it here doesn't harm anything. If the
current (only) example of checking it is followed as normal
procedure, the port type will always be checked first, before
checking the revision, ensuring only valid revisions are
referenced.

>   scratch = serial_inp(info, UART_DLM);
>   serial_outp(info, UART_LCR, 0);
> +
>   if (scratch == 0x10 || scratch == 0x14) {
> + if (scratch == 0x10)
> + state->revision = scratch2;
>   state->type = PORT_16850;
>   return;
>   }

Only saving the revision for 850s is probably wrong. It should
be saved for all the 85x uarts.

> + /* Restore the DLL and DLM */
> +
> + serial_outp(info, UART_LCR, UART_LCR_DLAB);
> + serial_outp(info, UART_DLL, scratch3);
> + serial_outp(info, UART_DLM, scratch4);
> + serial_outp(info, UART_LCR, 0);
>   /*
>   * We distinguish between the '654 and the '650 by counting
>   * how many bytes are in the FIFO.  I'm using this for now,

..Stu


