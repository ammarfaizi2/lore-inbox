Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRFSAjH>; Mon, 18 Jun 2001 20:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbRFSAi6>; Mon, 18 Jun 2001 20:38:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18684 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S262618AbRFSAiu>; Mon, 18 Jun 2001 20:38:50 -0400
Message-ID: <3B2E9EFA.7E0D17A4@mvista.com>
Date: Mon, 18 Jun 2001 17:38:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: very strange (semi-)lockups in 2.4.5
In-Reply-To: <200106182118.f5ILIxa187286@saturn.cs.uml.edu>
Content-Type: multipart/mixed;
 boundary="------------6448DC1233A52A7AA5ACBA29"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6448DC1233A52A7AA5ACBA29
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

"Albert D. Cahalan" wrote:
> 
> george anzinger writes:
> > Pozsar Balazs wrote:
> 
> >> The NMI card would be interesting, if anyone tells me how to make
> >> one, and how to patch the kernel to show useable information i'm
> >> looking forward to do it, and send reports.
> >
> > Given that your system still handles interrupts:
> > a.) It would probably not trigger an NMI timer (the interrupts would
> > keep resetting it)
> 
> Huh? No, this isn't the NMI timer. It's an NMI you generate
> with a pushbutton on the back of your PC. My computer doesn't
> have the APIC hardware needed for an NMI timer anyway.

Actually all that is needed is an 8254 PIT.  This is the same chip that
is used to generate the system clock (timer 0) and tones (timer 2).  As
I understand it timer 1 is used for memory refresh.  Each x86 PC has at
least one of these chips and each chip has three timers all clocked from
the same clock source.  But, and this is the point/ question, some PCs
have a second chip wired to NMI.  At least that is what my "The
Indispensable PC hardware book" says.

If your cpu has such a chip, it would be rather easy to program it to do
what the APIC NMI does.  According to the above book, the second PIT
should be at port 048h (counter 0) with the control port at 04bh.

But, actually my point is that, if your system is handling interrupts,
it is not so dead as to need and NMI.  The control-C from the serial
card should, for example, get it to do something useful (you know, like
spill its guts).
> 
> For a PCI card, one must assert the SERR# signal. This is supposed
> to be done for 1 clock cycle, on the proper clock edge. Going a bit
> beyond 1 clock cycle ought to be OK, but my hand on a button is
> likely to assert SERR# for millions of clock cycles. I've no idea
> if my motherboard will handle that well.

If you really want to build the push button, take a look at the
attached.  This is a message file that comes with KGDB....
> 
> > b.) Using KGDB will, most likely, be all you need anyway.
> 
> I'd rather just get an oops, but even still the board would
> be good to have. KGDB can be triggered by an NMI, right?

Usually the KGDB patch is set to catch NMI as well as any other kernel
fault.
> 
> Building an NMI board would be fun, overkill or not. :-)
> 
> > If you have a complete freeze, then the NMI is useful, but even
> > here, it is best to let KGDB handle the NMI.  Much easier to see
> > what's what than looking thru an OOPS.
> 
> I don't have an APIC. I have a plain Pentium MMX. If I want
> an NMI it's going to come from a pushbutton.
--------------6448DC1233A52A7AA5ACBA29
Content-Type: text/plain; charset=iso-8859-15;
 name="debug-nmi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug-nmi.txt"

Subject: Debugging with NMI
Date: Mon, 12 Jul 1999 11:28:31 -0500
From: David Grothe <dave@gcom.com>
Organization: Gcom, Inc
To: David Grothe <dave@gcom.com>

Kernel hackers:

Maybe this is old hat, but it is new to me --

On an ISA bus machine, if you short out the A1 and B1 pins of an ISA
slot you will generate an NMI to the CPU.  This interrupts even a
machine that is hung in a loop with interrupts disabled.  Used in
conjunction with kgdb <
ftp://ftp.gcom.com/pub/linux/src/kgdb-2.3.35/kgdb-2.3.35.tgz > you can
gain debugger control of a machine that is hung in the kernel!  Even
without kgdb the kernel will print a stack trace so you can find out
where it was hung.

The A1/B1 pins are directly opposite one another and the farthest pins
towards the bracket end of the ISA bus socket.  You can stick a paper
clip or multi-meter probe between them to short them out.

I had a spare ISA bus to PC104 bus adapter around.  The PC104 end of the
board consists of two rows of wire wrap pins.  So I wired a push button
between the A1/B1 pins and now have an ISA board that I can stick into
any ISA bus slot for debugger entry.

Microsoft has a circuit diagram of a PCI card at
http://www.microsoft.com/hwdev/DEBUGGING/DMPSW.HTM.  If you want to
build one you will have to mail them and ask for the PAL equations.
Nobody makes one comercially.

[THIS TIP COMES WITH NO WARRANTY WHATSOEVER.  It works for me, but if
your machine catches fire, it is your problem, not mine.]

-- Dave (the kgdb guy)

--------------6448DC1233A52A7AA5ACBA29--

