Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUANNVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUANNVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:21:18 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:33412 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266271AbUANNVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:21:04 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: kgdb cleanups
Date: Wed, 14 Jan 2004 18:50:25 +0530
User-Agent: KMail/1.5
Cc: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
References: <20040109183826.GA795@elf.ucw.cz> <200401121923.27513.amitkale@emsyssoft.com> <40046115.5090700@mvista.com>
In-Reply-To: <40046115.5090700@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141850.25650.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 Jan 2004 2:50 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > Regarding pluggable iterfaces -
> > The version I have lets a user to choose the interface by supplying
> > appropriate command line. (e.g. kgdbwait kgdb8250=... or kgdbwait
> > kgdbeth=...) It supports an arbitrary number of interfaces. The kgdb core
> > itself is independent of an interface. All interfaces are defined by a
> > structure described below. An interface registers itself with kgdb core
> > by assigning this structure to pointer kgdb_serial.
> >
> > struct kgdb_serial {
> > 	int chunksize;
>
> Do we really need this?  The only place I saw it used it did not seem to
> matter where the split occured and there was now endchunck/beginchunck
> stuff.  I would MUCH rather see the interface code take care of this with
> out mucking up the core code (as the eth code already does).  Did I miss
> something here?

Having an interface recognize a kgdb core record isn't a good design.
Having kgdb core record know interface limitations isn't good either.

If kgdb calls flush at end of a packet and an interface splits a packet 
whenever its length goes above its limit, that'll be the right way of doing 
it.

>
> > 	int (*read_char)(void);
> > 	void (*write_char)(int);
> > 	void (*flush)(void);
> > 	int (*hook)(void);
> > 	void (*begin_session)(void);
> > 	void (*end_session)(void);
> > };
> >
> > Where chunksize is maximum chunksize an interface can handle.
> >
> > read_char and write_char are derived from getDebugChar and putDebugChar
> > flush flushes written characters. Flush control is given to kgdb core so
> > that it can ensure that #checksum doesn't split.
>
> Actually, I think it is needed so that gdb knows that the kgdb stub has
> exited. This could, of course, be done with out the flush, but then the
> write code would have to recognize an end of record (not hard with the
> given protocol).  I don't think there is any requirement that a checksum
> not be split.  My assumption here is that the logical record is reassembled
> on the gdb end without concern about how many physical records are
> involved.  Is this not true?

I guess yes. Splitting of #checksum may not matter.

>
> > begin_session and end_session inform an interface about a gdb
> > communication session. (Haven't decided about console packets to gdb yet)
>
> I assume you mean entry to the stub/ exit the stub as a "session".  This
> eliminates the old hook, right?

Yes. begin_session and end_session mark entry and exit points into 
handle_exception. They are required to mark ethernet interface in trap mode.

What's old hook?

>
> > hook is interface initialization. It can return errors. This allows kgdb
> > core to probe the interface for availability at multiple points. Because
> > of this, there can be multiple debugger entry points
> > 1. At very begining of start_kernel -> Only an 8250 interface with early
> > boot enabled can respond to hook call.
> > 2. After smp initialization -> An 8250 interface without an early boot
> > can respond to this.
> > 3. An ethernet interface can itself call debugger_entry to enter debugger
> > after it's brought up from userland.
>
> Hm..  Eth is up way before user land, else we could not nfs mount root and
> all that that implies.  I think eth should be "available" when it is
> initialized.  I am not sure I see a reason to support a way to get to kgdb
> from user land.  We have ^C and also the Sys Rq entry.  That should be
> enough.

Pardon my poor knowledge of network stack. I still have to work out the 
details of how and when to start kgdb-ethernet connection.

Now that you mention it, I'll think about it. I can actually bring up an 
ethernet interface from kgdb eth code itself and associate an ip address with 
it.

>
> Also, as mention in a prior email, I don't think it is a good idea to
> switch interfaces once communication is started, unless commanded to do so,
> even if the default request is to use an inteface that just came up.

Agreed. 

-amit

>
> I would suggest the the readyness of an interface be something one can
> easily determine from gdb (assuming we have established a connection).  I
> suggest putting this in the kgdb_info structure.  Possibly a pointer to an
> array of ??? where each entry is one of the interfaces.  Should have an
> "up" value here (filled in by the hook calls), as well as, say a pointer to
> more details on the interface.  The details might be baud, irq, address,
> for serial, and the ip address, etc for eth.
>
> -g
>
> > Other interfaces can come up at (1) or (2)
> >
> > On Monday 12 Jan 2004 12:19 pm, Matt Mackall wrote:
> >>On Sun, Jan 11, 2004 at 09:41:57PM -0800, George Anzinger wrote:
> >>>For the internal kgdb stuff I have created kdgb_local.h which I intended
> >>>to be local to the workings of kgdb and not to contain anything a user
> >>>would need.
> >>
> >>Agreed, I just haven't touched it since you last mentioned it.
> >>
> >>>>+struct kgdb_hook {
> >>>>+	char *sendbuf;
> >>>>+	int maxsend;
> >>>
> >>>I don't see the need of maxsend, or sendbuff, for that matter, as kgdb
> >>>uses it now (for the eth code) it is redundant, in that the eth putchar
> >>>also does the same thing as is being done in the kgdb_stub.c code.  I
> >>>think this should be removed from the stub and the limit in the ethcode
> >>>relied upon.
> >>
> >>Fair enough.
> >>
> >>>>void
> >>>>putDebugChar(int c)
> >>>>{
> >>>>-	if (!kgdboe) {
> >>>>-		tty_putDebugChar(c);
> >>>>-	} else {
> >>>>-		eth_putDebugChar(c);
> >>>>-	}
> >>>>+	if (kh)
> >>>>+		kh->putchar(c);
> >>>>}
> >>>
> >>>I was thinking that this might read something like:
> >>>         if (xxx[kh].putchar(c))
> >>>                xxx[kh].putchar(c);
> >>>
> >>>One might further want to do something like:
> >>>         if (!xxx[kh].putchar(c))
> >>>                kh = 0;
> >>>
> >>>In otherwords, an array (xxx must, of course, be renamed) of stuct
> >>>kgdb_hook (which name should also be changed to relate to I/O,
> >>>kgdb_IO_hook, for example). Then reserve entry 0 for the rs232 I/O code.
> >>
> >>Dunno about that. Probably should work more like the console code,
> >>whoever registers first wins. Early boot will probably be the
> >>exclusive province of serial for a while yet, but designing it in is
> >>probably short-sighted.
> >>
> >>> An alternate possibility is an array of pointer to struct kgdb_hook
> >>>which allows one to define the struct contents as below and to build the
> >>>array, all at compile/link time.  A legal entry MUST define get and put,
> >>>but why not define them all, using dummy functions for the ones that
> >>> make no sense in a particular interface.
> >>
> >>Throwing all the stubs in a special section could work well too. Then
> >>we could add an avail() function so that early boot debugging could
> >>discover if each one was available. The serial code could use this to
> >>kickstart itself while the eth code could test a local initialized
> >>flag and say "not a chance". Which gives us all the architecture to
> >>throw in other trivial interfaces (parallel, bus-snoopers, etc.).

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

