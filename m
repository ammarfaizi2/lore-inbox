Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSHBPRc>; Fri, 2 Aug 2002 11:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSHBPRc>; Fri, 2 Aug 2002 11:17:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2177 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315257AbSHBPRb>; Fri, 2 Aug 2002 11:17:31 -0400
Date: Fri, 2 Aug 2002 11:23:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ioremap_nocache(0xfffe0000, 0x00020000);
Message-ID: <Pine.LNX.3.95.1020802111956.6884A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The AMD SC-520 board uses a 128k BIOS ROM which is decoded
at 0xfffe0000. Of course the real BIOS  starts 1/2 way through
it at 0xffff0000. This gets shadowed to F000:0000 in 'real-mode'
as part of the boot sequence.

I want to re-program that BIOS PROM from a driver in Linux.
I find that ioremap_nocache(0xfffe0000, 0x00020000) seems to
'Work', i.e., returns some non-null cookie. However, I can't
access the BIOS ROM. I am accessing something, but it's something
in low memory, not the PROM that is quite identifiable.

/proc/iomem does not show my allocation and says, in fact, that
it's been 'reserved'. I can't understand such a 'reservation' because
I didn't reserve it and I wrote the BIOS.

fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


Snippit from module init...


#define PROM_BASE 0xfffe0000
#define PROM_LEN  0x00020000 (also tried 0x0001ffff)



int __init init_module()
{
    int result;
    if((cp = (UC *) ioremap_nocache(PROM_BASE, PROM_LEN)) == NULL)
    {
        printk(KERN_ERR"%s : Can't access PROM\n", dev);
        return -EACCES;
    }

If I do:

        if(copy_to_user((UC *)arg, cp, PROM_LEN))
            return -EFAULT;

... as an ioctl() with the passed arg, and cp being the cookie from
ioremap_nocache()... This hangs (forever) with no panic(). If I
copy first to a kmalloc() buffer, then to the user, it goes okay,
but it's not the PROM image, it's something within the kernel's
RAM that I'm looking at.

Anybody got any hints? FYI, If I substitute other addresses, I can
access other PROMS including the Adaptec PROM in its controller
via PCI, plus the shadowed one in low RAM. Same with screen-card
BIOS. There seems to be something about the 0xfffe0000 address that
the kernel doesn't like.  Also, from user-mode, I can't mmap any
addresses above about 0xbfffffff. This may be part of the same problem.

Anybody have any idea?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

