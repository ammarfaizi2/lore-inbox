Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <156496-26601>; Wed, 21 Oct 1998 05:28:44 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:5480 "HELO mail.ocs.com.au" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <157558-26601>; Wed, 21 Oct 1998 04:28:12 -0400
Message-ID: <19981021150647.32722.qmail@mail.ocs.com.au>
From: Keith Owens <kaos@ocs.com.au>
To: dwguest@win.tue.nl (Guest section DW)
cc: linux-kernel@vger.rutgers.edu, Andries.Brouwer@cwi.nl
Subject: New ksymoops that handles modules (was Re: How to translate an oops)
In-reply-to: Your message of "Sat, 17 Oct 1998 15:19:00 +0200." <199810171319.PAA01223@wsdw01.win.tue.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Oct 1998 01:06:41 +1000
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, 17 Oct 1998 15:19:00 +0200 (MET DST), 
dwguest@win.tue.nl (Guest section DW) wrote:
Probably really Andries.Brouwer@cwi.nl
>In fact, the program ksymoops found in linux/scripts is worthless junk.
>
>First of all, it is in C++. On many machines it does not compile.
>Secondly, it is not robust at all. It will only work when given the
>precise Oops output (and sometimes it even dumps core on an actual Oops).
>It does not work with Oops output that someone copied down by hand.
>
>Maybe someone with a little spare time can write a real ksymoops.c.
>[Or perhaps it has been written, and only linux/scripts/ksymoops.cc has to
>be replaced?]

Ask and ye shall receive :).

ftp://ftp.ocs.com.au/pub/ksymoops.c.gz  (a link to ksymoops-0.1.c.gz).

Bug reports directly to kaos@ocs.com.au please.  Patches for other
architectures and/or sample Oops logs will be gratefully accepted.

>And a ksymoops.8 wouldnt harm either.

No ksymoops.8 yet, everything is documented in the source.  From the
start of the code :-

  Read a kernel Oops file and make the best stab at converting the code to
  instructions and mapping stack values to kernel symbols.

  Why another ksymoops I hear you ask?  Various complaints about
  ksymoops.cc -

  * It requires C++.
  * It has hard wired limitations on the number of symbols.
  * It does not handle modules at all.
  * Very rigid requirements on the format of input, especially the Oops
    log.
  * No cross checking between ksyms, modules, System.map etc.
  * Very little error checking, diagnostics are not suitable for
    beginners.
  * It only prints the trace and decoded code, users have to manually
    extract the other lines from the Oops.
  * Gives up on the slightest problem.
  * Only handles i386 and possibly m68k.  The code is difficult to extend
    to other architectures.
  * Stops after the first Oops, you have to manually extract each one and
    run through ksymoops one at a time.

  This version is -
  * C.
  * No hard wired limitations (malloc as far as the eye can see).
  * Handles modules by default.
  * Uses regular pattern matching so it is a lot more forgiving about
    input formats.
  * By default, cross checks ksyms, modules, System.map and vmlinux.
  * Lots of diagnostics and error checking.
  * Prints all relevant lines for a complete Oops report.
  * Tries to provide output no matter how bad the input is.  The level of
     progress and error reporting is aimed at beginners.
  * Still only handles i386 and possibly m68k, but it is a lot easier to
    extend to other architectures (patches and/or sample data gratefully
    accepted).
  * Handles all Oops in the input file(s).


  Usage:  ksymoops
		  [-v vmlinux]    Where to read vmlinux
		  [-V]            No vmlinux is available
		  [-o object_dir] Directory containing modules
		  [-O]            No modules is available
		  [-k ksyms]      Where to read ksyms
		  [-K]            No ksyms is available
		  [-m system.map] Where to read System.map
		  [-M]            No System.map is available
		  [-s save.map]   Save consolidated map
		  [-d]            Increase debug level by 1
		  [-h]            Print help text
		  Oops.file       Oops to decode

	  All flags can occur more than once.  With the exception of -o
	  and -d which are cumulative, the last occurrence of each flag is
	  used.  Note that "-v my.vmlinux -V" will be taken as "No vmlinux
	  available" but "-V -v my.vmlinux" will read my.vmlinux.  You
	  will be warned about such combinations.

	  Each occurrence of -d increases the debug level.

	  Each -o flag can refer to a directory or to a single object
	  file.  If a directory is specified then all *.o files in that
	  directory and its subdirectories are assumed to be modules.

	  Defaults:       -v /usr/src/linux/vmlinux
			  -o /lib/modules/`uname -r`
			  -k /proc/ksyms
			  -m /usr/src/linux/System.map
			  Oops report is read from stdin

  Note:   Unless you tell ksymoops *NOT* to read a particular file, it
	  will try to read and reconcile all possible sources of kernel
	  symbol information.  This is intended for beginners, they just
	  type

	    ksymoops < /var/log/syslog

	  no thinking required.  Experts can point at different files or
	  suppress the input from selected files.  For example, if you
	  save /proc/ksyms before doing a test that creates an Oops, you
	  can point ksymoops at the saved ksyms instead of using
	  /proc/ksyms.

	  To get the equivalent of the old ksymoops.c (no vmlinux, no
	  modules objects, no ksyms, no System.map) just do ksymoops
	  -VOKM.  Or to just read System.map, ksymoops -VOK -m mapfile.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
