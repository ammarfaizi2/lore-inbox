Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTJFM7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJFM7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:59:32 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:44788 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262038AbTJFM73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:59:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16257.26407.439415.325123@gargle.gargle.HOWL>
Date: Mon, 6 Oct 2003 14:59:19 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: root@chaos.analogic.com
Cc: Dave Jones <davej@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <Pine.LNX.4.53.0310060834180.8593@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos>
	<20031003235801.GA5183@redhat.com>
	<Pine.LNX.4.53.0310060834180.8593@chaos>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
 > On Sat, 4 Oct 2003, Dave Jones wrote:
 > 
 > > On Fri, Oct 03, 2003 at 01:25:30PM -0400, Richard B. Johnson wrote:
 > >  > In linux-2.4.22 and earlier, if there is no FDC driver installed,
 > >  > the FDC motor may continue to run after boot if the motor was
 > >  > started as part of the BIOS boot sequence.
 > >  > This patch turns OFF the motor once Linux gets control.
 > >  >
 > >  >
 > >  > --- linux-2.4.22/arch/i386/boot/setup.S.orig	Fri Aug  2 20:39:42 2002
 > >  > +++ linux-2.4.22/arch/i386/boot/setup.S	Fri Oct  3 11:50:43 2003
 > >  > @@ -59,6 +59,8 @@
 > >
 > > Does this mean the 'kill_motor' function in bootsect.S isn't doing
 > > what it should be? If so, maybe that needs fixing instead of turning
 > > it off in two places ?
 > >
 > > 		Dave
 > 
 > Yes. I didn't even see that. The code there makes me kinda sick.
 > Anyway, the kill_motor function executes "reset diskette/disk" function
 > which will never turn OFF the drive. Instead, it will restart
 > the motor timer because, as a condition of reseting the diskette,
 > it must make sure the motor is running.
 > 
 > I suggest that the FDC control byte be read, then the result be
 > ANDed with ~0x10, then written back. The ifed-out code clears
 > the whole control word which is inappropriate at a time the
 > diskette channel may be still be active.

Do NOT do any outbs to the FDC unless you've done the equivalent of
the HW detection done in the floppy driver. The BIOS call in kill_motor
is a workaround for the fact that the original raw accesses lock up
the FDCs in some SuperIO chips (including the one in my ASUS P4T-E).

The floppy driver gets it right, but it also does HW detection
first and does the reset differently for non-ancient FDCs.

/Mikael
