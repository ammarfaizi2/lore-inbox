Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTFAOoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFAOoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:44:16 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:35542 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S264634AbTFAOoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:44:13 -0400
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
References: <3EDA0E5D.8080404@pacbell.net>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 01 Jun 2003 16:57:35 +0200
In-Reply-To: <3EDA0E5D.8080404@pacbell.net>
Message-ID: <87znl1g80w.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Brownell <david-b@pacbell.net> writes:

> > I'm trying to nail own a problem here, with my shiny new Maxtor 250Gb
> > USB 2.0 disk. Under 2.4 (vanilla, latest 21-preX and 21-preX-acY) the
> > disk will mount and talk nicely. As soon as any load hits it, e.g. a
> > single cp from my internal CD-ROM to the disk, the mahcine load will
> > sky-rocket and at some point within a few minuter hang the machine.
> > On 2.5 (vanilla and -mm) the load will show as i/o-wait and at some
> > point hang any access to the drive, but the kernel will go on working.
> 
> That's a big clue -- nothing in the USB code ever shows up
> as "i/o wait".  It can't, since USB is usually built as
> modules and things like io_schedule() are, for some odd
> reason, never exported for use in modules.  So USB I/O
> can't use them, and won't show up as "i/o" ... and that
> load must come from some place other than USB.
> 
> There are some patches that really ought to get merged
> into the 2.4.21 release (2.5.70 has both of these), but
> they shouldn't affect anything with an "i/o wait" symptom.
> 

Here's the output from about one minute of cp'ing to the disk on an
idle machine:

top - 16:51:17 up 16:37,  8 users,  load average: 3.59, 1.43, 0.70
Tasks:  85 total,   3 running,  82 sleeping,   0 stopped,   0 zombie
Cpu(s):   7.0% user,   2.0% system,   0.0% nice,   0.0% idle,  91.0% IO-wait
Mem:    775072k total,   772444k used,     2628k free,     2820k buffers
Swap:   136040k total,    14372k used,   121668k free,   600664k cached

Both the load and the percentage of time marked as "io-wait" is
completely bogus.

I ran procinfo too, to dump irq stats, and it ran with ~2k interrupts
per 10 secs (matching numer of irq's for the ide-system where the file
comes from) and at some point it does, no message in the kernel
log. Currently it's doing about 20 interrupts per 10 seconds and the
cp command cannot be broken off.

Doing a ps -efadl for the cp command yiled this:

0 D alexh    25915  4861  1  75   0 -   845 io_sch 16:49 pts/3 00:00:05 cp

and if it's of any use, it's /proc/$PID/status file contains this:

alexh@lapper /proc/25915 $ cat status
Name:   cp
State:  D (disk sleep)
Tgid:   25915
Pid:    25915
PPid:   4861
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    100     100     100     100
FDSize: 256
Groups: 100 5 10 18 19 35 80
VmSize:     3380 kB
VmLck:         0 kB
VmRSS:      1376 kB
VmData:       20 kB
VmStk:        12 kB
VmExe:        48 kB
VmLib:      1228 kB
SigPnd: 0000000000000100
ShdPnd: 0000000000000002
SigBlk: 0000000080000000
SigIgn: 8000000000000000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000ffffffff
CapEff: 00000000fffffeff

and wchan says "io_schedule".

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+2hRcCQ1pa+gRoggRAgtSAJsGsxr3Bo+TG6KPpP7mK4IJ1pphXQCfcBqE
Vy2EVyvseC9L6OmNd6P/3PM=
=U4HH
-----END PGP SIGNATURE-----
