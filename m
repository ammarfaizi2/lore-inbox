Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289049AbSAIWTb>; Wed, 9 Jan 2002 17:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAIWTR>; Wed, 9 Jan 2002 17:19:17 -0500
Received: from mail.zeelandnet.nl ([212.115.192.194]:48079 "HELO
	mail.zeelandnet.nl") by vger.kernel.org with SMTP
	id <S289054AbSAIWRp>; Wed, 9 Jan 2002 17:17:45 -0500
Message-ID: <005401c19953$3139c750$7800a8c0@darkskywinblow>
From: "Dennis Fleurbaaij" <dennis@core-lan.nl>
To: <linux-kernel@vger.kernel.org>
Subject: arch/i386/kernel/pci-irq.c
Date: Wed, 9 Jan 2002 22:18:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm sorry for my last posting, it seems that there are many ways to
incidently hit the send mail button.

I have stumbled upon an error in linux 2.4 that prevents my laptop from
using it's PCMCIA and PS2 mouse together. This is with every known 2.4
kernel and is a result of the BIOS not acknowleging the cardbus controller.
This problem was posted a couple of times to the lkm but has never been
fixed.

A simple solution is offered by suse in the form of a lilo trick. As can be
read in:
http://sdb.suse.de/en/sdb/html/pcmcia_install_kernel2.4.x.html. There is
also another problem description there.

In anycase I've been working to get rid of the bug without having to apply
tricks. The solution as it seems is very simple.

The problem is a follows:

If the kernel detects the controllers (there are 2 of them) it find that
thay both have an IRQ of 255 set by the bios. This is ofcourse rediculous.
It also finds ou that they have a irq map of f000 which is to use only irq
12, 13 and 14. The secont time that the IRQ handler is called is when the
yenta driver (i guess) orders the card to be found. This triggers a loop
that will search for a free IRQ. This loop is located inside
arch/i386/kernel/pci-irq.c line 574.

Now with that mapping, we are nearly guaranteed to cllide with either PS/2
or ide. And that is exactly what happens. This is avoided by allowing the
device to also look at the 'free' irq's 5, 8-11. this is done by adding the
bitmask of those irq's.

Just below the if statement on line 573 and above the loop place the code

mask |= 0x1e60;

that will allow linux to circumvent my braindead BIOS. In my computer it
also has the advantage of spreading the 2 controllers to 2 free IRQ's which
(in theory) should allow for more efficient communications. If the space
gets really cramped they both are put on the same irq, which is hwo it was
originally meant.

I hope that you will make this mainstream or give me pointers where to look
next in order to get rid of this bug.

-
I hope that I didn't waste any of your time.
Dennis Fleurbaaij
dennis@core-lan.nl

