Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUE3LZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUE3LZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUE3LZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:25:33 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:62694 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263088AbUE3LZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:25:26 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <MPG.1b2111558bc2d299896a2@news.gmane.org>
	<20040525201616.GE6512@gucio>
	<xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
	<xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>
	<20040529131233.GA6185@ucw.cz>
	<xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de>
	<20040530101914.GA1226@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 13:25:24 +0200
In-Reply-To: <20040530101914.GA1226@ucw.cz>
Message-ID: <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    >> >> What I hate is only the part where mouse/keyboard drivers
    >> >> are now in kernel space.  The translation of raw byte
    >> >> streams into input events should be better done in userland.
    >> >> One important argument is: userland program may be swapped
    >> >> out.  Kernel modules can't.
    >> 

    Vojtech> Well, keyboard support was always in the kernel

Once in kernel space, forever in kernel space?  What's the logic?

Where  it is  now possible  to  move it  out of  kernel space  WITHOUT
performance problems, why not move it out?


    Vojtech>  - you need it there, because you need the keyboard
    Vojtech> always to work

Then, why make 'i8042' and  'atkbd' modules?  I still remember reading
web pages  that early  pioneers who migrated  from 2.4  to 2.6.0-test*
encountered a problem: they didn't compile-in these modules, and hence
the system boot  up without a responding keyboard.   Despite that, the
system does work and daemons are running!

So, why is a the keyboard need to always work?


I've  been  testing  'i8042'  module  and my  atkbd  driver  (and  the
SERIO_USERDEV  patch) through  the  network.  I've  been doing  'rmmod
i8042' many many times.  The system DOES work without that module (and
keyboard  functionality).   Why are  you  saying  that  "you need  the
keyboard  always  to  work"?   Again,   is  that  the  limit  of  your
imagination?

Are you aware of the i8042_shutdown bug, which I discovered and fixed?
How could I have found such a bug, if "keyboard has to always work"?


And  how about  mouse  drivers?  They  used  to be  in userland  (gpm,
XFree86 3.x -- 4.x, etc.)  Why move it into the kernel?




    >> I like the fact that 2.6.6 no longer assumes that the keyboard
    >> must be there (and thanks for your work to modularize those
    >> pieces of code).  This assumption doesn't hold, for instance,
    >> in some embedded systems, which has no keyboard controller and
    >> can only be controlled via an RS232 port.

    Vojtech> I meant that keyboard handling was never done in
    Vojtech> userspace. 

OK.  Then, it's time to consider moving it to userspace.


    Vojtech> Of course it is modular now, but that still counts as 'in
    Vojtech> the kernel'.

How about my atkbd.c?



    Vojtech> ;) On embedded systems, or when you have an USB
    Vojtech> keyboard, you can leave the whole PS/2 stuff out.

Is  it impossible  to run  daemons driving  the keyboard  (my atkbd.c,
should  be invoked  from inittab)  and mouse  (e.g.  gpm)  on embedded
systems?  I mean, why MUST the keyboard and mouse drivers be in kernel
space?


    Vojtech> But still, if you have a working keyboard, the handling
    Vojtech> is done in the kernel, and you can do a register dump,
    Vojtech> process listing, etc, even when the system is
    Vojtech> crashed.

Why just  the keyboard?  For that  purpose, we can  use mouse buttons,
the  power button,  a joystick  button, or  even a  home-brewed button
connected to the RS232 port or parallel port.  Why *limit* that to the
keyboard?


    Vojtech> You wouldn't be able to do that if the processing of the
    Vojtech> byte stream was done in an userspace program.

Isn't it  possible to monitor  the kernel via  a tty connected  to the
serial line?


    Vojtech> - even in the case of a crash, when all userspace
    Vojtech> programs may already be dead.
    >>  There are still RS232 ports and the network.

    Vojtech> Sure. How convenient it is to have to find an RS232
    Vojtech> cable, when your keyboard is just next to you on the
    Vojtech> table?

The keyboard should be made an *option*, not a *requirement* for that.
As an optional feature, yo shouldn't assume it for granted.



    >>  Can't SysRq be triggered from a program now, in addition to
    >> using a keyboard?

    Vojtech> It can. But if your userspace is dead, you cannot run
    Vojtech> that program. And that's usually when you need sysrq.

So, why limit that to the  keyboard only?  Why can't my LED lid switch
do it?


    >>  Is that "improvement" significant for 1200 baud devices?  Even
    >> on a 386DX-33?

    Vojtech> Yes. Very much significant. Exactly because they're
    Vojtech> running at 1200 baud, you need get most of that little
    Vojtech> data they're sending to you. 

I don't  understand this.  The slower  a device is, the  lesser is the
need to handle the incoming  data in kernel space.  I can't understand
how 1200baud is  fast enough to cause significant  delays.  Maybe, you
can enlighten me on that?


    Vojtech> The problem is that you get jerky mouse movement. It
    Vojtech> stays for a while on one place (when the buffer is
    Vojtech> filled), and then jumps elsewhere (when it's
    Vojtech> processed). You need to do the processing byte by byte,
    Vojtech> as they arrive.

Yeah.  At  what rate  are they arriving?   1200baud.  Let's  say that'
9600bps.   So,   1200  bytes  per   second.   1  byte  in   every  833
microseconds.  How  come a processor at 33MHz  (0.030 microseconds per
clock cycle) cannot  cope with that?  Assuming that  the processing of
the  data  plus  context  switching  plus  other  overhead  taks  1000
microseconds, that still shouldn't be felt by a HUMAN user.  Who has a
reaction time of less than 100 _milli_seconds?



    Vojtech> Yes, it does. Because it uses the _kernel_ input system
    Vojtech> to do the interfacing work. But I don't see any benefit
    Vojtech> of having to go to userspace and back again into the
    Vojtech> kernel.

Flexibility.  The  keyboard driver can  talk to another machine  via a
TCP  connection, for  instance.   The keyboard  driver  can be  easily
modified  and debugged --  all in  user space  -- without  hanging the
kernel due to  stupid bugs (e.g. NULL pointers).   The keyboard driver
could be prototyped  in Perl, C++, or any  other high-level languages.
(It'd be possible  to design a specific language to  make it easier to
describe the state machine, than in a general purpose language like C,
making it possible to  less programming-proficient users to change the
keyboard behaviours.)



    Vojtech> Care to name any? Everything from raw SCSI handling to
    Vojtech> presenting files to processes is done in the
    Vojtech> kernel. 

So,  raw access  is  still available,  just  in case  the kernel  code
developers' imaginations are exceeded in some applications.


    >> If you think those are kernel jobs, then you have an argument
    >> for implementing Ghostscript completely in kernel, so that we
    >> can cat mythesis.ps > /dev/psprinter, whether or not my printer
    >> is a Postscript printer, and whether or not it is connected
    >> locally or remotely, right?

    Vojtech> Good argument. There are limits of what makes sense to do
    Vojtech> in the kernel.  Ghostscript is easier to do in userspace,
    Vojtech> because it needs access to fonts, has a nontrivial
    Vojtech> configuration, isn't time critical, etc. Good candidate
    Vojtech> for userspace.

Keyboard and mouse drivers are also easier to do in userspace, because
that  makes access to  keymaps, mouse  protocol modules,  etc. easier.
Neither do I think keyboard/mouse  drivers are time critical enough to
be absolutely  placed in  kernel space.  Human  beings do not  work in
units of milliseconds.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

