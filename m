Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270356AbUJUJLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270356AbUJUJLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUJTSuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:50:54 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:54451 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268989AbUJTSpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:45:03 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Pavel Machek <pavel@ucw.cz>
Date: Wed, 20 Oct 2004 11:44:51 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <41764FB3.29782.1B9A13F4@localhost>
In-reply-to: <20041020173102.GB19940@elf.ucw.cz>
References: <41763777.27136.1B3B687B@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> > > BTW, does this look like right way to POST VGA BIOS from real
> > > mode? It is what we currently use... and it works on some
> > > machines... 
> > > 
> > >         movw    $0xb800, %ax
> > >         movw    %ax,%fs
> > >         movw    $0x0e00 + 'L', %fs:(0x10)
> > 
> > What is this for?
> 
> Debugging.

Ok ;-)

> > >         cli
> > >         cld
> > > 
> > >         # setup data segment
> > >         movw    %cs, %ax
> > >         movw    %ax, %ds                                        # Make ds:0 point to wakeup_start
> > >         movw    %ax, %ss
> > >         mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
> > >         movw    $0x0e00 + 'S', %fs:(0x12)
> > 
> > We have never needed to set up a private stack. What ASUS board was it 
> > that you had problems with and needed to do this for?
> 
> This is running at system resume, so it is not normal boot. Some
> ASUS Athlon 900MHz machine needed this; I'm no longer using this
> one. 

Ok. For the BIOS emulator the code always has it's own local stack anyway 
so I assume the problme you had may have been that the BIOS on the board 
was using too much stack space, so setting up a local stack that is big 
enough is probably a good idea.

> > >         pushl   $0                                              # Kill any dangerous flags
> > >         popfl
> > > 
> > >         movl    real_magic - wakeup_code, %eax
> > >         cmpl    $0x12345678, %eax
> > >         jne     bogus_real_magic
> > > 
> > >         testl   $1, video_flags - wakeup_code
> > >         jz      1f
> > >         lcall   $0xc000,$3
> > 
> > The call to 0xC000:0x0003 is the entry point to POST the card. However 
> > for PCI cards you need to make sure that AX is loaded with the bus, slot 
> > and function for the card that is being POST'ed. It will pass this value 
> > to the PCI BIOS Int 0x1A functions in order to find itself, so if this is 
> > not set many BIOS'es will not work.
> 
> Ok, this one is bad... ... In case of just one vga adapter, we
> should be able to store its parameters in some well-known place.
> For more than one adapter, we'll definitely need to run BIOS in
> emulator. 

Yes. If you are running this in real mode you don't have any option but 
to use the BIOS emulator. If you are running in protected mode and using 
vm86() style service, the 0xC0000 memory is just memory and can be re-
written. For instance on Linux you can map 0xC0000 into your process 
address space as copy on write, which then allows you to re-write the 
BIOS image for a secondary controller and then restore it when you are 
done.

But you will also need to make sure you can hook the Int 0x1A interrupt 
to hide any other graphics cards on the bus as some BIOS'es are pretty 
stupid and will find the first card on the bus that matches their 
Vendor/Device ID's. So if you have two of the same card, it will find th 
wrong one ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


