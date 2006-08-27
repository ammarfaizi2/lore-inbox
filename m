Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWH0UFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWH0UFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWH0UFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:05:54 -0400
Received: from 1wt.eu ([62.212.114.60]:27409 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750960AbWH0UFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:05:54 -0400
Date: Sun, 27 Aug 2006 22:04:40 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
Message-ID: <20060827200440.GA229@1wt.eu>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu> <20060826231314.GA24109@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826231314.GA24109@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 27, 2006 at 03:13:14AM +0400, Solar Designer wrote:
> On Sat, Aug 26, 2006 at 10:22:36AM +0200, Willy Tarreau wrote:
> > I think that we are trying to protect against :
> >   1) local users faking kernel messages. (eg: disk errors, oopses, ...)
> >   2) local users changing console settings (eg: black on black)
> >   3) local users corrupting the log reader's terminal
> > 
> > 1) is relatively easy to do, basically if we escape \b, \r and \n, it will
> > become hard to produce fake logs.
> 
> I think it's just '\n'; other characters that you've mentioned achieve
> (1) by exploiting (2).
> 
> > 2) should be as easy. I'm not aware of any way to change a local console
> > setting with non-control chars (>= 0x20)
> 
> ...except that there are control chars above 0x20:
> 
> 	http://archives.neohapsis.com/archives/linux/lsap/2000-q2/0151.html
> 
> (scroll down to the end).  One thing that I did not mention in that older
> posting is that, IIRC, according to my vt420 manual, macro recording and
> playback may be invoked via the 8-bit controls (in some terminal modes).
> 
> This is not limited to real (hardware) terminals; of the 8-bit controls,
> at least CSI (0x9b) is typically supported by terminal emulators.  Even
> our linux/drivers/char/console.c supports it.

Thanks for the pointers, I didn't even know about this one. I also found
DCS which looks nasty too.

> Although most terminal emulators don't appear to allow for macro
> recording/playback to be requested with control chars, they do support
> status requests - to which they respond with certain easy-to-guess
> strings (an attack would be to create a script in PATH under that name -
> yes, this has multiple prerequisites).
> 
> So I think that we should escape chars in the 0x7f to 0x9f range as well.

OK that's what I adopted in my first attempt.

> > 3) is a problem of interpretation between the program storing the logs on
> > disk and the one retrieving them and showing them to the user. It's by no
> > way a kernel problem.
> 
> I'd agree, but what about dmesg?  It reads directly from the kernel and
> it is commonly run with output to a tty.  OK, maybe dmesg (the userspace
> program) should be fixed.

Exactly.

> > Thus, 1 and 2 could be merged by escaping ...
> 
> Yes.
> 
> In fact, if you do the escaping right when substituting values for "%s",
> then you'll cover (3) as well.
> 
> You probably don't want to modify the behavior of vsnprintf() for all of
> the kernel; you only want to affect its behavior when called from
> printk().  So you might need to be calling a private function instead,
> which would accept an additional argument, and make vsnprintf() a
> wrapper around that function.  Yes, that would be a hack.

No, I have forked it into vsnprintf_escaped() which is used by printk()
only.

> Alternatively, you can do the escaping right after the vsnprintf() call,
> but then it will affect more than just "%s".  I am not sure whether this
> is acceptable.

I didn't want to affect anything but "%s". Unfortunately, it seems that it
was already too much because there are several users in the kernel which
first construct their multi-line strings then call printk("%s") with it :-(
See example below with "\n" escaped with "^J" :

root@pcw:~# dmesg|fgrep '^J'
    ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.UAR2._STA] (Node 79b1aec0), AE_NOT_EXIST^J<6>ACPI: Interpreter enabled
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled^J<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.3.9^J        <Adaptec 29160 Ultra160 SCSI adapter>^J        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs^J
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)^J(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 16)^J(scsi0:A:2): 19.230MB/s transfers (19.230MHz, offset 16)^J(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 7)^J(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 32)^J  Vendor: COMPAQ
Model: BD01874554        Rev: 3B08
IP Protocols: ICMP, UDP, TCP, IGMP^J<6>IP: routing cache hash table of 8192 buckets, 64Kbytes
sd(8,6):Using r5 hash to sort names^JVFS: Mounted root (reiserfs filesystem) readonly.
root@pcw:~#

ACPI, Serial and Net are among the "clean" users, they correctly start
their next line with the log level prefix. Others such as aic7xxx and
reiserfs are not as clean as you can see above.

So I'm a bit lost now. The only alternative that I can imagine would
become a little bit complicated ; for "%s", do the following :

  - replace "\n" by "\\\n" to show that the first line is not complete
  - force the log level prefix immediately before first char of next
    line, to the same level as for the former message. This is to
    prevent user-space programs from hiding their actions by injecting
    level prefixes such as <7> which sends everything till EOL to the
    debug log, often equivalent to /dev/null on most systems.
  - ignore the log level prefix provided after a potential linefeed.
  - escape other non-printable characters

One of the problems is that we don't want to print "\" alone at the
end of lines before the final "\n", so there are lots of non-trivial
tests to perform. Also, the vsnprintf_escaped() function has to know
about the current log level (only need to add one argument).

Another idea I had was to add a new format specifier to vsnprintf()
to explicitly escape the string (eg: "%S"). But there are so many
users of printk() to fix then that I'm not sure we would find them
all. However, it would be the real fix and not a hack because what
we're trying to do is to enforce controls on some data type, which
is exactly the point of this solution.

Ideas are very welcome. I Cc Alan since he often has good ideas or
simple solutions to non-trivial problems such as this one.

> Thanks,
> 
> Alexander

Regards,
Willy

