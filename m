Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTKLWfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 17:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTKLWfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 17:35:53 -0500
Received: from gaia.cela.pl ([213.134.162.11]:6410 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261681AbTKLWfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 17:35:48 -0500
Date: Wed, 12 Nov 2003 23:35:16 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Solar Designer <solar@openwall.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311120824450.3288-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311122319580.18399-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It really looks like this patch just triggers the real issue. I can't
> even begin to speculate _how_ it would trigger it, though. At a guess,
> it might just trigger a bug in the X server that might depend on how the
> mmap's are laid out - and the strace might be needed just to get a lot
> of scheduling activity and a large stream of X events (without it, the
> pty connection to the xterm would mostly end up "chunking" the output of
> the "ls -lR" and xterm would end up doing a lot more fastscrolls).

strace ls -lR => dies
strace ls -lR 2>/dev/null => dies.
strace ls -lR  >/dev/null => dies.
strace ls -lR 2>/dev/null >/dev/null => doesn't die.
[only dies during ide disk IO in an xterm under X]

> Just a theory.

> Do you have another machine on the network? In particular, some crashes
> under X are literally just the X server crashing. Sometimes that takes 
> the whole machine down with it (if it causes X to do stuff to the video 
> card that the video card really doesn't like), but quite often you can 
> still ping the machine and maybe log in remotely even when it appears 
> otherwise dead.

As I've said it doesn't respond to pings.  As far as I can tell the 
processor might as well be doing a cli hlt.  As for X - I've had X crash 
(many) times and never in an unrestorable way - usually you can login from 
the network or hit my hotkey Fn+\ for bios vm86 int 10 screen reset...

> Ok. The nice thing about getting a serial console is that now you could 
> try the NMI watchdog - just boot up with "nmi_watchdog=1" on the kernel 
> command line (or "=2" - see Documentation/nmi_watchdog.txt for more 
> information on it). 
> 
> That won't necessarily see the problem either, especially if it's a total 
> hardware lockup brought on by X poking registers in unfortunate ways, but 
> if it's a pure kernel lockup with interrupts disabled, it can help.

OK, I've tried the NMI watchdog with no luck, for both =1 and =2, Celeron 
Mendocino 400 MHz CPU, any ideas?  I can't see the NMI count in 
/proc/interrupts being incremented.  The NMI watchdog welcome message 
shows up on boot (but there is no local APIC).

At the moment I'm thinking this might be caused by graphics acceleration, 
I'm gonna try with a VGA16 Xserver...

Furthermore I tried booting a minimal statically linked (no modules) and 
min options 2.4.23rc1 + bug triggering patch kernel on this laptop and 
another stationary P3 1GHz.  The laptop crashes as expected - but the 
stationary one works no problem - still this is a total exchange of 
everything... CPU/MEM/video card/IDE controller/mainboard, different 
program versions (laptop RH9, stationary Fedora 1)... there's just too 
many possibilities to pin it down.

nb. Linus, if you could answer one tiny question - how would I go about 
reading seg:ofs memory of a ptraced process from the ptracer if seg isn't 
the normal user_ds but something more wild?  I'm assuming I'd have to read 
the segment registers descriptor code32/addr32/limit/base add the base to 
ofs and ptrace(PEEKDATA) with base+ofs as the address... I'd really be 
grateful - I'm working on an iotrace utility and am lacking this for full 
functionality (without going about it the hardway of patching the user 
code of the ptraced process to perform the memory access, continuing
the child, it performs the access, faults on an int 3, returns to the
ptraceing parent, which unpatches the child, backs up eip, does whatever 
I wanted with the data, and continues on with life...)

Cheers,

MaZe.

