Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUAOCVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266403AbUAOCVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:21:30 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:55424 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S264505AbUAOCV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:21:28 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16389.63781.783923.930112@jik.kamens.brookline.ma.us>
Date: Wed, 14 Jan 2004 21:21:25 -0500
To: linux-kernel@vger.kernel.org
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
In-reply-to: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
Subject: Updated on UDMA BadCRC errors + subsequent problems
  (was: Is it safe to ignore UDMA BadCRC errors?)
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'd like to provide an update on my efforts to understand what causes
"DriveStatusError BadCRC" errors when using UDMA drives, how to debug
these errors in general, the specific progress I've made at resolving
these errors on my system, and subsequent problems I've encountered
when doing so.

Recall that I was getting these errors from 2.4.22-ac4 on my
dual-processor (550MHz Pentium III Katmai) system:

  hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

from a Seagate 160GB drive (ST3160021A) plugged into its own channel
on a Promise Ultra66 (PDC20262) controller.

The suggestion most frequently given to me and others for resolving
BadCRC errors is to replace the IDE cable with one that conforms to
the Ultra ATA spec (80-conductor, flat, two drive connectors, single
drive connected to the end connector).  I tried several such cables,
none of which made the BadCRC errors go away.

Other suggestions given to me included:

* Make sure the IDE cable is not running parallel to another cable.
* Make sure the cable is not passing near magnets inside the case,
  e.g., speaker magnets.
* Update the IDE controller's firmware.
* Check to make sure the PCI bus speed is valid (33MHz, normally).
* Make sure the PCI latency timer is set in the BIOS to at least 64.

I tried all of these suggestions, and none of them worked.

I tried swapping the drives on the controller's two channels, and the
BadCRC errors traveled with the drive.  Then I swapped the cables on
the two channels, and the errors still remained on the same drive.

Next, I bought a SIIG Ultra ATA 133 controller, compiled SIIMAGE
support into my kernel, plugged in the new SIIG controller, and moved
the drive getting the BadCRC errors over to it.  They stopped -- I
haven't seen a single BadCRC error since I moved the drive to the SIIG
controller a couple of weeks ago.

Alas, another problem has presented itself.  Twice after I installed
the SIIG controller and moved the Seagate drive to it, my system hung
(all activity seemed to stop, syslogd stopped logging, X server
stopped responding, couldn't switch VTs).  Both times, Alt-SysRq-s and
Alt-SysRq-u appeared to have no effect, but Alt-SysRq-b successfully
rebooted the system.  I couldn't get any more information because I
don't have a serial console and my monitor was in X when the hang
happened; since I couldn't switch VT's I couldn't get to one where the
magic SysRq sequences would display information.

After the second hang, I tried two more things -- moving the other
drive to the SIIG controller, such that the Promise controller no
longer has any drives on it (but it's still plugged in, and also, my
motherboard's PIIX4 controller still has a hard drive, CD-ROM and
OnStream DI-30 drive plugged into it as hda, hdc and hdd
respectively), and turning off unmask IRQ for the drives on the SIIG
controller, as suggested in other messages here.  Unfortunately, even
with these two additional steps, I'm still seeing kernel hangs, albeit
seemingly less frequently -- I just had another one about an hour ago.

I've just enabled the NMI watchdog, compiled software watchdog support
into my kernel and installed and enabled the watchdog daemon.  If
anyone can suggest anything else I can do to debug these hangs, I'm
all ears.

Thanks for reading this far. :-)

  Jonathan Kamens
