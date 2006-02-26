Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWBZNGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWBZNGX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBZNGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:06:23 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:55228 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751101AbWBZNGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:06:23 -0500
Date: Sun, 26 Feb 2006 08:05:05 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re:Badness in vsnprintf
To: Horst Schirmeier <horst@schirmeier.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@suse.de>
Message-ID: <200602260806_MC3-1-B956-121A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060126195038.GB22994@quickstop.soohrt.org>

On Thu, 26 Jan 2006 at 20:50:38 +0100, Horst Schirmeier wrote:

> input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:04.2-1
> Badness in vsnprintf at lib/vsprintf.c:279
>  [<c0324f64>] vsnprintf+0x544/0x550
>  [<c0324fbc>] snprintf+0x1c/0x30
>  [<c03ec17a>] print_modalias_bits+0x8a/0x90
>  [<c03ec213>] print_modalias+0x93/0x1d0
>  [<c03ec8c0>] input_dev_uevent+0x1d0/0x4b0
>  [<c0384060>] class_uevent+0xb0/0x260
>  [<c0383fb0>] class_uevent+0x0/0x260
>  [<c03223f1>] kobject_uevent+0x3f1/0x450

print_modalias() passed a negative length to snprintf().

There's a general lack of error checking in the whole area;
input_dev_uevent() does:

        envp[i++] = buffer + len;
        len += snprintf(buffer + len, buffer_size - len, "MODALIAS=");
        len += print_modalias(buffer + len, buffer_size - len, dev) + 1;

        envp[i] = NULL;

and never checks whether 'buffer_size - len' is negative or even if there
is space in envp[] for another pointer.  And print_modalias() and
print_modalias_bits() don't check anything either.

Maybe the modalias shouldn't be in there at all since there doesn't seem to
be enough space for it?

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

