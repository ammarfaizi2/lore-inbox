Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131395AbRATC4w>; Fri, 19 Jan 2001 21:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135412AbRATC4m>; Fri, 19 Jan 2001 21:56:42 -0500
Received: from exit1.i-55.com ([204.27.97.1]:10695 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S131395AbRATC4b>;
	Fri, 19 Jan 2001 21:56:31 -0500
Message-ID: <3A68FC79.679DA671@mailhost.cs.rose-hulman.edu>
Date: Fri, 19 Jan 2001 20:48:25 -0600
From: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>,
        "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang
In-Reply-To: <200101191756.f0JHuns30179@aslan.scsiguy.com> <3A6881F9.17F7B9F6@mailhost.cs.rose-hulman.edu> <3A68AAEC.7@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann wrote:
> 
> >> There is also a known issue with U160 modes and the currently
> >> embedded aic7xxx driver.
> >
> >
> > That's true the problem is the TCQ command seems to be sequencing wrong.
> >
> >
> >> You might want to try the Adaptec
> >> supported driver from here:
> >>
> >> http://people.FreeBSD.org/~gibbs/linux/
> >>
> >> 6.09 BETA should be released later today.
> 
> Just a little FYI, I wanted to point out that 6.08 BETA fixed a problem
> I've been having since the 2.4.0-test series on a machine with the
> following adaptec integrated controller:
>    Bus  4, device   7, function  0:
>      SCSI storage controller: Adaptec 7899P (rev 1).
>        IRQ 19.
>        Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
>        I/O at 0x5000 [0x50ff].
>        Non-prefetchable 64 bit memory at 0xf7e00000 [0xf7e00fff].
>    Bus  4, device   7, function  1:
>      SCSI storage controller: Adaptec 7899P (#2) (rev 1).
>        IRQ 16.
>        Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
>        I/O at 0x5400 [0x54ff].
>        Non-prefetchable 64 bit memory at 0xf7f00000 [0xf7f00fff].
> 
> This is an Ultra160 controller I believe (or at least thats what it says
> during bootup.)
> 
> Before I applied this patch it would print garbage for the
> Vendor/Rev/Type/ANSI SCSI revision of my hard disk.  With this patch it
> does not.
> 
> I unfortunately know very little about SCSI drivers, so I can't say
> exactly what causes this problem with the stock 2.4.0 adaptec driver.
> 
> -Jeff

  This sounds like the segate bios problem that Justin Gibbs refered to.
I have
two Western Digital enteprise drives that had the same problem. The
problem
that I was fighting was a Tagged Queue Command (or at least that is how
it is manifesting. This only occurs under heavy disk load for me.

My system is a 667 Alpha with a 64 bit PCI bus Feeding the 64 bit
Adaptec card.
(I note this cause I only know of one intel board with a 64 bit pci bus
and
 dual cpus' (found it on Tom's site back in November from the Tapei ??
computer
  conference.)

Well the problem seems to be that a command is flying and another is
then issued
causeing and overflow of the buffer causing the kernel to issue a
recurssive failure.

Error was

(scsi:1:0:0:0) Data overrun detected in Data-Out phase tag 5;
Have seen Data Phase. Length=0, Num SGS=0
Unable to handle kernel paging request at virtual address
003ffc0000006000
bzip2(8065): Oops 1

Then some NULL pointer stuff in the kernel.

Well the drive worked with no problem under the adaptec 3960UW
controller
so I finally caught the oops and played some with the TCQ logic.

The process that caused this was a rpm --rebuild of XFree. Something
which I have been doing lately as I am trying to get 4.0.2 to work
correctly. sigh.

I configured my patch to disable the TCQ logic only on 160M controllers
after other reports
of this problem. So far all the feed back says this fixed their problems
so that is were
I focused my attention.

Unfortuently emacs is segfaulting left and right these days so it has
slowed down my work a lot.
(rawhide systems do have a few ummm unstabilitys.)

I will try out the latest code sonnn and see if it crashes or works for
we and let everyone know.
My primary concern was to try to get a patch into 2.4.1 that at least
stops the kernel crashes.
Dosen't fix the problem but stops people from having an unstable
machine.

Well back to downloading.

Leslie Donaldson.

P.S. Thanks for all the input. It has been very helpful.


-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills:
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  :
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n---
b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw
LusCA++
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
