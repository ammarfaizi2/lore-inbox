Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWJ2XUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWJ2XUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWJ2XUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:20:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:33567 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030434AbWJ2XUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:20:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UK1If+MC8XxmKOdGl5CkLFF/zVzluWTANYmA8Alh2y+yNJ/40ZyG5h0q7I5Npb2R9zdy8d7gdmdQl3x+i+p3JjBwVjvmhaWsqw3pDLANTp0vr4pHwbVfVqWCfysxc5Rfydcg3iHUYyFGAc4PO0nbUmXZRLoMi/mRSGdn220hbKg=
Message-ID: <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
Date: Sun, 29 Oct 2006 18:20:19 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <200608232311.07599.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
X-Google-Sender-Auth: 09d977260ceb5f09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> Hi everyone,
>
> Here is another version of the patch removing polling timer from i8042
> which is needed if we want tickless kernel. Keyboards should now work
> on boxes that do not have mouse plugged in. PLease give it a test.

 What's the intent of this; just to allow tickless? Or is it also to
make the i8042 driver less racy? I ask because I've applied this over
(a modified) 2.6.18 on my Compaq Presario X1010us laptop which has
been driving me crazy w/ Synaptics problems and keyboard problems
(intermittent, but   frequent enough lately that I finally figured I
needed to do something about it).

If removing raciness is part of the goal, isn't the window in
i8042_aux_write still a problem?

	if (port->mux == -1)
		retval = i8042_command(&c, I8042_CMD_AUX_SEND);
	else
		retval = i8042_command(&c, I8042_CMD_MUX_SEND + port->mux);

        /* i8042_command has re-enabled interrupts;
           what happens if real interrupt happens here, before we call
the ISR ourselves? */

	i8042_interrupt(0, NULL, NULL);
	return retval;
}

I don't really know if or how much the races in this driver are
contributing to my problems (keyboard getting stuck repeating last
key, or ignoring interrupts, or synaptics touchpad freezing, last of
which requires cold boot to fix). Maybe more likely an ACPI thing?

Anyway, thought I'd point this out and see if this patch is actually
going in someone's queue. I think I'll keep running w/ the patch since
w/ the polling in there and HZ set to 1000, it seemed like there were
an awful lot of opportunities for the driver to get confused, and even
if it's not causing my problems it doesn't seem like it could be
helping.

Dave
