Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUK1REO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUK1REO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUK1REN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:04:13 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:54544 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261528AbUK1RBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:01:10 -0500
Message-ID: <41AA044F.6050008@wanadoo.fr>
Date: Sun, 28 Nov 2004 18:01:03 +0100
From: Eric Pouech <pouech-eric@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Daniel Jacobowitz <dan@debian.org>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
References: <20041119212327.GA8121@nevyn.them.org> <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net> <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de> <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org> <20041122231521.GA5966@tesore.ph.cox.net>
In-Reply-To: <20041122231521.GA5966@tesore.ph.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen a écrit :
> On Sun, Nov 21, 2004 at 10:23:41PM -0800, Linus Torvalds wrote:
> 
>>Ok, how about this patch?
>>
>>It does basically two things:
>>
>> - it makes the x86 version of ptrace be a lot more careful about the TF 
>>   bit in eflags, and in particular it never touches it _unless_ the 
>>   tracer has explicitly asked for it (ie we set TF only when doing a
>>   PTRACE_SINGESTEP, and we clear it only when it has been set by us, not 
>>   if it has been set by the program itself).
>>
>>   This patch also cleans up the codepaths by doing all the common stuff
>>   in set_singlestep()/clear_singlestep().
>>
>> - It clarifies signal handling, and makes it clear that we always push 
>>   the full eflags onto the signal stack, _except_ if the TF bit was set 
>>   by an external ptrace user, in which case we hide it so that the tracee 
>>   doesn't see it when it looks at its stack contents.
>>
>>   It also adds a few comments, and makes it clear that the signal handler
>>   itself is always set up with TF _clear_. But if we were single-stepped 
>>   into it, we will have notified the debugger, so the debugger obviously 
>>   can (and often will) decide to continue single-stepping.
>>
>>IMHO, this is a nice cleanup, and it also means that I can actually debug 
>>my "program from hell":
>>
>>	[torvalds@evo ~]$ gdb ./a.out 
>>	GNU gdb Red Hat Linux (6.1post-1.20040607.41rh)
>>	Copyright 2004 Free Software Foundation, Inc.
>>	GDB is free software, covered by the GNU General Public License, and you are
>>	welcome to change it and/or distribute copies of it under certain conditions.
>>	Type "show copying" to see the conditions.
>>	There is absolutely no warranty for GDB.  Type "show warranty" for details.
>>	This GDB was configured as "i386-redhat-linux-gnu"...(no debugging symbols 
>>	found)...Using host libthread_db library "/lib/tls/libthread_db.so.1".
>>
>>	(gdb) run
>>	Starting program: /home/torvalds/a.out 
>>	Reading symbols from shared object read from target memory...(no debugging 
>>	symbols found)...done.
>>	Loaded system supplied DSO at 0xffffe000
>>	(no debugging symbols found)...(no debugging symbols found)...
>>	Program received signal SIGTRAP, Trace/breakpoint trap.
>>	0x08048480 in main ()
>>	(gdb) signal SIGTRAP
>>	Continuing with signal SIGTRAP.
>>
>>	Program received signal SIGTRAP, Trace/breakpoint trap.
>>	0x08048487 in main ()
>>	(gdb) signal SIGTRAP
>>	Continuing with signal SIGTRAP.
>>
>>	Program received signal SIGTRAP, Trace/breakpoint trap.
>>	0x08048488 in smc ()
>>	(gdb) signal SIGTRAP
>>	Continuing with signal SIGTRAP.
>>	Copy protected: ok
>>
>>	Program exited with code 01.
>>	(gdb) 
>>
>>which I think is a sign that this patch actually fixes ptrace.
>>
>>Does this help with wine? I dunno. Maybe some wine people can comment..
>>
> 
> 
> 
> For the wine app in question, it does make a difference.  However, there is 
> a new problem.  The program gets stuck at the loading screen at 100% CPU.
> It's making a call to select, timing out, and then tries select again, 
> repeats.  It's waiting for something that seems to never happen.
> 
> I've captured a log, "loop.log.bz2", and shortened to have only the relevent
> information after the CMS32_MUTEX is created.  Look for occurances of
>  "select()" -- I think the second one is where it starts.  It's on my ftp if 
> anyone wants to take a look.  It probably can be compared to the working-
> version log where this doesn't occur, but it might be a pain to spot the 
> working particular instance.

Hi Jesse
Any network issue on your side? I tried to traceroute resnet.disp.net, but no avail.
So I cannot have a look to you newest trace.

A+

