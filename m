Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUE3JpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUE3JpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 05:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUE3JpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 05:45:25 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:21728 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261976AbUE3JpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 05:45:13 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <MPG.1b2111558bc2d299896a2@news.gmane.org>
	<20040525201616.GE6512@gucio>
	<xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
	<xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>
	<20040529131233.GA6185@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 11:45:02 +0200
In-Reply-To: <20040529131233.GA6185@ucw.cz>
Message-ID: <xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    >> What I hate is only the part where mouse/keyboard drivers are
    >> now in kernel space.  The translation of raw byte streams into
    >> input events should be better done in userland.  One important
    >> argument is: userland program may be swapped out.  Kernel
    >> modules can't.

    Vojtech> Well, keyboard support was always in the kernel - you
    Vojtech> need it there, because you need the keyboard always to
    Vojtech> work

No.   That's not the  case (at  least beginning  from 2.6.6).   If you
assume the keyboard is always there, they why make 'i8042' and 'atkbd'
modules?

I like the fact that 2.6.6 no longer assumes that the keyboard must be
there (and thanks  for your work to modularize  those pieces of code).
This assumption doesn't hold,  for instance, in some embedded systems,
which has  no keyboard  controller and can  only be controlled  via an
RS232 port.


    Vojtech>  - even in the case of a crash, when all userspace
    Vojtech> programs may already be dead.

There are still RS232 ports and the network.


    Vojtech> That's also the reason why keyboard processing is done in
    Vojtech> the interrupt context - even if nothing else works in the
    Vojtech> kernel but interrupts, you still can get a register dump
    Vojtech> for example, using the keyboard.

Can't SysRq  be triggered from a  program now, in addition  to using a
keyboard?


    Vojtech> Regarding mice: Yes, PS/2 and serial mice can be in
    Vojtech> userspace, as is proven by reality. With USB mice it's
    Vojtech> much tougher, and busmice and many other mice on non-PC
    Vojtech> platforms need their drivers to be in the kernel, as they
    Vojtech> access hardware directly and not via a byte stream
    Vojtech> abstraction.

A kernel driver can turn it into a byte stream.  What does 'evdev' do,
then?   Isn't  it  turning  those  events into  a  stream  of  "struct
input_event"s?  That's a byte stream,  although you have to be careful
to call read()/write() with a suitable size parameter.


    Vojtech> For serial mice, doing the processing in the kernel
    Vojtech> brought us a 4 times better response rate for the
    Vojtech> mousesystems kind of them and 2 times better for
    Vojtech> microsoft mice. That actually makes both useable.

Is that  "improvement" significant for  1200 baud devices?  Even  on a
386DX-33?


    Vojtech> And here are the two main reasons to keep mouse and
    Vojtech> keyboard processing in the kernel:

    Vojtech> 1) Latency. The time it takes from keypress to giving it
    Vojtech> to an application. Adding intermediate programs inbetween
    Vojtech> doesn't help this at all.

Well... I believe 'pppd' is more sensitive to latencies problems (when
talking to the RS232 port) than a mouse driver.  Why don't you migrate
pppd into the kernel, then?   Remember, we have 56kbps modems (at 2400
baud?).  I believe pppd should be kernelized before the mouse drivers.
Making pppd a kernel module  also eliminates the current need for pppd
to  communicate  with  a  kernel  driver to  create  the  ppp0,  ppp1,
... interfaces, too.

Actually, as long as the low-level byte-stream module has a big enough
buffer to handle the bursts of  data, and the userland driver is quick
enough (on average) to consume the incoming data, what's the problem?


    Vojtech> 2) Unified interface. If an application (X, QtEmbedded,
    Vojtech> SDL ...) needs to talk to a mouse or keyboard, it can use
    Vojtech> the event interface instead of knowing a gazillion of
    Vojtech> different protocols. 

I've demonstrated how a unified interface can be done using my atkbd.c
and psmouse userland drivers.  These useland drivers translate the raw
byte stream,  convert them into "struct input_event",  and then refeed
them into the input system.  It works!


    Vojtech> This is a kernel job.

No.  This can be done in userspace.  We should keep the kernel code to
a  minimal size.   Most other  "drivers" in  Linux has  a  kernel half
(a.k.a. bottom-half?) and  a userland half.  The kernel  half is to do
what  must  be  done  in   kernel:  creating  a  device,  reacting  to
interrupts, putting  the stream  of data in  a buffer.   Mostly simple
tasks that  must be  done quickly.  The  userland half, which  is more
computation-intensitive,  gets   the  data  and   do  the  complicated
processing.


If you  think those  are kernel  jobs, then you  have an  argument for
implementing  Ghostscript completely  in kernel,  so that  we  can cat
mythesis.ps  >  /dev/psprinter,  whether   or  not  my  printer  is  a
Postscript  printer, and  whether or  not it  is connected  locally or
remotely, right?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

