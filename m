Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUBVQbC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUBVQbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:31:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39692 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261692AbUBVQao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:30:44 -0500
Date: Sun, 22 Feb 2004 16:30:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Silla Rizzoli <silla@netvalley.it>
Cc: daniel.ritz@gmx.ch, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Message-ID: <20040222163038.A23746@flint.arm.linux.org.uk>
Mail-Followup-To: Silla Rizzoli <silla@netvalley.it>, daniel.ritz@gmx.ch,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200402202331.45218.daniel.ritz@gmx.ch> <200402211328.56826.silla@netvalley.it> <200402211812.14040.daniel.ritz@gmx.ch> <200402221703.55235.silla@netvalley.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402221703.55235.silla@netvalley.it>; from silla@netvalley.it on Sun, Feb 22, 2004 at 05:03:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 05:03:54PM +0100, Silla Rizzoli wrote:
> This is dmesg after bootup completes: if I insert the card nothing happens, 
> but if I start X, the card gets magically recognized and initialized! 
> The following lines are added to dmesg:

This probably occurs because starting X caused AGP to be initialised,
which caused an interrupt on IRQ11.  Since the cardbus bridge is also
using IRQ11 to report status changes, we notice the status change.

So, the reason this went wrong _appears_ to be because we never received
the interrupt from the cardbus bridge, although the cardbus status
correctly indicated there was work to be done.

Also, you seem to have some proprietary modules loaded - have you tried
running without these modules loaded?  (See below.)

> airo_cs                 4004   0 (unused)
> airo                   49048   0 [airo_cs]
> ds                      7028   1 [airo_cs]
> yenta_socket           11072   1
> pcmcia_core            47328   0 [airo_cs ds yenta_socket]
> aes                    31200   1 (autoclean)
> radeon                106816   0
> agpgart                19312   1 (autoclean)
> ide-cd                 32416   0 (autoclean)
> sr_mod                 14392   0 (autoclean) (unused)
> cdrom                  29248   0 (autoclean) [ide-cd sr_mod]
> scsi_mod               87712   1 (autoclean) [sr_mod]
> mousedev                4372   0
> hid                    21988   0 (unused)
> input                   3616   0 [mousedev hid]
> hci_usb                 6648   0 (unused)
> bluez                  32996   1 [hci_usb]
> uhci                   25948   0 (unused)
> ehci-hcd               18764   0 (unused)
> slamr                 247108   0 (unused)

This seems to be a closed source modem driver, which seems to be using
IRQ11.  This is definitely one thing to try removing and seeing if the
problem goes away.  (By "removing" here I mean _never_ having been
loaded since boot - any other type of "removing" will not give the
desired test conditions required to correctly isolate the problem.)

> snd-pcm-oss            39492   0 (unused)
> snd-mixer-oss          13648   0 [snd-pcm-oss]
> snd-intel8x0           19428   0 (autoclean)
> snd-pcm                62980   0 (autoclean) [snd-pcm-oss snd-intel8x0]
> snd-ac97-codec         43256   0 (autoclean) [snd-intel8x0]
> snd-page-alloc          6676   0 (autoclean) [snd-intel8x0 snd-pcm]
> snd-mpu401-uart         3376   0 (autoclean) [snd-intel8x0]
> snd-rawmidi            14048   0 (autoclean) [snd-mpu401-uart]
> snd-seq-oss            29632   0 (unused)
> snd-seq-midi-event      3552   0 [snd-seq-oss]
> snd-seq                37040   2 [snd-seq-oss snd-seq-midi-event]
> snd-timer              14852   0 [snd-pcm snd-seq]
> snd-seq-device          4400   0 [snd-rawmidi snd-seq-oss snd-seq]
> snd                    34148   0 [snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
> soundcore               3940   5 [snd]
> rtc                     7080   0 (autoclean)
> usbcore                63852   1 [hid hci_usb uhci ehci-hcd]
> ipv6                  171924  -1
> e100                   49992   0 (unused)
> unix                   15468   5 (autoclean)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
