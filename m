Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUE3KZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUE3KZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 06:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUE3KZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 06:25:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:8832 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262009AbUE3KSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 06:18:53 -0400
Date: Sun, 30 May 2004 12:19:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530101914.GA1226@ucw.cz>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de> <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de> <20040529131233.GA6185@ucw.cz> <xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 11:45:02AM +0200, Sau Dan Lee wrote:
> >>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:
> 
>     >> What I hate is only the part where mouse/keyboard drivers are
>     >> now in kernel space.  The translation of raw byte streams into
>     >> input events should be better done in userland.  One important
>     >> argument is: userland program may be swapped out.  Kernel
>     >> modules can't.
> 
>     Vojtech> Well, keyboard support was always in the kernel - you
>     Vojtech> need it there, because you need the keyboard always to
>     Vojtech> work
> 
> No.   That's not the  case (at  least beginning  from 2.6.6).   If you
> assume the keyboard is always there, they why make 'i8042' and 'atkbd'
> modules?
> 
> I like the fact that 2.6.6 no longer assumes that the keyboard must be
> there (and thanks  for your work to modularize  those pieces of code).
> This assumption doesn't hold,  for instance, in some embedded systems,
> which has  no keyboard  controller and can  only be controlled  via an
> RS232 port.

I meant that keyboard handling was never done in userspace. Of course it
is modular now, but that still counts as 'in the kernel'. ;) On embedded
systems, or when you have an USB keyboard, you can leave the whole PS/2
stuff out.

But still, if you have a working keyboard, the handling is done in the
kernel, and you can do a register dump, process listing, etc, even when
the system is crashed. You wouldn't be able to do that if the processing
of the byte stream was done in an userspace program.

>     Vojtech>  - even in the case of a crash, when all userspace
>     Vojtech> programs may already be dead.
> 
> There are still RS232 ports and the network.

Sure. How convenient it is to have to find an RS232 cable, when your
keyboard is just next to you on the table? I don't advocate _always_
having keyboard support, just the fact that if you have it, that it
should work regardless of system state.

>     Vojtech> That's also the reason why keyboard processing is done in
>     Vojtech> the interrupt context - even if nothing else works in the
>     Vojtech> kernel but interrupts, you still can get a register dump
>     Vojtech> for example, using the keyboard.
> 
> Can't SysRq  be triggered from a  program now, in addition  to using a
> keyboard?

It can. But if your userspace is dead, you cannot run that program. And
that's usually when you need sysrq.

>     Vojtech> Regarding mice: Yes, PS/2 and serial mice can be in
>     Vojtech> userspace, as is proven by reality. With USB mice it's
>     Vojtech> much tougher, and busmice and many other mice on non-PC
>     Vojtech> platforms need their drivers to be in the kernel, as they
>     Vojtech> access hardware directly and not via a byte stream
>     Vojtech> abstraction.
> 
> A kernel driver can turn it into a byte stream.

Sure. You can turn anything into a byte stream. But you already have to
process it in the kernel. There is no point in creating a device
specific bytestream and then disassembling it again in userspace only to
again create a generic format bytestream.

>  What does 'evdev' do,
> then?  Isn't  it  turning  those  events into  a  stream  of  "struct
> input_event"s?  That's a byte stream,  although you have to be careful
> to call read()/write() with a suitable size parameter.

Sure. But it's a generic one, that's able to cover _any_ device. And all
with the same format. That's why it's much better to export this to
userspace than the raw mouse data.

>     Vojtech> For serial mice, doing the processing in the kernel
>     Vojtech> brought us a 4 times better response rate for the
>     Vojtech> mousesystems kind of them and 2 times better for
>     Vojtech> microsoft mice. That actually makes both useable.
> 
> Is that  "improvement" significant for  1200 baud devices?  Even  on a
> 386DX-33?

Yes. Very much significant. Exactly because they're running at 1200
baud, you need get most of that little data they're sending to you. With
the new kernel driver, MouseSystems mice are actually nice to work with,
and not the pain they used to be. Even on 386SX-16.

>     Vojtech> And here are the two main reasons to keep mouse and
>     Vojtech> keyboard processing in the kernel:
> 
>     Vojtech> 1) Latency. The time it takes from keypress to giving it
>     Vojtech> to an application. Adding intermediate programs inbetween
>     Vojtech> doesn't help this at all.
> 
> Well... I believe 'pppd' is more sensitive to latencies problems (when
> talking to the RS232 port) than a mouse driver.  Why don't you migrate
> pppd into the kernel, then?   Remember, we have 56kbps modems (at 2400
> baud?).  I believe pppd should be kernelized before the mouse drivers.
> Making pppd a kernel module  also eliminates the current need for pppd
> to  communicate  with  a  kernel  driver to  create  the  ppp0,  ppp1,
> ... interfaces, too.

Surprise: PPP handling _is_ in the kernel. pppd does the initial
handshaking, and then switches the kernel line discipline, and then the
characters are going straight from the port to the kernel, and then
they're packetized and appear in the ppp0 interface. No pppd interaction
inbetween at all.

> Actually, as long as the low-level byte-stream module has a big enough
> buffer to handle the bursts of  data, and the userland driver is quick
> enough (on average) to consume the incoming data, what's the problem?

The problem is that you get jerky mouse movement. It stays for a while
on one place (when the buffer is filled), and then jumps elsewhere (when
it's processed). You need to do the processing byte by byte, as they
arrive.

>     Vojtech> 2) Unified interface. If an application (X, QtEmbedded,
>     Vojtech> SDL ...) needs to talk to a mouse or keyboard, it can use
>     Vojtech> the event interface instead of knowing a gazillion of
>     Vojtech> different protocols. 
> 
> I've demonstrated how a unified interface can be done using my atkbd.c
> and psmouse userland drivers.  These useland drivers translate the raw
> byte stream,  convert them into "struct input_event",  and then refeed
> them into the input system.  It works!

Yes, it does. Because it uses the _kernel_ input system to do the
interfacing work. But I don't see any benefit of having to go to
userspace and back again into the kernel.

>     Vojtech> This is a kernel job.
> 
> No.  This can be done in userspace.  We should keep the kernel code to
> a  minimal size.   Most other  "drivers" in  Linux has  a  kernel half
> (a.k.a. bottom-half?) and  a userland half.  The kernel  half is to do
> what  must  be  done  in   kernel:  creating  a  device,  reacting  to
> interrupts, putting  the stream  of data in  a buffer.   Mostly simple
> tasks that  must be  done quickly.  The  userland half, which  is more
> computation-intensitive,  gets   the  data  and   do  the  complicated
> processing.

Care to name any? Everything from raw SCSI handling to presenting files
to processes is done in the kernel. Everything from talking to Ethernet
HW to processing IP and TCP and routing and firewalling to presenting
read()able sockets to applications is done in the kernel. No userspace
support there.

> If you  think those  are kernel  jobs, then you  have an  argument for
> implementing  Ghostscript completely  in kernel,  so that  we  can cat
> mythesis.ps  >  /dev/psprinter,  whether   or  not  my  printer  is  a
> Postscript  printer, and  whether or  not it  is connected  locally or
> remotely, right?

Good argument. There are limits of what makes sense to do in the kernel.
Ghostscript is easier to do in userspace, because it needs access to
fonts, has a nontrivial configuration, isn't time critical, etc. Good
candidate for userspace.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
