Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTAKNpV>; Sat, 11 Jan 2003 08:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTAKNpV>; Sat, 11 Jan 2003 08:45:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21140
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267217AbTAKNpU>; Sat, 11 Jan 2003 08:45:20 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3iswv27o3.fsf@averell.firstfloor.org>
References: <20030110165441$1a8a@gated-at.bofh.it>
	 <20030110165505$38d9@gated-at.bofh.it>
	 <m3iswv27o3.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042295999.2517.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Jan 2003 14:39:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 12:27, Andi Kleen wrote:
> Can you quickly summarize what is broken with IDE ?
> Are just some low level drivers broken or are there some generic
> nasty problems.
> 
> If it is just some broken low level drivers I guess they can 
> be marked dangerous or CONFIG_EXPERIMENTAL.

Low level drivers are basically sorted.

The main problems are
  - Incorrect locking all over the place
  - Incorrect timings on some phases
  - Some ioctls can cause crashes due to locking
  - ISAPnP IDE doesn't work right now
  - Flaws in error recovery paths in certain situations
  - Lots of random oopses on boot/remove that were apparently
    introduced by the kobject/sysfs people and need chasing
    down. (There are some non sysfs ones mostly fixed)
  - ide-scsi needs some cleanup to fix switchover ide-cd/scsi
    (We can't dump ide-scsi)
  - Unregister path has races which cause all the long
    standing problems with pcmcia and prevents pci unreg
  - PCI IDE driver registration needs busy checks
  - PCI layer needs some stuff from 2.4
  - PCI layer in 2.4/2.5 needs an IRQ bug fixing
  - ACPI doesn't seem to handle compatibility IRQ mode
  - We don't handle a few errata (MWDMA on 450NX for example)
  - IDE raid hasn't been ported to 2.5 at all yet

Thats off the top of my head right now.

> How does it differ from the code that was just merged into 2.4.21pre3
> (has the later all the problems fixed?)

No, although some don't show up in the same ways in 2.4 - eg the pcmcia
unload race is rare in 2.4 for other reasons. Endianism should all
be cured in 2.4, and I sent that to Linus. The PCI i/o assignment code
in 2.4 is done. I hope to have some of the locking and also the timing
path work Ross Biro has done in for 2.4.22 proper

> > broken and nobody has even started fixing it. Just try a mass of parallel
> > tty/pty activity . It was problematic before, pre-empt has taken it  to dead, 
> > defunct and buried. 
> 
> Can someone shortly describe what is the main problem with TTY?
> 
> >From what I can see the high level tty code mostly takes lock_kernel
> before doing anything.

Which works really well with all the IRQ paths on it

> On reads access to file->private_data is not serialized, but it at 
> least shouldn't go away because VFS takes care of struct file
> reference counting.

The refcounting bugs are/were in the ldisc stuff. I thought the
bluetooth folks (Max and co) fixed that one

If we can lock_kernel the tty layer for now (I'm bothered about
the ldisc end of tht which is IRQ context) then great, tty scaling
is suddenelly a 2.7 problem.

