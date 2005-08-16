Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVHPTWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVHPTWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVHPTWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:22:05 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:1727 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932372AbVHPTWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:22:03 -0400
Date: Tue, 16 Aug 2005 21:29:46 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
Message-ID: <20050816192946.GB10024@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no> <Pine.LNX.4.58.0508151550360.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0508151550360.3553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 03:59:07PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 16 Aug 2005, Helge Hafting wrote:
> >
> > This was interesting.  At first, lots of kernels just kept working,
> > I almost suspected I was doing something wrong. Then the second last kernel
> > recompiled a lot of DRM stuff - and the crash came back!
> > The kernel after that worked again, and so the final message was:
> > 
> > 561fb765b97f287211a2c73a844c5edb12f44f1d is first bad commit
> 
> Ok, that definitely looks bogus. 
> 
> That commit should not matter at _all_, it only changes ppc64 specific 
> things. 
> 
> If the bug is sometimes hard to trigger, maybe one of the "good" kernels 
> wasn't good after all. That would definitely throw a wrench in the 
> bisection.
> 
The hang, or at least an X "pause" tends to happen in 5-10 minutes of
playing cuyo. (�2D game).  I have now had the last good kernel
(6ade43fbbcc3c12f0ddba112351d14d6c82ae476) running for almost 24
hours, only interrupted by the brief test of drm-less rc6.

Normal use haven't provoked anything. Since DRM sort of works with this
kernell, I tried tuxracer on the radeon.  (Trouble is always with
the radeon, never the mga xserver).  I played several games, ok
except for the usual lousy 5-9 fps. One time I had a "pause", the 3D-game
just froze for about half a minute.  The other xserver kept
displaying firefox (and updating the page too) but I could not
start any processes there.  I tried starting an xterm - it did not
appear until tuxracer "unfroze" and continued as if nothing happened. 
Perhaps the frozen process held a lock? 

Disk io seemed sluggish after that incident, and the load meter in
icewm seemed to indicate more waiting than usual.  The logs tells
me of SCSI aborts and a bus reset.  I booted into drm-less rc6 after
that.  

Some interrupts are shared on this machine:
$ cat /proc/interrupts 
           CPU0       
  0:   10113154    IO-APIC-edge  timer
  1:        371    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       5735    IO-APIC-edge  serial
  8:          0    IO-APIC-edge  rtc
 12:      11024    IO-APIC-edge  i8042
 14:         21    IO-APIC-edge  ide0
 16:     803248   IO-APIC-level  sym53c8xx, eth0, mga@pci:0000:01:00.0
 17:          0   IO-APIC-level  Trident Audio
 19:     755535   IO-APIC-level  radeon@pci:0000:00:08.0
 20:       5946   IO-APIC-level  libata
 21:       9448   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, 
uhci_hcd:usb4
NMI:        234 
LOC:   10111810 
ERR:          0
MIS:          0

The troublesome radoen has a irq of its own.  The scsi controller
shares irq with the matrox g550, but that card never seem to
cause any trouble, other than saturating the cpu during games. :-)

On to look at iomem and that rc6 crash.

Helge Hafting
