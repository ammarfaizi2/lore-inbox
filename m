Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131101AbQKWXjJ>; Thu, 23 Nov 2000 18:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131118AbQKWXiv>; Thu, 23 Nov 2000 18:38:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48901 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S131101AbQKWXil>;
        Thu, 23 Nov 2000 18:38:41 -0500
Message-ID: <3A1DA2F7.94114CD2@mandrakesoft.com>
Date: Thu, 23 Nov 2000 18:06:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Elkins <me@sigpipe.org>
CC: Rui Sousa <rsousa@grad.physics.sunysb.edu>, usb@in.tum.de,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci and 
 emu10k1
In-Reply-To: <20001123020203.A30491@toesinperil.com> <Pine.LNX.4.21.0011231028030.17678-100000@grad.physics.sunysb.edu> <20001123174952.B7591@in.tum.de> <20001123144517.A31910@toesinperil.com>
Content-Type: multipart/mixed;
 boundary="------------6B398BD2C93DDD91A1A366A3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B398BD2C93DDD91A1A366A3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Michael Elkins wrote:
> 
> On Thu, Nov 23, 2000 at 05:49:52PM +0100, Georg Acher wrote:
> > On Thu, Nov 23, 2000 at 04:35:33PM +0000, Rui Sousa wrote:
> > > On Thu, 23 Nov 2000, Michael Elkins wrote:
> > >
> > > Usb controller is sharing a interrupt with the emu10k1.
> > > For what I know the emu10k1 driver doesn't have any problem
> > > sharing irq's, so I would blame the usb driver...
> >
> > usb-uhci doesn't also have any problem with sharing irqs:
> >
> > > cat /proc/interrupts
> >  10:    5597981          XT-PIC  aic7xxx, eth0, usb-uhci
> >
> > Hm, no one left to blame...
> > I would debug it as follows:
> > Place various printks in the initialization code (reset_hc(), start_hc() and
> > alloc_uhci) and find out after which printk it hangs. Then it would be
> > possible to investigate this further...
> 
> It hangs in start_uhci():
> 
>                 /* disable legacy emulation */
>                 pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);
> 
> The loop that the call is in gets iterated 5 times.  For i < 4, the
>                 if (!(dev->resource[i].flags & 1))
> is TRUE, but on i==4, it drops into the bottom of the loop to execute
> check_region() and then pci_write_config_word(), where it hangs.

It may not make a difference, but that check is flat out wrong.

Apply this patch...  (untested, you may need to include ioport.h)

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
--------------6B398BD2C93DDD91A1A366A3
Content-Type: text/plain; charset=us-ascii;
 name="usb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb.patch"

Index: drivers/usb/usb-uhci.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/usb/usb-uhci.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 usb-uhci.c
--- drivers/usb/usb-uhci.c	2000/10/22 23:25:12	1.1.1.9
+++ drivers/usb/usb-uhci.c	2000/11/23 23:04:37
@@ -2886,7 +2886,7 @@
 		unsigned int io_addr = dev->resource[i].start;
 		unsigned int io_size =
 		dev->resource[i].end - dev->resource[i].start + 1;
-		if (!(dev->resource[i].flags & 1))
+		if (!(dev->resource[i].flags & IORESOURCE_IO))
 			continue;
 
 		/* Is it already in use? */

--------------6B398BD2C93DDD91A1A366A3--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
