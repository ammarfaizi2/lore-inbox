Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129632AbQKWXNz>; Thu, 23 Nov 2000 18:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129903AbQKWXNp>; Thu, 23 Nov 2000 18:13:45 -0500
Received: from toesinperil.com ([216.207.184.47]:6405 "HELO toesinperil.com")
        by vger.kernel.org with SMTP id <S129632AbQKWXN3>;
        Thu, 23 Nov 2000 18:13:29 -0500
Date: Thu, 23 Nov 2000 14:45:17 -0800
From: Michael Elkins <me@sigpipe.org>
To: Rui Sousa <rsousa@grad.physics.sunysb.edu>, usb@in.tum.de,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci and emu10k1
Message-ID: <20001123144517.A31910@toesinperil.com>
In-Reply-To: <20001123020203.A30491@toesinperil.com> <Pine.LNX.4.21.0011231028030.17678-100000@grad.physics.sunysb.edu> <20001123174952.B7591@in.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.10i
In-Reply-To: <20001123174952.B7591@in.tum.de>; from acher@in.tum.de on Thu, Nov 23, 2000 at 05:49:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 05:49:52PM +0100, Georg Acher wrote:
> On Thu, Nov 23, 2000 at 04:35:33PM +0000, Rui Sousa wrote:
> > On Thu, 23 Nov 2000, Michael Elkins wrote:
> > 
> > Usb controller is sharing a interrupt with the emu10k1.
> > For what I know the emu10k1 driver doesn't have any problem
> > sharing irq's, so I would blame the usb driver...
> 
> usb-uhci doesn't also have any problem with sharing irqs:
> 
> > cat /proc/interrupts
>  10:    5597981          XT-PIC  aic7xxx, eth0, usb-uhci
> 
> Hm, no one left to blame...
> I would debug it as follows:
> Place various printks in the initialization code (reset_hc(), start_hc() and
> alloc_uhci) and find out after which printk it hangs. Then it would be
> possible to investigate this further...

It hangs in start_uhci():

		/* disable legacy emulation */
		pci_write_config_word (dev, USBLEGSUP, USBLEGSUP_DEFAULT);

The loop that the call is in gets iterated 5 times.  For i < 4, the
		if (!(dev->resource[i].flags & 1))
is TRUE, but on i==4, it drops into the bottom of the loop to execute
check_region() and then pci_write_config_word(), where it hangs.

This only seems to be a problem for initialization.  If  I load the
usb-uhci.o module before the emu10k1.o module, everything works perfectly
(no lockups).

me
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
