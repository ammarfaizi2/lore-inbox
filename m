Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUANNZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbUANNZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:25:31 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:60292 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261500AbUANNZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:25:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Date: Wed, 14 Jan 2004 18:54:23 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net, discuss@x86-64.org,
       ak@suse.de, shivaram.upadhyayula@wipro.com,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401122020.08578.amitkale@emsyssoft.com> <40046296.1050702@mvista.com>
In-Reply-To: <40046296.1050702@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141854.23423.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 Jan 2004 2:56 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > 8250.patch changes generic 8250/16550 driver behavior only in following
> > ways 1. It adds a function serial8250_release_irq to release those serial
> > ports which share an irq with kgdb irq.
> > 2. There are checks so that a serial port that uses an irq used by an
> > initialized kgdb can't be initialized or started.
> >
> > File kgdb_8250.c is independent of 8250.c kgdb_8250.c depends on
> > KGDB_8250 and 8250.c depends on SERIAL_8250 which can be independently
> > configured. kgdb_8250.c can be compiled even if 8250.c is not included.
> > kgdb_8250.c does only the _minimum_ set of initializations required by
> > hardware.
>
> Ok.
>
> > Serial interface should be configurable independent of kgdb and may not
> > be configured if ethernet interface is configured.  Serial interface is
> > far simpler hence superior for debugging purposes. If it's available,
> > using ethernet interface is out of question. Ethernet interface can be
> > used when serial hardware isn't present or is being used for some other
> > purposes.
>
> I rather think that the serial inteface should be the fall back unless the
> user has told us at configure time that it is not available.  I am not
> prepared to make a statment that it is better than eth.  The eth intface
> should be much faster, but it has its fingers into a large part of the
> kernel that MAY be the subject of the current session.  Thus, I think that
> eth may be better, IF one is clearly not involved in debugging those areas
> of the kernel.  (Which, by the way, we need to enumerate at some point.)

Ethernet interface spans a large part of the kernel, so is going to be limited 
in near future. When it becomes as minimal as the serial interface, both may 
be given equal priority.

At 115kbps, serial interface is usable even when doing a thread list of 200 
threads.

Slow scanning of modules is a design problem in my gdb modifications, it'll be 
corrected soon.

>
> > On Monday 12 Jan 2004 11:30 am, George Anzinger wrote:
> >>Amit S. Kale wrote:
> >>>George,
> >>>
> >>>Well said!
> >>>
> >>>I have released kgdb 2.0.1 for kernel 2.6.1:
> >>>http://kgdb.sourceforge.net/linux-2.6.1-kgdb-2.0.1.tar.bz2
> >>>
> >>>It doesn't contain any assert stuff. I have split it into multiple parts
> >>>to make a merge easier. Please let me know if you want me to further
> >>>split them or if you want something to be changed. The README file from
> >>>this tarball is pasted below.
> >>>
> >>>Here is two possible starting points:
> >>>1. SMP stuff -> Replace my old smp and nmi handling code.
> >>>2. Early boot -> Change 8250.patch to make configuration of serial port
> >>>either through config options or through command line.
> >>
> >>What does messing with 8250.c code buy us?  I use a completely
> >> independent UART driver and only have "back off" code in the 8250
> >> driver.  In fact, I usually recommend that the serial (i.e. 8250.c)
> >> driver not even be loaded. My code also allows a more aggressive hookup
> >> to the interrupt code, to get the ^C to do its thing.  I REALLY would
> >> like to keep Mr. Heisenberg out of kgdb.  By using existing kernel code
> >> we are inviting him to visit.
> >>
> >>>I'll attempt reading your patch and merging as much stuff as possible.
> >>>Thanks.
> >>
> >>May I suggest reading the comments preceeding the patch itself in
> >> Andrew's breakout code.  These were written by Ingo and, I think,
> >> reflect some of the things he found useful.
> >>
> >>Also, the information found in .../Documentation/i386/kgdb/* of the
> >> patch.
> >>
> >>>Patch:
> >>>------
> >>>Patch the kernel out of following patches.
> >>>core.patch -	KGDB architecture and interface independent code. Required.
> >>>i386.patch -	i386 architecture dependent part. Required only for that
> >>>		architecture.
> >>>x86_64.patch -	x86_64 architecture dependent part. Required only for
> >>> that architecture.
> >>>8250.patch -	Generic serial port (8250 and 16550) interface for kgdb.
> >>>This is the only working interface in this release. Hence required.
> >>>eth.patch -	Ethernet interface for kgdb. This is still under
> >>> development. Use only if you plan to contribute to its development.
> >>>
> >>>Build:
> >>>------
> >>>Enable following config options (in this order).
> >>>
> >>>Kernel hacking ->
> >>>	KGDB: kernel debugging with remote gdb ->
> >>>		KGDB: Thread analysis
> >>>		KGDB: Console messages through gdb
> >>>Device drivers ->
> >>>	Character devices ->
> >>>		Serial drivers ->
> >>>			KGDB: On generic serial port (8250)
> >>
> >>If KGDB is on, this should not be needed.  Also the driver part of KGDB
> >>should be local to the KGDB configure in the configure file.  I think we
> >>should ALWAYS have the serial link.  The eth link should be backed up by
> >>the serial link.
> >>
> >>By the way, I will be out of town on Monday, back on Tuesday.
> >>
> >>George
> >>
> >>>Boot:
> >>>-----
> >>>Supply command line options kgdbwait and kgdb8250 to the kernel.
> >>>Example:  kgdbwait kgdb8250=1,115200
> >>>
> >>>On Saturday 10 Jan 2004 3:46 am, George Anzinger wrote:
> >>>>Amit,
> >>>>
> >>>>The base line kgdb code in the mm patches was offered by me.  It
> >>>> derives
> >>>>
> >>>>from (a long time ago) a kgdb I got from the RTIA (or was it the
> >>>> RTLINUX)
> >>>>
> >>>>folks.  Prio to that, well, your name is on it as well as others.
> >>>>
> >>>>As you may have noted there have been a lot of changes, mostly for the
> >>>>better, I hope.  I think we have slightly different objectives in our
> >>>>work. I debug kernels, not drivers, so I am interested in getting into
> >>>>kgdb as early as possible.  To this end the current mm patch allows one
> >>>>to put a breakpoint() as the first line of C code in the kernel.  This
> >>>>required a few adjustments, such as configuring the I/O port at CONFIG
> >>>>time, for example.
> >>>>
> >>>>I would like for the two versions of kgdb to merge while keeping the
> >>>>features of both.  The work on seperating the common code is something
> >>>> I like and, while I never do modules, the automatic module stuff in
> >>>> gdb sound good.
> >>>>
> >>>>May I suggest that we compare and contrast the two versions and take a
> >>>>look at the differences and the overlaps and settle on one way of doing
> >>>>the various things.
> >>>>
> >>>>George

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

