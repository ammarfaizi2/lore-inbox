Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbUK3TlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUK3TlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbUK3Th6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:37:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7582 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262286AbUK3TeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:34:09 -0500
Subject: Re: Problem: Kernel Panic/Oops on shutdown with 2.6.9 and Dell
	Optiplex SX280
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       delgado@dfn-cert.de
In-Reply-To: <20041130160717.GA13106@kermit.dfn-cert.de>
References: <20041130160717.GA13106@kermit.dfn-cert.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101839437.25617.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:30:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 16:07, Friedrich Delgado Friedrichs wrote:
> We have a bunch of 15 Dell Optiplex SX280 Workstations, all running
> SuSE Linux with (nearly) unpatched 2.6.9. A few times every week, one
> of these Machines will halt upon shutdown with a kernel NULL pointer
> dereference before all services in the runlevel have been stopped. It
> always happens in one of the init scripts, but not always in the same
> ones, however it appears that the crash most often appears *after*
> arpwatch has been stopped, since the last message before a crash is
> most often "device eth0 left promiscuous mode".

Are you running some kind of sniffer tool on these machines. That
message itself is the last sniffer type application exiting. If you are
running such a tool then it tells you that the shutdown got that far
into the shutdown scripts which may help the search.

2.6.9 also has some quite nasty bugs and other problems so trying
something newer might help. 10rc2 has a fairly number of the problems
fixed and  a few new ones (eg it won't boot on some boxes) but might be
useful to at least see if you are chaasing a fixed bug. Ditto possibly
2.6.9-ac although nothing in your oops stands out and identifies with
any specific fixed bug.

d9aeffe
> esi: d86ce320   edi: 00000f07   ebp: 00000f07   esp: d744decc
> ds: 007b   es: 007b   ss: 0068
> Process fuser (pid: 16550, threadinfo=d744c000 task=deced350)
> Stack: dd9aeffe deb4d290 00000000 df518100 deb4d290 dd9ae0f8 00000000 c0171c63
>        df518100 dd9ae0f8 00000f07 d86ce320 dd9ae0f8 d86ce320 c0aa8180 c035ab84
>        c017752e 00000f08 df096f00 00000005 0000002c c0aa8180 df096f00 c0186703
> Call Trace:
>  [<c0171c63>] d_path+0x83/0xe0
>  [<c017752e>] seq_path+0x2e/0xf0
>  [<c0186703>] show_map+0xd3/0x100

The oops is at least fairly clear - at some point in the shutdown
scripts fuser
was run (quite possibly to clean up processes before unmounting a file
system).
It seems to have hit corruption in the dcache.

> nnpfs 213484 1 - Live 0xe02ad000
> subfs 12288 1 - Live 0xe01c4000

This is ARLA stuff ?

> [7.7.] Other information that might be relevant to the problem:
> 
> We're using the nnpfs module from arla 0.36.2. This appears to have
> some problems of its own:

That might be relevant given the posted oops is dcache related

> Also, one of the workstations has crashed after an external usb DVD
> burner was removed, but that was with an unofficial 2.6.8 kernel from
> SuSE.

Thats a known 2.6.x bug fixed in 2.6.10rc2 hopefully (its a collection
of SCSI bug fixes and USB fixes - removing the CD triggered quite a few
different problems). This one isn't (yet) fixed in 2.6.9-ac because of
the number and complexity of patches.

> Nov 30 14:12:07 kermit kernel: mtrr: no more MTRRs available
> Nov 30 14:12:07 kermit kernel: mtrr: 0xc0000000,0x400000 overlaps existing 0xc0000000,0x100000

X isn't very bright about MTRR overlap but it should be harmless.

Alan

