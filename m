Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUKVEGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUKVEGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 23:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUKVEGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 23:06:43 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:32696 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261915AbUKVEGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 23:06:39 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Nov 2004 20:06:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andreas Schwab <schwab@suse.de>, Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de>
 <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Linus Torvalds wrote:

> On Mon, 22 Nov 2004, Andreas Schwab wrote:
> >
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > Now, try to "strace" it, or debug it with gdb, and see if you can repeat 
> > > the behaviour.
> > 
> > You'll always have hard time repeating that under strace or gdb, since a
> > debugger uses SIGTRAP for it's own purpose and does not pass it to the
> > program.
> 
> Sure. But "hard time" and "impossible" are two different things. 
> 
> It _should_ be perfectly easy to debug this, by using
> 
> 	signal SIGTRAP
> 
> instead of "continue" when you get a SIGTRAP that wasn't due to anything 
> you did.
> 
> But try it. It doesn't work. Why? Because the kernel will have cleared TF 
> on the signal stack, so even when you do a "signal SIGTRAP", it will only 
> run the trap handler _once_, even though it should run it three times 
> (once for each instruction in between the "popfl"s.
> 
> I do think this is actually a bug, although whether it's the bug that 
> causes problems for Wine is not clear at all. I'mm too lazy to build 
> and boot an older kernel, but I bet that on an older kernel you _can_ do 
> "signal SIGTRAP" three times, and it will work correctly. That would 
> indeed make this a regression.

Hmmm ..., this is 2.4.27:


[davide@bigblue davide]$ gcc -g -o zzzzzzzz zzzzzzzz.c 
[davide@bigblue davide]$ ./zzzzzzzz 
Copy protected: ok
[davide@bigblue davide]$ gdb ./zzzzzzzz
GNU gdb Red Hat Linux (5.3.90-0.20030710.41rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db
library "/lib/libthread_db.so.1".

(gdb) r
Starting program: /home/davide/zzzzzzzz 

Program received signal SIGTRAP, Trace/breakpoint trap.
0x08048454 in main (argc=1, argv=0xbffff9c4) at zzzzzzzz.c:26
26              asm volatile("pushfl ; andl %0,(%%esp) ; popfl"
(gdb) signal SIGTRAP
Continuing with signal SIGTRAP.

Program received signal SIGSEGV, Segmentation fault.
0x00000003 in ?? ()
(gdb) bt
#0  0x00000003 in ?? ()
#1  0x0804846b in smc () at zzzzzzzz.c:32
#2  0x46649b7f in __libc_start_main () from /lib/i686/libc.so.6
#3  0x08048359 in _start ()


So it seems it did not work even before, the gdb-SIGTRAP stepping. In 
2.6.8 I get a straight segfault just for running it.



- Davide

