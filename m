Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVJBExX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVJBExX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 00:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVJBExX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 00:53:23 -0400
Received: from asclepius2.uwa.edu.au ([130.95.128.59]:2283 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S1750969AbVJBExX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 00:53:23 -0400
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Sun, 2 Oct 2005 12:53:15 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: lokum spand <lokumsspand@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051002045315.GA20946@ucc.gu.uwa.edu.au>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
X-SpamTest-Info: Profile: Formal (269/050913)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 01:30:22PM -0800, lokum spand wrote:
> Suppose Linux could save the total state of a program to disk, for
> instance, imagine a program like mozilla with many open windows. I give
> it a SIGNAL-SAVETODISK and the process memory image is dropped to a
> file. I can then turn off the computer and later continue using the
> program where I left it, by loading it back into memory.

www.checkpointing.org lists several solutions for this.

I'm the author of CryoPID[1] - it's a checkpointing program that
allows you to save the state of a process to a file without any
prior thought when linking or running the process. It won't handle
an entire mozilla process, but single-threaded console-based apps
are quite feasible.  Migration between machines works too - 2.6 to
2.6 works, 2.4 to 2.4 works, 2.6 to 2.4 works, and 2.4 to 2.6 mostly
works with some TLS emulation (which might be incomplete, but can
always be improved).

Open files are reopened. Opened temporary files (unlinked) could
potentially be restored by scraping the contents out of the file
while the process in question has it open.

Networking isn't too bad really so long as you keep the same IP. TCP
sockets can be handled by tcpcp[2] which is already supported by
CryoPID. UDP sockets are pretty trivial, but not yet done. For both
of these to be reliable though, there needs to be some sort of
arrangement to drop packets on these connections whilst they are
suspended and not have the kernel send an RST back. (Thinking a
daemon that drives some iptables).

Unix sockets are indeed trickier. Mostly this is for X applications,
and for this I'm actually looking towards toolkit-based solutions as
apps can't be expected to deal with things like colour depth changes
and so on.  Gtk+ can already migrate applications between displays,
with the only issue being that not all the resources tied to the
original X server are freed, so you can't lose it. This is scheduled
to be fixed for Gtk+ 2.10 though, so I'm holding out hope for this.

Multithreading or even multiple processes will be a fun one though.
Ditto for shared memory and other IPC stuff.  Determined that it's
possible, just not sure how yet. :)

As for portability, it was written for x86 and has been ported to
AMD64, and I'm also in the middle of porting it to sparc. (ppc and
alpha planned too).

Yes, it has to do some pretty vile things to avoid modifying the
kernel or userspace programs, but it's quite suitable for doing
things like backing up your irssi sessions hourly, saving
computational jobs across a reboot or moving them to another
machine, or showing off features of an application.

Bernard.

[1] http://cryopid.berlios.de/
[2] http://tcpcp.sf.net/

