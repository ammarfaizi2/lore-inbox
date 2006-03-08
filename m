Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWCHIxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWCHIxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCHIxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:53:14 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:10308 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932519AbWCHIxM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:53:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lXU3UYddY/NlmCAfTz2CexC62wbYtm/tAZZktfCBqtGIbc2k9h8sxQg1ak15FtEOHg69WAKrDwL0PURm2Wq4k9oI+GmhtlIVhQcwQZ6aFDnsnJFVxNcOHrUnTBuH201/jgCHgI8uw8aQOjy/9uDJA1KnyIxgSSTtdMxzdYcVB0c=
Message-ID: <756b48450603080053q3a6e5dccu4e351cf4891d0fb@mail.gmail.com>
Date: Wed, 8 Mar 2006 16:53:11 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B22AB1A@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ACA40606221794F80A5670F0AF15F840B22AB1A@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Yu, Luming <luming.yu@intel.com> wrote:
>
> I know this user-defined region needs address space handler, but your
> address space handler below  is so weird that make me doubt
> the correctness.  The example of address space handler is:
> ec.c : acpi_ec_space_handler
>

As you suggested, I looked at the ec case:

845         if ((address > 0xFF) || !value || !handler_context)
846                 return_VALUE(AE_BAD_PARAMETER);
847
848         if (bit_width != 8 && acpi_strict) {
849                 printk(KERN_WARNING PREFIX
850                        "acpi_ec_space_handler: bit_width should be 8\n");
851                 return_VALUE(AE_BAD_PARAMETER);
852         }
853

I don't do any of above parameter checking in the atlas button handler
because the only parameter that is used is "address". That's what I
handoff to bus_generate_event. In my case, and unlike the ec case,
there is no embedded controller to read to get more info. To be
specific, on the board, when button 2 is pressed, I get address=1, if
button 3, I get address=2 and so on. Hence, as you can imagine, the
code in the atlas button handler below:

+	if (function == ACPI_WRITE)
+		status = acpi_bus_generate_event(dev, 0x80, address);

is a lot simpler than the ec case where they have to read stuff from
the controller as well as handle multiple bytes of reads.

856       next_byte:
857         switch (function) {
858         case ACPI_READ:
859                 temp = 0;
860                 result = acpi_ec_read(ec, (u8) address, (u32 *) & temp);
861                 break;

So to conclude, I'm not certain in what way the atlas button handler
code is weird. If you could help elaborate on what changes you would
like to see in that code, I'd be happy to change it as per your
desires.

> I suggest LCD support in hotkey.c like:
> http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view
>
>
> Config userspace acpi daemon to respond events by evoking
> LCD._BCM with command:
>        echo -n xx > /sys/hotkey/brightness.

Ok, I think maybe I sort of see what you are saying and I'll take a
look at it when I have some time.

You are suggesting that I should try to get hotkey support working
because the hotkey driver may somehow evaluate _BCM methods to affect
brightness and then to have a userspace app that is triggered by the
ASIM button support thru acpi/event which then writes to the hotkey
driver through hotkey/brightness to then go and evaluate the _BCM
method to affect the LCD brightness.

I hope I've understood what you are saying.

Thanks,
jayakumar
