Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbUJ0UXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUJ0UXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUJ0UXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:23:03 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:4988 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262597AbUJ0UQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:16:51 -0400
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Greg KH <greg@kroah.com>, Oleksiy <Oleksiy@kharkiv.com.ua>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1098576844.5996.27.camel@at2.pipehead.org>
References: <416A6CF8.5050106@kharkiv.com.ua>
	 <20041012171004.GB11750@kroah.com>  <20041023180625.GA12113@logos.cnet>
	 <1098572412.5996.6.camel@at2.pipehead.org>
	 <1098576844.5996.27.camel@at2.pipehead.org>
Content-Type: text/plain
Message-Id: <1098908206.2856.17.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 27 Oct 2004 15:16:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 19:14, Paul Fulghum wrote:
> This change fits the reported symptom (loss of receive data).
> 
> The change preserves line status errors
> across multiple read interrupt callbacks until the error
> can be applied to the contents of the next read bulk callback.
> 
> What looks wrong to me is that the line status error,
> which should be associated with an individual character,
> is applied to the entire contents of the next bulk read.
> Wouldn't this potentially invalidate good data?
> 
> I'm not familiar with the operation of USB-serial converters,
> so I don't know exactly how the flow of read interrupt and
> read bulk callbacks are implemented to handle character errors.
> 
> If I was to guess, before the change, errors were lost
> (overwritten by the next read interrupt callback)
> so the mask was added to preserve the error.
> But the error is applied to more data than it should,
> causing loss of valid receive data.

USB CDC 1.1 does not specify how these error indications
relate to subsequent bulk data packets. I could not find
manufacturer info that helps. BSD drivers don't do
error processing at all.

Here is a patch that applies the error only to the
next receive byte instead of all bytes in the
next read bulk packet.

Greg: Any comment?

Oleksiy: Can you try this patch?

Thanks,
Paul

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.4.28-pre4/drivers/usb/serial/pl2303.c	2004-08-07 18:26:05.000000000 -0500
+++ linux-2.4.28-pre4-mg/drivers/usb/serial/pl2303.c	2004-10-27 15:09:09.000000000 -0500
@@ -799,6 +799,7 @@ static void pl2303_read_bulk_callback (s
 				tty_flip_buffer_push(tty);
 			}
 			tty_insert_flip_char (tty, data[i], tty_flag);
+			tty_flag = TTY_NORMAL;
 		}
 		tty_flip_buffer_push (tty);
 	}


