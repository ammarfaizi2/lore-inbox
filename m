Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVC2HXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVC2HXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVC2HXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:23:36 -0500
Received: from host-216-252-217-242.interpacket.net ([216.252.217.242]:46059
	"EHLO forof.hylink.am") by vger.kernel.org with ESMTP
	id S262447AbVC2HCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:02:54 -0500
Message-ID: <00e901c5342d$477faed0$1000000a@araavanesyan>
From: "Ara Avanesyan" <araav@hylink.am>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>, <avila@lists.unixstudios.net>
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan> <20050127144441.GB4848@home.fluff.org> <00ae01c533a6$85ddf1f0$1000000a@araavanesyan> <Pine.LNX.4.61.0503281705230.16973@yvahk01.tjqt.qr>
Subject: Re: Strange memory problem with Linux booted from U-Boot
Date: Tue, 29 Mar 2005 12:02:30 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
To: "Ara Avanesyan" <araav@hylink.am>
Cc: <linux-kernel@vger.kernel.org>; <avila@lists.unixstudios.net>
Sent: Monday, March 28, 2005 8:06 PM
Subject: Re: Strange memory problem with Linux booted from U-Boot


> >Hi,
> >
> >I need some help on solving this strange problem.
> >Here is what I have,
> >I have a loadable module (linux.2.4.20) which contains a 2 mb static
gloabal
> >array.
> >
> >Additional information:
> >The same error occurs if I just run depmod -a.
>
> I'd be more interested in the kernel space code...
>
>
>
> Jan Engelhardt
> -- 
> No TOFU for me, please.
>

Oh, the code for kernel space is exactly the same code translated to C:
That is:

___________
#include <linux/vmalloc.h>

void mtestit(char val)
{
    char *buf;
    int i, j;
    int size = 64;
    int pass = 2 * 1024 * 1024;
    printk("starting val == %x\n", val);
    buf = vmalloc(size);
    printk("allocated memory of %d bytes. buf == %x\n", size, (int)buf);

    for (j = 0; j < pass; j++)
    {
        printk("passing %d", j);
        for (i = 0; i < size; i++)
        {
            buf[i] = val;
        }
        printk("passed\n");
    }

    printk("freeing\n");
    vfree(buf);
    printk("finished!\n");
}
___________

I call this in a module's entry point and insmod that module.
now, mtestit(0xff) works, but mtestit(0x00) crashes:(
Works fine with RedBoot. Very strange to me:)
Moreover, works fine if I do the very same thing from
within U-Boot (mw.b 100000 0 100000).

I'm interested in ideas of what could potentially be the
cause of this strange behaviour.

__
Thanks,
Ara

