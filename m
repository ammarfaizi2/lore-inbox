Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTEDPuL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTEDPuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:50:11 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:14886 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263639AbTEDPuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:50:09 -0400
Date: Sun, 04 May 2003 12:00:00 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: will be able to load new kernel without restarting?
In-reply-to: <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <200305041200000380.00B553E1@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <freemail.20030403212422.18231@fm9.freemail.hu>
 <20030503205656.GA19352@middle.of.nowhere>
 <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You silly boys.  Thinking everything is impossible.  The old kernel
is just a shadow of the new one... just a shadow............  I'll try
spitting out a basic sketch.  This I'm sure you've done but if not,
fix it.  I'm an idiot, so this won't work as-is.

For starters, freeze the system.  halt EVERYTHING.

Now load the new kernel.

Now you have this thing in RAM.  Fine.  It's not running but it's in
RAM.

Start feeding data over to it.  In a manner it can understand.  You know,
make all the modules work with a standard named stream (check the
Advanced Tracker planning file at the very end:
http://advancedtracker.sourceforge.net/at/__at.plan.txt
I did copy it below, so you don't have to go there).  This is the
hard part--Module compatibility through defined names.  This would
bloat the kernel, so think about it and maybe you'll figure out a good
way.

Good.  Ask the new kernel if it has understood completely the data.
If yes, then jump to its resume routine.  This will make it unload the
old running kernel.  Free the old kernel, move yourself where you want
to be in RAM.  Now start up IPC again, and BAM!  Running new kernel
switched on-the-fly.

That last step is CRITICAL!  If the kernel--every single part--does NOT
understand EVERY piece of data sent to it, then stop.  Free the new
kernel.  Thank it kindly for its time.  Blarg to the user about loading an
incompatible kernel.  If the kernel acutally HAD the on-the-fly switching
support, then you can actually tell where it failed.  If not, say it's an old
kernel which does not understand OTFS.  Either way, turn everything
back on. Keep running.  No problem.

Please note you may need a standard, non-changing jump table in the
same exact place in RAM for all of the kernel syscalls, so that running
applicatioins don't b0rk out when the addresses of the syscalls change.

--Bluefox Icy

=======================
What is a named stream?
=======================
  A named stream is a named stream.  It separates out segments with clear names
to pass varying data.  Unknown names are usually discarded.  It looks like
this:

TYPE   SIZE    DESC
string    n    A string that tells the name of the next data.  Null terminated.
DWORD     4    32 bit length of the following data.  If 0, there is no data.
stream    x    A stream of bytes as long as the preceding dword gave.

*********** REPLY SEPARATOR  ***********

On 5/3/2003 at 6:52 PM Valdis.Kletnieks@vt.edu wrote:

>On Sat, 03 May 2003 22:56:56 +0200, Jurriaan said:
>
>> > Just a simple question. When I will be able to load new
>> > kernel without restarting the system? Working anybody on
>> > this problem?
>
>> Check the archives for 'kexec'. Some success messages were posted even
>> today.
>>
>
>As I understand it, that's still restarting, just skipping the usual detour
>through the BIOS and lilo/grub/whatever.
>
>What he wants is the sort of on-the-fly upgrading that bellheads have
>grown to
>know and love, and which is NOT likely to be implemented for the entire
>Linux
>kernel anytime soon.  Large sections can do it now with the "module"
>stuff, so
>you can rmmod the old one and insmod the new one.. but I don't see any
>easy way
>to implement rmmmod/insmod semantics for things like kernel/schedule.c (how
>would you get your next timeslice?).  There's also issues with changing the
>API for something - it's hard to drop a 2.5.71 kernel/signals.c into a
>2.5.70
>kernel if the API is different.  Googling around will probably cough up
>lots of references to how the telcos do software upgrades - it basically
>involves LOTS of up-front design work to make sure all the details are
>addressed in the basic design of the system.
>
>Bottom line - you can do it now for things that can be built as modules,
>*if* it's something you can effectively rmmod and insmod.  If it's not a
>module,
>or if it's the driver for something you can't rmmod (a disk or network
>driver,
>etc), you can't do it on-the-fly.
>
>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.1 (GNU/Linux)
>Comment: Exmh version 2.5 07/13/2001
>
>iD8DBQE+tEgWcC3lWbTT17ARAipeAKDXI7/xjQaVzg9HQW7+pQpJRHkH8wCg0mAF
>p+dGwFcpwR1X8ayWfGQ738I=
>=CHbq
>-----END PGP SIGNATURE-----
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



