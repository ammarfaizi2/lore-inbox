Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268755AbUJTRWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbUJTRWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268711AbUJTRDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:03:19 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:22446 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268683AbUJTRBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:01:49 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Pavel Machek <pavel@ucw.cz>
Date: Wed, 20 Oct 2004 10:01:27 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <41763777.27136.1B3B687B@localhost>
In-reply-to: <20041019211114.GC1142@elf.ucw.cz>
References: <416E6ADC.3007.294DF20D@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> BTW, does this look like right way to POST VGA BIOS from real
> mode? It is what we currently use... and it works on some
> machines... 
> 
>         movw    $0xb800, %ax
>         movw    %ax,%fs
>         movw    $0x0e00 + 'L', %fs:(0x10)

What is this for?

>         cli
>         cld
> 
>         # setup data segment
>         movw    %cs, %ax
>         movw    %ax, %ds                                        # Make ds:0 point to wakeup_start
>         movw    %ax, %ss
>         mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
>         movw    $0x0e00 + 'S', %fs:(0x12)

We have never needed to set up a private stack. What ASUS board was it 
that you had problems with and needed to do this for?

>         pushl   $0                                              # Kill any dangerous flags
>         popfl
> 
>         movl    real_magic - wakeup_code, %eax
>         cmpl    $0x12345678, %eax
>         jne     bogus_real_magic
> 
>         testl   $1, video_flags - wakeup_code
>         jz      1f
>         lcall   $0xc000,$3

The call to 0xC000:0x0003 is the entry point to POST the card. However 
for PCI cards you need to make sure that AX is loaded with the bus, slot 
and function for the card that is being POST'ed. It will pass this value 
to the PCI BIOS Int 0x1A functions in order to find itself, so if this is 
not set many BIOS'es will not work.

The rest of the code you have above seems superfluous to me as we have 
never needed to do that. Then again we boot the card using the BIOS 
emulator, which is different because it runs within a protected machine 
state.

Have you taken a look at the X.org code? They have code in there to POST 
the video card also (either using vm86() or the BIOS emulator).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


